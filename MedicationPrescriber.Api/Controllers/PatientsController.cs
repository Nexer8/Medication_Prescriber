using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/patients")]
    [ApiController]
    public class PatientsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;

        public PatientsController(MedicationPresriberDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            return Ok(await _context.Patients.ToListAsync());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetByIdAsync(int id)
        {
            var patient = await _context.Patients.FirstOrDefaultAsync(x => x.PersonalId == id);

            if (patient == null)
            {
                return NotFound();
            }

            return Ok(patient);
        }

        
        [HttpPost]
        public async Task<IActionResult> PostAsync(Patient patient)
        {
            _context.Patients.Add(patient);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPatient", new { id = patient.PersonalId }, patient);
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
