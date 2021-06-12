$(function(){
  $("#accordion").on("click", function() {
    $(this).next().slideToggle();
  });
  $(".close-btn").on("click", function(){
    $(".header-deteil-search").slideToggle();
    });
});