using MedicationPresriber.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace MedicationPresriber.Domain.Configuration
{
    public class MedicationConfiguration : IEntityTypeConfiguration<Medication>
    {
        public void Configure(EntityTypeBuilder<Medication> builder)
        {

            builder.Property(x => x.Name)
                   .IsRequired();
            builder.Property(x => x.StartDate)
                   .IsRequired();
            builder.Property(x => x.EndDate)
                   .IsRequired();
            builder.Property(x => x.Dosage)
                   .IsRequired();
            builder.Property(x => x.Timing)
                   .IsRequired();
            builder.HasOne(x => x.Patient);
            builder.HasOne(x => x.Doctor);
            builder.HasKey(x => x.Id);
        }
    }
}
