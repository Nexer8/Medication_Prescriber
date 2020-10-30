using System;

namespace MedicationPresriber.Domain.Models
{
    public class Medication
    {
        public int Id { get; set; }

        public long PatientId { get; set; }

        public int DoctorId { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public int Dosage { get; set; }

        public Timing Timing { get; set; }

        public Doctor Doctor { get; set; }

        public Patient Patient { get; set; }
    }
}
