using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using plataforma_ecp.application.Interfaces;
using plataforma_ecp.application.Services;
using plataforma_ecp.domain.CustomEntities;
using plataforma_ecp.infrastructure.Data;
using plataforma_ecp.infrastructure.Repositories;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

#region LlavesApp 
AppKeys.Instance.setcadena(builder.Configuration.GetConnectionString("WebApiDatabase"));
AppKeys.Instance.obtenerKeysApp();
#endregion

builder.Services.Configure<PaginationOptions>(option => builder.Configuration.GetSection("Pagination").Bind(option));

#region JWT
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.SaveToken = true;
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters()
    {
        ValidateIssuer = true,
        ValidateAudience = true, // Cambia a 'true' si quieres validar la audiencia
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTIssuer").valor,
        ValidAudience = AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTIssuer").valor,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(AppKeys.Instance.keysLists.FirstOrDefault(x => x.nombre == "JWTKey").valor))
    };
    options.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            // Leer el token desde la cookie
            var token = context.HttpContext.Request.Cookies["authToken"];
            if (!string.IsNullOrEmpty(token))
            {
                context.Token = token;
            }
            return Task.CompletedTask;
        }
    };
});
#endregion

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddHttpContextAccessor();

#region SwaggerConfig
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "primera marcha WebApi", Version = "v1" });
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Jwt Auth",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            }, new string[] {}
        }
    });
});
#endregion

#region Dependencias
builder.Services.AddScoped<IUserRepository, UsuarioRepository>();
builder.Services.AddScoped<IParametersRepository, ParametersRepository>();
builder.Services.AddScoped<IAsignacionClasesRepository, AsignacionClasesRepository>();
builder.Services.AddScoped<IAgendaEstudianteRepository, AgendaEstudianteRepository>();
builder.Services.AddScoped<IPermissionsRepository, PermissionsRepository>();
builder.Services.AddSingleton<IUriService>(provider =>
{
    var accessor = provider.GetRequiredService<IHttpContextAccessor>();
    var request = accessor.HttpContext.Request;
    var absoluteUri = string.Concat(request.Scheme, "://", request.Host.ToUriComponent(), request.Path);
    return new UriService(absoluteUri);
});
#endregion

#region CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("corsapp", builder =>
    {
        builder.WithOrigins(
                   "http://localhost:3000",
                   "http://localhost:5000",
                   "http://127.0.0.1:3000",
                   "http://44.218.60.51:3000",
                   "http://44.218.60.51"
               )
               .AllowAnyMethod()
               .AllowAnyHeader()
               .AllowCredentials(); 
    });
});
#endregion

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.UseCors("corsapp"); 

app.UseAuthentication();
app.UseAuthorization();
/*
app.Use(async (context, next) =>
{
    context.Response.Headers.Add("Content-Security-Policy",
        "default-src 'self'; script-src 'self' 'nonce-abc123' https://mercadopago.com https://*.mercadopago.com; style-src 'self' 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com; frame-ancestors 'none';");

    context.Response.Headers.Add("Referrer-Policy", "strict-origin-when-cross-origin");

    await next();
});
*/

if (app.Environment.IsDevelopment())
{
    app.MapControllers().AllowAnonymous();
}else
{
    app.MapControllers();
}
// app.MapControllers();

app.Run();
