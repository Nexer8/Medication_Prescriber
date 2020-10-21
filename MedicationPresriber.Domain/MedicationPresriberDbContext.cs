using MedicationPresriber.Domain.Configuration;
using MedicationPresriber.Domain.Models;
using Microsoft.EntityFrameworkCore;

namespace MedicationPresriber.Domain
{
    public class MedicationPresriberDbContext : DbContext
    {
        public MedicationPresriberDbContext(DbContextOptions<MedicationPresriberDbContext> dbOptions) : base(dbOptions)
        {

        }

        public DbSet<Doctor> Doctors { get; set; }

        public DbSet<Patient> Patients { get; set; }

        public DbSet<User> Users { get; set; }

        public DbSet<Medication> Medications { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.ApplyConfiguration(new DoctorConfiguration());
            modelBuilder.ApplyConfiguration(new PatientConfiguration());
            modelBuilder.ApplyConfiguration(new UserConfiguration());
            modelBuilder.ApplyConfiguration(new MedicationConfiguration());
        }
    }
}
