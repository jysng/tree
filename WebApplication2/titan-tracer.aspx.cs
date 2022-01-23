using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using static WebApplication2.trace;// TitanFunctions.DataLayer;

namespace WebApplication2
{
    public partial class titan_tracer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //FillTables();
                FillSolutions(ddlSolutions);
                //ddlSolutions.Items.AddRange(GetSolutions(urls));
            }
            
        }
        protected void ddlSolutions_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillProjects(ddlProjects, ddlSolutions.SelectedValue);
        }
        protected void ddlProjects_SelectedIndexChanged(object sender, EventArgs e)
        {

            FillActivities(ddlActivities, ddlProjects.SelectedValue);
        }
        
        protected void btnSave_Click(object sender, EventArgs e)
        {
            CreateATrace(ddlActivities.SelectedValue, txtIssue.Text, txtSolution.Text, ddlTraceType.SelectedValue);
        }

       
    }
}