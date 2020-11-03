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
using System.Net;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/medications")]
    [Produces("application/json")]
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

        /// <summary>
        /// Get medications
        /// </summary>
        /// <param name="date">Get medications for given date</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetAsync(DateTime? date)
        {
            var query = await _context.Medications.FilterByDateIfNeeded(date).ToListAsync();
            return Ok(_mapper.Map<List<MedicationDto>>(query));
        }

        /// <summary>
        /// Get medications by id
        /// </summary>
        /// <param name="id">Id of the medication</param>
        /// <returns></returns>
        /// <response code="404">If medication with given id does not exist</response>
        [HttpGet("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> GeByIdAsync(int id)
        {
            var medication = await _context.Medications.FirstOrDefaultAsync(x => x.Id == id);

            if (medication == null)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<MedicationDto>(medication));
        }

        /// <summary>
        /// Get medications presribed for the patient
        /// </summary>
        /// <param name="patientId">PersonalId of patient</param>
        /// <param name="date">Get medications for given date</param>
        /// <returns></returns>
        /// <response code="404">If patient with given id does not exist</response>
        [HttpGet("patient/{patientId}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> GeByUserIdAsync(long patientId, DateTime? date)
        {
            if(!_context.Patients.Any(x => x.PersonalId == patientId))
            {
                return NotFound();
            }

            var medication = await _context.Medications
                .Where(x => x.PatientId == patientId)
                .FilterByDateIfNeeded(date)
                .OrderByDescending(x => x.StartDate)
                .ToListAsync();

            return Ok(_mapper.Map<List<MedicationDto>>(medication));
        }

        /// <summary>
        /// Get medications created by the doctor
        /// </summary>
        /// <param name="doctorId">Id of doctor</param>
        /// <param name="date">Get medications for given date</param>
        /// <returns></returns>
        /// <response code="404">If doctor with given id does not exist</response>
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        [HttpGet("doctor/{doctorId}")]
        public async Task<IActionResult> GeByDoctorIdAsync(int doctorId, DateTime? date)
        {
            if (!_context.Doctors.Any(x => x.Id == doctorId))
            {
                return NotFound();
            }

            var medication = await _context.Medications
                .Where(x => x.DoctorId == doctorId)
                .FilterByDateIfNeeded(date)
                .OrderByDescending(x => x.StartDate)
                .ToListAsync();
            return Ok(_mapper.Map<List<MedicationDto>>(medication));
        }

        /// <summary>
        /// Create medication
        /// </summary>
        /// <param name="medicationdto">Medication to create</param>
        /// <returns></returns>
        [HttpPost]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> PostAsync(CreateMedicationDto medicationdto)
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
            return Ok(_mapper.Map<MedicationDto>(medicationEntity));
        }

        /// <summary>
        /// Update medication
        /// </summary>
        /// <param name="id">Id of medication</param>
        /// <param name="medicationdto">Medication data to update</param>
        /// <returns></returns>
        /// <response code="404">When medcation with given id does not exist</response>
        [HttpPut("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> PutAsync(int id, MedicationDto medicationdto)
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

        /// <summary>
        /// Delete medication
        /// </summary>
        /// <param name="id">Id of medication</param>
        /// <returns></returns>
        /// <response code="404">When medcation with given id does not exist</response>
        [HttpDelete("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
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
