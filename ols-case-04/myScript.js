
//..............................
// handling of collapsibles
// see: https://www.w3schools.com/howto/howto_js_collapsible.asp
var coll = document.getElementsByClassName("collButtonCl");
var i;

for (i = 0; i < coll.length; i++) {
    coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var content = this.nextElementSibling;
        if (content.style.display === "block") {
        content.style.display = "none";
        } else {
        content.style.display = "block";
        }
    });
}

//..............................
// handling of tabs      
// see: https://www.w3schools.com/howto/howto_js_tabs.asp

// open specific tab
function openSpecificTab(tabContentId, tabLinkId, color) {

    // hide all elements with class="tabcontent_l1" by default */
    var i, tabcontent, tablinks;

    tabcontent = document.getElementsByClassName("tabContentL1Cl");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tabLinkL1Cl");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }

    // show the specific tab content
    document.getElementById(tabContentId).style.display = "block";

    // add the specific color to the button used to open the tab content
    document.getElementById(tabLinkId).style.backgroundColor = color;

}

var nVec = [5, 10, 25, 50, 100];
var b1Vec = [-2, -1, 0, 1, 2];
var b2Vec = [-2, -1, 0, 1, 2];
var rhoVec = [-0.9, -0.5, 0, 0.5, 0.9];

// set initial value for slider 1
document.getElementById("ex601Val").innerHTML = "\\(n = " + nVec[2] + "\\)";
var element = document.getElementById("ex601Val");
MathJax.typeset([element]);

// set initial value for slider 2
document.getElementById("ex602Val").innerHTML = "\\(\\beta_{1} = " + b1Vec[2] + "\\)";
var element = document.getElementById("ex602Val");
MathJax.typeset([element]);

// set initial value for slider 3
document.getElementById("ex603Val").innerHTML = "\\(\\beta_{2} = " + b2Vec[2] + "\\)";
var element = document.getElementById("ex603Val");
MathJax.typeset([element]);

// set initial value for slider 4
document.getElementById("ex604Val").innerHTML = "\\(\\rho_{X_{1}X_{2}} = " + rhoVec[2] + "\\)";
var element = document.getElementById("ex604Val");
MathJax.typeset([element]);

// set initial value for bias
var bias = b2Vec[2] * rhoVec[2] * 10/10;
document.getElementById("equBias").innerHTML = "$$\\begin{align}\\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} \\beta_{1} + \\beta_{2} \\rho_{X_{1}X_{2}} \\frac{\\sigma_{X_{2}}}{\\sigma_{X_{1}}} \\\\ \\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} " + b1Vec[2] + " + " + bias + ",\\end{align}$$";
var element = document.getElementById("equBias");
MathJax.typeset([element]);      

//..............................
// handling of slider                
// see: https://seiyria.com/bootstrap-slider/

//var slider01 = new Slider("#ex601", { tooltip: 'always' });
var slider01 = new Slider("#ex601", { 
    tooltip: "never",
    formatter: function(value) {
        return nVec[value];
    } 
});
//var slider02 = new Slider("#ex602", { tooltip: 'always' });
var slider02 = new Slider("#ex602", { 
    tooltip: "never",
    formatter: function(value) {
        return b1Vec[value];
    } 
});
//var slider03 = new Slider("#ex603", { tooltip: 'always' });
var slider03 = new Slider("#ex603", { 
    tooltip: "never",
    formatter: function(value) {
        return b2Vec[value];
    } 
});
//var slider04 = new Slider("#ex604", { tooltip: 'always' });
var slider04 = new Slider("#ex604", { 
    tooltip: "never",
    formatter: function(value) {
        return rhoVec[value];
    } 
});

