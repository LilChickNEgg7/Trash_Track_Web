﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_Dispatcher.aspx.cs" Inherits="Capstone.SAM_Dispatcher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>PBC - Dashboard</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <%--#052507--%>
    <style>
        /* Add this style to change the modal header and footer background color */
        .modal-header,
        .modal-footer {
            background-color: #041d06;
            border-top-color: #052507;
            border-bottom-color: #052507;
        }

        .modal-content .modal-header .btn-close {
            color: aquamarine !important;
        }
        /* Add this style to change the modal title text color */
        .modal-title {
            color: mediumaquamarine; /* You can adjust the text color as needed */
            /*        text-align: center !important;
*/
        }

        /* Add this style to change the modal body background color */
        .modal-body {
            background-color: #052507; /* You can adjust the background color as needed */
            /*        border-color: aquamarine;
*/
        }

        .modal-content .modal-header button.custom-close-button {
            color: aquamarine !important;
            background-color: aquamarine !important; /* Background color */
            border: none; /* Remove the default border */
            padding: 0; /* Remove padding */
        }
        /* Add this style to change the color of the close button */
        .btn-close {
            color: #ffffff; /* You can adjust the text color as needed */
        }

        .modal-content {
            border: 2.5px solid aquamarine; /* You can adjust the border color as needed */
            border-radius: 10px; /* You can adjust the border-radius as needed */
        }

        .modal-header .btn-close {
            color: aquamarine;
            background-color: aquamarine;
        }

        .gridview-container .columns_label {
            white-space: normal;
            word-wrap: break-word;
        }
    </style>
    <style type="text/css">
        .customGridView tr {
            border-bottom: 1px solid #0a4d1d;
        }
    </style>

    <style>
        .arrow-button {
            background-color: transparent;
            /*        color: orangered;
*/ border: none;
            cursor: pointer;
            font-size: 16px; /* Adjust the font size as needed */
        }

            .arrow-button::before {
                content: "\2191"; /* Unicode character for the arrow-up */
            }
    </style>
    <style>
        .edit-icon {
            filter: invert(68%) sepia(54%) saturate(2180%) hue-rotate(161deg) brightness(91%) contrast(87%);
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        function search() {
            var searchText = document.getElementById('<%= txtSearch.ClientID %>').value.toUpperCase();
            var grid = document.getElementById('<%= gridViewDispatcher.ClientID %>');

            for (var i = 1; i < grid.rows.length; i++) {
                var row = grid.rows[i];
                var id = row.cells[0].innerHTML.toUpperCase();
                var firstname = row.cells[1].innerHTML.toUpperCase();
                var mi = row.cells[2].innerHTML.toUpperCase();
                var lastname = row.cells[3].innerHTML.toUpperCase();
                var username = row.cells[4].innerHTML.toUpperCase();
                var contact = row.cells[5].innerHTML.toUpperCase();
                var email = row.cells[6].innerHTML.toUpperCase();
                var created_at = row.cells[7].innerHTML.toUpperCase();
                var updated_at = row.cells[8].innerHTML.toUpperCase();
                var status = row.cells[9].innerHTML.toUpperCase();
                //var date = row.cells[9].innerHTML.toUpperCase();
                //var stock_level = row.cells[10].innerHTML.toUpperCase();
                if (id.indexOf(searchText) > -1 || firstname.indexOf(searchText) > -1 || mi.indexOf(searchText) > -1 ||
                    lastname.indexOf(searchText) > -1 || username.indexOf(searchText) > -1 ||
                    contact.indexOf(searchText) > -1 || email.indexOf(searchText) > -1 ||
                    created_at.indexOf(searchText) > -1 || updated_at.indexOf(searchText) > -1 ||
                    status.indexOf(searchText) > -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }


    </script>

</head>
<form id="form2" runat="server">
    <div>
        <body style="background-color: #041d06">

            <!-- ======= Header ======= -->
            <%--#9ee2a0, #9ee2a0, #9ee2a0--%>
            <header style="background-color: black; height: 80px" id="header" class="header fixed-top d-flex align-items-center">

                <div class="d-flex align-items-center justify-content-between">
                    <a href="WAREHOUSE_ADD_ITEM.aspx" class="logo d-flex align-items-center">
                        <img style="border-radius: 1px" src="Pictures/logo2.png" alt="" />
                        <span style="color: aqua; font-weight: 900; font-family: 'Agency FB'" class="d-none d-lg-block">PBC</span>
                    </a>
                    <i style="color: aqua" class="bi bi-list toggle-sidebar-btn"></i>
                </div>
                <!-- End Logo -->
                <nav class="header-nav ms-auto">
                    <ul class="d-flex align-items-center">
                        <li class="nav-item dropdown">
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                            </ul>
                            <!-- End Notification Dropdown Items -->

                        </li>
                        <!-- End Notification Nav -->

                        <li class="nav-item dropdown pe-3">

                            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown" style="color: aqua">
                                <asp:ImageMap ID="profile_image" runat="server" alt="Profile" class="rounded-circle"></asp:ImageMap>
                                <span style="color: aqua" class="d-none d-md-block dropdown-toggle ps-2">
                                    <asp:Label ID="Label2" runat="server" Text=""></asp:Label></span>
                            </a>
                            <!-- End Profile Image Icon -->

                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                                <li class="dropdown-header">
                                    <h6>
                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label></h6>
                                    <span>
                                        <asp:Label ID="Label3" runat="server" Text="Administrator"></asp:Label></span>
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <a class="dropdown-item d-flex align-items-center" href="Admin_Change_Pass.aspx">
                                        <i class="bi bi-gear"></i>
                                        <span>Account Settings</span>
                                    </a>
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <hr class="dropdown-divider">
                                </li>

                                <li>
                                    <a class="dropdown-item d-flex align-items-center" href="#" onclick="confirmLogout()">
                                        <i class="bi bi-box-arrow-right"></i>
                                        <span>Sign Out</span>
                                    </a>
                                </li>
                                <script>
                                    function confirmLogout() {
                                        var isConfirmed = confirm("Are you sure you want to log out?");
                                        if (isConfirmed) {
                                            // If confirmed, redirect to the logout page
                                            window.location.href = "LOGIN.aspx";
                                        } else {
                                            // If not confirmed, do nothing or handle as needed
                                        }
                                    }
                                </script>
                            </ul>
                            <!-- End Profile Dropdown Items -->
                        </li>
                        <!-- End Profile Nav -->

                    </ul>
                </nav>
                <!-- End Icons Navigation -->

            </header>
            <!-- End Header -->

            <!-- ======= Sidebar ======= -->
            <%--#052507--%>
            <aside style="padding-top: 50px" id="sidebar" class="sidebar">

                <ul class="sidebar-nav" id="sidebar-nav">

                    <li class="nav-item">
                        <a class="nav-link collapsed" href="SAM_Dashboard.aspx">
                            <i class="bi bi-grid"></i>
                            <span>Dashboard</span>
                        </a>

                    </li>
                    <!-- End Employee Nav -->


                    <li class="nav-item">
                        <a class="nav-link" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
                            <%--          <i class="bi bi-people" style="color:#52996F"></i><span style="color:#52996F">Manage Account</span><i class="bi bi-chevron-down ms-auto" style="color:aquamarine"></i>--%>
                            <i class="bi bi-people"></i><span>Manage Account</span><i class="bi bi-chevron-down ms-auto"></i>

                        </a>
                        <ul id="forms-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
                            <li>
                                <a href="SAM_AccountMan.aspx">
                                    <i class="bi bi-circle"></i><span>Account Manager</span>
                                </a>
                            </li>
                            <li>
                                <a href="SAM_Dispatcher.aspx">
                                    <i class="bi bi-circle"></i><span>Dispatcher</span>
                                </a>
                            </li>

                            <li>
                                <a href="SAM_Hauler.aspx" class="active">
                                    <i class="bi bi-circle"></i><span>Hauler</span>
                                </a>
                            </li>

                            <li>
                                <a href="WAREHOUSE_ADD_CATEGORY.aspx">
                                    <i class="bi bi-circle"></i><span>Billing Officer</span>
                                </a>
                            </li>

                            <li>
                                <a href="SAM_ContracFINAL.aspx">
                                    <i class="bi bi-circle"></i><span>Non-Contractual</span>
                                </a>
                            </li>

                            <li>
                                <a href="SAM_ContracFINAL.aspx">
                                    <i class="bi bi-circle"></i><span>Contractual</span>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
                            <i class="ri-bill-line"></i><span>Reports</span><i class="bi bi-chevron-down ms-auto"></i>
                        </a>
                        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                            <li>
                                <a href="Admin_Billing_GenerateBill.aspx">
                                    <i class="bi bi-circle"></i><span>Generate Bill</span>
                                </a>
                            </li>

                            <li>
                                <a href="Admin_Billing_Controls.aspx">
                                    <i class="bi bi-circle"></i><span>Controls</span>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <%-- <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#receipt-nav" data-bs-toggle="collapse" href="#">
                <i class="ri-secure-payment-line"></i><span>Payment</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="receipt-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li>
                    <a href="Admin_Payment_ViewPays.aspx">
                        <i class="bi bi-circle"></i><span>View Payments</span>
                    </a>
                </li>
            </ul>
        </li>--%>


                    <%--  <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
          <i class="ri-bar-chart-2-line"></i><span>Reports</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="components-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <a href="WAREHOUSE_VIEW_REQUESTS.aspx">
              <i class="bi bi-circle"></i><span>Requests</span>
            </a>
          </li>
      </li>--%><!-- End Transaction Nav -->
                </ul>
            </aside>
            <!-- End Sidebar-->

            <main id="main" class="main">

                <div class="pagetitle">
                    <h1 style="padding-top: 20px; color: chartreuse">Manage Accounts</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="SAM_Dashboard.aspx">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="admin_manage_account.aspx">Manage Accounts   </a></li>
                            <li class="breadcrumb-item">Dispatcher</li>

                        </ol>
                    </nav>
                </div>
                <!-- End Page Title -->

                <section class="section dashboard">
                    <div class="row">

                        <!-- Left side columns -->
                        <div class="col-lg-8">
                            <div class="row">
                            </div>
                        </div>
                        <!-- End Left side columns -->

                        <!-- Right side columns -->
                        <div class="col-lg-4">
                        </div>
                        <!-- End Right side columns -->

                    </div>
                </section>

                <%-- ADD OPERATIONAL DISPATCHER --%>

                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <!-- Modal Header -->
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Add Operational Dispatcher</h1>
                                <button type="button" class="btn-close custom-close-button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <!-- Modal Body -->
                            <div class="modal-body">
                                <!-- Firstname -->
                                <div class="mb-3">
                                    <asp:Label ID="Label13" runat="server" class="form-label" Text="Firstname" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_firstname" runat="server" class="form-control" onkeyup="validateFirstname()"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid firstname.</div>
                                </div>

                                <!-- Middle Initial -->
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" Text="M.I" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_mi" class="form-control" runat="server" MaxLength="1" onkeypress="return isLetter(event)"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid middle initial (optional).</div>
                                </div>

                                <!-- Lastname -->
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" Text="Lastname" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_lastname" runat="server" class="form-control" onkeyup="validateLastname()"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid lastname.</div>
                                </div>

                                <!-- Address -->
                                <div class="mb-3">
                                    <asp:Label ID="Label11" runat="server" Text="Address" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_address" runat="server" class="form-control" onkeyup="validateAddress()"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid address.</div>
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <asp:Label ID="Label10" runat="server" Text="Email" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_email" runat="server" class="form-control" onkeyup="validateEmail()"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid email address.</div>
                                </div>

                                <!-- Password -->
                                <div class="col-12 mb-3">
                                    <asp:Label ID="Label7" runat="server" Text="Password" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <div class="input-group">
                                        <asp:TextBox ID="emp_pass" runat="server" class="form-control" type="password" onkeyup="validatePassword()"></asp:TextBox>
                                        <span class="input-group-text" style="cursor: pointer;" onclick="togglePasswords()">
                                            <i id="passIcon" class="fas fa-eye-slash"></i>
                                        </span>
                                    </div>
                                    <div class="invalid-feedback">Password must be at least 6 characters long and contain at least one uppercase letter, one number, and one special character.</div>
                                </div>


                                <!-- Contact No. -->
                                <div class="mb-3">
                                    <asp:Label ID="Label8" runat="server" Text="Contact No." for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_contact" runat="server" class="form-control" onkeyup="validateContact()"></asp:TextBox>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid Philippines contact number (e.g., 09XXXXXXXXX).</div>
                                </div>

                                <!-- Display (Role) -->
                                <div class="mb-3">
                                    <asp:Label ID="Label6" runat="server" Text="Employee Role" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:TextBox ID="emp_role" runat="server" class="form-control" Style="margin-top: 10px" onkeyup="validateLastname()" ReadOnly="True"></asp:TextBox>
                                </div>



                                <!-- File Upload (with Image Preview) -->
                                <div class="mb-3">
                                    <asp:Label ID="Label12" runat="server" Text="Picture" for="inputText" Style="color: chartreuse"></asp:Label>
                                    <asp:FileUpload ID="formFile" accept="image/*" class="form-control" runat="server" OnChange="previewImage1()" />
                                    <asp:ImageMap ID="imagePreview" src="Pictures/blank_prof.png" runat="server" alt="Image Preview" CssClass="img-thumbnail mt-2" Style="max-width: 150px;"></asp:ImageMap>
                                    <span id="fileError" style="color: red; display: none;">File uploaded is not an image.</span>
                                </div>
                            </div>

                            <!-- Modal Footer -->
                            <div class="modal-footer">
                                <asp:Button ID="ClearForm" Text="Close" runat="server" class="btn btn-secondary" data-bs-dismiss="modal" OnClick="ClearForm_Click" />
                                <asp:Button class="btn btn-primary" ID="submitBtn" runat="server" Text="Submit Form" OnClick="submitBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <section style="background-color: #052507; padding: 25px; border-radius: 8px; box-shadow: 0 0 5px rgba(0, 0, 0, .2)">

                    <div>
                        <asp:ImageMap ID="ImageMap1" runat="server" ImageUrl="Pictures//box_format.png" Style="float: right; margin-right: 0px; margin-top: 0px; width: 50px"></asp:ImageMap>
                    </div>
                    <div style="margin-top: 50px; margin-bottom: 30px">
                        <asp:TextBox Style="border-radius: 10px; padding-left: 10px; padding: 2px; margin-top: 7px; border-color: aquamarine; border-width: 3px" placeholder="Search" ID="txtSearch" runat="server" oninput="search();" AutoPostBack="false"></asp:TextBox>
                        <button type="button" class="btn btn-primary" style="margin: 10px; float: right; background-color: #052507; border-color: aquamarine; border-radius: 8px; border-width: 3px" data-bs-toggle="modal" data-bs-target="#exampleModal">
                            Add Operational Dispatcher +
                        </button>
                    </div>

                    <div class="gridview-container">
                        <asp:GridView Style="width: 100%; word-break: break-all; table-layout: fixed" ID="gridViewDispatcher" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                            DataKeyNames="emp_id" AllowPaging="False" CellPadding="20" GridLines="None">
                            <AlternatingRowStyle BackColor="white" ForeColor="Black" />

                            <Columns>
                                <asp:BoundField DataField="emp_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="emp_id" ItemStyle-Width="100px">
                                    <ItemStyle Width="100px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_fname" HeaderText="First Name" SortExpression="emp_fname" ItemStyle-Width="150px">
                                    <ItemStyle Width="150px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_mname" HeaderText="M.I" SortExpression="emp_mname" ItemStyle-Width="100px">
                                    <ItemStyle Width="100px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_lname" HeaderText="Last Name" SortExpression="emp_lname" ItemStyle-Width="150px">
                                    <ItemStyle Width="150px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_contact" HeaderText="Contact" SortExpression="emp_contact" ItemStyle-Width="100px">
                                    <ItemStyle Width="100px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_email" HeaderText="Contact" SortExpression="emp_email" ItemStyle-Width="100px">
                                    <ItemStyle Width="100px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_status" HeaderText="Email" SortExpression="emp_status" ItemStyle-Width="200px">
                                    <ItemStyle Width="200px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_created_at" HeaderText="Created At" SortExpression="emp_created_at" ItemStyle-Width="150px">
                                    <ItemStyle Width="150px" Wrap="true" />
                                </asp:BoundField>
                                <asp:BoundField DataField="emp_updated_at" HeaderText="Updated At" SortExpression="emp_updated_at" ItemStyle-Width="150px">
                                    <ItemStyle Width="150px" Wrap="true" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Button Style="font-size: 10px; color: orangered; font-weight: bold;" ID="btnUnsuspend" runat="server" Text='<%# Eval("emp_status") + " ▼"%>'
                                            OnClick="Unsuspend_Click"
                                            OnClientClick="return confirm('Are you sure you want to Unsuspend this account manager?');"
                                            Visible='<%# Eval("emp_status").ToString() == "Suspend" %>' CommandArgument='<%# Eval("emp_id") %>' />
                                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("emp_status")%>' Visible='<%# Eval("emp_status").ToString() == "Inactive" %>' />
                                        <asp:Button Style="font-size: 10px; color: lawngreen; font-weight: bold;" ID="btnSuspend" runat="server" Text='<%# Eval("emp_status") + " ▲"%>'
                                            OnClick="Suspend_Click"
                                            OnClientClick="return confirm('Are you sure you want to Suspend this account manager?');"
                                            Visible='<%# Eval("emp_status").ToString() == "Active" %>' CommandArgument='<%# Eval("emp_id") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="update" runat="server" OnClick="Update_Click" CommandArgument='<%# Eval("emp_id") %>'>
                                            <asp:Image ID="imgEdit" runat="server" ImageUrl="~/Pictures/editlogo.png" Width="35%" Height="35%" Style="margin-right: 10px" AlternateText="Edit" />
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="Remove" runat="server" OnClick="Remove_Click" CommandArgument='<%# Eval("emp_id") %>' OnClientClick="return confirm('Are you sure you want to remove this account manager?');">
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Pictures/removeBtn.png" Width="35%" Height="35%" AlternateText="Remove" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <RowStyle BackColor="White" ForeColor="Black" />
                            <EditRowStyle BackColor="#90EE90" />
                            <FooterStyle BackColor="Black" Font-Bold="True" ForeColor="#f9cfb4" />
                            <HeaderStyle BackColor="#66CDAA" Font-Bold="True" ForeColor="black" BorderStyle="None" />
                            <PagerStyle BorderColor="#CC9900" Font-Size="20px" BackColor="White" ForeColor="#f9cfb4" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="Black" />
                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                            <SortedDescendingCellStyle BackColor="Black" />
                            <SortedDescendingHeaderStyle BackColor="#15524A" />
                        </asp:GridView>
                    </div>


                </section>


                <asp:LinkButton ID="LinkButton1" runat="server"></asp:LinkButton>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <!-- First Form (Update Info) -->
                <asp:Panel ID="updatePanel" CssClass="card shadow-lg scrollable-panel" runat="server" Style="max-width: 600px; background-color: #052507; border: 1px solid aquamarine; border-radius: 8px;">
                    <contenttemplate>
                        <div class="card bg-light" style="background-color: #052507;">
                            <!-- Header Section -->
                            <div class="card-header text-center" style="background-color: #052507; color: aquamarine;">
                                <h4 class="mb-0">Update Information</h4>
                            </div>

                            <!-- Body Section -->
                            <div class="card-body" style="background-color: #052507;">
                                <div class="row">
                                    <!-- ID (Disabled) -->
                                    <div class="col-12 mb-3">
                                        <div class="input-group input-group-sm">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">ID</span>
                                            </div>
                                            <asp:TextBox ID="txtbxID" runat="server" CssClass="form-control" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>

                                    <!-- Firstname -->
                                    <div class="col-6 mb-3">
                                        <asp:Label ID="Label17" runat="server" Text="Firstname" Style="color: chartreuse"></asp:Label>

                                        <asp:TextBox ID="txtbfirstname" runat="server" CssClass="form-control" ClientIDMode="Static" onkeyup="validateUpdateFirstname()"></asp:TextBox>
                                        <div class="valid-feedback">Looks good!</div>
                                        <div class="invalid-feedback">Please provide a valid firstname.</div>
                                    </div>

                                    <!-- Lastname -->
                                    <div class="col-6 mb-3">
                                        <asp:Label ID="Label16" runat="server" Text="Lastname" Style="color: chartreuse"></asp:Label>

                                        <asp:TextBox ID="txtLastname" runat="server" CssClass="form-control" ClientIDMode="Static" onkeyup="validateUpdateLastname()"></asp:TextBox>
                                        <div class="valid-feedback">Looks good!</div>
                                        <div class="invalid-feedback">Please provide a valid lastname.</div>
                                    </div>

                                    <!-- Middle Initial (Optional) -->
                                    <div class="col-6 mb-3">
                                        <asp:Label ID="Label14" runat="server" Text="Middle Initial" Style="color: chartreuse"></asp:Label>

                                        <asp:TextBox ID="txtmi" runat="server" CssClass="form-control" ClientIDMode="Static" MaxLength="1" onkeypress="return isLetter(event)"></asp:TextBox>
                                        <div class="valid-feedback">Looks good!</div>
                                        <div class="invalid-feedback">Please provide a valid middle initial (optional).</div>

                                    </div>

                                    <!-- Contact -->
                                    <div class="col-6 mb-3">
                                        <asp:Label ID="Label15" runat="server" Text="Contact No." Style="color: chartreuse"></asp:Label>

                                        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" ClientIDMode="Static" onkeyup="validateUpdateContact()"></asp:TextBox>
                                        <div class="valid-feedback">Looks good!</div>
                                        <div class="invalid-feedback">Please provide a valid Philippines contact number (e.g., 09XXXXXXXXX).</div>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="col-12 mb-3">
                                    <div class="mb-3">
                                        <%--<div class="input-group-prepend">
                                <span class="input-group-text">Email</span>
                            </div>--%>
                                        <asp:Label ID="Label18" runat="server" Text="Email" Style="color: chartreuse"></asp:Label>

                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ClientIDMode="Static" onkeyup="validateUpdateEmail()"></asp:TextBox>
                                        <div class="valid-feedback">Looks good!</div>
                                        <div class="invalid-feedback">Please provide a valid email address.</div>
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="col-12 mb-3">

                                    <asp:Label ID="Label19" runat="server" Text="Password" Style="color: chartreuse"></asp:Label>
                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control mt-2" type="password" onkeyup="validateUpdatePassword()"></asp:TextBox>
                                        <span class="input-group-text mt-2" style="cursor: pointer;" onclick="toggleUpdatePassword()">
                                            <i id="updatePasswordIcon" class="fas fa-eye-slash"></i>
                                        </span>
                                    </div>
                                    <div class="invalid-feedback">Password must be at least 6 characters long and contain at least one uppercase letter, one number, and one special character.</div>
                                </div>





                                <!-- Picture Upload -->
                                <div class="col-12 mb-3">
                                    <asp:Label ID="Label20" runat="server" Text="Picture" Style="color: chartreuse"></asp:Label>
                                    <asp:FileUpload ID="FileUpload1" accept="image/*" class="form-control" runat="server" OnChange="previewUpdateImage();" />
                                    <asp:Image ID="imagePreviewUpdate" runat="server" AlternateText="Image Preview" CssClass="img-thumbnail mt-2" Style="max-width: 150px;" />
                                    <span id="fileErrorUpdate" class="text-danger" style="display: none;">File uploaded is not an image.</span>
                                </div>
                            </div>
                        </div>

                        <!-- Footer Section -->
                        <div class="card-footer text-center" style="background-color: #052507; color: aquamarine;">
                            <asp:Button ID="btncancel" CssClass="btn btn-secondary" runat="server" Text="Cancel" />
                            <asp:Button ID="btnUpdate" CssClass="btn btn-primary" runat="server" Text="Update" OnClick="UpdateAdminInfo" OnClientClick="return confirm('Are you sure you want to update category?');" />
                        </div>

                    </contenttemplate>
                </asp:Panel>



                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" CancelControlID="btncancel" PopupControlID="updatePanel" TargetControlID="LinkButton1" BackgroundCssClass="Background" DropShadow="True"></ajaxToolkit:ModalPopupExtender>

                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script>
                    $(function () {
                        $("input[name='EmpId']").on('input', function (e) {
                            $(this).val($(this).val().replace(/[^0-9]/g, ''));
                        });
                    });
                </script>


                <style>
                    /* Container Styles */
                    .gridview-container {
                        max-height: 530px;
                        overflow-y: auto;
                        position: relative;
                    }

                        /* WebKit Scrollbar Styles */
                        .gridview-container::-webkit-scrollbar {
                            width: 12px;
                        }

                        .gridview-container::-webkit-scrollbar-thumb {
                            background-color: #1C5E55;
                            border-radius: 10px;
                            border: 3px solid aquamarine;
                        }

                        .gridview-container::-webkit-scrollbar-track {
                            background-color: #f5f5f5;
                            border-radius: 10px;
                        }

                    /* Firefox Scrollbar Styles */
                    .gridview-container {
                        scrollbar-color: #1C5E55 #f5f5f5;
                    }

                        /* Table Styles */
                        .gridview-container table {
                            table-layout: fixed;
                            width: 100%;
                        }

                        .gridview-container th,
                        .gridview-container td {
                            white-space: nowrap;
                            overflow: hidden;
                            text-overflow: ellipsis;
                        }

                        .gridview-container .description-column {
                            white-space: normal;
                            word-wrap: break-word;
                        }

                        .gridview-container thead {
                            position: sticky;
                            top: 0;
                            background-color: #1C5E55;
                            color: white;
                            z-index: 2; /* Keep the header on top */
                        }

                            .gridview-container thead th {
                                position: sticky;
                                top: 0;
                                background-color: #1C5E55;
                                color: white;
                                z-index: 3; /* Increase z-index to keep the header text on top */
                            }

                        /* Animation for Hover Effect */
                        .gridview-container::-webkit-scrollbar-thumb:hover {
                            background-color: #167c6d;
                        }

                        .gridview-container::-webkit-scrollbar-track:hover {
                            background-color: #d8d8d8;
                        }

                        .gridview-container::-webkit-scrollbar-thumb:active {
                            background-color: #134f45;
                        }

                        .gridview-container::-webkit-scrollbar-track:active {
                            background-color: #c2c2c2;
                        }
                </style>

                <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                <script>
                    $(document).ready(function () {
                        $('#<%= gridViewDispatcher.ClientID %> .edit-button').on('click', function () {
                            var rowIndex = $(this).closest('tr').index();
                            $('#<%= gridViewDispatcher.ClientID %> tr').height('auto'); // Reset all rows to auto height
                            $('#<%= gridViewDispatcher.ClientID %> tr:eq(' + rowIndex + ')').height($('#<%= gridViewDispatcher.ClientID %> tr:eq(' + rowIndex + ')').height());
                        });
                    });

                </script>

                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script>


                    //Validation Functions for Add Account Manager
                    function validateFirstname() {
                        const firstname = document.getElementById('<%= emp_firstname.ClientID %>');
                        if (!/^[A-Za-z]+$/.test(firstname.value)) {
                            firstname.classList.add('is-invalid');
                            firstname.classList.remove('is-valid');
                        } else {
                            firstname.classList.remove('is-invalid');
                            firstname.classList.add('is-valid');
                        }
                    }

                    // Validate Middle Initial (Required)
                    function validateMiddleInitialRequired() {
                        const middleInitial = document.getElementById('<%= emp_mi.ClientID %>');

                        // Validate the input
                        if (middleInitial.value.length > 1 || !/^[A-Za-z]$/.test(middleInitial.value)) {
                            middleInitial.classList.add('is-invalid');
                            middleInitial.classList.remove('is-valid');
                        } else {
                            middleInitial.classList.remove('is-invalid');
                            middleInitial.classList.add('is-valid');
                        }
                    }

                    function validateLastname() {
                        const lastname = document.getElementById('<%= emp_lastname.ClientID %>');
                        if (!/^[A-Za-z]+$/.test(lastname.value)) {
                            lastname.classList.add('is-invalid');
                            lastname.classList.remove('is-valid');
                        } else {
                            lastname.classList.remove('is-invalid');
                            lastname.classList.add('is-valid');
                        }
                    }

                    function validateEmail() {
                        const email = document.getElementById('<%= emp_email.ClientID %>');
                        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
                        if (!emailPattern.test(email.value)) {
                            email.classList.add('is-invalid');
                            email.classList.remove('is-valid');
                        } else {
                            email.classList.remove('is-invalid');
                            email.classList.add('is-valid');
                        }
                    }

          <%--function validateContact() {
              const contact = document.getElementById('<%= emp_contact.ClientID %>');
              const contactPattern = /^09\d{9}$/;
              if (!contactPattern.test(contact.value)) {
                  contact.classList.add('is-invalid');
                  contact.classList.remove('is-valid');
              } else {
                  contact.classList.remove('is-invalid');
                  contact.classList.add('is-valid');
              }
          }--%>
                    function validateContact() {
                        const contact = document.getElementById('<%= emp_contact.ClientID %>');

                        // Remove non-numeric characters and limit to 11 digits
                        contact.value = contact.value.replace(/\D/g, ''); // Allow only numbers
                        if (contact.value.length > 11) {
                            contact.value = contact.value.substring(0, 11); // Limit to 11 digits
                        }

                        // Validation pattern for Philippines contact numbers
                        const contactPattern = /^09\d{9}$/; // Should start with 09 and followed by 9 digits
                        if (!contactPattern.test(contact.value)) {
                            contact.classList.add('is-invalid');
                            contact.classList.remove('is-valid');
                        } else {
                            contact.classList.remove('is-invalid');
                            contact.classList.add('is-valid');
                        }
                    }


                    function validateAddress() {
                        const address = document.getElementById('<%= emp_address.ClientID %>');
                        if (address.value.trim() === "") {
                            address.classList.add('is-invalid');
                            address.classList.remove('is-valid');
                        } else {
                            address.classList.remove('is-invalid');
                            address.classList.add('is-valid');
                        }
                    }

                    function validatePassword() {
                        const password = document.getElementById('<%= emp_pass.ClientID %>');
                        const passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$/;
                        if (!passwordPattern.test(password.value)) {
                            password.classList.add('is-invalid');
                            password.classList.remove('is-valid');
                        } else {
                            password.classList.remove('is-invalid');
                            password.classList.add('is-valid');
                        }
                    }
                    function togglePasswords() {
                        const password = document.getElementById('<%= emp_pass.ClientID %>');
                        const passIcon = document.getElementById('passIcon');
                        if (password.type === "password") {
                            password.type = "text";
                            passIcon.classList.remove("fa-eye-slash");
                            passIcon.classList.add("fa-eye");
                        } else {
                            password.type = "password";
                            passIcon.classList.remove("fa-eye");
                            passIcon.classList.add("fa-eye-slash");
                        }
                    }

                         <%--function validateRole() {
              const role = document.getElementById('<%= emp_role.ClientID %>');
                         if (role.value === "") {
                             role.classList.add('is-invalid');
                         role.classList.remove('is-valid');
              } else {
                             role.classList.remove('is-invalid');
                         role.classList.add('is-valid');
              }
          }--%>

                    function previewImage1() {
                        const fileInput = document.getElementById('<%= formFile.ClientID %>');
                        const imagePreview = document.getElementById('<%= imagePreview.ClientID %>');
                        const file = fileInput.files[0];
                        const allowedExtensions = ["image/jpeg", "image/jpg", "image/png", "image/gif"];
                        const fileError = document.getElementById('fileError');

                        if (file && allowedExtensions.includes(file.type)) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                imagePreview.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                            fileError.style.display = "none";
                        } else {
                            imagePreview.src = "Pictures/blank_prof.png";
                            fileError.style.display = "block";
                            alert("Invalid file. Please upload a valid image.");
                        }
                    }

                    // Validation Functions for Update Information
                    function validateUpdateFirstname() {
                        const firstname = document.getElementById('<%=txtbfirstname.ClientID%>');
                        if (!/^[A-Za-z]+$/.test(firstname.value)) {
                            firstname.classList.add('is-invalid');
                            firstname.classList.remove('is-valid');
                        } else {
                            firstname.classList.remove('is-invalid');
                            firstname.classList.add('is-valid');
                        }
                    }

                    // Function to allow only letter input
                    function isLetter(event) {
                        const char = String.fromCharCode(event.which);
                        return /^[A-Za-z]$/.test(char);
                    }

                    // Validate Middle Initial (Optional)
                    function validateMiddleInitialOptional() {
                        const middleInitial = document.getElementById('<%= txtmi.ClientID %>');

                        // Validate the input
                        if (middleInitial.value.length > 1 || !/^[A-Za-z]$/.test(middleInitial.value)) {
                            middleInitial.classList.add('is-invalid');
                            middleInitial.classList.remove('is-valid');
                        } else {
                            middleInitial.classList.remove('is-invalid');
                            middleInitial.classList.add('is-valid');
                        }
                    }

                    function validateUpdateLastname() {
                        const lastname = document.getElementById('<%=txtLastname.ClientID%>');
                        if (!/^[A-Za-z]+$/.test(lastname.value)) {
                            lastname.classList.add('is-invalid');
                            lastname.classList.remove('is-valid');
                        } else {
                            lastname.classList.remove('is-invalid');
                            lastname.classList.add('is-valid');
                        }
                    }

                    function validateUpdateEmail() {
                        const email = document.getElementById('<%=txtEmail.ClientID%>');
                        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
                        if (!emailPattern.test(email.value)) {
                            email.classList.add('is-invalid');
                            email.classList.remove('is-valid');
                        } else {
                            email.classList.remove('is-invalid');
                            email.classList.add('is-valid');
                        }
                    }

                    function validateUpdateContact() {
                        const contact = document.getElementById('<%=txtContact.ClientID%>');
                        const contactPattern = /^09\d{9}$/;
                        if (!contactPattern.test(contact.value)) {
                            contact.classList.add('is-invalid');
                            contact.classList.remove('is-valid');
                        } else {
                            contact.classList.remove('is-invalid');
                            contact.classList.add('is-valid');
                        }
                    }

                    function validateUpdateContact() {
                        const contactInput = document.getElementById('<%= txtContact.ClientID %>');

                        // Only allow digits and limit to 11 characters
                        contactInput.value = contactInput.value.replace(/\D/g, ''); // Remove non-numeric characters
                        if (contactInput.value.length > 11) {
                            contactInput.value = contactInput.value.substring(0, 11); // Limit to 11 digits
                        }

                        // Validation feedback for contact number
                        const contactPattern = /^09\d{9}$/; // Philippines phone numbers starting with 09 followed by 9 digits
                        if (!contactPattern.test(contactInput.value)) {
                            contactInput.classList.add('is-invalid');
                            contactInput.classList.remove('is-valid');
                        } else {
                            contactInput.classList.remove('is-invalid');
                            contactInput.classList.add('is-valid');
                        }
                    }



                    //TextBox1 exist in the Update Panel Modal

          <%--function validateUpdatePassword() {
              const password = document.getElementById('<%= TextBox1.ClientID %>');
              const passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$/;
              if (!passwordPattern.test(password.value)) {
                  password.classList.add('is-invalid');
                  password.classList.remove('is-valid');
              } else {
                  password.classList.remove('is-invalid');
                  password.classList.add('is-valid');
              }
          }

          function toggleUpdatePassword() {
              const passwordField = document.getElementById('<%= TextBox1.ClientID %>');
              const icon = document.getElementById('updatePasswordIcon');

              if (passwordField.type === "password") {
                  passwordField.type = "text";
                  icon.classList.remove("fa-eye-slash");
                  icon.classList.add("fa-eye");
              } else {
                  passwordField.type = "password";
                  icon.classList.remove("fa-eye");
                  icon.classList.add("fa-eye-slash");
              }
          }--%>



                    function previewImageUpdate() {
                        const fileInput = document.getElementById('<%=FileUpload1.ClientID%>');
                        const imagePreview = document.getElementById('<%=imagePreviewUpdate.ClientID%>');
                        const file = fileInput.files[0];
                        const allowedExtensions = ["image/jpeg", "image/png", "image/gif"];
                        const fileError = document.getElementById('fileErrorUpdate');

                        if (file && allowedExtensions.includes(file.type)) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                imagePreview.src = e.target.result;
                                fileError.style.display = 'none';
                            };
                            reader.readAsDataURL(file);
                        } else {
                            imagePreview.src = "";
                            fileError.style.display = 'block';
                        }
                    }


                    // Validate entire Update form
                    function validateUpdateForm() {
                        let isValid = true;

                        validateUpdateFirstname();
                        validateUpdateLastname();
                        validateUpdateEmail();
                        validateUpdateContact();
                        validateUpdatePassword();
                        previewImageUpdate();

                        if (document.querySelectorAll('.is-invalid').length > 0) {
                            isValid = false;
                            alert("Please fill in all required fields correctly!");
                        }

                        return isValid;
                    }


                    // Form submission handlers
                    document.getElementById('submitBtn').onclick = function (event) {
                        if (!validateForm()) {
                            event.preventDefault();
                        }
                    };

                    document.getElementById('btnUpdate').onclick = function (event) {
                        if (!validateUpdateForm()) {
                            event.preventDefault();
                        }
                    };

                    function previewImage1() {
                        const fileInput = document.getElementById('<%= formFile.ClientID %>');
                        const imagePreview = document.getElementById('<%= imagePreview.ClientID %>');
                        const file = fileInput.files[0];
                        const allowedExtensions = ["image/jpeg", "image/jpg", "image/png", "image/gif"];
                        const fileError = document.getElementById('fileError');

                        if (file && allowedExtensions.includes(file.type)) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                imagePreview.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                            fileError.style.display = "none";
                        } else {
                            imagePreview.src = "Pictures/blank_prof.png";
                            fileError.style.display = "block";
                            alert("Invalid file. Please upload a valid image.");
                        }
                    }
                </script>
                <!-- End General Form Elements -->
            </main>
            <!-- End #main -->

            <!-- ======= Footer ======= -->
            <footer id="footer" class="footer" style="border-top-color: chartreuse">
                <div class="copyright" style="color: #d4f3cf">
                    &copy; Copyright <strong><span style="color: #d4f3cf">Pinoy Basurero Corporation</span></strong>. All Rights Reserved
                </div>
            </footer>
            <!-- End Footer -->

            <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

            <!-- Vendor JS Files -->
            <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
            <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            fgen
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
            <script src="assets/vendor/echarts/echarts.min.js"></script>
            <script src="assets/vendor/quill/quill.min.js"></script>
            <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
            <script src="assets/vendor/tinymce/tinymce.min.js"></script>
            <script src="assets/vendor/php-email-form/validate.js"></script>

            <!-- Template Main JS File -->
            <script src="assets/js/main.js"></script>
    </div>

</form>
</html>

