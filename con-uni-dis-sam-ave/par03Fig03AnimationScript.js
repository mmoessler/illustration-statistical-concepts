
// loop over 3 slider and 2 figures
function sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03) {

  var sliderValue01 = loopSliderValue01 + 1;
  var sliderValue02 = loopSliderValue02 + 1;
  var sliderValue03 = loopSliderValue03 + 1;

  document.getElementById("imageL1N1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + ".svg");
  document.getElementById("imageL1N2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + ".svg");
  document.getElementById("imageL1N3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + ".svg");

  document.getElementById("sliderValue01Id").innerHTML = par01Str01 + par01Vec[slider01.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue01Id")]);

  document.getElementById("sliderValue02Id").innerHTML = par02Str01 + par02Vec[slider02.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue02Id")]);

  document.getElementById("sliderValue03Id").innerHTML = par03Str01 + par03Vec[slider03.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue03Id")]);

  document.getElementById("slider01Id").value = sliderValue01;
  document.getElementById("slider02Id").value = sliderValue02;
  document.getElementById("slider03Id").value = sliderValue03;

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

// animate silder 1 out of 3
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
  var loopSliderValue03 = slider03.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue01 = ind;
    slider01.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider01.setValue(ind);
        slider01.setValue(org);
        sliderLoop(org, loopSliderValue02, loopSliderValue03);
        clearInterval(innerInterval);
      }, 1000);
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 2 out of 3
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
  var loopSliderValue03 = slider03.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue02 = ind;
    slider02.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider02.setValue(ind);
        slider02.setValue(org);            
        sliderLoop(loopSliderValue01, org, loopSliderValue03);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 3 out of 3
animateButto03Click = function(org, start, stop) {   
  
  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider03Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider03Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider03Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();  
  var ind = start;
  var loopSliderValue01 = slider01.getValue();
  var loopSliderValue02 = slider02.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue03 = ind;
    slider03.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider03.setValue(ind);
        slider03.setValue(org);            
        sliderLoop(loopSliderValue01, loopSliderValue02, org);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}
