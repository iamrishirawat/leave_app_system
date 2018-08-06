jQuery (document).ready(function($){
    $(window).on('popstate', function(){
    location.reload(true);
  })
  
  $('#all_applications tr td').each(function(){
    if($(this).text() == "Approve")$(this).css('background-color','green');
    if($(this).text() == "Reject")$(this).css('background-color','red');
  });
})

