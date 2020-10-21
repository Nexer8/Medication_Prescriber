using FluentValidation;
using System;

namespace MedicationPrescriber.Api.Dtos
{
    public class PatientDto
    {
        public int PersonalId { get; set; }

        public DateTime Birthdate { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }
    }

    public class PatientDtoValidator : AbstractValidator<PatientDto>
    {
        public PatientDtoValidator()
        {
            RuleFor(x => x.FirstName).NotEmpty();
            RuleFor(x => x.LastName).NotEmpty();
            RuleFor(x => x.Birthdate).NotEmpty();
        }
    }
}
