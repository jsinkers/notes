document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems);
    var container = document.getElementById("results-container");
    var searchInput = document.getElementById('search-input');
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
        searchInput: searchInput,
        resultsContainer: container,
        json: '/notes/search.json',
        //fuzzy: true
    });

    // clear the 
    document.getElementById("close-icon").addEventListener("click", function (){
        searchInput.value = "";
        while (container.firstChild) {
            container.removeChild(container.firstChild);
        }
    });
    

});

// Initialize collapsible (uncomment the lines below if you use the dropdown variation)
// var collapsibleElem = document.querySelector('.collapsible');
// var collapsibleInstance = M.Collapsible.init(collapsibleElem, options);

// Or with jQuery

// $(document).ready(function(){
//   $('.sidenav').sidenav();
// });
