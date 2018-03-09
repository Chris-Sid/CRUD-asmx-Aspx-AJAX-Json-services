using JQuery_Ajax_Services.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace JQuery_Ajax_Services.Services
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class EmployeeService : System.Web.Services.WebService
    {



        [WebMethod]
        public void GetAllEmployees()
        {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<Employee> employees = new List<Employee>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.Id = Convert.ToInt32(rdr["Id"]);
                    employee.FirstName = rdr["FirstName"].ToString();
                    employee.LastName = rdr["LastName"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.JobTitle = rdr["JobTitle"].ToString();
                    employee.Salary = Convert.ToInt32(rdr["Salary"]);
                  
                    employees.Add(employee);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(employees));
        }

        [WebMethod]

        public void GetEmployeeById(int Id) 
        {                                   
            Employee employee = new Employee();

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployeeById", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parameter = new SqlParameter();
                parameter.ParameterName = "@Id";
                parameter.Value = Id;

                cmd.Parameters.Add(parameter);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    employee.Id = Convert.ToInt32(rdr["Id"]);
                    employee.FirstName = rdr["FirstName"].ToString();
                    employee.LastName = rdr["LastName"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.JobTitle = rdr["JobTitle"].ToString();
                    employee.Salary = Convert.ToInt32(rdr["Salary"]);
            
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(employee));
        }
    
        
  


    [WebMethod]
        public void AddEmployee(Employee emp)
        {

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spInsertEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@FirstName",
                    Value = emp.FirstName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@LastName",
                    Value = emp.LastName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Gender",
                    Value = emp.Gender
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@JobTitle",
                    Value = emp.JobTitle
                });       

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Salary",
                    Value = emp.Salary
                });

      

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        [WebMethod]
        public void UpdateEmployee(Employee emp)
        {

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UpdateEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    Value = emp.Id
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@FirstName",
                    Value = emp.FirstName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@LastName",
                    Value = emp.LastName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Gender",
                    Value = emp.Gender
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@JobTitle",
                    Value = emp.JobTitle
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Salary",
                    Value = emp.Salary
                });

          

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        [WebMethod]
        public int Delete(int Id)
        {
            int i;
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DeleteEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Id", Id);
                i = Convert.ToInt32(cmd.ExecuteScalar());
                i = cmd.ExecuteNonQuery();
            }
            return i;
        }
    }
 }


