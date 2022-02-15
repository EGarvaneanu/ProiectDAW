<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Biblioteca.aspx.cs" Inherits="ProiectDAW.Biblioteca" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <asp:AccessDataSource ID="ADS1" runat="server" DataFile="~/Biblioteca.mdb" SelectCommand="SELECT [IdCategorie], [DCategorie] FROM [Categorii]"></asp:AccessDataSource>
       <asp:AccessDataSource ID="ADS3" runat="server" DataFile="~/Biblioteca.mdb" 
             DeleteCommand="DELETE FROM [StocCarti] WHERE [IdCarte] = ?" 
             InsertCommand="INSERT INTO [StocCarti] ([Cantitate]) VALUES (?)" 
             SelectCommand="SELECT [IdCarte], [Cantitate] FROM [StocCarti]" 
             UpdateCommand="UPDATE [StocCarti] SET [Cantitate] = ? WHERE [IdCarte] = ?">
             <DeleteParameters>
                 <asp:Parameter Name="IdCarte" Type="Int32" />
             </DeleteParameters>
             <InsertParameters>
                
                 <asp:Parameter Name="Cantitate" Type="Int32" />
             </InsertParameters>
             <UpdateParameters>
                 <asp:Parameter Name="Cantitate" Type="Int32" />
                 <asp:Parameter Name="IdCarte" Type="Int32" />
             </UpdateParameters>
        </asp:AccessDataSource>
        <asp:AccessDataSource ID="ADS2" runat="server" DataFile="~/Biblioteca.mdb" 
            SelectCommand="SELECT [IdCarte], [Titlu], [Autor], [IdCategorie], [Pret], [SpPoza] FROM [Carte] WHERE ([IdCategorie] = ?)" 
            DeleteCommand="DELETE FROM [Carte] WHERE [IdCarte] = ?" 
            InsertCommand="INSERT INTO [Carte] ([Titlu], [Autor], [IdCategorie], [Pret], [SpPoza]) VALUES (?, ?, ?, ?, ?)" 
            OnSelecting="ADS2_Selecting" 
            UpdateCommand="UPDATE [Carte] SET [Titlu] = ?, [Autor] = ?, [IdCategorie] = ?, [Pret] = ?, [SpPoza] = ? WHERE [IdCarte] = ?">
            <DeleteParameters>
                <asp:Parameter Name="IdCarte" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
               
                <asp:Parameter Name="Titlu" Type="String" />
                <asp:Parameter Name="Autor" Type="String" />
                <asp:Parameter Name="IdCategorie" Type="Int32" />
                <asp:Parameter Name="Pret" Type="Decimal" />
                <asp:Parameter Name="SpPoza" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ListBox1" Name="IdCategorie" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Titlu" Type="String" />
                <asp:Parameter Name="Autor" Type="String" />
                <asp:Parameter Name="IdCategorie" Type="Int32" />
                <asp:Parameter Name="Pret" Type="Decimal" />
                <asp:Parameter Name="SpPoza" Type="String" />
                <asp:Parameter Name="IdCarte" Type="Int32" />
            </UpdateParameters>
        </asp:AccessDataSource>
        
        <div class="container">
        
            <div class="row">
            <div class="col-xs-12">
            <asp:Panel ID="Panel2" runat="server" style="height: 44px; width: 570px;">
            <asp:Label ID="lblConfirma" runat="server" style="position:absolute; top: 7px; left: 6px;" Text="Confirmati stergerea cartii nr:"></asp:Label>
            
            <asp:TextBox ID="txtStergeTitlu" style="position:absolute; top: 6px; left: 300px; width: 220px;" runat="server" ReadOnly="True"></asp:TextBox>
            <asp:TextBox ID="txtStergeId" style="position:absolute; top: 6px; left: 230px; width: 48px;" runat="server" ReadOnly="True"></asp:TextBox>
           
            <asp:Button ID="btnConfirmaSterge" style="position:absolute; left: 550px;" runat="server" Text="Confirma" OnClick="btnConfirmaSterge_Click" />
            <asp:Button ID="btnRenuntaSterge" style="position:absolute;  left: 650px;" runat="server" Text="Renunta" OnClick="btnRenuntaSterge_Click" />

            </asp:Panel>
            </div>
            </div>

            <div class="row">
                <div class="col-md-2"><asp:Label ID="Label1" runat="server" Text="Categorie:"></asp:Label>
                </div>
                <div class="col-md-2"><asp:Button ID="btnAdauga" runat="server" Text="Adauga" style="width: 114px;" OnClick="Button1_Click" />
                </div>
                <div class="col-md-2"><asp:Button ID="btnModifica" runat="server" Text="Modifica" style="width: 114px;" OnClick="btnModifica_Click" />
                </div>
                <div class="col-md-2"><asp:Button ID="btnSterge" runat="server" Text="Sterge" style="width: 114px;" OnClick="btnSterge_Click" />
                </div>
                <div class="col-md-2"><asp:Button ID="btnStoc" runat="server" Text="Vizualizare stoc" style="width: 170px;" OnClick="btnStoc_Click" />        
                </div>
                <div class="col-md-2"> <asp:Label ID="lblActiune" style="left: 948px;" runat="server" Text="Label" Font-Size="X-Large"></asp:Label>
                </div>
           </div>

            <div class="row">
            <div class="col-md-2">
               <asp:ListBox ID="ListBox1" runat="server" style="width: 122px;" AutoPostBack="True" DataSourceID="ADS1" DataTextField="DCategorie" DataValueField="IdCategorie"></asp:ListBox>
            </div>
            <div class="col-md-7">
                <asp:GridView ID="GridView1" style="height: 204px; width: 362px;" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IdCarte" DataSourceID="ADS2" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ButtonType="Button" SelectText=" " ShowSelectButton="True" />
                <asp:BoundField DataField="IdCarte" HeaderText="IdCarte" InsertVisible="False" ReadOnly="True" SortExpression="IdCarte" />
                <asp:BoundField DataField="Titlu" HeaderText="Titlu" SortExpression="Titlu" />
                <asp:BoundField DataField="Autor" HeaderText="Autor" SortExpression="Autor" />
                <asp:BoundField DataField="IdCategorie" HeaderText="IdCategorie" SortExpression="IdCategorie" />
                <asp:BoundField DataField="Pret" HeaderText="Pret" SortExpression="Pret" />
                <asp:BoundField DataField="SpPoza" HeaderText="SpPoza" SortExpression="SpPoza" />
                <asp:ImageField DataImageUrlField="SpPoza">
                    <ControlStyle Height="70px" Width="48px" />
                </asp:ImageField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="White" HorizontalAlign="Center" BackColor="#2461BF" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
            </div>
            <div class="col-md-3">
             <asp:Panel ID="Panel1" runat="server" style="height: 292px; width: 463px;">
            <asp:Label ID="lblAutor" runat="server" Text="Autor" style="position:absolute; top: 55px; left: 0px; height: 27px;"></asp:Label>
            <asp:Label ID="lblPret" runat="server" Text="Pret" style="position:absolute; top: 91px; left: 0px; height: 21px;"></asp:Label>
            <asp:Label ID="lblCategorie" runat="server" Text="Categorie" style="position:absolute; top: 129px; left: 0px; height: 23px;"></asp:Label>
            <asp:Label ID="lblPoza" runat="server" Text="Poza" style="position:absolute; top: 162px; left: 0px; height: 20px;"></asp:Label>
            <asp:Label ID="lblTitlu" runat="server" Text="Titlu" style="position:absolute; top: 20px; left: 0px; height: 23px;"></asp:Label>
            <asp:Label ID="lblStoc" runat="server" Text="Stoc" style="position:absolute; top: 205px; left: 3px; height: 20px;"></asp:Label>
            <asp:TextBox ID="txtTitlu" runat="server" style="position:absolute; top: 20px; left: 84px; height: 18px; width: 134px;"></asp:TextBox>
            <asp:TextBox ID="txtAutor" runat="server" style="position:absolute; top: 55px; left: 84px; height: 18px; width: 134px;"></asp:TextBox>
            <asp:TextBox ID="txtPret" runat="server" style="position:absolute; top: 90px; left: 84px; height: 18px; width: 134px;"></asp:TextBox>
            <asp:TextBox ID="txtPoza" runat="server" style="position:absolute; top: 160px; left: 84px; height: 18px; width: 134px;"></asp:TextBox>
       
            <asp:TextBox ID="txtStoc" runat="server" style="position:absolute; top: 201px; left: 85px; height: 18px; width: 134px;"></asp:TextBox>

            
            <asp:DropDownList ID="ddlCategorie" style="position:absolute; top: 125px; left: 84px; height: 25px; width: 141px;" runat="server" DataSourceID="ADS1" DataTextField="DCategorie" DataValueField="IdCategorie">
            </asp:DropDownList>
       
            <asp:Button ID="btnConfirmare" runat="server" Text="Confirma" style="position:absolute; top: 245px; left: 40px; height: 24px; width: 86px;" OnClick="btnConfirmare_Click"/>
            <asp:Button ID="btRenuntare" runat="server" Text="Renunta" CausesValidation="false" style="position:absolute; top: 245px; left: 172px; height: 24px; width: 86px;" OnClick="btRenuntare_Click"/>
       
            <asp:RequiredFieldValidator ID="rfvTitlu" runat="server" ErrorMessage="Completeaza Titlu" ControlToValidate="txtTitlu">&nbsp
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvAutor" runat="server" ErrorMessage="Completeaza Autor" ControlToValidate="txtAutor">&nbsp
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvPret" runat="server" ErrorMessage="Completeaza Pret" ControlToValidate="txtPret">&nbsp
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvPoza" runat="server" ErrorMessage="Completeaza Poza" ControlToValidate="txtPoza">&nbsp
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfvStoc" runat="server" ErrorMessage="Completeaza Stoc" ControlToValidate="txtPoza">&nbsp
            </asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RVPret" runat="server" ErrorMessage="Pret eronat" 
            style="position :absolute; top: 42px; left: 262px;" 
            ControlToValidate="txtPret" MaximumValue="1000" MinimumValue="0" 
            Type="Currency">&nbsp;</asp:RangeValidator>

            <asp:RangeValidator ID="RVStoc" runat="server" ErrorMessage="Stoc eronat" 
            style="position :absolute; top: 42px; left: 262px;" 
            ControlToValidate="txtPret" MaximumValue="10000" MinimumValue="0" 
            Type="Currency">&nbsp;</asp:RangeValidator>

            <asp:ValidationSummary ID="ValidationSummary" style="position:absolute; top: 24px; left: 265px; width: 201px; height: 60px;" runat="server" ForeColor="Red" />
        </asp:Panel>
            </div>
            </div>
            <div class="row">
            <div class="col-xs-12">
            <asp:Panel ID="Panel3" runat="server" style="height: 351px; width: 783px;">
            <asp:AccessDataSource ID="ADS4" runat="server" DataFile="~/Biblioteca.mdb" SelectCommand="SELECT Carte.Titlu, Carte.Autor, StocCarti.Cantitate FROM (Carte INNER JOIN StocCarti ON Carte.IdCarte = StocCarti.IdCarte)"></asp:AccessDataSource>
            
            <asp:AccessDataSource ID="ChartADS" runat="server" DataFile="~/Biblioteca.mdb" SelectCommand="SELECT Carte.Titlu, StocCarti.Cantitate FROM (Carte INNER JOIN StocCarti ON Carte.IdCarte = StocCarti.IdCarte)"></asp:AccessDataSource>
            
            <asp:Chart ID="Chart1" runat="server" style="width: 264px; height: 255px;" DataSourceID="ChartADS"><series><asp:Series Name="Series1" ChartType="Bar" XValueMember="Titlu" YValueMembers="Cantitate"></asp:Series></series><chartareas><asp:ChartArea Name="ChartArea1"></asp:ChartArea></chartareas></asp:Chart>
            <asp:GridView ID="GridView2" style="position:absolute; top: 37px; left: 7px; width: 149px;" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ADS4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField SelectText="" ShowSelectButton="True" />
                    <asp:BoundField DataField="Titlu" HeaderText="Titlu" SortExpression="Titlu" />
                    <asp:BoundField DataField="Cantitate" HeaderText="Cantitate" SortExpression="Cantitate" />
                    <asp:BoundField HeaderText="Procent" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="White" HorizontalAlign="Center" BackColor="#2461BF" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:Button ID="btnInchide" runat="server" Text="Inchide vizualizare stoc" style="position:absolute; top: 313px; left: 772px;" OnClick="btnInchide_Click" CausesValidation="false"/>
        </asp:Panel>
            </div>
            </div>
       </div>
    </form>
</body>
</html>
