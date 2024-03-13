using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Todo_List_Fazal.Todo_List;

namespace Todo_List_Fazal
{
    public partial class Todo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        [WebMethod]
        public static string Add_Click(string data)
        {

            var todo = new Todo_()
            {
                Description = data.ToString(),
                IsDone = 0,
                ItemPosition = 0,
                ListColor = 0,
                CreateDt = DateTime.Now


            };
            string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;


            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();


                string insertQuery = "INSERT INTO Todo_Table (Description, IsDone,ItemPosition,ListColor,CreateDt) VALUES (@Description, @IsDone,@ItemPosition,@ListColor,@CreateDt)";
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {

                    command.Parameters.AddWithValue("@Description", todo.Description.ToString());
                    command.Parameters.AddWithValue("@IsDone", todo.IsDone);
                    command.Parameters.AddWithValue("@ItemPosition", todo.ItemPosition);
                    command.Parameters.AddWithValue("@ListColor", todo.ListColor);
                    command.Parameters.AddWithValue("@CreateDt", todo.CreateDt);



                    int rowsAffected = command.ExecuteNonQuery();


                    if (rowsAffected > 0)
                    {

                        return "Data inserted successfully!";
                    }
                    else
                    {

                        return "Error inserting data.";
                    }
                }
            }

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<Todo_> Get_List()
        {
            string ConnectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;
            List<Todo_> data = new List<Todo_>();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string query = "SELECT  ListItemId,Description,IsDone,ItemPosition,ListColor,CreateDt FROM ToDo_List_Fazal.[dbo].[Todo_Table]";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Todo_ item = new Todo_
                            {
                                ListItemId = Convert.ToInt32(reader["ListItemId"]),
                                Description = reader["Description"].ToString(),
                                IsDone = Convert.ToInt32(reader["IsDone"]),
                                ItemPosition = Convert.ToInt32(reader["ItemPosition"]),
                                ListColor = Convert.ToInt32(reader["ListColor"])
                            };

                            data.Add(item);
                        }
                    }
                }
            }

            //return JsonConvert.SerializeObject(data, Formatting.Indented);
            return data;
        }


        [WebMethod]
        public static string Delete_Task(int ListItemId) {
            string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;


            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();


                string deleteQuery = $"DELETE FROM ToDo_List_Fazal.[dbo].[Todo_Table] WHERE ListItemId = @Id";
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    // Add a parameter for the ID value
                    command.Parameters.AddWithValue("@Id", ListItemId);

                    // Execute the command
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return "Delete Record successfully!";
                    }
                    else
                    {
                        return "Record Not Delete!";
                    }
                }
            }
        }


        [WebMethod]
        public static string Update_Task(int ListItemId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;
            int done = 1;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();


                string deleteQuery = $"UPDATE ToDo_List_Fazal.[dbo].[Todo_Table] SET IsDone = @IsDone WHERE ListItemId = @Id";
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    // Add a parameter for the ID value
                    command.Parameters.AddWithValue("@Id", ListItemId);
                    command.Parameters.AddWithValue("@IsDone", done);

                    // Execute the command
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return "Update Record successfully!";
                    }
                    else
                    {
                        return "Record Not Update!";
                    }
                }
            }
        }


        [WebMethod]
        public static string Update_Order(int[] Order)
        {

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;
               
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = connection.CreateCommand())
                    {
                        using (SqlTransaction transaction = connection.BeginTransaction())
                        {
                            command.Transaction = transaction;

                            try
                            {
                                for (int i = 0; i < Order.Length; i++)
                                {
                                    command.CommandText = "UPDATE ToDo_List_Fazal.[dbo].[Todo_Table] SET ItemPosition = @ItemPosition WHERE ListItemId = @ListItemId";
                                    command.Parameters.Clear();
                                    command.Parameters.AddWithValue("@ItemPosition", i );
                                    command.Parameters.AddWithValue("@ListItemId", Order[i]);
                                  
                                    command.ExecuteNonQuery();
                                }

                                transaction.Commit();

                                return "Tasks updated successfully.";
                            }
                            catch (Exception ex)
                            {
                                transaction.Rollback();
                                return "Error updating tasks: " + ex.Message;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error updating tasks: " + ex.Message;
            }
        }

            [WebMethod]
        public static string Update_Des(int ListItemId,string Description)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString; 
            int done = 1;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();


                string deleteQuery = $"UPDATE ToDo_List_Fazal.[dbo].[Todo_Table] SET Description = @Description WHERE ListItemId = @Id";
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    // Add a parameter for the ID value
                    command.Parameters.AddWithValue("@Id", ListItemId);
                    command.Parameters.AddWithValue("@Description", Description);

                    // Execute the command
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return "Update Record successfully!";
                    }
                    else
                    {
                        return "Record Not Update!";
                    }
                }
            }
        }

        protected void Add_Button_Click(object sender, EventArgs e)
        {
            var todo = new Todo_()
            {
                Description = "",
                IsDone = 0,
                ItemPosition = 0,
                ListColor = 0,
                CreateDt = DateTime.Now


            };
            string connectionString = ConfigurationManager.ConnectionStrings["Todo_list"].ConnectionString;


            using (SqlConnection connection = new SqlConnection(connectionString))
              {

                  connection.Open();


                  string insertQuery = "INSERT INTO Todo_Table (Description, IsDone,ItemPosition,ListColor,CreateDt) VALUES (@Description, @IsDone,@ItemPosition,@ListColor,@CreateDt)";
                  using (SqlCommand command = new SqlCommand(insertQuery, connection))
                  {

                      command.Parameters.AddWithValue("@Description", todo.Description.ToString());
                      command.Parameters.AddWithValue("@IsDone", todo.IsDone);
                      command.Parameters.AddWithValue("@ItemPosition", todo.ItemPosition);
                      command.Parameters.AddWithValue("@ListColor", todo.ListColor);
                      command.Parameters.AddWithValue("@CreateDt", todo.CreateDt);



                      int rowsAffected = command.ExecuteNonQuery();


                      if (rowsAffected > 0)
                      {

                        Response.Write("Data inserted successfully!");
                    }
                      else
                      {

                        Response.Write("Error inserting data.");
                    }
                  }
              }

        }


        public class Todo_
        {
            public int ListItemId { get; set; }
            public string Description { get; set; }
            public int IsDone { get; set; }
            public int ItemPosition { get; set; }
            public int ListColor { get; set; }
            public DateTime CreateDt { get; set; }


        }

        public class TODOVM 
        {
            public string Description { get; set; }
        }

    }

}