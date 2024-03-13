<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Todo.aspx.cs" Inherits="Todo_List_Fazal.Todo" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
    <link href="Content/style.css" rel="stylesheet" />

  <title></title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
     <script type="text/javascript">
         
         $(document).ready(function () {
            
             $.ajax({
                 url: 'Todo.aspx/Get_List',
                 method: 'GET',
                 contentType: 'application/json; charset=utf-8',
                 dataType: 'json',
                 success: function (data) {
                     console.log(data);
                     var ul = $('#list');

                     //for (var i = 0; i < data.length; i++) {
                     //    var li = '<li color="1" class="colorBlue" rel="5" id=' + data[i].ListItemId + '>  <span id="10listitem" title="Double-click to edit...">' + data[i].Description + '</span><div class="draggertab tab"></div><div class="colortab tab"></div><div class="deletetab tab"></div> <div class="donetab tab"></div></li>';
                     //}
                     //ul.append(li);

                     //$.each(data, function (index, item) {
                     //    ul.append('<li color="1" class="colorBlue" rel="5" id=' + item.ListItemId + '>  <span id="10listitem" title="Double-click to edit...">' + item.Description + '</span><div class="draggertab tab"></div><div class="colortab tab"></div><div class="deletetab tab"></div> <div class="donetab tab"></div></li>');
                     //});
                     appendDataToList(data.d)
                 },
                 error: function (error) {
                     console.log('Error:', error);
                 }
             });

             function appendDataToList(data) {
                
                 var ul = $('#list');

                 data.sort(function (a, b) {
                     return a.ItemPosition - b.ItemPosition;
                 });
                 
                 $.each(data, function (item) {
                     var li;
                     if ($(this)[0].IsDone == 1) {
                         li = $('<li color="1" class="colorBlue" rel="5" id=' + $(this)[0].ListItemId + '>').html('<s> <span id="10listitem" title="Double-click to edit..." ondblclick="EditD<a href="favicon.ico">favicon.ico</a>es(' + $(this)[0].ListItemId + ')">' + $(this)[0].Description + '</span></s><div class=""><div class="draggertab tab" onclick="InitSortable(this)"></div><div class="colortab tab"></div><div  data-item-id="' + $(this)[0].ListItemId + '" ondblclick="Deletebtn(' + $(this)[0].ListItemId + ')" class="deletetab tab item"></div> <div  onclick="UpdateTask(' + $(this)[0].ListItemId + ')" class="donetab tab"></div></div></li>');
                     }
                     else
                     {
                         li = $('<li color="1" class="colorBlue" rel="5" id=' + $(this)[0].ListItemId + '>').html(' <span id="10listitem" title="Double-click to edit..." ondblclick="EditDes(' + $(this)[0].ListItemId + ')">' + $(this)[0].Description + '</span><div class=""><div class="draggertab tab"  onclick="InitSortable(this)"></div><div class="colortab tab"></div><div  data-item-id="' + $(this)[0].ListItemId + '" ondblclick="Deletebtn(' + $(this)[0].ListItemId + ')" class="deletetab tab item"></div> <div  onclick="UpdateTask(' + $(this)[0].ListItemId + ')" class="donetab tab"></div></div></li>');
                     }

                     
                     ul.append(li);
                 });
             }

             //$("#list").sortable();
             //$("#list").disableSelection();

         });
             
         function Postbtn() {

             
             var dataTo= $("#new-list-item-text").val();
             
               
             $.ajax({
                 type: "POST",
                 url: "Todo.aspx/Add_Click",
                 data: JSON.stringify({ data: dataTo }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     
                     alert(response.d);
                 },
                 error: function (error) {
                     console.log(error);
                 }
             });
         };


         function Deletebtn(itemId) {


             var item = $(this).closest('.item');
             

             // Show confirmation alert
             var isConfirmed = confirm('Are you sure you want to delete this item?');

             // If user confirms, delete the item
             if (isConfirmed) {
                 deleteItem(itemId);
                 // Optionally, you can also remove the item from the UI
                 item.remove();
             }

         }

         function deleteItem(itemId) {

             $.ajax({
                 type: "POST",
                 url: "Todo.aspx/Delete_Task",
                 data: JSON.stringify({ ListItemId: itemId }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {

                     alert(response.d);
                     location.reload();

                 },
                 error: function (error) {
                     console.log(error);
                 }
             });
         }



         function UpdateTask(itemId) {

             $.ajax({
                 type: "POST",
                 url: "Todo.aspx/Update_Task",
                 data: JSON.stringify({ ListItemId: itemId }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {

                     alert(response.d);
                     location.reload();

                 },
                 error: function (error) {
                     console.log(error);
                 }
             });
         }



         function EditDes(itemId) {
             var spanElement = $('#' + itemId + ' span');
             var originalText = spanElement.text();

             // Create an input element for editing
             var inputElement = $('<input type="text" class="edit-box" value="' + originalText + '">');

             // Replace the span with the input element
             spanElement.replaceWith(inputElement);

             // Focus on the input element
             inputElement.focus();

             // Add a save button
             var saveButton = $('<button onclick="saveText(' + itemId + ')">Save</button>');
             inputElement.after(saveButton);
         }
    



         function saveText(itemId) {
             var inputElement = $('#' + itemId + ' input');
             var newText = inputElement.val();

             // Replace the input element with a new span containing the edited text
             //inputElement.replaceWith('<span id="10listitem" title="Double-click to edit..." ondblclick="editText(' + itemId + ')">' + newText + '</span>');
             UpdateDes(itemId, newText);
             // Remove the save button
             $('#' + itemId + ' button').remove();
         }

         function UpdateDes(itemId, newText) {

             $.ajax({
                 type: "POST",
                 url: "Todo.aspx/Update_Des",
                 data: JSON.stringify({ ListItemId: itemId, Description: newText }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {

                     alert(response.d);
                     location.reload();

                 },
                 error: function (error) {
                     console.log(error);
                 }
             });
         }

         function InitSortable(button) {
             $('#list').sortable({
                     update: function (event, ui) {
                         var order = $('#list').sortable("toArray");

                         // Send AJAX request to update order
                         $.ajax({
                             type: "POST",
                             url: "Todo.aspx/Update_Order",
                             data: JSON.stringify({ Order: order }),
                             contentType: "application/json; charset=utf-8",
                             dataType: "json",
                             success: function (response) {
                                 console.log("Order updated successfully");
                             },
                             error: function (xhr, status, error) {
                                 console.log("Error updating order: " + error);
                             }
                         });
                     }
                 });
             
         }


         $(function () {
            
             // Make the entire list item draggable
           /*  $(".draggable-tab").draggable({
                 handle: "#dragged_div",
                 // Add additional options as needed
             });*/
         });

     </script>
    
</head>

<body >
  <div id="page-wrap">
    <div id="header">
    </div>

    <div id="main">
      <noscript>This site just doesn't work, period, without JavaScript</noscript>
      <div style="display:flex; justify-content:center; align-content:center "><h1>Todo App</h1></div>
      <ul id="list" class="ui-sortable" style="margin-top:30px">
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
    <input type="text" id="new-list-item-text" name="new-list-item-text" />
        <%--   <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>

    <button  id="add-new-submit"  class="button" onclick="Postbtn()" style="background-color:orange; color:white; font-weight:700; height:41px;" >Add</button>
      <%--<asp:Button ID="Add_Button" runat="server" class="button" Text="Add" OnClick="Add_Button_Click" />--%>
  </form>

      <div class="clear"></div>
    </div>
  </div>
</body>

 
</html>
