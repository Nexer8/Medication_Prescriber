using MedicationPrescriber.Api.Dtos;
using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using System.Collections.Generic;
using System.Net;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/doctors/")]
    [Produces("application/json")]
    [ApiController]
    public class DoctorsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;
        private readonly IMapper _mapper;

        public DoctorsController(MedicationPresriberDbContext medicationPresriberDbContext, IMapper mapper)
        {
            _context = medicationPresriberDbContext;
            _mapper = mapper;
        }

        /// <summary>
        /// Create doctor
        /// </summary>
        /// <param name="doctorDto">Doctor to create</param>
        /// <returns></returns>
        [HttpPost]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> PostAsync(CreateDoctorDto doctorDto)
        {
            var user = new User
            {
                FirstName = doctorDto.FirstName,
                LastName = doctorDto.LastName
            };
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            var doctorEntity = _mapper.Map<Doctor>(doctorDto);
            doctorEntity.UserId = user.Id;
            await _context.AddAsync(doctorEntity);

            await _context.SaveChangesAsync();
            return Ok(_mapper.Map<DoctorDto>(doctorEntity));
        }

        /// <summary>
        /// Delete doctor
        /// </summary>
        /// <param name="id">Id of the doctor</param>
        /// <returns></returns>
        /// <response code="404">If doctor with given id does not exist</response>
        [HttpDelete("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> DeleteAsync(int id)
        {
            var doctorToDelete = _context.Doctors.FirstOrDefault(x => x.Id == id);
            if (doctorToDelete is null)
            {
                return NotFound();
            }

            _context.Doctors.Remove(doctorToDelete);
            await _context.SaveChangesAsync();
            return Ok();
        }

        /// <summary>
        /// Get doctor by Id
        /// </summary>
        /// <param name="id">Id of the doctor</param>
        /// <returns></returns>
        /// <response code="404">If doctor with given id does not exist</response>
        [HttpGet("{id}")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> GetByIdAsync(int id)
        {
            var doctorToDelete =  await _context.Doctors.Include(x => x.User).FirstOrDefaultAsync(x => x.Id == id);
            if (doctorToDelete is null)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<DoctorDto>(doctorToDelete));
        }

        /// <summary>
        /// Get doctors
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            var doctorEntitiesList = await _context.Doctors.Include(x => x.User).ToListAsync();
            return Ok(_mapper.Map<List<DoctorDto>>(doctorEntitiesList));
        }
    }
}
