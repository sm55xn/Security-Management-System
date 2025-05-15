using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Security_Management_Server.Helpers;
using Security_Management_Server.Models;
using Security_Management_Server.Services;
using Security_Management_Server.db;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.Configure<JWT>(builder.Configuration.GetSection("JWT"));
builder.Services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<ApplicationDbContext>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<ISendSMS, SendSMS>();
builder.Services.AddScoped<IOService, OService>();
builder.Services.AddScoped<ISendNotification, SendNotification>();
builder.Services.AddHttpClient();
builder.Services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"))
            ) ; 

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
             .AddJwtBearer(o =>
             {
                 o.RequireHttpsMetadata = false;
                 o.SaveToken = false;
                 o.TokenValidationParameters = new TokenValidationParameters
                 {
                     ValidateIssuerSigningKey = true,
                     ValidateIssuer = true,
                     ValidateAudience = true,
                     ValidateLifetime = true,
                     ValidIssuer = builder.Configuration["JWT:Issuer"],
                     ValidAudience = builder.Configuration["JWT:Audience"],
                     IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(builder.Configuration["JWT:Key"]))
                 };
             }); ;

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors();

var app = builder.Build();

FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Firebase_KEY.json")),
});


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseAuthentication();
app.UseAuthorization();
app.UseHttpsRedirection();
app.UseCors(builder => builder.AllowAnyOrigin()
.AllowAnyMethod()
.AllowAnyHeader());
app.MapControllers();
app.Run();
