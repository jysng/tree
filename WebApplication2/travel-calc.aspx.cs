using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class travel_calc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Title = Environment.GetFolderPath( Environment.SpecialFolder.LocalApplicationData);
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            double NoOfDays = Convert.ToDouble(nod.Value);
            double NoOfPersons = Convert.ToDouble(nop.Value);
            double DailyFoodExpanse = Convert.ToDouble(adfe.Value);
            double DailyLodgeExpanse = Convert.ToDouble(adle.Value);
            double Mileage = Convert.ToDouble(vehicle_mileage.Value);
            double TotalKm = Convert.ToDouble(tktt.Value);
            double GasPrice = 95.00;
            
            double TotalFoodExpenditure = Math.Round((NoOfDays * NoOfPersons * DailyFoodExpanse));
            double TotalLodgeExpenditure =  Math.Round(NoOfDays * NoOfPersons * DailyFoodExpanse);
            double TotalTransportExpenditure = Math.Round((TotalKm / Mileage) * GasPrice);
            
            double TotalExpenditure = TotalFoodExpenditure + TotalTransportExpenditure + TotalLodgeExpenditure;

            pFood.InnerHtml = TotalFoodExpenditure.ToString();
            pTransport.InnerHtml = TotalTransportExpenditure.ToString();
            pLodge.InnerHtml = TotalLodgeExpenditure.ToString();
            pTotal.InnerHtml = TotalExpenditure.ToString();
            // Title = nod.Value* adfe.Value*;
        }
    }
}