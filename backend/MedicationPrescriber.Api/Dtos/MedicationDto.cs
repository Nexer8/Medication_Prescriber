using FluentValidation;
using System;

namespace MedicationPrescriber.Api.Dtos
{
    public class MedicationDto
    {
        public int? Id { get; set; }

        public long PatientId { get; set; }

        public int DoctorId { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public int Dosage { get; set; }

        public string Timing { get; set; }
    }

    public class MedicationDtoValidator : AbstractValidator<MedicationDto>
    {
        public MedicationDtoValidator()
        {
            RuleFor(x => x.Name).NotEmpty();
            RuleFor(x => x.StartDate).NotEmpty();
            RuleFor(x => x.EndDate).NotEmpty();
            RuleFor(x => x.Timing).NotEmpty();
            RuleFor(x => x.Dosage).GreaterThan(0);
            RuleFor(x => x.EndDate).GreaterThanOrEqualTo(x => x.StartDate);
            RuleFor(x => x.Timing).Must(x => Tools.IsTimingDefinedByValue(x))
                    .WithMessage(x => $"{x.Timing} is not a valid timing, choose from: {Tools.GetValuesOfTiming()}");
        }
    }
}
