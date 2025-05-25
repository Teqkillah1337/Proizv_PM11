using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryManagementSystem.Models
{
    public class ActivityLogs
    {
        [Key]
        public int LogID { get; set; }
        public string Username { get; set; }
        public string ActivityType { get; set; }
        public string Details { get; set; }
        public DateTime Timestamp { get; set; }
    }
}
