using FluentValidation;
using System;

namespace MedicationPrescriber.Api.Dtos
{
    public class UpdatePatientDto
    {
        public DateTime Birthdate { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }


        public class UpdatePatientDtoValidator : AbstractValidator<UpdatePatientDto>
        {
            public UpdatePatientDtoValidator()
            {
                RuleFor(x => x.FirstName).NotEmpty();
                RuleFor(x => x.LastName).NotEmpty();
                RuleFor(x => x.Birthdate).NotEmpty();
            }
        }

    }
}