slider01.on("slide", function() {

    var sliderValue01 = slider01.getValue() + 1;
    var sliderValue02 = slider02.getValue() + 1;
    var sliderValue03 = slider03.getValue() + 1;
    var sliderValue04 = slider04.getValue() + 1;

    document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

    document.getElementById("ex601Val").innerHTML = "\\(n = " + nVec[slider01.getValue()] + "\\)";
    var element = document.getElementById("ex601Val");
    MathJax.typeset([element]);

    // Calculate and display bias
    var bias = b2Vec[slider03.getValue()] * rhoVec[slider04.getValue()] * 10/10;
    document.getElementById("equBias").innerHTML = "$$\\begin{align}\\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} \\beta_{1} + \\beta_{2} \\rho_{X_{1}X_{2}} \\frac{\\sigma_{X_{2}}}{\\sigma_{X_{1}}} \\\\ \\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} " + b1Vec[slider02.getValue()] + " + " + bias + ",\\end{align}$$";
    var element = document.getElementById("equBias");
    MathJax.typeset([element]);      

})

slider02.on("slide", function() {

    var sliderValue01 = slider01.getValue() + 1;
    var sliderValue02 = slider02.getValue() + 1;
    var sliderValue03 = slider03.getValue() + 1;
    var sliderValue04 = slider04.getValue() + 1;

    document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

    document.getElementById("ex602Val").innerHTML = "\\(\\beta_{1} = " + bVec[slider02.getValue()] + "\\)";
    var element = document.getElementById("ex602Val");
    MathJax.typeset([element]);

    // Calculate and display bias
    var bias = b2Vec[slider03.getValue()] * rhoVec[slider04.getValue()] * 10/10;
    document.getElementById("equBias").innerHTML = "$$\\begin{align}\\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} \\beta_{1} + \\beta_{2} \\rho_{X_{1}X_{2}} \\frac{\\sigma_{X_{2}}}{\\sigma_{X_{1}}} \\\\ \\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} " + b1Vec[slider02.getValue()] + " + " + bias + ",\\end{align}$$";
    var element = document.getElementById("equBias");
    MathJax.typeset([element]);      

})

slider03.on("slide", function() {

    var sliderValue01 = slider01.getValue() + 1;
    var sliderValue02 = slider02.getValue() + 1;
    var sliderValue03 = slider03.getValue() + 1;
    var sliderValue04 = slider04.getValue() + 1;

    document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

    document.getElementById("ex603Val").innerHTML = "\\(\\beta_{2} = " + b2Vec[slider03.getValue()] + "\\)";
    var element = document.getElementById("ex603Val");
    MathJax.typeset([element]);

    // Calculate and display bias
    var bias = b2Vec[slider03.getValue()] * rhoVec[slider04.getValue()] * 10/10;
    document.getElementById("equBias").innerHTML = "$$\\begin{align}\\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} \\beta_{1} + \\beta_{2} \\rho_{X_{1}X_{2}} \\frac{\\sigma_{X_{2}}}{\\sigma_{X_{1}}} \\\\ \\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} " + b1Vec[slider02.getValue()] + " + " + bias + ",\\end{align}$$";
    var element = document.getElementById("equBias");
    MathJax.typeset([element]);  

})

slider04.on("slide", function() {

    var sliderValue01 = slider01.getValue() + 1;
    var sliderValue02 = slider02.getValue() + 1;
    var sliderValue03 = slider03.getValue() + 1;
    var sliderValue04 = slider04.getValue() + 1;

    document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
    document.getElementById("imageL1N4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

    document.getElementById("ex604Val").innerHTML = "\\(\\rho_{X_{1}X_{2}} = " + rhoVec[slider04.getValue()] + "\\)";
    var element = document.getElementById("ex604Val");
    MathJax.typeset([element]);    

    // Calculate and display bias
    var bias = b2Vec[slider03.getValue()] * rhoVec[slider04.getValue()] * 10/10;
    document.getElementById("equBias").innerHTML = "$$\\begin{align}\\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} \\beta_{1} + \\beta_{2} \\rho_{X_{1}X_{2}} \\frac{\\sigma_{X_{2}}}{\\sigma_{X_{1}}} \\\\ \\widehat{\\beta}_{1} &\\overset{p}{\\rightarrow} " + b1Vec[slider02.getValue()] + " + " + bias + ",\\end{align}$$";
    var element = document.getElementById("equBias");
    MathJax.typeset([element]);  

})

// set start page
document.getElementById("tabLinkL1N1Id").click();
