using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for Account
/// </summary>
public class User
{
    public string Title { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string PhoneNumber { get; set; }
    public string NewEmailAddress { get; set; }
    public string NonUSPhoneNumber { get; set; }
    public string FaxNumber { get; set; }
    public string EmailAddress { get; set; }
}