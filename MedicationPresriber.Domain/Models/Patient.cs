using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedicationPresriber.Domain.Models
{
    public class Patient
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long PersonalId { get; set; }

        public DateTime Birthdate { get; set; }

        public int UserId { get; set; }

        public User User { get; set; }

        public List<Medication> Medications { get; set; }
    }
}
