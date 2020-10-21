using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/doctors/")]
    [ApiController]
    public class DoctorsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;

        public DoctorsController(MedicationPresriberDbContext medicationPresriberDbContext)
        {
            _context = medicationPresriberDbContext;
        }

        [HttpPost]
        public async Task<IActionResult> PostAsync(Doctor doctor)
        {
            await _context.AddAsync(_context);
            await _context.SaveChangesAsync();
            return Ok(doctor);
        }

        [HttpDelete("{id}")]
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

        [HttpGet("{id}")]
        public async Task<IActionResult> GetByIdAsync(int id)
        {
            var doctorToDelete =  await _context.Doctors.FirstOrDefaultAsync(x => x.Id == id);
            if (doctorToDelete is null)
            {
                return NotFound();
            }

            return Ok(doctorToDelete);
        }


        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            return Ok(await _context.Doctors.ToListAsync());
        }
    }
}
