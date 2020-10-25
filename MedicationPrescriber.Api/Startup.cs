using AutoMapper;
using FluentValidation.AspNetCore;
using MedicationPrescriber.Api.Mapper;
using MedicationPresriber.Domain;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using static MedicationPrescriber.Api.Dtos.DoctorDto;

namespace MedicationPrescriber
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<MedicationPresriberDbContext>(options =>
                options.UseSqlServer(Configuration.GetSection("AzureConnectionString").Value, x => x.MigrationsAssembly("MedicationPresriber.Domain")));
            services.AddMvc().AddFluentValidation(x => x.RegisterValidatorsFromAssemblyContaining<DoctorDtoValidator>());
            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "Medication Presriber API", Version = "v1" });
            });
            services.AddAutoMapper(typeof(MappingProfile));
            services.AddApplicationInsightsTelemetry();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "Medication Presriber API");
                c.RoutePrefix = string.Empty;
            });
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
        }
    }
}
