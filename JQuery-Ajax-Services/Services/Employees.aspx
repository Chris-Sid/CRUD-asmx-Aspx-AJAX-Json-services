<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="JQuery_Ajax_Services.Services.Employees" %>

 <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    

    <script src="../Scripts/jquery-3.3.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" type="text/css"
        href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
        <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js">
    </script>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
       <script src="https://cdn.datatables.net/responsive/2.2.1/js/dataTables.responsive.min.js"></script>
       <link href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.datatables.net/responsive/2.2.1/js/responsive.bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-ui.js"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'EmployeeService.asmx/GetAllEmployees',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    $('#datatable').dataTable({
                        paging: true,
                        sort: true,
                        searching: true,
                        scrollY: 200,
                        data: data,
                        columns: [
                           
                            { 'data': 'FirstName' },
                            { 'data': 'LastName' },
                            { 'data': 'Gender' },
                            { 'data': 'JobTitle' },                   
                            {
                                'data': 'Salary',
                                'render': function (salary) {
                                    return "$" + salary;
                                }
                            },
                     
                            {
                                "data": "Id", "render": function (Id) {
                                    return "<button type='button' class='btn btn- primary' onclick='getEmployeebyID(" + Id + ");'>Update</button> / <button type='button' class='btn btn- primary' onclick='Delete(" + Id + ");'>Delete</button>";
                                },
                            }
                        ]
                    });
                }
            });
        });

        function AddEmployee() {
            $("#ModalTitleAdd").html("Add Employee");
            $("#MyModalAdd").modal();
        $('#btnAddEmployee').click(function () {
            var employee = {};
            employee.FirstName = $('#txtFirstNameAdd').val();
            employee.LastName = $('#txtLastNameAdd').val();
            employee.Gender = $('#txtGenderAdd').val();
            employee.JobTitle = $('#txtJobTitleAdd').val();
            employee.Salary = $('#txtSalaryAdd').val();

            $.ajax({
                url: 'EmployeeService.asmx/AddEmployee',
                method: 'post',
                data: '{emp: ' + JSON.stringify(employee) + '}',
                contentType: "application/json; charset=utf-8",
                success: function () {
                    $('#MyModalAdd').hide();
                    location.reload();
                },
                error: function (err) {
                    alert(err);
                }
            });
        });
        return false;
        }
        function getEmployeebyID(Id) {
            $("#ModalTitle").html("Update Employee");
            $("#MyModal").modal();
            var Id = Id;
            $.ajax({
                url: "EmployeeService.asmx/GetEmployeeById",
                type: "GET",                         
                dataType: "json",
                data: { Id: Id },
                success: function (data) {               
                    $('#txtId').val(data.Id);
                    $('#txtFirstName').val(data.FirstName);
                    $('#txtLastName').val(data.LastName);
                    $('#txtGender').val(data.Gender);
                    $('#txtJobTitle').val(data.JobTitle);
                    $('#txtSalary').val(data.Salary);        
                   
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            return false;
        }

     

        function UpdateEmployee() { 
            var employee = {};
            employee.Id = $('#txtId').val();
            employee.FirstName = $('#txtFirstName').val();
            employee.LastName = $('#txtLastName').val();
            employee.Gender = $('#txtGender').val();
            employee.JobTitle = $('#txtJobTitle').val();
            employee.Salary = $('#txtSalary').val();
    
            $.ajax({
                url: "EmployeeService.asmx/UpdateEmployee",
                method: 'post',
                data: '{emp: ' + JSON.stringify(employee) + '}',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function () {
                    $('#MyModal').hide();
                    location.reload();

                  
                },
                error: function (err) {
                    alert(err);
                }
            });
            
        }

        
        function Delete(Id) {
             
            var ans = confirm("Are you sure you want to delete this Record?");
            if (ans) {
               
                $.ajax({
                    url: "EmployeeService.asmx/Delete" ,
                    type: "POST",
                    data: "{ 'Id': '" + Id + "'}",  
                    contentType: "application/json;charset=UTF-8",
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        window.location.href = window.location.href;
                    },
                   
                    error: function (errormessage) {
                        alert(errormessage.responseText);
                    }
                });
            }
        }
    </script>
</head>
<body style="font-family: Arial">
     
     <button type='button' class='btn btn- primary' onclick='AddEmployee();'>Add Employee</button> <br/><br/>
    <form id="form1" runat="server">
        <div class="col-lg-12 col-md-12 col-xm-12" style="width: 1200px; height:100vh; border: 1px solid black; padding: 3px">
         
            <table id="datatable">
                <thead>
                    <tr>           
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Job Title</th>                        
                        <th>Salary</th>
                        <th>Actions</th>
                    </tr>
                </thead>
      
            </table>
        </div>
    </form>
     <div class="modal fade" id="MyModalAdd">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" class="close" data-dismiss="modal">&times;</a>
                    <h4 id="ModalTitleAdd"></h4>
                </div>
                <div class="modal-body">
                    <form id="form2">
                        <fieldset id="SubmitForm2">
                       
    <table border="1" style="border-collapse:collapse">
    
        <tr>
            <td>FIrstName</td>
            <td><input id="txtFirstNameAdd" type="text" /></td>
        </tr>
        <tr>
            <td>LastName</td>
            <td><input id="txtLastNameAdd" type="text" /></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td><input id="txtGenderAdd" type="text" /></td>
        </tr>
        <tr>
            <td>JobTitle</td>
            <td><input id="txtJobTitleAdd" type="text" /></td>
        </tr>
 
        <tr>
            <td>Salary</td>
            <td><input id="txtSalaryAdd" type="text" /></td>
        </tr>
       
      
    </table>
            
    <div class="form-group">
                               
      
                            </div>
                        </fieldset>
                    </form>
                   
                  
             <input type="button" id="btnAddEmployee" value="Add Employee" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="MyModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" class="close" data-dismiss="modal">&times;</a>
                    <h4 id="ModalTitle"></h4>
                </div>
                <div class="modal-body">
                    <form id="form">
                        <fieldset id="SubmitForm">
                       
    <table border="1" style="border-collapse:collapse">
        <tr>
         
            <td><input id="txtId" type="hidden" /></td>
        </tr>
        <tr>
            <td>FIrstName</td>
            <td><input id="txtFirstName" type="text" /></td>
        </tr>
        <tr>
            <td>LastName</td>
            <td><input id="txtLastName" type="text" /></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td><input id="txtGender" type="text" /></td>
        </tr>
        <tr>
            <td>JobTitle</td>
            <td><input id="txtJobTitle" type="text" /></td>
        </tr>
 
        <tr>
            <td>Salary</td>
            <td><input id="txtSalary" type="text" /></td>
        </tr>
       
      
    </table>
            
    <div class="form-group">
                               
      
                            </div>
                        </fieldset>
                    </form>
                   
                  
                <button type='button' class='btn btn- primary' onclick='UpdateEmployee();'>Update</button>
                </div>
            </div>
        </div>
    </div>
          
      
</body>
</html>