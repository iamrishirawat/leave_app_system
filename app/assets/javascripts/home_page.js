$(document).on('turbolinks:load', function() {
    
  $(window).on('popstate', function(){
    alert("Yo")
    location.reload(true);
  })

  
  $('#all_applications tr td').each(function(){
    if($(this).text() == "Approve")$(this).css('background-color','green');
    if($(this).text() == "Reject")$(this).css('background-color','red');
  });
})

