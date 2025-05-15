using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Security_Management_Server.Models;
using Security_Management_Server.db;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Security_Management_Server.Models
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
           
            builder.Entity<ApplicationUser>().ToTable("Users");
            builder.Entity<IdentityRole>().ToTable("Roles");
            builder.Entity<PhoneNumber>().ToTable("PhoneNumbers");
            builder.Entity<IdentityUserRole<string>>().ToTable("UserRole");
            builder.Entity<IdentityUserClaim<string>>().ToTable("UserClaim");
            builder.Entity<IdentityRoleClaim<string>>().ToTable("RoleClaim");
            builder.Entity<ApplicationUser>().Property(e => e.PasswordHash).HasColumnType("nvarchar(512)");
            builder.Entity<ApplicationUser>()
                .Ignore(c => c.Email)
                .Ignore(c => c.NormalizedEmail)
                .Ignore(c => c.EmailConfirmed)
                .Ignore(c => c.TwoFactorEnabled)
                .Ignore(c => c.LockoutEnd)
                .Ignore(c => c.LockoutEnabled);
           



        }

        //Tables of Accounts
        public DbSet<ApplicationUser> applicationUsers { get; set; }
        public DbSet<AccEmployees> accEmployees { get; set; }
        public DbSet<AccUsers> accUsers { get; set; }
        public DbSet<TokenRequestModel> tokenRequestModels { get; set; }
        public DbSet<PhoneNumber> PhoneNumbers { get; set; }
        public DbSet<FirebaseTokens> firebaseTokens { get; set; }

        // Tables of Reports
        public DbSet<Reports> Reports { get; set; }
        public DbSet<Attachments> Attachments { get; set; }
        public DbSet<AttachmentsForReply> AttachmentsForReply { get; set; }
        public DbSet<Replys> Replys { get; set; }
        public DbSet<Office> Offices { get; set; }
        public DbSet<Polices> Polices { get; set; }
        public DbSet<Delivereds> Delivereds { get; set; }
        public DbSet<HandlingReports> HandlingReports { get; set; }



        public DbSet<ReportStatus> reportStatuses { get; set; }
        public DbSet<ReportType> reportTypes { get; set; }
        public DbSet<RespondingAgency> respondingAgencies { get; set; }

        //Tables of Updates 
        public DbSet<AttachmentPost> attachmentPosts { get; set; }
        public DbSet<Bloggers> bloggers { get; set; }
        public DbSet<Comments> comments { get; set; }
        public DbSet<Posts> posts { get; set; }
        public DbSet<Followers> followers { get; set; }
        public DbSet<Like> likes { get; set; }
        public DbSet<Pages> pages { get; set; }

        //Tables of Statistics
        public DbSet<StatAgency> statAgencies { get; set; }
        public DbSet<StatEmployee> statEmployees { get; set; }
        public DbSet<StatEveryDay> statEveryDays { get; set; }
        public DbSet<StatUser> statUsers { get; set; }




    }
}