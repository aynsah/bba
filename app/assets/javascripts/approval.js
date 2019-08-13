//= require turbolinks
//= require jquery
//= require jquery-ui

function approve(campaign_id) {
  $.ajax({
    url: "/campaigns/approval/" + campaign_id,
    type: "POST",  
    success:function(data) {
      alert("Updated"); 
    }
  });
}