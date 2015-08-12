$( document ).ready(function() {
  var heights = $(".same_height").map(function() {
    return $(this).height();
  }).get(),

      maxHeight = Math.max.apply(null, heights);

  $(".same_height").height(heights[0]);
});
