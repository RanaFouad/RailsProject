$(function() {
$(".remove").click(function(e){  

	var btn_id = e.target.id;
	console.log(btn_id);
	$.ajax({
            url: "/order_details/"+btn_id,
            method: 'DELETE',
            success:function(response){
                $("#row_"+btn_id).remove();
            },
            complete: function(xmlHttpRequestObj) {
                console.log("complete");
            },
        });





});
//$("#modal_header").on("click","button",del);
var number_invited_friends;
var number_joined_friends;
$(".invited_friends").click(function(e){

	//alert("ddddddddddd");
	//alert(e.target.id);
	var order_id = e.target.id;
	$.ajax({
            url: "/orders/details/"+order_id,
            method: 'GET',
            success:function(response){
                
                number_invited_friends = response.invites.length;
            	console.log(response.invitations_id);
            	//$('#myModal').modal('toggle');
            	$("#modal_header").text("");
            	$("#modal_header").append("Number of invited friends is : "+response.invites.length);
            	$("#invitation_table").html("");
                console.log($("#modal_header").text());
            	for(var i = 0 ; i<response.invites.length ; i++)
            	{	
            		$("#invitation_table").append("<tr id='row_"+response.invitations_id[i]+"'><td>"+response.invites[i].username+"</td><td id='td_"+response.invitations_id[i]+"'></td></tr>");
            		if(response.creator == 1)
            		{
            			$("#td_"+response.invitations_id[i]).append("<button id='"+response.invitations_id[i]+"'>Remove</button>");
            			$("#"+response.invitations_id[i]).click(del);

            		}



            	}	

            },
            complete: function(xmlHttpRequestObj) {
                console.log("complete");
            },
        });	



});


function del(e)
{

	//alert("Kkkkkkkkkkkkkkkk");
	var btn_id = e.target.id

	$.ajax({
            url: "/orders/delete_invitation/"+btn_id,
            method: 'DELETE',
            success:function(response){
                $("#row_"+btn_id).remove();
                number_invited_friends=number_invited_friends-1;
                $("#modal_header").text("");
                $("#modal_header").append("Number of invited friends is : "+number_invited_friends);
            },
            complete: function(xmlHttpRequestObj) {
                console.log("complete");
            },
        });	

}






$(".joined_friends").click(function(e){

	//alert("ddddddddddd");
	//alert(e.target.id);
	var order_id = e.target.id;
    console.log("order_id",e.target.id);
	$.ajax({
            url: "/orders/join_details/"+order_id,
            method: 'GET',
            success:function(response){
                
                number_joined_friends = response.join.length;
            	console.log(response.invitations_id);
            	//$('#myModal').modal('toggle');
            	$("#modal_header_join").text("");
            	$("#modal_header_join").append("Number of joined friends is : "+response.join.length);
            	$("#join_table").html("");
            	for(var i = 0 ; i<response.join.length ; i++)
            	{	
            		$("#join_table").append("<tr id='row_"+response.invitations_id[i]+"'><td>"+response.join[i].username+"</td>");
            		/*if(response.creator == 1)
            		{
            			$("#td_"+response.invitations_id[i]).append("<button id='"+response.invitations_id[i]+"'>Remove</button>");
            			$("#"+response.invitations_id[i]).click(del);

            		}
*/


            	}	

            },
            complete: function(xmlHttpRequestObj) {
                console.log("complete");
            },
        });	



});





$(".joinn").click(function(e){


//alert("jjjjjjjjjjjjjj");

///invitations/join/

//alert($(this).parent());

$(this).parent().removeChild();











});














});