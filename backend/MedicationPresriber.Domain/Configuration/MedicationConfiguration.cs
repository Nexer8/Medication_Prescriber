using MedicationPresriber.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;

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

            builder
               .Property(x => x.Timing)
                .HasConversion(
                    y => y.ToString(),
                    y => (Timing)Enum.Parse(typeof(Timing), y)
                )
                .IsRequired();

            builder.HasOne(x => x.Patient).WithMany(x => x.Medications);
            builder.HasOne(x => x.Doctor).WithMany(x => x.Medications);
            builder.HasKey(x => x.Id);
        }
    }
}
