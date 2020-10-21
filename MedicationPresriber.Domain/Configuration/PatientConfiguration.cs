using MedicationPresriber.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace MedicationPresriber.Domain.Configuration
{
    public class PatientConfiguration : IEntityTypeConfiguration<Patient>
    {
        public void Configure(EntityTypeBuilder<Patient> builder)
        {

            builder.Property(x => x.Birthdate)
                   .IsRequired();
            builder.HasOne(x => x.User);
            builder.HasKey(x => x.PersonalId);
        }
    }
}
