<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="JQuery_Ajax_Services.Services.AddEmployee" %>

 <html>
<head>
 
    <script src="../Scripts/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css"
        href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js">
    </script>
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnAddEmployee').click(function () {         
                var employee = {};               
                employee.FirstName = $('#txtFirstName').val();
                employee.LastName = $('#txtLastName').val();
                employee.Gender = $('#txtGender').val();
                employee.JobTitle = $('#txtJobTitle').val();
                employee.Salary = $('#txtSalary').val();
            
                $.ajax({
                    url: 'EmployeeService.asmx/AddEmployee',
                    method: 'post',
                    data: '{emp: ' + JSON.stringify(employee) + '}',
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        getAllEmployees();
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        
        

            function getAllEmployees() {
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
                        contentType: false,
                        processData: false,
                        columns: [
                            { 'data': 'Id' },
                            { 'data': 'FirstName' },
                            { 'data': 'LastName' },
                            { 'data': 'Gender' },
                            { 'data': 'JobTitle' },
                            {
                                'data': 'Salary',
                                'render': function (salary) {
                                    return "$" + salary;
                                }
                            }
                        
                        ]
                      
                    });
                }
            });
        }
        });

             </script>
</head>
<body style="font-family:Arial">
    <table border="1" style="border-collapse:collapse">
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
              <input type="button" id="btnAddEmployee" value="Add Employee" /> <br />
             <button type='button' class='btn btn- primary' style="margin:25px;" onclick="location.href = '/../Services/Employees.aspx';">Update or Delete Employee</button>
          
      <div class="col-lg-12 col-md-12 col-xm-12" style="width: 1200px; height:100vh; border: 1px solid black; padding: 3px">
            <table id="datatable">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Job Title</th>
                        <th>Salary</th>                    
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Job Title</th>                         
                        <th>Salary</th>
                        
                    </tr>
                </tfoot>
            </table>
        </div>
</body>
</html>