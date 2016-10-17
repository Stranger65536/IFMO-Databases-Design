using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CollectionGUI
{
    public partial class Form1 : Form
    {

        SqlConnection connection;
        Dictionary<String, DataGridView> tables;
        Dictionary<String, Int32> films; //<combo box, id>
        Dictionary<String, Int32> countries;

        public Form1()
        {
            InitializeComponent();
            tables = new Dictionary<string,DataGridView>();
            films = new Dictionary<String, Int32>();
            countries = new Dictionary<String, Int32>();
        }

        private int DropDownWidth(ComboBox myCombo)
        {
            int maxWidth = 0, temp = 0;
            foreach (var obj in myCombo.Items)
            {
                temp = TextRenderer.MeasureText(obj.ToString(), myCombo.Font).Width;
                if (temp > maxWidth)
                {
                    maxWidth = temp;
                }
            }
            return maxWidth;
        }

        private void dataGridView_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            int count = e.RowCount;
            int first = e.RowIndex;
            TabPage page = tabControl1.SelectedTab;
        }

        private void connectToDatabase()
        {
            connection = new SqlConnection("user id=Stranger;" +
                                       "password=95175382;server=.\\SQLExpress;" +
                                       "Trusted_Connection=yes;" +
                                       "database=film collection; " +
                                       "connection timeout=2");
            try
            {
                connection.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error while connecting to server");
                this.Close();
            }
        }
        private void fillTables()
        {
            DataTable dataTable = connection.GetSchema("Tables");
            foreach (DataRow row in dataTable.Rows)
            {
                string tableName = row[2].ToString();
                if (!tableName.Equals("sysdiagrams"))
                {
                    TabPage page = new TabPage(tableName);
                    page.Name = tableName;
                    DataGridView table = new DataGridView();
                    tables.Add(tableName, table);
                    using (SqlDataAdapter a = new SqlDataAdapter("SELECT * FROM " + "\"" + tableName + "\"", connection))
                    {
                        DataTable t = new DataTable();
                        a.Fill(t);
                        table.DataSource = t;
                        table.ReadOnly = true;
                    }
                    table.Dock = DockStyle.Fill;
                    page.Controls.Add(table);
                    tabControl1.TabPages.Add(page);
                }
            }
        }

        private void fillFirstName()
        {
            comboBox1.Items.Clear();
            comboBox4.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT DISTINCT \"first name\" FROM people ";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    comboBox1.Items.Add(dReader.GetString(0));
                    comboBox4.Items.Add(dReader.GetString(0));
                }
            }
            comboBox1.DropDownWidth = DropDownWidth(comboBox1);
            comboBox4.DropDownWidth = DropDownWidth(comboBox4);
            comboBox1.Text = comboBox1.Items[0].ToString();
            comboBox4.Text = comboBox4.Items[0].ToString();
            dReader.Close();
        }

        private void fillLastName()
        {
            comboBox2.Items.Clear();
            comboBox7.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT DISTINCT \"last name\" FROM people ";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    comboBox2.Items.Add(dReader.GetString(0));
                    comboBox7.Items.Add(dReader.GetString(0));
                }
            }
            comboBox2.DropDownWidth = DropDownWidth(comboBox2);
            comboBox7.DropDownWidth = DropDownWidth(comboBox7);
            comboBox2.Text = comboBox2.Items[0].ToString();
            comboBox7.Text = comboBox7.Items[0].ToString();
            dReader.Close();
        }

        private void fillBirthDate()
        {
            comboBox6.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT DISTINCT \"birth date\" FROM \"people\" ORDER BY \"birth date\"";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    object sqlDateTime = dReader[0];
                    DateTime? dt = (sqlDateTime == System.DBNull.Value) ? (DateTime?)null : Convert.ToDateTime(sqlDateTime);
                    if (dt == null) 
                    {
                        comboBox6.Items.Add("NULL");
                    } 
                    else 
                    {
                        comboBox6.Items.Add(dt.Value.Date.ToShortDateString());
                    } 
                }
            }
            comboBox6.DropDownWidth = DropDownWidth(comboBox6);
            comboBox6.Text = comboBox6.Items[0].ToString();
            dReader.Close();
        }

        private void fillCountry()
        {
            countries.Clear();
            comboBox5.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT \"country id\", \"name\" FROM \"countries\" ";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    int id = dReader.GetInt32(0);
                    String name = dReader.GetString(1);
                    comboBox5.Items.Add(name);
                    countries.Add(name, id);
                }
            }
            comboBox5.Items.Add("NULL");
            comboBox5.DropDownWidth = DropDownWidth(comboBox5);
            comboBox5.Text = "NULL";
            dReader.Close();
        }

        private void fillFilms()
        {
            films.Clear();
            comboBox8.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT \"film id\", \"localized name\", year(\"year\") FROM \"films info\" ";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    int id = dReader.GetInt32(0);
                    String name = dReader.GetString(1);
                    int year = dReader.GetInt32(2);
                    name = name + " (" + year + ")";
                    films.Add(name, id);
                    comboBox8.Items.Add(name);
                }
            }
            comboBox8.DropDownWidth = DropDownWidth(comboBox8);
            comboBox8.Text = comboBox8.Items[0].ToString();
            dReader.Close();
        }

        private void fillFiles()
        {
            comboBox3.Items.Clear();
            SqlDataReader dReader;
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT \"link\" FROM \"files info\" ";
            comm.Connection = connection;
            dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    String path = dReader.GetString(0);
                    comboBox3.Items.Add(path);
                }
            }
            comboBox3.DropDownWidth = DropDownWidth(comboBox3);
            comboBox3.Text = comboBox3.Items[0].ToString();
            dReader.Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            connectToDatabase();
            fillTables();
            fillFirstName();
            fillLastName();
            fillBirthDate();
            fillCountry();
            fillFilms();
            fillFiles();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                connection.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Close connection error");
            }
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
                using (SqlDataAdapter a = new SqlDataAdapter("SELECT * FROM " + "\"" + tabControl1.SelectedTab.Name + "\"", connection))
                {
                    DataTable t = new DataTable();
                    a.Fill(t);
                    tables[tabControl1.SelectedTab.Name].DataSource = t;
                    fillFirstName();
                    fillLastName();
                    fillBirthDate();
                    fillCountry();
                    fillFilms();
                    fillFiles();
                }    
            }
            if (e.KeyCode == Keys.Escape)
            {
                this.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("dbo.\"year range\"", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dReader;
            dReader = cmd.ExecuteReader();
            StringBuilder result = new StringBuilder();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    result.Append("From ");
                    result.Append(dReader.GetInt32(0).ToString());
                    result.Append(" to ");
                    result.Append(dReader.GetInt32(1).ToString());
                }
                MessageBox.Show(result.ToString(), "Film collection year range");
            }
            dReader.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String firstName = String.Empty;
            String lastName = String.Empty;
            firstName = comboBox1.Text;
            lastName = comboBox2.Text;
            SqlCommand cmd = new SqlCommand("dbo.\"films by people\"", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@firstname", firstName));
            cmd.Parameters.Add(new SqlParameter("@lastname", lastName));
            SqlDataReader dReader;
            dReader = cmd.ExecuteReader();
            StringBuilder result = new StringBuilder();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    result.Append(dReader.GetString(0));
                    result.Append(" (");
                    result.Append(dReader.GetInt32(1).ToString());
                    result.Append(")\n");
                }
                MessageBox.Show(result.ToString(), firstName + " " + lastName);
            }
            else
            {
                MessageBox.Show("No one film by this human found", firstName + " " + lastName);
            }
            dReader.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            String name = comboBox3.Text;
            long size = 0;
            if (!name.Equals(""))
            {
                String path = comboBox3.Text;
                SqlCommand cmd = new SqlCommand("dbo.\"get file size by link\"", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parm = new SqlParameter("@link", path);
                parm.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(parm);

                SqlParameter parm2 = new SqlParameter("@size", size);
                parm2.Direction = ParameterDirection.Output; 
                cmd.Parameters.Add(parm2);

                cmd.ExecuteNonQuery();
                StringBuilder result = new StringBuilder();
                MessageBox.Show(path + " : " + cmd.Parameters["@size"].Value);
            }
            else
            {
                MessageBox.Show("That film does not stored in db", "Error");
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("\"dbo\".\"get count of people by film id\"", connection);
            int res = 0;
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter p1 = new SqlParameter("@id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@Result", SqlDbType.Int);

            p1.Direction = ParameterDirection.Input;
            p2.Direction = ParameterDirection.ReturnValue;

            p1.Value = films[comboBox8.Text];

            cmd.Parameters.Add(p1);
            cmd.Parameters.Add(p2);

            cmd.ExecuteNonQuery();

            if (p2.Value != DBNull.Value)
            {
                res = (int)p2.Value;
            }
            MessageBox.Show(res.ToString() + " people take part in this film", comboBox8.Text);     
        }

        private void button5_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("\"dbo\".\"get min year\"", connection);
            int res = 0;
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter p2 = new SqlParameter("@Result", SqlDbType.Int);

            p2.Direction = ParameterDirection.ReturnValue;

            cmd.Parameters.Add(p2);

            cmd.ExecuteNonQuery();

            if (p2.Value != DBNull.Value)
            {
                res = (int)p2.Value;
            }
            MessageBox.Show("The eldest film year is" + res.ToString(), "The eldest film year");     
        }

        private void button6_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("\"dbo\".\"get count of films by person\"", connection);
            int res = 0;
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter p1 = new SqlParameter("@firstname", SqlDbType.VarChar);
            SqlParameter p2 = new SqlParameter("@lastname", SqlDbType.VarChar);
            SqlParameter p3 = new SqlParameter("@birthdate", SqlDbType.Date);
            SqlParameter p4 = new SqlParameter("@countryid", SqlDbType.Int);
            SqlParameter p5 = new SqlParameter("@Result", SqlDbType.Int);

            p1.Direction = ParameterDirection.Input;
            p1.Value = comboBox4.Text;
            p2.Direction = ParameterDirection.Input;
            p2.Value = comboBox7.Text;
            p3.Direction = ParameterDirection.Input;
            if (comboBox6.Text.Equals("NULL"))
            {
                p3.Value = SqlDateTime.Null;
            }
            else
            {
                p3.Value = comboBox6.Text;
            }
            if (comboBox5.Text.Equals("NULL"))
            {
                p4.Value = SqlInt32.Null;
            }
            else
            {
                p4.Value = countries[comboBox5.Text];
            }
            p4.Direction = ParameterDirection.Input;
            p5.Direction = ParameterDirection.ReturnValue;

            cmd.Parameters.Add(p1);
            cmd.Parameters.Add(p2);
            cmd.Parameters.Add(p3);
            cmd.Parameters.Add(p4);
            cmd.Parameters.Add(p5);

            cmd.ExecuteNonQuery();

            if (p5.Value != DBNull.Value)
            {
                res = (int)p5.Value;
            }
            MessageBox.Show(comboBox4.Text + " " + comboBox7.Text + " take part in " + res + " films");  
        }
    }
}
