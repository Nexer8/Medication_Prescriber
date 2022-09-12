using System.Collections.Generic;

namespace MedicationPresriber.Domain.Models
{
    public class Doctor
    {
        public int Id { get; set; }

        public string Specialization { get; set; }

        public int UserId { get; set; }

        public User User { get; set; }

        public List<Medication> Medications { get; set; }
    }
}
