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
using System;

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
        public async Task<IActionResult> GetAsync(DateTime? date)
        {
            var query = await _context.Medications.FilterByDateIfNeeded(date).ToListAsync();
            return Ok(_mapper.Map<List<MedicationDto>>(query));
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

        [HttpGet("patient/{patientId}")]
        public async Task<IActionResult> GeByUserIdAsync(int patientId, DateTime? date)
        {
            var medication = await _context.Medications
                .Where(x => x.PatientId == patientId)
                .FilterByDateIfNeeded(date)
                .OrderByDescending(x => x.StartDate)
                .ToListAsync();

            return Ok(_mapper.Map<List<MedicationDto>>(medication));
        }

        [HttpGet("doctor/{doctorId}")]
        public async Task<IActionResult> GeByDoctorIdAsync(int doctorId, DateTime? date)
        {
            var medication = await _context.Medications
                .Where(x => x.DoctorId == doctorId)
                .FilterByDateIfNeeded(date)
                .OrderByDescending(x => x.StartDate)
                .ToListAsync();
            return Ok(_mapper.Map<List<MedicationDto>>(medication));
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

        [HttpPut("{id}")]
        public async Task<IActionResult> PostAsync(int id, MedicationDto medicationdto)
        {
            var medication = await _context.Medications.FirstOrDefaultAsync(x => x.Id == id);
            if (medication == null)
            {
                return NotFound();
            }
            if (medication.DoctorId != medicationdto.DoctorId)
            {
                return BadRequest($"Doctor with id: {medicationdto.DoctorId} does not exists!");
            }

            if (!_context.Patients.Any(x => x.PersonalId == medicationdto.PatientId))
            {
                return BadRequest($"Patient with id: {medicationdto.PatientId} does not exists!");
            }

            medication.Dosage = medicationdto.Dosage;
            medication.StartDate = medicationdto.StartDate;
            medication.EndDate = medicationdto.EndDate;
            medication.Timing = (Timing)Enum.Parse(typeof(Timing), medicationdto.Timing);
            medication.Name = medicationdto.Name;

            _context.Medications.Update(medication);
            await _context.SaveChangesAsync();

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
