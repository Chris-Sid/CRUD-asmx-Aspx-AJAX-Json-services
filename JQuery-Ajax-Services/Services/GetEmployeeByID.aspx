<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetEmployeeByID.aspx.cs" Inherits="JQuery_Ajax_Services.Services.GetEmployeeByID" %>

<!DOCTYPE html>

 <html>
<head>
    <script src="../Scripts/jquery-1.10.2.js"></script>
  
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnGetEmployee').click(function () {

                var Id = $('#txtId').val();

                $.ajax({
                    url: 'EmployeeService.asmx/GetEmployeeById',
                    dataType: "json",
                    data: { Id: Id },
                    method: 'post',
                    
                    success: function (data) {
                        
                        $('#txtName').val(data.FirstName);
                        $('#txtLastName').val(data.LastName);
                        $('#txtGender').val(data.Gender);
                        $('#txtSalary').val(data.Salary);
                        $('#txtJobTitle').val(data.JobTitle);               
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        });
    </script>
</head>
<body style="font-family:Arial">
    ID : <input id="txtId" type="text" style="width:100px" />
    <input type="button" id="btnGetEmployee" value="Get Employee" />
    <br /><br />
    <table border="1" style="border-collapse:collapse">
        <tr>
            <td>Name</td>
            <td><input id="txtName" type="text" /></td>
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
            <td>Salary</td>
            <td><input id="txtSalary" type="text" /></td>
        </tr>
          <tr>
            <td>Salary</td>
            <td><input id="txtJobTitle" type="text" /></td>
        </tr>
    </table>
</body>
</html>