using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;
using MedicationPrescriber.Api.Dtos;
using AutoMapper;
using Microsoft.EntityFrameworkCore.Internal;
using System.Linq;
using System.Collections.Generic;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/patients")]
    [ApiController]
    public class PatientsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;
        private readonly IMapper _mapper;

        public PatientsController(MedicationPresriberDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            var patientsEntitiesList = await _context.Patients.Include(x => x.User).ToListAsync();
            return Ok(_mapper.Map<List<PatientDto>>(patientsEntitiesList));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetByIdAsync(int id)
        {
            var patientEntity = await _context.Patients.Include(x => x.User).FirstOrDefaultAsync(x => x.PersonalId == id);

            if (patientEntity == null)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<PatientDto>(patientEntity));
        }

        
        [HttpPost]
        public async Task<IActionResult> PostAsync(PatientDto patientDto)
        {
            if(_context.Patients.Any(x => x.PersonalId == patientDto.PersonalId))
            {
                return BadRequest($"User with personalId: {patientDto.PersonalId} already exists");
            }    

            var user = new User
            {
                FirstName = patientDto.FirstName,
                LastName = patientDto.LastName
            };
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var patientEntity = _mapper.Map<Patient>(patientDto);
            patientEntity.UserId = user.Id;
            _context.Patients.Add(patientEntity);
            await _context.SaveChangesAsync();

            return Ok(patientDto);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var patient = await _context.Patients.FirstOrDefaultAsync(x => x.PersonalId == id);
            if (patient == null)
            {
                return NotFound();
            }

            _context.Patients.Remove(patient);
            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}
