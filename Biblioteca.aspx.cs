using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProiectDAW
{
    public partial class Biblioteca : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListBox1.SelectedIndex = 0;
                GridView1.SelectedIndex = 0;
                Panel1.Visible = false;
                Panel2.Visible = false;
                lblActiune.Text = "";

                int totalStoc = 0;
                foreach(GridViewRow row in GridView2.Rows)
                {
                    totalStoc += Convert.ToInt32(row.Cells[2].Text);
                }
                foreach (GridViewRow row in GridView2.Rows)
                {
                    //row.Cells[3].Value = (totalStoc * 100 / Convert.ToInt32(row.Cells[2].Text)).ToString();
                    decimal procent = (Convert.ToInt32(row.Cells[2].Text)*100)/totalStoc ;
                    row.Cells[3].Text = procent.ToString();

                }

                Panel3.Visible = false;

            }
        }

        private void dezactiveazaButoane()
        {
            btnAdauga.Enabled = false;
            btnModifica.Enabled = false;
            btnSterge.Enabled = false;
        }

        private void activeazaButoane()
        {
            btnAdauga.Enabled = true;
            btnModifica.Enabled = true;
            btnSterge.Enabled = true;
        }

        private void adaugaCarte()
        {
            ADS2.InsertParameters[0].DefaultValue = txtTitlu.Text;
            ADS2.InsertParameters[1].DefaultValue = txtAutor.Text;
            ADS2.InsertParameters[3].DefaultValue = txtPret.Text;
            ADS2.InsertParameters[4].DefaultValue = txtPoza.Text;
            ADS2.InsertParameters[2].DefaultValue = ddlCategorie.Text;
            
            ADS2.Insert();

            ADS3.InsertParameters[0].DefaultValue = txtStoc.Text;
            ADS3.Insert();
        }

        private void stergeCarte()
        {
            ADS2.DeleteParameters[0].DefaultValue = txtStergeId.Text;
            ADS2.Delete();

            ADS3.DeleteParameters[0].DefaultValue = txtStergeId.Text;
            ADS3.Delete();
        }
       
        private void modificaCarte()
        {
            ADS2.UpdateParameters[0].DefaultValue = txtTitlu.Text;
            ADS2.UpdateParameters[1].DefaultValue = txtAutor.Text;
            ADS2.UpdateParameters[2].DefaultValue = ddlCategorie.Text;
            ADS2.UpdateParameters[3].DefaultValue = txtPret.Text;
            ADS2.UpdateParameters[4].DefaultValue = txtPoza.Text;
            ADS2.UpdateParameters[5].DefaultValue = GridView1.SelectedRow.Cells[1].Text;

            ADS2.Update();

            ADS3.UpdateParameters[0].DefaultValue = txtStoc.Text;
            ADS3.UpdateParameters[1].DefaultValue = GridView1.SelectedRow.Cells[1].Text;
            ADS3.Update();
        }

        private void preiaTextForm()
        {
            txtTitlu.Text = GridView1.SelectedRow.Cells[2].Text;
            txtAutor.Text = GridView1.SelectedRow.Cells[3].Text;
            txtPret.Text = GridView1.SelectedRow.Cells[5].Text;
            ddlCategorie.SelectedValue = GridView1.SelectedRow.Cells[4].Text;
            txtPoza.Text = GridView1.SelectedRow.Cells[6].Text;
        }

        private void reseteazaTextForm()
        {
            txtTitlu.Text ="";
            txtAutor.Text = "";
            txtPret.Text = "";
            txtPoza.Text = "";
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Image1.ImageUrl = GridView1.SelectedRow.Cells[6].Text;
            txtStergeId.Text = GridView1.SelectedRow.Cells[1].Text;
            txtStergeTitlu.Text = GridView1.SelectedRow.Cells[2].Text;
            preiaTextForm();
        }

        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            
        }

        protected void ADS2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void btnConfirmare_Click(object sender, EventArgs e)
        {
            if (lblActiune.Text == "Adauga")
            {
                adaugaCarte();
            }
            else
            if (lblActiune.Text == "Modifica")
                modificaCarte();

        }

        protected void btRenuntare_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            activeazaButoane();
            lblActiune.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            reseteazaTextForm();
            dezactiveazaButoane();
            Panel1.Visible = true;
            lblActiune.Text = "Adauga";
        }

        protected void btnSterge_Click(object sender, EventArgs e)
        {
            Panel2.Visible = true;
            dezactiveazaButoane();
            txtStergeId.Text = GridView1.SelectedRow.Cells[1].Text;
            txtStergeTitlu.Text = GridView1.SelectedRow.Cells[2].Text;
        }

        protected void btnRenuntaSterge_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            activeazaButoane();
        }

        protected void btnConfirmaSterge_Click(object sender, EventArgs e)
        {
            stergeCarte();
            Panel2.Visible = false;
            activeazaButoane();
        }

        protected void btnModifica_Click(object sender, EventArgs e)
        {
            preiaTextForm();
            Panel1.Visible = true;
            dezactiveazaButoane();
            lblActiune.Text = "Modifica";
        }

        protected void btnStoc_Click(object sender, EventArgs e)
        {
            Panel3.Visible = true;
        }

        protected void btnInchide_Click(object sender, EventArgs e)
        {
            Panel3.Visible = false;
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}