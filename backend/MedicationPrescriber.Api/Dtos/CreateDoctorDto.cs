using FluentValidation;

namespace MedicationPrescriber.Api.Dtos
{
    public class CreateDoctorDto
    {
        public string Specialization { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public class CreateDoctorDtoValidator : AbstractValidator<CreateDoctorDto>
        {
            public CreateDoctorDtoValidator()
            {
                RuleFor(x => x.FirstName).NotEmpty();
                RuleFor(x => x.LastName).NotEmpty();
            }
        }
    }
}
