
// loop over 4 slider and 4 figures
function sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04) {

  var sliderValue01 = loopSliderValue01 + 1;
  var sliderValue02 = loopSliderValue02 + 1;
  var sliderValue03 = loopSliderValue03 + 1;
  var sliderValue04 = loopSliderValue04 + 1;

  document.getElementById("image1Id").setAttribute("src", "./figures/figure_01_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image2Id").setAttribute("src", "./figures/figure_02_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image3Id").setAttribute("src", "./figures/figure_03_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");
  document.getElementById("image4Id").setAttribute("src", "./figures/figure_04_" + sliderValue01 + "_" + sliderValue02 + "_" + sliderValue03 + "_" + sliderValue04 + ".svg");

  document.getElementById("sliderValue1Id").innerHTML = par01Str01 + par01Vec[slider01.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue1Id")]);

  document.getElementById("sliderValue2Id").innerHTML = par02Str01 + par02Vec[slider02.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue2Id")]);

  document.getElementById("sliderValue3Id").innerHTML = par03Str01 + par03Vec[slider03.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue3Id")]);

  document.getElementById("sliderValue4Id").innerHTML = par04Str01 + par04Vec[slider04.getValue()] + "\\)";
  MathJax.typeset([document.getElementById("sliderValue4Id")]);

  document.getElementById("slider1Id").value = sliderValue01;
  document.getElementById("slider2Id").value = sliderValue02;
  document.getElementById("slider3Id").value = sliderValue03;
  document.getElementById("slider4Id").value = sliderValue04;

};

// explanation button
explainButton01Click = function() {

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01OverallId");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02OverallId");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03OverallId");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audio = document.getElementById("audioFigure04OverallId");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  
}

// animate silder 1 out of 4
animateButton01Click = function(org, start, stop) {

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider1Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider1Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider1Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audio = document.getElementById("audioFigure04Slider1Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue02 = slider02.getValue();
  var loopSliderValue03 = slider03.getValue();
  var loopSliderValue04 = slider04.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue01 = ind;
    slider01.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider01.setValue(ind);
        slider01.setValue(org);
        sliderLoop(org, loopSliderValue02, loopSliderValue03, loopSliderValue04);
        clearInterval(innerInterval);
      }, 1000);
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 2 out of 4
animateButton02Click = function(org, start, stop) {    

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider2Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider2Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider2Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audio = document.getElementById("audioFigure04Slider2Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue01 = slider01.getValue();
  var loopSliderValue03 = slider03.getValue();
  var loopSliderValue04 = slider04.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue02 = ind;
    slider02.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider02.setValue(ind);
        slider02.setValue(org);            
        sliderLoop(loopSliderValue01, org, loopSliderValue03, loopSliderValue04);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 3 out of 4
animateButton03Click = function(org, start, stop) {    

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider2Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider2Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider2Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audio = document.getElementById("audioFigure04Slider2Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue01 = slider01.getValue();
  var loopSliderValue02 = slider02.getValue();
  var loopSliderValue04 = slider04.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue03 = ind;
    slider03.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider03.setValue(ind);
        slider03.setValue(org);            
        sliderLoop(loopSliderValue01, loopSliderValue02, org, loopSliderValue04);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}

// animate silder 4 out of 4
animateButton04Click = function(org, start, stop) {    

  if (activeTabId == "tabContentL1N1Id") {
    var audio = document.getElementById("audioFigure01Slider2Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audio = document.getElementById("audioFigure02Slider2Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audio = document.getElementById("audioFigure03Slider2Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audio = document.getElementById("audioFigure04Slider2Id");
  } else {
    var audio = document.getElementById("audioErrorId");
  }
  audio.play();
  var ind = start;
  var loopSliderValue01 = slider01.getValue();
  var loopSliderValue02 = slider02.getValue();
  var loopSliderValue03 = slider03.getValue();
  var outerInterval = setInterval(function() {
    var loopSliderValue04 = ind;
    slider04.setValue(ind);
    sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
    ind++;
    if (ind > stop) {
      var innerInterval = setInterval(function() {
        slider04.setValue(ind);
        slider04.setValue(org);            
        sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, org);
        clearInterval(innerInterval);
      }, 1000);        
      clearInterval(outerInterval);
    }
  }, 1000);
}
