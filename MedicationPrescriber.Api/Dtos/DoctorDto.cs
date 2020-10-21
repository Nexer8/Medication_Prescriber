using FluentValidation;
using Newtonsoft.Json;

namespace MedicationPrescriber.Api.Dtos
{
    public class DoctorDto
    {
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public int? Id { get; set; }

        public string Specialization { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public class DoctorDtoValidator : AbstractValidator<DoctorDto>
        {
            public DoctorDtoValidator()
            {
                RuleFor(x => x.FirstName).NotEmpty();
                RuleFor(x => x.LastName).NotEmpty();
            }
        }
    }
}
