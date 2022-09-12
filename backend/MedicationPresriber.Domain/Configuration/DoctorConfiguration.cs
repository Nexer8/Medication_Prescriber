using MedicationPresriber.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace MedicationPresriber.Domain.Configuration
{
    public class DoctorConfiguration : IEntityTypeConfiguration<Doctor>
    {
        public void Configure(EntityTypeBuilder<Doctor> builder)
        {

            builder.Property(x => x.Specialization)
                   .IsRequired();
            builder.HasOne(x => x.User);
            builder.HasMany(x => x.Medications).WithOne(x => x.Doctor).OnDelete(DeleteBehavior.Restrict);
            builder.HasKey(x => x.Id);
        }
    }
}
