using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Todo_List_Fazal
{
    public partial class Todo_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Add_Button_Click(object sender, EventArgs e) {

            var todo = new Todo()
            {
                Description = newitem.Text,
                IsDone = 0,
                ItemPosition=0,
                ListColor=0,
                CreateDt= DateTime.Now


            };
            string connectionString = "Data Source=192.168.10.23;Initial Catalog=ToDo_List_Fazal;User ID=sa;Password=bdqs123456@@;TrustServerCertificate=True";

            
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

        [System.Web.Services.WebMethod]
        public static List<Todo> GetListViewData()
        {
            List<Todo> data = new List<Todo> { 
                new Todo { ListItemId=1,Description="abc", IsDone=1,ItemPosition=1,ListColor=1} 
            } ;
            return data;
        }


        public class Todo 
        {
            public int ListItemId { get; set; }
            public string Description { get; set; }
            public int IsDone { get; set; }
            public int ItemPosition { get; set; }
            public int ListColor { get; set; }
            public DateTime CreateDt { get; set; }
           

        }
    }
}