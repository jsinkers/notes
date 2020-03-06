document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(elems);
  // grab all elements in DOM with the class 'equation'
  //var tex = document.getElementsByClassName("equation");

  // for each element, render the expression attribute
  /* Array.prototype.forEach.call(tex, function(el) {
    katex.render(el.getAttribute("data-expr"), el);
  });*/
  $("script[type='math/tex']").replaceWith(
      function(){
      var tex = $(this).text();
      return "<span class=\"inline-equation\">" +
             katex.renderToString(tex) +
             "</span>";
  });

  $("script[type='math/tex; mode=display']").replaceWith(
    function(){
      var tex = $(this).text();
      return "<div class=\"equation\">" +
             katex.renderToString("\\displaystyle "+tex) +
             "</div>";
  });
});

// Initialize collapsible (uncomment the lines below if you use the dropdown variation)
// var collapsibleElem = document.querySelector('.collapsible');
// var collapsibleInstance = M.Collapsible.init(collapsibleElem, options);

// Or with jQuery

// $(document).ready(function(){
//   $('.sidenav').sidenav();
// });
