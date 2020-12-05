document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems);
    // grab all elements in DOM with the class 'equation'
    //var tex = document.getElementsByClassName("equation");

    // for each element, render the expression attribute
    /* Array.prototype.forEach.call(tex, function(el) {
      katex.render(el.getAttribute("data-expr"), el);
    });*/
    renderMathInElement(document.body, {
        delimiters: [
            {left: "\\(", right: "\\)", display: false},
            {left: "\\[", right: "\\]", display: true},           
            {left: "$$", right: "$$", display: true},
            {left: "$", right: "$", display: false}]
    });
    var sjs = SimpleJekyllSearch({
        searchInput: document.getElementById('search-input'),
        resultsContainer: document.getElementById('results-container'),
        json: '/notes/search.json'
    })
});

// Initialize collapsible (uncomment the lines below if you use the dropdown variation)
// var collapsibleElem = document.querySelector('.collapsible');
// var collapsibleInstance = M.Collapsible.init(collapsibleElem, options);

// Or with jQuery

// $(document).ready(function(){
//   $('.sidenav').sidenav();
// });
