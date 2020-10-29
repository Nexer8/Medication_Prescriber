using MedicationPresriber.Domain.Models;
using System;
using System.Linq;
using System.Text;

namespace MedicationPrescriber.Api
{
    public static class Tools
    {
        public static bool IsTimingDefinedByValue(string value)
        {
            try
            {
                _ = (Timing)Enum.Parse(typeof(Timing), value);
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        public static string GetValuesOfTiming()
        {
            StringBuilder result = new StringBuilder();

            foreach (var value in Enum.GetValues(typeof(Timing)))
            {
                result.Append(value);
                result.Append(" ");
            }

            return result.ToString();
        }


        public static IQueryable<Medication> FilterByDateIfNeeded(this IQueryable<Medication> query, DateTime? date)
        {
            if (date != null)
            {
                query = query.Where(x => x.StartDate <= date && x.EndDate >= date);
            }

            return query;
        }
    }
}
