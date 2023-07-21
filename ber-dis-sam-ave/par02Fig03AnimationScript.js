
// loop over 2 slider and 2 figures
function sliderLoop(loopSliderValue01, loopSliderValue02) {

  var sliderValue01 = loopSliderValue01 + 1;
  var sliderValue02 = loopSliderValue02 + 1;

  document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + ".svg");
  document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + ".svg");

  document.getElementById("sliderValue01Id").innerHTML = par01Str01 + par01Vec[slider01.getValue()] + "\\)";
  MathJax.typeset([element = document.getElementById("sliderValue01Id")]);

  document.getElementById("sliderValue02Id").innerHTML = par02Str01 + par02Vec[slider02.getValue()] + "\\)";
  MathJax.typeset([element = document.getElementById("sliderValue02Id")]);

  document.getElementById("slider01Id").value = sliderValue01;
  document.getElementById("slider02Id").value = sliderValue02;

};

// explanation button
explainButto01Click = function() {

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01OverallId");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02OverallId");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03OverallId");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  
}

// animate silder 1 out of 2
animateButto01Click = function(org, start, stop) {

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider01Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider01Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue02 = slider02.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue01 = ind;
    slider01.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider01.setValue(ind);
        slider01.setValue(org);
        sliderLoop(org, loopSliderValue02);
        clearInterval(innerInterval);
      }, 1000);
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 2 out of 2
animateButto02Click = function(org, start, stop) {

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider02Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider02Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue01 = slider01.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue02 = ind;
    slider02.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider02.setValue(ind);
        slider02.setValue(org);            
        sliderLoop(loopSliderValue01, org);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}
