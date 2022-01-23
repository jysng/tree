using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml;
using static TitanFunctions.DataLayer;
namespace WebApplication2
{
    public static class trace
    {
        public static List<string>  urls = new List<string>() {
            @"C:\Users\jsing192\source\repos\TitanApp_ToolBoxLibrary",
            @"C:\Users\jsing192\source\repos\Nucleus",
            @"C:\Users\jsing192\source\repos\TitanToolBox\TitanToolBox"
            };
        
        private static ListItem[] GetSolutions(List<string> urls)
        {
            var ls = new List<ListItem>();
            foreach (var item in urls)
            {
                foreach (var f in Directory.GetFiles(item, "*.sln"))
                {
                    ls.Add(new ListItem(Path.GetFileNameWithoutExtension(f), f));
                }
            }
            return ls.ToArray();
        }
        private static ListItem[] GetProjects(string selectedValue)
        {
            var ls = new List<ListItem>();
            foreach (var i in File.ReadAllLines(selectedValue))
            {
                if (i.StartsWith("Project"))
                {
                    var ProjectName = i.Substring(i.IndexOf("=") + 3, (i.IndexOf(",") - 1 - i.IndexOf("=") - 3));
                    //var FullPath=i.Substring()
                    ls.Add(new ListItem(ProjectName, Path.Combine(Path.GetDirectoryName(selectedValue), i.Split(',')[1].Replace(@"""", "").Replace(" ", ""))));

                }
            }
            return ls.ToArray();
        }
        private static ListItem[] GetActivities(string ProjectPath)
        {
            var ls = new List<ListItem>();
            foreach (var i in GetFileNames(ProjectPath))
            {
                foreach (var item in File.ReadAllLines(Path.Combine(i.Value, i.Text)))
                {
                    if (item.Contains("sealed"))
                        ls.Add(new ListItem(item.Substring(item.IndexOf("class") + 5, item.IndexOf(":") - (item.IndexOf("class") + 5))));
                }
            }
            return ls.ToArray();
        }
        private static List<ListItem> GetFileNames(string url)
        {
            //var url = @"C:\Users\jsing192\source\repos\TitanToolBox\TitanToolBox\TitanApp.Core.Mainframe\TitanApp.Core.Mainframe1.xml";

            //var xPath = "/Project/PropertyGroup/Configuration/text()";

            List<ListItem> ls = new List<ListItem>();
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(url);

            XmlNamespaceManager mgr = new XmlNamespaceManager(xmldoc.NameTable);
            mgr.AddNamespace("x", "http://schemas.microsoft.com/developer/msbuild/2003");


            foreach (XmlNode item in xmldoc.SelectNodes("//x:Compile", mgr))
            {
                if (!item.Attributes["Include"].Value.Contains(@"Properties\AssemblyInfo.cs"))
                    ls.Add(new ListItem(item.Attributes["Include"].Value, Path.GetDirectoryName(url)));
            }
            return ls;
        }

        private static void FillTables()
        {
            List<string> urls = new List<string>() {
            @"C:\Users\jsing192\source\repos\TitanToolBox\TitanToolBox"
            };

            foreach (var s in GetSolutions(urls))
            {
                ExecuteProcWithParams("spSolutions", new Hashtable() { { "solution_name", s.Text } });
                foreach (var p in GetProjects(s.Value))
                {
                    ExecuteProcWithParams("spProjects", new Hashtable() { { "project_name", p.Text }, { "solution_id", GetSingleValue("select max(id) from solutions") } });
                    foreach (var a in GetActivities(p.Value))
                    {
                        ExecuteProcWithParams("spActivities", new Hashtable() { { "activity_name", a.Text }, { "project_id", GetSingleValue("select max(id) from projects") } });
                    }
                }

            }
        }

        public static void PopulateDDFromDataTable(ListControl dd, DataTable dt)
        {
            try
            {
                BindDDL(dd, dt);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private static void BindDDL(ListControl dd, DataTable dt)
        {
            try
            {
                if (dd.GetType().Name == "DropDownList")
                {
                    var firstitem = dd.Items[0];
                    dd.Items.Clear();
                    dd.Items.Add(firstitem);
                }

                dd.DataSource = dt;
                dd.DataTextField = dt.Columns[0].ColumnName;
                dd.DataValueField = dt.Columns[1].ColumnName;
                if (dt.Rows.Count <= 0)
                    dt = null/* TODO Change to default(_) if this is not a reference type */;
                dd.DataBind();
                if (dd.GetType().Name == "DropDownList")
                    dd.Items.Insert(0, new ListItem("Select", ""));
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static void FillSolutions(DropDownList dd)
        {
            PopulateDDFromDataTable(dd, GetDataTableFromSQL("Select solution_name,id from solutions order by 2"));
        }

        public static void FillProjects(DropDownList dd,string id)
        {
            PopulateDDFromDataTable(dd, GetDataTableFromSQL($"Select project_name,id from projects where solution_id={id} order by 2"));
        }

        public static void FillActivities(DropDownList dd,string id)
        {
            PopulateDDFromDataTable(dd, GetDataTableFromSQL($"Select activity_name,id from activities where project_id={id} order by 2"));
        }

        public static void CreateATrace(string activity_id, string issue, string sol, string type)
        {
            ExecuteProcWithParams("spTrace_log",new Hashtable() {
                {"activity_id", activity_id},
                {"trace_info", issue},
                {"trace_res", sol},
                {"trace_type", type},
            });
        }
    }
}