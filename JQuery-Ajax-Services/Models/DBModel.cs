using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
namespace JQuery_Ajax_Services.Models
{
    public class DBModel : DbContext
    {
        public DBModel()
           : base("DefaultConnection")
        {
        }
        public DbSet<Employee> Employees { get; set; }

    }
}