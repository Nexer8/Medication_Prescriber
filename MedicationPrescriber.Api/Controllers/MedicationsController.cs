using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MedicationPresriber.Domain;
using MedicationPresriber.Domain.Models;

namespace MedicationPrescriber.Api.Controllers
{
    [Route("api/medications")]
    [ApiController]
    public class MedicationsController : ControllerBase
    {
        private readonly MedicationPresriberDbContext _context;

        public MedicationsController(MedicationPresriberDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            return Ok(await _context.Medications.ToListAsync());
        }
         
        [HttpGet("{id}")]
        public async Task<IActionResult> GeByIdAsync(int id)
        {
            var medication = await _context.Medications.FirstOrDefaultAsync(x => x.Id == id);

            if (medication == null)
            {
                return NotFound();
            }

            return Ok(medication);
        }

        
        [HttpPost]
        public async Task<IActionResult> PostAsync(Medication medication)
        {
            _context.Medications.Add(medication);
            await _context.SaveChangesAsync();

            return Ok(medication);
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
