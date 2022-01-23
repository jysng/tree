using AngleSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using static TitanFunctions.DataLayer;
using AngleSharp.Dom;

namespace WebApplication2
{
    public partial class tree : Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            //tree
            var config = Configuration.Default;

            var context = BrowsingContext.New(config);

            var source = "<div class='container'><div class='row'><div class='tree'></div></div>";

            var document = await context.OpenAsync(req => req.Content(source));

            var treeDiv = document.GetElementsByClassName("tree")[0];
            DataTable dt = GetDataTableFromSQL("SELECT * FROM TREE --WHERE PARENTID IN(0,1)");
            IElement pr =null;
            IElement cr =null;
            string lastParent = "";

            foreach (DataRow item in dt.Rows)
            {
                if (item["parentid"].ToString() == "0")
                { pr = CreateChild(document, item["HumanName"].ToString());  }
                if (lastParent != item["ParentId"].ToString())
                {
                    DataTable dtc = GetDataTableFromSQL($"SELECT * FROM TREE Where ParentId={item["ParentId"]} and Parentid<>0");
                    if (dtc.Rows.Count >= 1)
                    {
                        IElement ul = document.CreateElement("ul");
                        foreach (DataRow p in dtc.Rows)
                        {
                            
                            lastParent = item["ParentId"].ToString();
                            cr = CreateLi(document, p["HumanName"].ToString());
                            ul.AppendChild(cr);
                            pr.Children[0].Append((ul));
                            //cr.AppendChild(cr);
                        }
                    }
                    //if (cr != null)
                        //pr.AppendChild(cr);
                }
                
                
            }

            treeDiv.AppendChild(pr);
            //Console.WriteLine("Serializing the document again:");
            Response.Write(document.DocumentElement.OuterHtml);
        }

        private static IElement CreateChild(IDocument document,string HumanName)
        {
            var ul = document.CreateElement("ul");
            var li = document.CreateElement("li");
            var a = document.CreateElement("a");
            var img = document.CreateElement("img");
            img.SetAttribute("src", "content/images/1.jpg");
            var span = document.CreateElement("span");
            span.InnerHtml = HumanName;
            li.AppendChild(a);
            a.AppendChild(img);
            a.AppendChild(span);
            ul.AppendChild(li);
            return ul;
        }

        private static IElement CreateLi(IDocument document, string HumanName)
        {
            
            var li = document.CreateElement("li");
            var a = document.CreateElement("a");
            var img = document.CreateElement("img");
            img.SetAttribute("src", "content/images/1.jpg");
            var span = document.CreateElement("span");
            span.InnerHtml = HumanName;
            li.AppendChild(a);
            a.AppendChild(img);
            a.AppendChild(span);
            return li;   
        }
    }
}