using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Admin : System.Web.UI.Page
{
    private bool isExport = false;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvResults.Visible = true;
        gvResults.DataSourceID = "odsSearchResults";
    }

    protected void gvResults_ItemCommand(object source, GridCommandEventArgs e)
    {
        if (e.CommandName.Contains("Export"))
        {
            isExport = true;
            //gvResults.MasterTableView.HierarchyDefaultExpanded = true;
            gvResults.MasterTableView.Caption = "<strong> Requests as of" + DateTime.Now.ToShortDateString() + "</strong>";
        }
    }

    protected void gvResults_ItemCreated(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridDataItem)
        //{
        //    HyperLink editLink = (HyperLink)e.Item.FindControl("hlkRequestID");
        //    editLink.Attributes["href"] = "#";
        //    editLink.Attributes["onclick"] = String.Format("return ShowDetailsForm('{0}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RQTID"]);
        //}

        if (isExport)
        {
            if (e.Item is GridHeaderItem)
            {
                switch (e.Item.OwnerTableView.Name)
                {
                    case "RequestDetails": e.Item.OwnerTableView.BackColor = System.Drawing.Color.LightGray; break;
                    case "AccountDetails": e.Item.OwnerTableView.BackColor = System.Drawing.Color.Gray; break;
                }
            }
        }
    }

    protected void gvResults_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        Session["RQTID"] = dataItem.GetDataKeyValue("RQTID").ToString();
    }

    protected void odsSearchResults_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["fromdate"] = txtFromDate.SelectedDate.HasValue ? txtFromDate.SelectedDate.Value.ToShortDateString() : null;
        e.InputParameters["todate"] = txtToDate.SelectedDate.HasValue ? txtToDate.SelectedDate.Value.ToShortDateString() : null;
    }
}