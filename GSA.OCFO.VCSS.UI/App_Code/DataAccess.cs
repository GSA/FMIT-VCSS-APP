using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Web.Configuration;
using System.Reflection;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for DataAccess
/// </summary>
public static class DataAccess
{
    public static DataTable GetAccountSearch(string duns, string duns4, string alc, string actcode, string company, string accounttype)
    {
        OracleDataReader reader;
        OracleCommand cmd = new OracleCommand();
        OracleConnection cn = new OracleConnection(ConfigurationManager.ConnectionStrings["VCSS"].ConnectionString);
        DataTable dt;
        //DataSet dataset;
        //Database database;
        //DbCommand command;
        try
        {
            //database = DatabaseFactory.CreateDatabase();
            //command = database.GetStoredProcCommand("USP_GETACCOUNTSBYSEARCH", string.IsNullOrEmpty(duns) ? duns : duns.Trim(), string.IsNullOrEmpty(duns4) ? duns4 : duns4.Trim(), string.IsNullOrEmpty(alc) ? alc : alc.Trim(), string.IsNullOrEmpty(actcode) ? actcode : actcode.Trim(), string.IsNullOrEmpty(company) ? company : company.Replace("'", "''").Trim(), accounttype, null);
            //dataset = database.ExecuteDataSet(command);
            
            cmd.Connection = cn;

            cmd.CommandText = "USP_GETACCOUNTSBYSEARCH ";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }

            cmd.Parameters.Add("P_DUNS", OracleDbType.Char).Value = duns;
            cmd.Parameters.Add("P_DUNS4", OracleDbType.Char).Value = duns4;
            cmd.Parameters.Add("P_ALC", OracleDbType.Char).Value = alc;
            cmd.Parameters.Add("P_ACTCDE", OracleDbType.Char).Value = actcode;
            cmd.Parameters.Add("P_CMPY", OracleDbType.Char).Value = company;
            cmd.Parameters.Add("P_ACTTYP", OracleDbType.Char).Value = accounttype;
            cmd.Parameters.Add("O_CURSOR", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

            using (OracleDataAdapter odaAccount = new OracleDataAdapter(cmd))
            {
                dt = new DataTable();
                odaAccount.Fill(dt);
            }

            //reader = cmd.ExecuteReader();

            //reader.Read();

        }
        catch (Exception ex)
        {
            //dataset = null;
            cn.Close();
            throw ex;
        }
        finally
        {
            //database = null;
            cn.Close();

        }

        return dt;
    }

