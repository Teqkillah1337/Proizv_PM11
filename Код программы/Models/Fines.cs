using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryManagementSystem.Models
{
    public class Fines
    {
        [Key]
        public int FineID { get; set; }
        public int ReaderID { get; set; }
        public decimal Amount { get; set; }
        public string Reason { get; set; }
        public DateTime IssueDate { get; set; }
        public bool Paid { get; set; }

        public virtual Readers Reader { get; set; }

        internal static void Add(Fines fine)
        {
            throw new NotImplementedException();
        }
    }
}
