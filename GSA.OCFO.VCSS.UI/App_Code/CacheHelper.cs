using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;

/// <summary>
/// Summary description for CacheHelper
/// </summary>
public static class CacheHelper
{
    public static void Create<T>(string key, T o) where T : class
    {
        HttpRuntime.Cache.Insert(key, o, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
    }

    public static void Clear(string key)
    {
        HttpRuntime.Cache.Remove(key);
    }

    public static bool Exists<T>(string key) where T : class
    {   
        return !string.IsNullOrEmpty(key) ? (HttpRuntime.Cache.Get(key) != null) : false;
    }

    public static T Get<T>(string key) where T : class
    {
        if (Exists<T>(key))
        {
            return (T)HttpRuntime.Cache.Get(key);
        }
        return null;
    }
}