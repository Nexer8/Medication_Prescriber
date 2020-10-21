using AutoMapper;
using MedicationPrescriber.Api.Dtos;
using MedicationPresriber.Domain.Models;

namespace MedicationPrescriber.Api.Mapper
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<DoctorDto, Doctor>();
            CreateMap<Doctor, DoctorDto>()
                .ForMember(src => src.FirstName, dst => dst.MapFrom(x => x.User.FirstName))
                .ForMember(src => src.LastName, dst => dst.MapFrom(x => x.User.LastName));

            CreateMap<PatientDto, Patient>();
            CreateMap<Patient, PatientDto>()
                .ForMember(src => src.FirstName, dst => dst.MapFrom(x => x.User.FirstName))
                .ForMember(src => src.LastName, dst => dst.MapFrom(x => x.User.LastName));

            CreateMap<MedicationDto, Medication>();
            CreateMap<Medication, MedicationDto>();
        }
    }
}
