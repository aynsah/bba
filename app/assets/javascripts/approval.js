//= require turbolinks
//= require jquery
//= require jquery-ui

function approve(campaign_id, status) {
  $.ajax({
    url: "/campaigns/approval/" + campaign_id,
    type: "POST",
    data: { status_data: status},  
    success:function(data) {
      alert("Campaign telah dirubah"); 
      location.reload();
    }
  });
}

function decline(campaign_id) {
  $.ajax({
    url: "/campaigns/decline/" + campaign_id,
    type: "POST",  
    success:function(data) {
      alert("Penolakan berhasil!"); 
    }
  });
}