<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Todo_List.aspx.cs" Inherits="Todo_List_Fazal.Todo_List" %>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>TODO PAGE</P>
      <div id="page-wrap">
    <div id="header">
      <%--<h1><a href="">PHP Sample Test App</a></h1>--%>
    </div>

    <div id="main">
      <noscript>This site just doesn't work, period, without JavaScript</noscript>

      <ul id="list" class="ui-sortable">
        <%--<li color="1" class="colorBlue" rel="1" id="2">
          <span id="2listitem" title="Double-click to edit..." style="opacity: 1;">Work
          List</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab" style="width: 44px; display: block; right: -64px;">
          </div>

          <div class="donetab tab"></div>
        </li>

        <li color="4" class="colorGreen" rel="2" id="4">
          <span id="4listitem" title="Double-click to edit..." style=
          "opacity: 0.5;">Saibaan List<img src="/images/crossout.png" class="crossout"
          style="width: 100%; display: block;" /></span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>

        <li color="1" class="colorBlue" rel="3" id="6">
          <span id="6listitem" title="Double-click to edit...">adfas</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>

        <li color="1" class="colorBlue" rel="4" id="7">
          <span id="7listitem" title="Double-click to edit...">adfa</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>

        <li color="1" class="colorBlue" rel="5" id="8">
          <span id="8listitem" title="Double-click to edit...">asdfas</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>

        <li color="1" class="colorBlue" rel="6" id="9">
          <span id="9listitem" title="Double-click to edit...">fasdfasdf</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>

        <li color="3" class="colorRed" rel="7" id="10">
          <span id="10listitem" title="Double-click to edit...">asdasfaf</span>

          <div class="draggertab tab"></div>

          <div class="colortab tab"></div>

          <div class="deletetab tab"></div>

          <div class="donetab tab"></div>
        </li>--%>
      </ul>
	  <br />

      <form action="" id="add-new" method="post">
        <%--<input type="text" id="new-list-item-text" name="new-list-item-text" />--%>
          <asp:TextBox ID="newitem" name="newitem" runat="server"></asp:TextBox>
        <%--<input type="submit" id="add-new-submit" value="Add" class="button" />--%>
          <asp:Button ID="Add_Button" runat="server" class="button" Text="Add" OnClick="Add_Button_Click" />
      </form>
        
      <div class="clear"></div>
    </div>
  </div>
  

   

</asp:Content>

