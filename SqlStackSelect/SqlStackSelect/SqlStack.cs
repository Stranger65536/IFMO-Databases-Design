using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using System.IO;
using System.Collections;

namespace SqlStackSelect
{
    public class SqlStack
    {

        private static Stack data;

        private static void GetData(SqlString tableName, SqlString columnName)
        {
            data = new Stack();
            SqlConnection connection = new SqlConnection("user id=Stranger;" +
                                                         "password=95175382;server=.\\SQLExpress;" +
                                                         "Trusted_Connection=yes;" +
                                                         "database=film collection; " +
                                                         "connection timeout=2");
            connection.Open();
            SqlCommand comm = new SqlCommand();
            comm.CommandText = "SELECT \"" + columnName.ToString() + "\" FROM \"" + tableName.ToString() + "\"";
            comm.Connection = connection;
            SqlDataReader dReader = comm.ExecuteReader();
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    data.Push(dReader.GetValue(0));
                }
            }
            dReader.Close();
            connection.Close();
        }

        private static void FlushData(SqlString savePath)
        {
            StreamWriter sw = new StreamWriter(savePath.ToString(), false);
            if (data != null)
            {             
                while (data.Count != 0)
                {
                    sw.WriteLine(data.Pop().ToString());
                }
            }
            sw.Close();
        }

        [SqlProcedure]
        public static void SaveColumnToFile(SqlString tableName, SqlString columnName, SqlString savePath)
        {
            GetData(tableName, columnName);
            FlushData(savePath);
        }
    }
}
