using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;
using MedicationPrescriber.Api.Dtos;
using AutoMapper;
using Microsoft.EntityFrameworkCore.Internal;
using System.Security.Cryptography.X509Certificates;
using System.Linq;
using System.Collections.Generic;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/medications")]
    [ApiController]
    public class MedicationsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;
        private readonly IMapper _mapper;

        public MedicationsController(MedicationPresriberDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            var medicationEntitiesList = await _context.Medications.ToListAsync();
            return Ok(_mapper.Map<List<MedicationDto>>(medicationEntitiesList));
        }
         
        [HttpGet("{id}")]
        public async Task<IActionResult> GeByIdAsync(int id)
        {
            var medication = await _context.Medications.FirstOrDefaultAsync(x => x.Id == id);

            if (medication == null)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<MedicationDto>(medication));
        }

        
        [HttpPost]
        public async Task<IActionResult> PostAsync(MedicationDto medicationdto)
        {
            if(!_context.Doctors.Any(x => x.Id == medicationdto.DoctorId))
            {
                return BadRequest($"Doctor with id: {medicationdto.DoctorId} does not exists!");
            }

            if(!_context.Patients.Any(x => x.PersonalId == medicationdto.PatientId))
            {
                return BadRequest($"Patient with id: {medicationdto.PatientId} does not exists!");
            }

            var medicationEntity = _mapper.Map<Medication>(medicationdto);
            _context.Medications.Add(medicationEntity);
            await _context.SaveChangesAsync();

            medicationdto.Id = medicationEntity.Id;
            return Ok(medicationdto);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var medication = await _context.Medications.FirstOrDefaultAsync(x => x.Id == id);
            if (medication == null)
            {
                return NotFound();
            }

            _context.Medications.Remove(medication);
            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}
