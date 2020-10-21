using System;
using System.ComponentModel.DataAnnotations;

namespace MedicationPresriber.Domain.Models
{
    public class Patient
    {
        public int PersonalId { get; set; }

        public DateTime Birthdate { get; set; }

        public int UserId { get; set; }

        public User User { get; set; }
    }
}
