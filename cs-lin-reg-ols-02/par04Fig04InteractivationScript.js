
// display initial figures
document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + par01Ini + "_" + par02Ini + "_" + par03Ini + "_" + par04Ini + ".svg");
document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + par01Ini + "_" + par02Ini + "_" + par03Ini + "_" + par04Ini + ".svg");
document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + par01Ini + "_" + par02Ini + "_" + par03Ini + "_" + par04Ini + ".svg");
document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + par01Ini + "_" + par02Ini + "_" + par03Ini + "_" + par04Ini + ".svg");

// set initial value of slider 1
document.getElementById("sliderValue1Id").innerHTML = par01Str01 + par01Vec[par01Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue1Id")]);

// set initial value of slider 2
document.getElementById("sliderValue2Id").innerHTML = par02Str01 + par02Vec[par02Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue2Id")]);

// set initial value of slider 3
document.getElementById("sliderValue3Id").innerHTML = par03Str01 + par03Vec[par03Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue3Id")]);

// set initial value of slider 4
document.getElementById("sliderValue4Id").innerHTML = par04Str01 + par04Vec[par04Ini] + "\\)";
MathJax.typeset([document.getElementById("sliderValue4Id")]);

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

// initialize slider 3
var slider03 = new Slider("#slider3Id", { 
  tooltip: "never",
  formatter: function(value) {
    return par03Vec[value]
  } 
});

// initialize slider 4
var slider04 = new Slider("#slider4Id", { 
  tooltip: "never",
  formatter: function(value) {
    return par04Vec[value]
  } 
});

// slide behavior of slider 1
slider01.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;
  var sliderValue03 = slider03.getValue() + 1;
  var sliderValue04 = slider04.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

  document.getElementById("sliderValue1Id").innerHTML = par01Str01 + par01Vec[slider01.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue1Id")]);

})

// slide behavior of slider 2
slider02.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;
  var sliderValue03 = slider03.getValue() + 1;
  var sliderValue04 = slider04.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

  document.getElementById("sliderValue2Id").innerHTML = par02Str01 + par02Vec[slider02.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue2Id")]);

})

// slide behavior of slider 3
slider03.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;
  var sliderValue03 = slider03.getValue() + 1;
  var sliderValue04 = slider04.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

  document.getElementById("sliderValue3Id").innerHTML = par03Str01 + par03Vec[slider03.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue3Id")]);

})

// slide behavior of slider 4
slider04.on("slide", function() {

  var sliderValue01 = slider01.getValue() + 1;
  var sliderValue02 = slider02.getValue() + 1;
  var sliderValue03 = slider03.getValue() + 1;
  var sliderValue04 = slider04.getValue() + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

  document.getElementById("sliderValue4Id").innerHTML = par04Str01 + par04Vec[slider04.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue4Id")]);

})
