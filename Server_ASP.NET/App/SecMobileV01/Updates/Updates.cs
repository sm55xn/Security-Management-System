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


namespace Security_Management_Server.App.SecMobileV01.Updates
{
    [Authorize(Roles = "User")]
    [Route("SecMobileV01/[Controller]")]
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
        [HttpGet("ViewPost")]
        public async Task<IActionResult> ViewPost([FromBody] string idPost)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var Post = await _context.posts.FindAsync(idPost);
            if (Post == null)
            { return NotFound(); }

            string Name;
            var Page = await _context.pages.FindAsync(Post.idPage);
            if (Page == null) { Name = "غير معروف"; }
            else
            { Name = Page.Name; } 

                var _post = new GetPostModel
                {
                    Text = Post.Text,
                    date = Post.date,
                    isComment = Post.isComment,
                    likes = Post.Likes,
                    NamePage = Name,
                    Attchment = Post.Attchment,
                    Comments = Post.Comments,
                    Profile =  Page.Profile,
                };
                
                return Ok(_post);


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
            if (Post != null && commentModel.Text.IsNullOrEmpty())
            {
                Post.Comments += 1;
                await _context.SaveChangesAsync();
            }
            if (Post != null)
            {
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
            else { return NotFound(); }
        }
        [HttpGet("GetComment")]
        public async Task<IActionResult> GetComment([FromBody] string idPost)
        {

            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            var checkPost = await _context.posts.FindAsync(idPost);
            if (checkPost != null)
            {
                var comments = await _context.comments.Where(p => p.IdPost == idPost ).ToListAsync();

                return Ok(comments);
            }
            else { return NotFound(); }
        }

    }
}
