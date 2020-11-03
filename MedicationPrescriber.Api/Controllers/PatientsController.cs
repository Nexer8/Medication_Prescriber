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
using System.Net;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/patients")]
    [Produces("application/json")]
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


        /// <summary>
        /// Get patients
        /// </summary>
        /// <param name="doctorId">Get patients of specified doctor</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetAsync([FromQuery] int? doctorId)
        {
            var patientsEntitiesList = await _context.Patients.Include(x => x.User).ToListAsync();
            if(doctorId.HasValue)
            {
                patientsEntitiesList = await _context.Medications
                    .Include(x => x.Patient)
                    .Where(x => x.DoctorId == doctorId)
                    .Select(x =>x.Patient).ToListAsync();
            }

            return Ok(_mapper.Map<List<PatientDto>>(patientsEntitiesList));
        }

        /// <summary>
        /// Get patient by id
        /// </summary>
        /// <param name="id">PersonalId ofthe patient</param>
        /// <response code="404">If patient with given id does not exist</response>
        /// <returns></returns>
        [HttpGet("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> GetByIdAsync(long id)
        {
            var patientEntity = await _context.Patients.Include(x => x.User).FirstOrDefaultAsync(x => x.PersonalId == id);

            if (patientEntity == null)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<PatientDto>(patientEntity));
        }

        /// <summary>
        /// Create patient
        /// </summary>
        /// <param name="patientDto">Patient to create</param>
        /// <returns></returns>
        [HttpPost]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> PostAsync(PatientDto patientDto)
        {
            if (_context.Patients.Any(x => x.PersonalId == patientDto.PersonalId))
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

        /// <summary>
        /// Update patient
        /// </summary>
        /// <param name="id">PersonalId of the patient</param>
        /// <param name="patientDto">PatientDto with infromation to update</param>
        /// <returns></returns>
        /// <response code="404">If patient with given id does not exist</response>
        [HttpPut("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> PutAsync(long id, UpdatePatientDto patientDto)
        {
            var patient = await _context.Patients.Include(x => x.User).FirstOrDefaultAsync(x => x.PersonalId == id);
            if (patient == null)
            {
                return NotFound();
            }

            patient.User.FirstName = patientDto.FirstName;
            patient.User.LastName = patientDto.LastName;
            patient.Birthdate = patientDto.Birthdate;
            _context.Patients.Update(patient);
            _context.Users.Update(patient.User);
            await _context.SaveChangesAsync();

            var mappedPatient = _mapper.Map<PatientDto>(patient);
            mappedPatient.PersonalId = id;
            return Ok(mappedPatient);
        }

        /// <summary>
        /// Delete patient
        /// </summary>
        /// <param name="id">PersonalId of the patient</param>
        /// <returns></returns>
        /// <response code="404">If patient with given id does not exist</response>
        [HttpDelete("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteAsync(long id)
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
