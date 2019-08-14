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

function decline(campaign_id) {
  $.ajax({
    url: "/campaigns/decline/" + campaign_id,
    type: "POST",  
    success:function(data) {
      alert("Declined"); 
    }
  });
}