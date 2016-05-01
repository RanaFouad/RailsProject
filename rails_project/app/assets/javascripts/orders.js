$(function() {	

var fvalue = $("#friends").val();
var myvalue = {"value":fvalue};
var no_invited_friends = [];
var invited_group_id_array = [];
$("#tbody").on("click","button",remove);
$('#friends').autocomplete({
    serviceUrl: '/orders/batota/',
    type: 'POST',
    onSearchStart: function (params) {
        var friends = [];
        var groups = [];
        for(var i = 0 ; i<no_invited_friends.length ; i++)
        {
            friends[i] = $("#invited_friend_"+no_invited_friends[i]).val();
           // console.log(friends[i]);
        }    
        for(var i = 0 ; i<invited_group_id_array.length ; i++)
        {
            groups[i] = $("#invited_group_"+invited_group_id_array[i]).val();
        }   

        params.friends = friends;
        params.groups = groups;

    },
    onSelect: function (suggestion) {
        //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
        if(suggestion.data.members)
        {
            $("#invited_groups_hidden").append("<input type='hidden' id='invited_group_"+suggestion.data.id+"' value='"+suggestion.data.id+"'>");
            invited_group_id_array.push(suggestion.data.id);    

            /*for(var user in suggestion.data.members)
            {console.log("user.id",suggestion.data.members[0].id);
                $("#invited_friends_hidden").append("<input type='hidden' id='invited_friend_"+suggestion.data.members.id+"' value='"+suggestion.data.members.id+"'>");
                no_invited_friends.push(suggestion.data.members.id);
                $("#tbody").append("<tr id='row_"+suggestion.data.members.id+"'><td>"+suggestion.data.members.username+"</td><td><button id='"+suggestion.data.members.id+"'>Remove</button></td></tr>");
        
            } 
*/
            for(var i = 0 ; i<suggestion.data.members.length ; i++)
            {
                console.log("user.id",suggestion.data.members[i].id);
                $("#invited_friends_hidden").append("<input type='hidden' name='friends[]' id='invited_friend_"+suggestion.data.members[i].id+"' value='"+suggestion.data.members[i].id+"'>");
                no_invited_friends.push(suggestion.data.members[i].id);
                $("#tbody").append("<tr id='row_"+suggestion.data.members[i].id+"'><td>"+suggestion.data.members[i].username+"</td><td><button id='"+suggestion.data.members[i].id+"'>Remove</button></td></tr>");
            }    




        }    
        else
        {    
        $("#invited_friends_hidden").append("<input type='hidden' name='friends[]'  id='invited_friend_"+suggestion.data.id+"' value='"+suggestion.data.id+"'>");
        no_invited_friends.push(suggestion.data.id);
        $("#tbody").append("<tr id='row_"+suggestion.data.id+"'><td>"+suggestion.value+"</td><td><button id='"+suggestion.data.id+"'>Remove</button></td></tr>");
        //$("#btn_"+suggestion.data.id).click('remove');
        }

        $('#friends').val("");
    }

});

function remove(e)
{
    //console.log(e.target.id);
    var btn_id = e.target.id;


    for(var i = 0 ; i<no_invited_friends.length ; i++)
    {
        var friend_id = $("#invited_friend_"+no_invited_friends[i]).val();
        
        if( friend_id == btn_id )
        {
            console.log(friend_id);
            $("#invited_friend_"+no_invited_friends[i]).remove();
            no_invited_friends[i]=0;
            $("#row_"+btn_id).remove();


        }    


    }      



}


});





/*$("#friends").keyup(function(e){      
    //alert("hhhhhhhh");
    var fvalue = $("#friends").val();
    var myvalue = {"value":fvalue};
    console.log (fvalue);
    $.ajax({
            url: "/orders/batota/",
            method: 'POST',
            data: {
                value: fvalue
            },
            success:function(response){
                console.log(response);
            },
            complete: function(xmlHttpRequestObj) {
                console.log("complete");
            },
        });

});*/