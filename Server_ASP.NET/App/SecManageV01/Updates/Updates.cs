using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Security_Management_Server.Models;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using System;
using Security_Management_Server.Data.Models;
using Security_Management_Server.db;
using Microsoft.IdentityModel.Tokens;
using Security_Management_Server.App.SecMobileV01.Report;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;
using System.Net.Mail;
using Google.Apis.Util;


namespace Security_Management_Server.App.SecManageV01.Updates
{
    [Authorize(Roles = "Blogger")]
    [Route("SecManageV01/[Controller]")]
    [ApiController]
    public class Updates : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public Updates(ApplicationDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpPost("addPage")]
        public async Task<IActionResult> addPage([FromForm] PageModel page)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            string profile;
            if (page.Profile != null)
            { profile = Guid.NewGuid().ToString(); }
            else
            {
                profile = "";
            }

            var _page = new db.Pages
            {
                Id = Guid.NewGuid().ToString(),
                Name = page.Name,
                dateJoin = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Description = page.Description,
                Profile = profile,
                FollowerCount = 0,
                PostsCount = 0,

            };

            await _context.pages.AddAsync(_page);
            await _context.SaveChangesAsync();
            if (page.Profile != null)
            {
                var folder = Directory.CreateDirectory("D:\\ASP.NET_Core\\data\\Profile");
                var filePath = Path.Combine($"{folder}", $"{profile}" + ".jpg");
                using var stream = System.IO.File.Create(filePath);
                { await page.Profile.CopyToAsync(stream); }
            }
            return Ok();
          
        }
        [HttpGet("GetPage")]
        public async Task<IActionResult> Pages()
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var pages = await _context.pages.ToListAsync() ;
            return Ok(pages);
        }
        [HttpGet("GetMyPages")]
        public async Task<IActionResult> MyPages()
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            string idBlogger = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var blogger = await _context.bloggers.Where(p => p.idBlogger == idBlogger).ToListAsync();
            if(blogger.IsNullOrEmpty())
                return NotFound(idBlogger);
            List<GetMyPagesModel> myPages = [];
            foreach (var blog in blogger)
            {
                var page = await _context.pages.FirstOrDefaultAsync(p=> p.Id == blog.idPage); 
                if(page == null)
                { continue; }
               
                var myPage = new GetMyPagesModel
                {
                  id = page.Id,
                  name = page.Name ,
                  profile = page.Profile,
                };
                myPages.Add(myPage);
            }
            return Ok(myPages);
        }

        [HttpPost("addBloggers")]
        public async Task<IActionResult> addBloggers([FromBody] BloggersModel blogger)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var emp = await _context.accEmployees.FindAsync(blogger.idEmp);
            var page = await _context.pages.FindAsync(blogger.idPage);
            if (emp == null || page == null)
            {
                return NotFound();
            }
            Random rand = new Random();

            var blogg = new db.Bloggers
            {
                Id = rand.Next(100000, 999999).ToString(),
                idBlogger = blogger.idEmp,
                idPage = blogger.idPage
            };
            await _context.AddAsync(blogg);
            await _context.SaveChangesAsync();
            return Ok();
        }
            [HttpPost("addPost")]
        public async Task<IActionResult> addPost([FromForm] PostModel post)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            string idBlogger = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
           
            var blogger = await _context.bloggers.Where(p => p.idBlogger == idBlogger && p.idPage == post.idPage).ToListAsync();
            if (blogger == null)
            { 
                return NotFound();
            }
                bool isComment = true;
                if (post.isComment == "false")
                    isComment = false;
                string Att;
                if (post.Attchment != null)
                { Att = Guid.NewGuid().ToString(); }
                else
                {
                    Att = "";
                }
                var _post = new db.Posts
                {
                    Id = Guid.NewGuid().ToString(),
                    Text = post.text,
                    date = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    idBlogger = idBlogger,
                    Likes = 0,
                    views = 0,
                    idPage = post.idPage,
                    Attchment =Att ,
                    isComment = isComment,
                   
                };

                await _context.posts.AddAsync(_post);
                await _context.SaveChangesAsync();
                var page = await _context.pages.FindAsync(post.idPage);
                if (page != null)
                {
                    page.PostsCount += 1;
                    await _context.SaveChangesAsync();
                }
                if (post.Attchment != null)
                {
                    var folder = Directory.CreateDirectory("D:\\ASP.NET_Core\\data\\AttachmentUpdatas");
                    var filePath = Path.Combine($"{folder}", $"{Att}" + ".jpg");
                    using var stream = System.IO.File.Create(filePath);
                    { await post.Attchment.CopyToAsync(stream); }
                }
                return Ok();
            


        }
        [HttpGet("GetPost")]
        public async Task<IActionResult> Posts()
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var Posts = await _context.posts.OrderByDescending(p=>p.date).ToListAsync();
            if(Posts == null)
            { return NotFound(); }
            List<GetPostModel> posts = new List<GetPostModel>();
            foreach (var Post in Posts)
            {
                string Name;
                var Page = await _context.pages.FindAsync(Post.idPage);
                if (Page == null) { Name = "غير معروف"; }
                else
                { Name = Page.Name; }
                var _post = new GetPostModel
                {
                    idPage = Post.idPage,
                    idPost = Post.Id,
                    Text = Post.Text,
                    date = Post.date,
                    isComment = Post.isComment,
                    likes = Post.Likes,
                    NamePage = Name,
                    Attchment = Post.Attchment,
                    Comments = Post.Comments,
                    Profile = Page.Profile,
                };
                posts.Add(_post);

            }
            return Ok(posts);
        }
        [HttpGet("GetPostsInPage")]
        public async Task<IActionResult> PostsInPage(string idPage)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var Posts = await _context.posts.Where(p=>p.idPage == idPage).OrderByDescending(p => p.date).ToListAsync();
            if (Posts == null)
            { return NotFound(); }
            List<GetPostModel> posts = new List<GetPostModel>();
            foreach (var Post in Posts)
            {
                string Name;
                var Page = await _context.pages.FindAsync(Post.idPage);
                if (Page == null) { Name = "غير معروف"; }
                else
                { Name = Page.Name; }
                var _post = new GetPostModel
                {
                    idPage = Post.idPage,
                    idPost = Post.Id,
                    Text = Post.Text,
                    date = Post.date,
                    isComment = Post.isComment,
                    likes = Post.Likes,
                    NamePage = Name,
                    Attchment = Post.Attchment,
                    Comments = Post.Comments,
                    Profile = Page.Profile,
                };
                posts.Add(_post);

            }
            return Ok(posts);
        }

        [HttpPost("setLike")]
        public async Task<IActionResult> setLike([FromBody] LikeModel like)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            
            var Post =await _context.posts.FindAsync(like.IdPost);
            if(Post != null && like.IsLike == true)
            {
                Post.Likes += 1;
                await _context.SaveChangesAsync();
            }
            if (Post != null && like.IsLike == false)
            {
                Post.Likes -= 1;
                await _context.SaveChangesAsync();
            }
            if (Post != null)
            {
                var _like = new db.Like
                {
                    Id = Guid.NewGuid().ToString(),
                    IdPost = like.IdPost,
                    iduser = like.iduser,
                    IsLike = like.IsLike

                };
                await _context.likes.AddAsync(_like);
                await _context.SaveChangesAsync();
                return Ok();
            }
            else { return NotFound(); }
        }

        [HttpPost("addComment")]
        public async Task<IActionResult> addComment([FromBody] CommentModel commentModel)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            string user = _httpContextAccessor.HttpContext.User.Claims.First(i => i.Type == "uid").Value;
            var Post = await _context.posts.FindAsync(commentModel.idPost);
            if (Post == null || commentModel.Text.IsNullOrEmpty())
            {
                return NotFound();
            }
                Post.Comments += 1;
                await _context.SaveChangesAsync();
                var _commet = new db.Comments
                {
                    Id = Guid.NewGuid().ToString(),
                    IdPost = commentModel.idPost,
                    idUser = user,
                    comment = commentModel.Text,
                    date = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),

                };
                await _context.comments.AddAsync(_commet);
                await _context.SaveChangesAsync();
                return Ok();
        
           
          
        }
        [HttpGet("GetComment")]
        public async Task<IActionResult> GetComment( string idPost)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var checkPost = await _context.posts.FindAsync(idPost);
            if (checkPost == null)
            { return NotFound(); }

            var comments = await _context.comments.Where(p => p.IdPost == idPost ).OrderByDescending(p => p.date).ToListAsync();
            List<GetComment> Comment = [];
            foreach(var comment in comments)
            {
                var user = await _context.Users.FindAsync(comment.idUser);
                if(user == null)
                { continue; }
                var com = new GetComment
                {
                    profile = user.Id,
                    name = user.Name,
                    date = comment.date,
                    comment = comment.comment,

                };
                Comment.Add(com);
            }
            return Ok(Comment);
            
            
        }

    }
}
