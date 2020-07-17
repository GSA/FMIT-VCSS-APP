using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Text;
using System.Xml.Linq;
using System.Reflection;
using System.ComponentModel;
using System.Text.RegularExpressions;
using System.Configuration;

/// <summary>
/// Summary description for Utilities
/// </summary>
public static class Utilities
{
    public static void RemoveFromCache(Account account, string accounttype, string requesttype)
    {
        try
        {
            List<Account> cart = new List<Account>();

            if (requesttype == "A")
            {
                cart = accounttype.Equals("V") ? (CacheHelper.Get<List<Account>>(SessionCache.VACacheKey) != null ? CacheHelper.Get<List<Account>>(SessionCache.VACacheKey) : cart) : (CacheHelper.Get<List<Account>>(SessionCache.CACacheKey) != null ? CacheHelper.Get<List<Account>>(SessionCache.CACacheKey) : cart);
                cart.RemoveAll(x => x.RegistrationNumber.Equals(account.RegistrationNumber) && x.AccountCode.Equals(account.AccountCode) && x.AddressCode.Equals(account.AddressCode));
            }
            else
            {
                cart = accounttype.Equals("V") ? (CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey) != null ? CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey) : cart) : (CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey) != null ? CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey) : cart);
                if (accounttype.Equals("V"))
                {
                    cart.RemoveAll(x => x.Num.Equals(account.Num) && x.Name.Equals(account.Name));
                }
                else
                {
                    cart.RemoveAll(x => (x.AccountCode.Equals(account.AccountCode) || x.ALC.Equals(account.ALC)) && x.Name.Equals(account.Name));
                }
            }

            if (accounttype.Equals("V"))
            {
                if (requesttype == "A")
                {
                    CacheHelper.Create(SessionCache.VACacheKey, cart);
                }
                else
                {
                    CacheHelper.Create(SessionCache.VRCacheKey, cart);
                }
            }
            else
            {
                if (requesttype == "A")
                {
                    CacheHelper.Create(SessionCache.CACacheKey, cart);
                }
                else
                {
                    CacheHelper.Create(SessionCache.CRCacheKey, cart);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static void AddToCache(Account account, string accounttype, string requesttype)
    {
        try
        {
            List<Account> cart = new List<Account>();
            string dtKey = DateTime.Now.ToString("ddMMyyHHmmssffff");

            if (requesttype.Equals("A"))
            {
                if (accounttype.Equals("V"))
                {
                    if (string.IsNullOrEmpty(SessionCache.VACacheKey))
                    {
                        SessionCache.VACacheKey = dtKey;
                    }
                    else
                    {
                        cart = CacheHelper.Get<List<Account>>(SessionCache.VACacheKey);
                    }
                }
                else
                {
                    if (string.IsNullOrEmpty(SessionCache.CACacheKey))
                    {
                        SessionCache.CACacheKey = dtKey;
                    }
                    else
                    {
                        cart = CacheHelper.Get<List<Account>>(SessionCache.CACacheKey);
                    }
                }
            }
            else
            {
                if (accounttype.Equals("V"))
                {
                    if (string.IsNullOrEmpty(SessionCache.VRCacheKey))
                    {
                        SessionCache.VRCacheKey = dtKey;
                    }
                    else
                    {
                        cart = CacheHelper.Get<List<Account>>(SessionCache.VRCacheKey);
                    }
                }
                else
                {
                    if (string.IsNullOrEmpty(SessionCache.CRCacheKey))
                    {
                        SessionCache.CRCacheKey = dtKey;
                    }
                    else
                    {
                        cart = CacheHelper.Get<List<Account>>(SessionCache.CRCacheKey);
                    }
                }
            }

            if (requesttype == "A")
            {
                if (cart != null)
                {
                    if (cart.Where(r => r.RegistrationNumber.Equals(account.RegistrationNumber) && r.AccountCode.Equals(account.AccountCode) && r.AddressCode.Equals(account.AddressCode)).Count().Equals(0))
                        cart.Add(new Account
                        {
                            Num = !string.IsNullOrEmpty(account.Num) ? account.Num : "N/A",
                            Num4 = !string.IsNullOrEmpty(account.Num4) ? account.Num4 : "N/A",
                            ALC = !string.IsNullOrEmpty(account.ALC) ? account.ALC : "N/A",
                            AccountCode = !string.IsNullOrEmpty(account.AccountCode) ? account.AccountCode : "N/A",
                            AddressCode = account.AddressCode,
                            RegistrationNumber = account.RegistrationNumber,
                            Name = account.Name,
                            Administrator = account.Administrator,
                            AdministratorEmail = account.AdministratorEmail,
                            AdministratorPhone = account.AdministratorPhone
                        });
                }
                else
                {
                    cart.Add(new Account
                    {
                        Num = !string.IsNullOrEmpty(account.Num) ? account.Num : "N/A",
                        Num4 = !string.IsNullOrEmpty(account.Num4) ? account.Num4 : "N/A",
                        ALC = !string.IsNullOrEmpty(account.ALC) ? account.ALC : "N/A",
                        AccountCode = !string.IsNullOrEmpty(account.AccountCode) ? account.AccountCode : "N/A",
                        AddressCode = account.AddressCode,
                        RegistrationNumber = account.RegistrationNumber,
                        Name = account.Name,
                        Administrator = account.Administrator,
                        AdministratorEmail = account.AdministratorEmail,
                        AdministratorPhone = account.AdministratorPhone
                    });
                }
            }
            else
            {
                if (cart != null)
                {
                    if (accounttype.Equals("V"))
                    {
                        if (cart.Where(r => r.Name.Equals(account.Name) && r.Num.Equals(account.Num)).Count().Equals(0))
                            cart.Add(new Account
                            {
                                Num = !string.IsNullOrEmpty(account.Num) ? account.Num : "N/A",
                                Num4 = !string.IsNullOrEmpty(account.Num4) ? account.Num4 : "N/A",
                                ALC = !string.IsNullOrEmpty(account.ALC) ? account.ALC : "N/A",
                                AccountCode = !string.IsNullOrEmpty(account.AccountCode) ? account.AccountCode : "N/A",
                                AddressCode = account.AddressCode,
                                RegistrationNumber = account.RegistrationNumber,
                                Name = account.Name,
                                Address1 = account.Address1,
                                Address2 = account.Address2,
                                City = account.City,
                                State = account.State,
                                ZipCode = account.ZipCode,
                                Administrator = account.Administrator,
                                AdministratorEmail = account.AdministratorEmail,
                                AdministratorPhone = account.AdministratorPhone
                            });
                    }
                    else
                    {
                        if (cart.Where(r => r.Name.Equals(account.Name) && r.ALC.Equals(account.ALC) && r.AccountCode.Equals(account.AccountCode)).Count().Equals(0))
                            cart.Add(new Account
                            {
                                Num = !string.IsNullOrEmpty(account.Num) ? account.Num : "N/A",
                                Num4 = !string.IsNullOrEmpty(account.Num4) ? account.Num4 : "N/A",
                                ALC = !string.IsNullOrEmpty(account.ALC) ? account.ALC : "N/A",
                                AccountCode = !string.IsNullOrEmpty(account.AccountCode) ? account.AccountCode : "N/A",
                                AddressCode = account.AddressCode,
                                RegistrationNumber = account.RegistrationNumber,
                                Name = account.Name,
                                Address1 = account.Address1,
                                Address2 = account.Address2,
                                City = account.City,
                                State = account.State,
                                ZipCode = account.ZipCode,
                                Administrator = account.Administrator,
                                AdministratorEmail = account.AdministratorEmail,
                                AdministratorPhone = account.AdministratorPhone
                            });
                    }
                }
                else
                {
                    cart.Add(new Account
                    {
                        Num = !string.IsNullOrEmpty(account.Num) ? account.Num : "N/A",
                        Num4 = !string.IsNullOrEmpty(account.Num4) ? account.Num4 : "N/A",
                        ALC = !string.IsNullOrEmpty(account.ALC) ? account.ALC : "N/A",
                        AccountCode = !string.IsNullOrEmpty(account.AccountCode) ? account.AccountCode : "N/A",
                        AddressCode = account.AddressCode,
                        RegistrationNumber = account.RegistrationNumber,
                        Name = account.Name,
                        Address1 = account.Address1,
                        Address2 = account.Address2,
                        City = account.City,
                        State = account.State,
                        ZipCode = account.ZipCode,
                        Administrator = account.Administrator,
                        AdministratorEmail = account.AdministratorEmail,
                        AdministratorPhone = account.AdministratorPhone
                    });
                }
            }
            if (accounttype.Equals("V"))
            {
                if (requesttype.Equals("A"))
                {
                    CacheHelper.Create(SessionCache.VACacheKey, cart.OrderBy(r => r.Name).ToList());
                }
                else
                {
                    CacheHelper.Create(SessionCache.VRCacheKey, cart.OrderBy(r => r.Name).ToList());
                }
            }
            else
            {
                if (requesttype.Equals("A"))
                {
                    CacheHelper.Create(SessionCache.CACacheKey, cart.OrderBy(r => r.Name).ToList());
                }
                else
                {
                    CacheHelper.Create(SessionCache.CRCacheKey, cart.OrderBy(r => r.Name).ToList());
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static void ClearCache(string accounttype)
    {
        if (accounttype.Equals("V"))
        {
            if (!string.IsNullOrEmpty(SessionCache.VACacheKey))
                CacheHelper.Clear(SessionCache.VACacheKey);

            if (!string.IsNullOrEmpty(SessionCache.VRCacheKey))
                CacheHelper.Clear(SessionCache.VRCacheKey);
        }
        else
        {
            if (!string.IsNullOrEmpty(SessionCache.CACacheKey))
                CacheHelper.Clear(SessionCache.CACacheKey);

            if (!string.IsNullOrEmpty(SessionCache.CRCacheKey))
                CacheHelper.Clear(SessionCache.CRCacheKey);
        }

        if (!string.IsNullOrEmpty(SessionCache.UICacheKey))
            CacheHelper.Clear(SessionCache.UICacheKey);
    }

    public static string GetMessageBody(XDocument xdoc, string accounttype, string srtype, string xsltfilename)
    {
        try
        {
            using (XmlReader dataReader = LoadXMLToReader(xdoc.ToString()))
            {
                XslCompiledTransform xslTrans = new XslCompiledTransform();
                string path = HttpContext.Current.Server.MapPath("~") + "/EmailFormats/" + accounttype + (!string.IsNullOrEmpty(accounttype) ? "/" : string.Empty) + srtype + xsltfilename + ".xslt";
                xslTrans.Load(path);
                using (MemoryStream outputStream = new MemoryStream())
                {
                    xslTrans.Transform(dataReader, null, outputStream);
                    outputStream.Position = 0;
                    using (StreamReader sr = new StreamReader(
                      outputStream, Encoding.UTF8))
                    {
                        string resultHtml = sr.ReadToEnd();
                        return resultHtml;
                    }
                }
            }
        }
        catch (XmlException xmlEx)
        {
            throw xmlEx;
        }
        catch (XsltException xsltEx)
        {
            throw xsltEx;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private static XmlReader LoadXMLToReader(string inputXML)
    {
        byte[] xmlData = Encoding.UTF8.GetBytes(inputXML);
        MemoryStream xmlStream = new MemoryStream(xmlData);
        xmlStream.Position = 0;
        XmlReader reader = XmlReader.Create(xmlStream);
        reader.Read();
        return reader;
    }

    public static XDocument GenerateListToXML(string confirmation, string requesttype, List<User> userinfo, List<Account> access, List<Account> registration, string comment)
    {
        XDocument xmlDocument = new XDocument(new XDeclaration("1.0", "UTF-8", "yes"), new XElement("Request"));

        try
        {
            if (confirmation != null)
            {
                xmlDocument.Descendants("Request").FirstOrDefault().Add(new XElement("Confirmations"));

                if (!string.IsNullOrEmpty(confirmation.Split('|')[0]))
                {
                    xmlDocument.Descendants("Confirmations").FirstOrDefault().Add(new XElement("Registration", confirmation.Split('|')[0]));
                }

                if (!string.IsNullOrEmpty(confirmation.Split('|')[1]))
                {
                    xmlDocument.Descendants("Confirmations").FirstOrDefault().Add(new XElement("Access", confirmation.Split('|')[1]));
                }
            }

            if (!string.IsNullOrEmpty(requesttype))
            {
                xmlDocument.Descendants("Request").FirstOrDefault().Add(new XElement("Type", requesttype));
            }

            if (userinfo != null)
            {
                xmlDocument.Descendants("Request").FirstOrDefault().Add(from user in userinfo
                                                                        select new XElement("UserInfo", new XElement("Title", user.Title),
                                                                                           new XElement("FirstName", user.FirstName),
                                                                                           new XElement("LastName", user.LastName),
                                                                                           new XElement("PhoneNumber", GetNumbers(user.PhoneNumber)),
                                                                                           new XElement("NonUSPhoneNumber", GetNumbers(user.NonUSPhoneNumber)),
                                                                                           new XElement("FaxNumber", GetNumbers(user.FaxNumber)),
                                                                                           new XElement("EmailAddress", user.EmailAddress)));
            }

            if (access != null)
            {
                if (access.Count > 0)
                {
                    xmlDocument.Descendants("Request").FirstOrDefault().Add(new XElement("AccessAccounts", from account in access
                                                                                                           select new XElement("Account", new XElement("Number", account.Num),
                                                                                                                   new XElement("Number4", account.Num4),
                                                                                                                   new XElement("ALC", account.ALC),
                                                                                                                   new XElement("AccountCode", account.AccountCode),
                                                                                                                   new XElement("AddressCode", account.AddressCode),
                                                                                                                   new XElement("RegistrationNumber", account.RegistrationNumber),
                                                                                                                   new XElement("Name", account.Name),
                                                                                                                   new XElement("Address1", account.Address1),
                                                                                                                   new XElement("Address2", account.Address2),
                                                                                                                   new XElement("City", account.City),
                                                                                                                   new XElement("State", account.State),
                                                                                                                   new XElement("ZipCode", account.ZipCode),
                                                                                                                   new XElement("Administrator", account.Administrator),
                                                                                                                   new XElement("AdministratorEmail", account.AdministratorEmail),
                                                                                                                   new XElement("AdministratorPhone", GetNumbers(account.AdministratorPhone))
                                                                                                                   )));
                }

            }

            if (registration != null)
            {
                if (registration.Count > 0)
                {
                    xmlDocument.Descendants("Request").FirstOrDefault().Add(new XElement("RegistrationAccounts", from account in registration
                                                                                                                 select new XElement("Account", new XElement("Number", account.Num),
                                                                                                                     new XElement("Number4", account.Num4),
                                                                                                                     new XElement("ALC", account.ALC),
                                                                                                                     new XElement("AccountCode", account.AccountCode),
                                                                                                                     new XElement("AddressCode", account.AddressCode),
                                                                                                                     new XElement("Name", account.Name),
                                                                                                                     new XElement("Address1", account.Address1),
                                                                                                                     new XElement("Address2", account.Address2),
                                                                                                                     new XElement("City", account.City),
                                                                                                                     new XElement("State", account.State),
                                                                                                                     new XElement("ZipCode", account.ZipCode)
                                                                                                                   )));
                }
            }

            if (!string.IsNullOrEmpty(comment))
            {
                xmlDocument.Descendants("Request").FirstOrDefault().Add(new XElement("Comment", comment));
            }

            return xmlDocument;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static string GetNumbers(string text)
    {
        return !string.IsNullOrEmpty(text) ? Regex.Replace(text, @"[^\d]", "") : string.Empty;
    }

    public static string GetConfigurationValue(string key)
    {
        return ConfigurationManager.AppSettings[key].ToString();
    }

    public static DataTable ConvertToDataTable<T>(IEnumerable<T> varlist)
    {
        DataTable dtReturn = new DataTable();

        // column names 
        PropertyInfo[] oProps = null;

        if (varlist == null) return dtReturn;

        foreach (T rec in varlist)
        {
            // Use reflection to get property names, to create table, Only first time, others will follow 
            if (oProps == null)
            {
                oProps = ((Type)rec.GetType()).GetProperties();
                foreach (PropertyInfo pi in oProps)
                {
                    Type colType = pi.PropertyType;

                    if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition() == typeof(Nullable<>)))
                    {
                        colType = colType.GetGenericArguments()[0];
                    }

                    dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
                }
            }

            DataRow dr = dtReturn.NewRow();

            foreach (PropertyInfo pi in oProps)
            {
                dr[pi.Name] = pi.GetValue(rec, null) == null ? DBNull.Value : pi.GetValue
                (rec, null);
            }

            dtReturn.Rows.Add(dr);
        }
        return dtReturn;
    }
}