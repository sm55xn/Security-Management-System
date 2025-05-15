using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Security_Management_Server.Models
{
    [Keyless]
    public class HandleModel
    {
       
        public int IsHandle { get; set; }
        public string? nameEmp { get; set; }
       
    }
}