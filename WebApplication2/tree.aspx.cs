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
using System.Text;

namespace WebApplication2
{
    public partial class tree : Page
    {
        //page load
        protected void Page_Load(object sender, EventArgs e)
        {
            #region comment
            //DataTable dataTable = GetDataTableFromSQL("select * from tree");
            //List<Node> nodes = new List<Node>();
            //foreach (DataRow item in dataTable.Rows)
            //{
            //    Node node = new Node
            //    {
            //        Id = (int)item["Id"],
            //        ParentId = (int)item["ParentId"],
            //        HumanName = item["HumanName"].ToString()
            //    };
            //    nodes.Add(node);
            //}

            //var hierarchy = nodes
            //                    .Where(c => c.ParentId == 0)
            //                 .Select(c => new Node()
            //                 {
            //                     Id = c.Id,

            //                     ParentId = c.ParentId,
            //             //hierarchy = "0000" + c.Id,
            //             Children = GetChildren(nodes, c.Id)
            //                 })
            //                 .ToList();

            //HieararchyWalk(hierarchy); 
            #endregion
            string nTree = WriteList();
            string BaseTree = $"<div class='container'><div class='row'><div class='tree'>{nTree}</div></div>";
            Response.Write(BaseTree);
        }

        protected string WriteList()
        {
            DataTable dataTable = GetDataTableFromSQL("select * from tree");
            List<Node> tasks = new List<Node>();
            foreach (DataRow item in dataTable.Rows)
            {
                Node node = new Node
                {
                    Id = (int)item["Id"],
                    ParentId = (int)item["ParentId"],
                    HumanName = item["HumanName"].ToString(),
                    ProfilePicture= item["ProfilePicURL"].ToString()

                };
                tasks.Add(node);
            }
            var s = new StringBuilder();

            s.Append("<ul>");
            foreach (var task in tasks)
            {
                if (task.ParentId == 0)
                {
                    WriteTaskList(tasks, task, s);
                }
            }
            s.Append("</ul>");

            return s.ToString();
        }

        private static void WriteTaskList(List<Node> tasks, Node task, StringBuilder s)
        {
            s.Append($"<li><a href='#'><img src='{task.ProfilePicture}'><span>{task.HumanName}</span></a>");

            var subtasks = tasks.Where(p => p.ParentId == task.Id);

            if (subtasks.Count() > 0)
            {
                s.Append("<ul>");
                foreach (Node p in subtasks)
                {
                    if (tasks.Count(x => x.ParentId == p.Id) > 0)
                        WriteTaskList(tasks, p, s);
                    else
                        s.Append($"<li> <a href='#'><img src='{p.ProfilePicture}'><span>{p.HumanName}</span></a></li>");
                }
                s.Append("</ul>");
            }

            s.Append("</li>");
        }
        #region Hide
        public List<Node> GetChildren(List<Node> comments, int parentId)
        {
            return comments
                    .Where(c => c.ParentId == parentId)
                    .Select(c => new Node
                    {
                        Id = c.Id,
                        //HumanName = c.HumanName,
                        ParentId = c.ParentId,
                        //hierarchy = "0000" + comments.Where(a => a.Id == parentId).FirstOrDefault().Id + ".0000" + c.Id,
                        Children = GetChildren(comments, c.Id)
                    })
                    .ToList();
        }
        private object GetName(int parentId)
        {
            return GetSingleValue($"Select HumanName From Tree Where Id={parentId}");
        }

        public class Node
        {
            public int Id { get; set; }
            public int ParentId { get; set; }
            public string HumanName { get; set; }
            public string ProfilePicture { get; set; }
            public List<Node> Children { get; set; }
        }
        #endregion
    }
}