    public static DataTable GetALCAccounts(string alc)
    {
        OracleDataReader reader;
        OracleCommand cmd = new OracleCommand();
        OracleConnection cn = new OracleConnection(ConfigurationManager.ConnectionStrings["VCSS"].ConnectionString);
        DataTable dt;
        //DataSet dataset;
        //Database database;
        //DbCommand command;

        try
        {

            cmd.Connection = cn;

            cmd.CommandText = "USP_GETACCOUNTSBYALC ";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            
            cmd.Parameters.Add("P_ALC", OracleDbType.Varchar2).Value = alc;
            cmd.Parameters.Add("O_CURSOR", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

            using (OracleDataAdapter odaAccount = new OracleDataAdapter(cmd))
            {
                dt = new DataTable();
                odaAccount.Fill(dt);
            }

            //reader = cmd.ExecuteReader();

            //reader.Read();


            //database = DatabaseFactory.CreateDatabase();
            //command = database.GetStoredProcCommand("USP_GETACCOUNTSBYALC", alc, null);
            //dataset = database.ExecuteDataSet(command);

        }
        catch (Exception ex)
        {
            //dataset = null;
            cn.Close();
            throw ex;
        }

        finally
        {
            //database = null;
            cn.Close();
        }

        return dt;
    }

    public static DataTable GetRequestDetails(string fromdate, string todate, string requestid, string requesttype, string firstname,
                                            string lastname, string company, string email, string duns, string duns4, string alc, string accountcode,
                                            string addresscode, string addr1, string addr2, string city, string state, string zipcode, string regid)
    {
        OracleDataReader reader;
        OracleCommand cmd = new OracleCommand();
        OracleConnection cn = new OracleConnection(ConfigurationManager.ConnectionStrings["VCSS"].ConnectionString);
        DataTable dt;
        //DataSet dataset;
        //Database database;
        //DbCommand command;
        try
        {
            //database = DatabaseFactory.CreateDatabase();
            //command = database.GetStoredProcCommand("USP_GETREQUESTDETAILS", fromdate, todate, requestid, requesttype, firstname, lastname, company, email, duns, duns4, alc, accountcode, addresscode, addr1, addr2, city, state, zipcode, regid, null);
            //dataset = database.ExecuteDataSet(command);

            cmd.Connection = cn;

            cmd.CommandText = "USP_GETREQUESTDETAILS ";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }

            //fromdate, todate, requestid, requesttype, firstname, lastname, company, email, duns, duns4, alc, accountcode, addresscode, addr1, addr2, city, state, zipcode, regid, null

            cmd.Parameters.Add("P_FMDTE", OracleDbType.Char).Value = fromdate;
            cmd.Parameters.Add("P_TODTE", OracleDbType.Char).Value = todate;
            cmd.Parameters.Add("P_RQTID", OracleDbType.Char).Value = requestid;
            cmd.Parameters.Add("P_RQTTYPE", OracleDbType.Char).Value = requesttype;
            cmd.Parameters.Add("P_FTNM", OracleDbType.Char).Value = firstname;
            cmd.Parameters.Add("P_LTNM", OracleDbType.Char).Value = lastname;
            cmd.Parameters.Add("P_CMPY", OracleDbType.Char).Value = company;
            cmd.Parameters.Add("P_EMLADR", OracleDbType.Char).Value = email;
            cmd.Parameters.Add("P_DUNS", OracleDbType.Char).Value = duns;
            cmd.Parameters.Add("P_DUNS4", OracleDbType.Char).Value = duns4;
            cmd.Parameters.Add("P_ALC", OracleDbType.Char).Value = alc;
            cmd.Parameters.Add("P_ACTCD", OracleDbType.Char).Value = accountcode;
            cmd.Parameters.Add("P_ADRCD", OracleDbType.Char).Value = addresscode;
            cmd.Parameters.Add("P_ADDR1", OracleDbType.Char).Value = addr1;
            cmd.Parameters.Add("P_ADDR2", OracleDbType.Char).Value = addr2;
            cmd.Parameters.Add("P_CTY", OracleDbType.Char).Value = city;
            cmd.Parameters.Add("P_STE", OracleDbType.Char).Value = state;
            cmd.Parameters.Add("P_ZIP", OracleDbType.Char).Value = zipcode;
            cmd.Parameters.Add("P_REGID", OracleDbType.Char).Value = regid;

            cmd.Parameters.Add("O_CURSOR", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

            using (OracleDataAdapter odaAccount = new OracleDataAdapter(cmd))
            {
                dt = new DataTable();
                odaAccount.Fill(dt);
            }

            //reader = cmd.ExecuteReader();

            //reader.Read();



        }
        catch (Exception ex)
        {
            //dataset = null;
            cn.Close();
            throw ex;
        }
        finally
        {
            //database = null;
            cn.Close();
        }

        return dt;
    }


    public static DataSet GetRequests(string fromdate, string todate, string requestid, string requesttype, string firstname, string lastname)
    {
        //DataSet dataset;
        DataSet dataset = new DataSet();
        DataSet result = new DataSet();
        OracleDataReader oraReader;
        DataTable dtReader = new DataTable("Records");

        try
        {
            //dataset = GetRequestDetails(fromdate, todate, requestid, requesttype, firstname, lastname, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty);

            dtReader = GetRequestDetails(fromdate, todate, requestid, requesttype, firstname, lastname, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty);

            ////Create a new DataTable.
            //DataTable dtReader = new DataTable("Records");

            ////Load Oracle DataReader into the DataTable.
            //dtReader.Load(oraReader);

            //now, convert to DataSet
            dataset.Tables.Add(dtReader);

            var query = dataset.Tables[0].AsEnumerable()
                .GroupBy(x => x.Field<string>("RQTID"))
                .Select(x => new
                {
                    RQTID = x.Key,
                    RQTTYP = x.Select(r => r.Field<string>("RQTTYP")).ToList().First(),
                    SBRFTNM = x.Select(r => r.Field<string>("SBRFTNM")).ToList().First(),
                    SBRLTNM = x.Select(r => r.Field<string>("SBRLTNM")).ToList().First(),
                    SBREML = x.Select(r => r.Field<string>("SBREML")).ToList().First(),
                    SBRPHNM = x.Select(r => r.Field<string>("SBRPHNM")).ToList().First(),
                    CTDON = x.Select(r => !string.IsNullOrEmpty(r.Field<DateTime?>("RQTCTDON").ToString()) ? r.Field<DateTime>("RQTCTDON").ToString("MM/dd/yyyy") : string.Empty).ToList().First()
                });

            result.Tables.Add(Utilities.ConvertToDataTable(query));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public static string CreateRequest(string xml, string acttype)
    {
        OracleCommand cmd;
        string confirmation = string.Empty;

        try
        {
            using (OracleConnection con = new OracleConnection(WebConfigurationManager.ConnectionStrings["VCSS"].ConnectionString))
            {
                using (cmd = new OracleCommand("USP_CREATEREQUEST", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    OracleParameter param1 = new OracleParameter();
                    param1.ParameterName = "P_REQUESTXML";
                    param1.OracleDbType = OracleDbType.XmlType;
                    param1.Direction = ParameterDirection.Input;
                    param1.Value = xml;
                    cmd.Parameters.Add(param1);

                    OracleParameter param2 = new OracleParameter();
                    param2.ParameterName = "P_ACTTYPE";
                    param2.OracleDbType = OracleDbType.NVarchar2;
                    param2.Direction = ParameterDirection.Input;
                    param2.Value = acttype;
                    cmd.Parameters.Add(param2);

                    OracleParameter param3 = new OracleParameter();
                    param3.ParameterName = "O_CONFIRMATION";
                    param3.OracleDbType = OracleDbType.Varchar2;
                    param3.Size = 40;
                    param3.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(param3);

                    cmd.ExecuteNonQuery();

                    confirmation = cmd.Parameters["O_CONFIRMATION"].Value.ToString();

                    con.Close();
                    con.Dispose();
                }
            }
        }
        catch (OracleException ex)
        {
            throw ex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            cmd = null;
        }
        return confirmation;
    }
}