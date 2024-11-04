using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using Npgsql;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Text.Json;
using System.IO;
using System.Diagnostics;
using System.Net.Mail;
using System.Net;
using System.Xml.Linq;
using System.Web.UI.HtmlControls;
using System;


namespace Capstone
{
    public partial class Dispatcher_AddSlip : System.Web.UI.Page
    {
        private readonly string con = "Server=localhost;Port=5432;User Id=postgres;Password=123456;Database=trashtrackV2";
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                GridViewBooking();
                //LoadProfile();

            }

        }

        private void LoadProfile()
        {
            //imagePreview.

            try
            {
                //if (Session["emp_id"] == null)
                //{
                //    // Session expired or not set, redirect to login
                //    Response.Redirect("Login.aspx");
                //    return;
                //}

                int empID = (int)Session["emp_id"];  // Retrieve admin ID from session


                //As if naa sulod
                //int empID = 1026;
                byte[] imageData = null;  // Initialize imageData

                // Define the PostgreSQL connection
                using (var db = new NpgsqlConnection(con))
                {
                    db.Open();

                    // PostgreSQL query to get profile image
                    string query = "SELECT emp_profile FROM EMPLOYEE WHERE emp_id = @id";
                    using (var cmd = new NpgsqlCommand(query, db))
                    {
                        // Set the parameter for admin ID
                        cmd.Parameters.AddWithValue("@id", NpgsqlTypes.NpgsqlDbType.Integer, empID);

                        // Execute the query and retrieve the image data
                        var result = cmd.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            imageData = (byte[])result;  // Cast the result to byte array
                        }
                    }
                }

                int role_id = (int)Session["role_id"];
                using (var db2 = new NpgsqlConnection(con))
                {
                    db2.Open();
                    using (var cmd2 = db2.CreateCommand())
                    {
                        cmd2.CommandType = CommandType.Text;
                        cmd2.CommandText = "SELECT ROLE_NAME FROM ROLES WHERE ROLE_ID = @role_id ";

                        cmd2.Parameters.AddWithValue("@role_id", role_id);
                        using (var reader2 = cmd2.ExecuteReader())
                        {
                            if (reader2.Read())
                            {
                                Employee_Role.Text = reader2["ROLE_NAME"].ToString();
                            }
                        }
                    }
                }


                // Check if the profile_image control exists and is not null
                if (profile_image != null)
                {
                    if (imageData != null && imageData.Length > 0)
                    {
                        string base64String = Convert.ToBase64String(imageData);
                        profile_image.ImageUrl = "data:image/jpeg;base64," + base64String;  // Set image as base64 string
                        //imagePreviewUpdate.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                    else
                    {
                        profile_image.ImageUrl = "~/Pictures/blank_prof.png";  // Default image if no profile picture found
                    }
                }
                else
                {
                    Response.Write("<script>alert('Profile image control is not found');</script>");
                }
            }
            catch (Exception ex)
            {
                // Log the exception or handle it
                Response.Write("<script>alert('Error loading profile image: " + ex.Message + "');</script>");
                profile_image.ImageUrl = "~/Pictures/blank_prof.png";  // Fallback in case of an error
            }
        }


        private void GridViewBooking()
        {
            using (var db = new NpgsqlConnection(con))
            {
                db.Open();
                using (var cmd = db.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT bk_id, bk_date, bk_status, bk_waste_scale_slip, cus_id FROM booking ORDER BY bk_created_at DESC"; // Query to fetch relevant columns

                    DataTable booking_datatable = new DataTable();
                    NpgsqlDataAdapter booking_sda = new NpgsqlDataAdapter(cmd);
                    booking_sda.Fill(booking_datatable);

                    // Bind the DataTable to the GridView
                    gridViewBooking.DataSource = booking_datatable;
                    gridViewBooking.DataBind();
                }
            }
        }

        protected void btnadd_slip_Click(object sender, EventArgs e)
        {
            // Cast the sender back to LinkButton
            LinkButton btn = (LinkButton)sender;

            // Get the CommandArgument (bk_id)
            string bk_id = btn.CommandArgument;

            // Show the bk_id in an alert
            Response.Write("<script>alert('Button is clicked! Booking ID: " + bk_id + "');</script>");
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            // Cast the sender to a LinkButton
            LinkButton btn = sender as LinkButton;

            // Get the Booking ID (bk_id) from the CommandArgument
            int bk_id = Convert.ToInt32(btn.CommandArgument);

            // Assign the bk_id to the TextBox inside the modal for display
            txtbxID.Text = bk_id.ToString();
            DisplayTruckSlip(bk_id);
            // Optionally, you can pre-fill other fields related to the booking here





            // Show the modal pop-up
            this.ModalPopupExtender2.Show();
        }

        private void DisplayTruckSlip(int bk_id)
        {
            int customer_id = 0;
            string province = "";
            string city = "";
            string barangay = "";
            string postal = "";
            string street = "";
            string book_status = "";

            try
            {
                using (var db = new NpgsqlConnection(con))
                {
                    db.Open();
                    using (var cmd = db.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "SELECT * FROM BOOKING WHERE bk_id = @bk_id";
                        cmd.Parameters.AddWithValue("@bk_id", bk_id);

                        var reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            byte[] imageData = reader["bk_waste_scale_slip"] as byte[];
                            province = reader["bk_province"].ToString();
                            city = reader["bk_city"].ToString();
                            barangay = reader["bk_brgy"].ToString();
                            postal = reader["bk_postal"].ToString();
                            street = reader["bk_street"].ToString();
                            customer_id = Convert.ToInt32(reader["cus_id"]);
                            book_status = reader["bk_status"].ToString();

                            txtPROVINCE.Text = province;
                            txtCITY.Text = city;
                            txtSTREET.Text = street;
                            txtBRGY.Text = barangay;
                            txtPOSTAL.Text = postal;
                            txtCUSTOMERID.Text = customer_id.ToString();

                            // Check if image data is null or empty
                            if (imageData != null && imageData.Length > 0)
                            {
                                // Convert image data to base64 string
                                string base64String = Convert.ToBase64String(imageData);
                                string imageUrl = "data:image/png;base64," + base64String;

                                // Bind the image URL to the Image control
                                imagePreview.ImageUrl = imageUrl;
                            }
                            else
                            {
                                // Display a default or placeholder image if no truck slip exists
                                imagePreview.ImageUrl = "~/Pictures/blank_prof.png";
                            }

                            // Enable the Upload button if the booking status is "Ongoing" or "Collected"
                            if (book_status == "Ongoing" || book_status == "Collected")
                            {
                                btnAddTruckSlip.Enabled = true;  // Enable button if status is Ongoing or Collected
                            }
                            else
                            {
                                btnAddTruckSlip.Enabled = false;  // Disable button for other statuses
                            }

                        }
                        else
                        {
                            // Display a default or placeholder image if no truck slip is found
                            imagePreview.ImageUrl = "~/Pictures/blank_prof.png";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    "swal('Error!', '" + ex.Message + "', 'error')", true);
            }
        }






        protected void btnAddTruckSlip_Click(object sender, EventArgs e)
        {
            string id = txtbxID.Text;
            int bk_id = Convert.ToInt32(id);

            // Check if a file is uploaded
            byte[] imageData = formFile.HasFile ? formFile.FileBytes : null;

            try
            {
                if (imageData == null)
                {
                    // Display SweetAlert if no image is uploaded
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    //    "swal('No File!', 'Please upload a truck slip.', 'warning')", true);

                    ClientScript.RegisterStartupScript(this.GetType(), "swal", "Swal.fire('Alert', 'Please upload a truck slip!', 'error');", true);

                    return; // Stop further execution
                }

                using (var db = new NpgsqlConnection(con))
                {
                    db.Open();
                    using (var cmd = db.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;

                        // Updating truck slip for the given booking ID
                        cmd.CommandText = "UPDATE BOOKING SET bk_waste_scale_slip  = @bk_waste_scale_slip," +
                                          "BK_STATUS = 'Collected' " +
                                          "WHERE bk_id = @bk_id";
                        cmd.Parameters.AddWithValue("@bk_waste_scale_slip", imageData);
                        cmd.Parameters.AddWithValue("@bk_id", bk_id);

                        int result = cmd.ExecuteNonQuery();
                        if (result >= 1)
                        {
                            //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            //    "swal('Success!', 'Truck Slip Updated!', 'success')", true);


                            ClientScript.RegisterStartupScript(this.GetType(), "swal", "Swal.fire({title: 'Success', text: 'Truck Slip Updated!', icon: 'success', confirmButtonColor: '#3085d6', cancelButtonColor: '#d33'});", true);


                            // Refresh the GridView if needed
                            GridViewBooking();
                        }
                        else
                        {
                            //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            //    "swal('Failed!', 'Truck Slip Update Failed!', 'error')", true);

                            ClientScript.RegisterStartupScript(this.GetType(), "swal", "Swal.fire('Failed!', 'Truck Slip Update Failed!', 'error');", true);

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                //    "swal('Unsuccessful!', '" + ex.Message + "', 'error')", true);

                //ClientScript.RegisterStartupScript(this.GetType(), "swal", "Swal.fire('Failed!', 'Truck Slip Update Failed!', 'error');", true);

                ClientScript.RegisterStartupScript(this.GetType(), "swal",
    "Swal.fire('Failed!', '" + ex.Message + "', 'error');", true);


            }
        }



    }
}
