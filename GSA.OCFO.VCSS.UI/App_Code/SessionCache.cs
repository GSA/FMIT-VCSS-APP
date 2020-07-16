using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

/// <summary>
/// Summary description for SessionCache
/// </summary>
public static class SessionCache
{
    private static HttpSessionState CurrentSession
    {
        get
        {
            if (HttpContext.Current.Session == null)
                throw new Exception("Session is not available in the current context.");
            else
                return HttpContext.Current.Session;
        }
    }

    //public static bool CheckBrowserCompatibility
    //{
    //    get
    //    {
    //        if (CurrentSession["CheckBrowserCompatibility"] != null)
    //            return Convert.ToBoolean(CurrentSession["CheckBrowserCompatibility"]);
    //        else
    //            return false;
    //    }
    //    set
    //    {
    //        if (value != null)
    //            CurrentSession["CheckBrowserCompatibility"] = value;
    //        else
    //            CurrentSession.Remove("CheckBrowserCompatibility");
    //    }
    //}

    public static string Confirmations
    {
        get
        {
            if (CurrentSession["Confirmations"] != null)
                return CurrentSession["Confirmations"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["Confirmations"] = value;
            else
                CurrentSession.Remove("Confirmations");
        }
    }

    public static string VRCacheKey
    {
        get
        {
            if (CurrentSession["VRCacheKey"] != null)
                return CurrentSession["VRCacheKey"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["VRCacheKey"] = "VR" + value;
            else
                CurrentSession.Remove("VRCacheKey");
        }
    }

    public static string VACacheKey
    {
        get
        {
            if (CurrentSession["VACacheKey"] != null)
                return CurrentSession["VACacheKey"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["VACacheKey"] = "VA" + value;
            else
                CurrentSession.Remove("VACacheKey");
        }
    }

    public static string CRCacheKey
    {
        get
        {
            if (CurrentSession["CRCacheKey"] != null)
                return CurrentSession["CRCacheKey"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["CRCacheKey"] = "CR" + value;
            else
                CurrentSession.Remove("CRCacheKey");
        }
    }

    public static string CACacheKey
    {
        get
        {
            if (CurrentSession["CACacheKey"] != null)
                return CurrentSession["CACacheKey"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["CACacheKey"] = "CA" + value;
            else
                CurrentSession.Remove("CACacheKey");
        }
    }

    public static string UICacheKey
    {
        get
        {
            if (CurrentSession["UICacheKey"] != null)
                return CurrentSession["UICacheKey"].ToString();
            else
                return null;
        }
        set
        {
            if (value != null)
                CurrentSession["UICacheKey"] = "UI" + value;
            else
                CurrentSession.Remove("UICacheKey");
        }
    }
}