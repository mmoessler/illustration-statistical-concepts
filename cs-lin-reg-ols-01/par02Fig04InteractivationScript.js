
// display initial figures
document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + par01Ini + "_" + par02Ini + ".svg");
document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + par01Ini + "_" + par02Ini + ".svg");
document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + par01Ini + "_" + par02Ini + ".svg");
document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + par01Ini + "_" + par02Ini + ".svg");

// set initial value of slider 1
document.getElementById("sliderValue1Id").innerHTML = par01Str01 + par01Vec[par01Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue1Id")]);

// set initial value of slider 2
document.getElementById("sliderValue2Id").innerHTML = par02Str01 + par02Vec[par02Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue2Id")]);

// initialize slider 1
var slider01 = new Slider("#slider1Id", { 
  tooltip: "never",
  formatter: function(value) {
    return par01Vec[value]
  } 
});

// initialize slider 2
var slider02 = new Slider("#slider2Id", { 
  tooltip: "never",
  formatter: function(value) {
    return par02Vec[value]
  } 
});

// slide behavior of slider 1
slider01.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + ".svg");

  document.getElementById("sliderValue1Id").innerHTML = par01Str01 + par01Vec[slider01.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue1Id")]);

})

// slide behavior of slider 2
slider02.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + ".svg");

  document.getElementById("sliderValue2Id").innerHTML = par02Str01 + par02Vec[slider02.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue2Id")]);

})
