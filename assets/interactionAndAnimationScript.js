
//..................................................

// collect all tab content ids
let tabContentAll = document.getElementsByClassName('tabContentL1Cl');
let tabContentIds = [];
for (let i = 0; i < tabContentAll.length; i++) {
  tabContentIds.push(tabContentAll[i].id);
}

// collect all figure ids
let figureAll = document.getElementsByClassName('figureCl');
let figureIds = [];
for (let i = 0; i < figureAll.length; i++) {
  figureIds.push(figureAll[i].id);
}

// collect slider ids
let sliderAll = document.getElementsByClassName('sliderCl');
let sliderIds = [];
for (let i = 0; i < sliderAll.length; i++) {
  sliderIds.push(sliderAll[i].id);
}

// collect slider value ids
let sliderValueAll = document.getElementsByClassName('sliderValueCl');
let sliderValueIds = [];
for (let i = 0; i < sliderValueAll.length; i++) {
  sliderValueIds.push(sliderValueAll[i].id);
}

//..................................................

// initialize sliders for all sliders
for (var i = 0; i < sliderIds.length; i++) {
  eval(
    'var slider' + (i + 1) + ' = new Slider("#slider' + (i + 1) + 'Id", { \n tooltip: "never", \n formatter: function(value) { \n return sliders.value.slider' + (i + 1) + '[value] \n } \n })'
  );
}

// set slide events for all sliders
for (var i = 0; i < sliderIds.length; i++) {
  eval(
    'slider' + (i + 1) + '.on("slide", function() { updateFiguresAndSliderValues() })'
    );
}

// set initial slider values
for (var i = 0; i < sliderIds.length; i++) {
  eval(
    'slider' + (i + 1) + '.setValue(sliders.initialIndex[' + i + '])'
  );
}

//..................................................

updateFiguresAndSliderValues = function() {
  
  let figurePathTmp = null;
  let sliderTmp = null;
  let sliderValue1Tmp = null;
  
  // loop over figures
  for (var i = 0; i < figureIds.length; i++) {
    figurePathTmp = './figures/figure_0' + (i + 1);
    // loop over sliders
    for (var j = 0; j < sliderIds.length; j++) {
      sliderTmp = 'slider' + (j + 1);
      sliderValue1Tmp = eval('slider' + (j + 1) + '.getValue()');
      figurePathTmp = figurePathTmp.concat('_' + (sliderValue1Tmp + 1));
      // set the slider value
      document.getElementById(sliderValueIds[j]).innerHTML = sliders.sliderValueParStr[j] + sliders.value[sliderTmp][sliderValue1Tmp] + "\\)";
      MathJax.typeset([document.getElementById(sliderValueIds[j])]);
    }
    document.getElementById(figureIds[i]).setAttribute("src", figurePathTmp.concat('.svg'));

    console.log(figurePathTmp);

  }
}

updateFiguresAndSliderValues();

//..................................................

// explain figure
explainButtonClick = function() {
  
  let tabEqual = false;
  let tab = 0;
  while (tabEqual==false) {
    tabEqual = activeTabId == tabContentIds[tab];
    tab++;
  }
  
  let audioShowTextIdTmp = 'audioShowTextFigure' + tab + 'Id'; // construct show text id
  let audioTextIdTmp = 'audioTextFigure' + tab + 'OverallId'; // construct audio text id
  
  var audioTextDiv = document.getElementById(audioTextIdTmp); // get show text
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");
  var audioShowPar = document.getElementById(audioShowTextIdTmp); // get audio text
  
  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";
  
  var stopLoop = false;
  var index = 0;
  
  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var spanText = span.textContent;
      var speech = new SpeechSynthesisUtterance(spanText);
      speechSynthesis.speak(speech);
      speech.onend = function() {
        setTimeout(function() {
          index++;
          readSpans();
        }, 1000);
      };                
      // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        eval('slider' + slider + '.setValue(slider' + slider + '.options.value)');
        updateFiguresAndSliderValues();
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  
  // start reading out the spans
  readSpans();
    
}

// animate slider
animateButtonClick = function(slider) {
  
  let tabEqual = false;
  let tab = 0;
  while (tabEqual==false) {
    tabEqual = activeTabId == tabContentIds[tab];
    tab++;
  }
    
  let audioShowTextIdTmp = 'audioShowTextFigure' + tab + 'Id'; // construct show text id
  let audioTextIdTmp = 'audioTextFigure' + tab + 'Slider' + slider + 'Id'; // construct audio text id
    
  var audioTextDiv = document.getElementById(audioTextIdTmp); // get show text
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");
  var audioShowPar = document.getElementById(audioShowTextIdTmp); // get audio text
  
  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";
  
  var stopLoop = false;
  var index = 0;
  
  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var spanText = span.textContent;
      var speech = new SpeechSynthesisUtterance(spanText);
      speechSynthesis.speak(speech);
      speech.onend = function() {
        setTimeout(function() {
          index++;
          readSpans();
        }, 1000);
      };                
      // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        eval('slider' + slider + '.setValue(slider' + slider + '.options.value)');
        updateFiguresAndSliderValues();
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  
  // start reading out the spans
  readSpans();
  
  // iteration over sliders (sider specific)
  var direction = 1; // 1 for increment, -1 for decrement
  var minValue = eval('slider' + slider + '.options.min');
  var maxValue = eval('slider' + slider + '.options.max');
  
  var loopInterval = setInterval(function() {
    // Get the current value of the slider
    var value = eval('slider' + slider + '.getValue()');
    
    // Check if the event to stop the loop has been triggered
    if (stopLoop) {
      eval('slider' + slider + '.setValue(slider' + slider + '.options.value)');
      updateFiguresAndSliderValues();
      clearInterval(loopInterval);      
    } else {
      // Check if the slider value reaches the minimum or maximum
      if (value === maxValue || value === minValue) {
        // Change the direction to move the slider back and forth
        direction *= -1;
      }
      // Increment or decrement the slider value based on the direction
      eval('slider' + slider + '.setValue(value + direction)');
      
      //sliderLoop(slider0.sliderValueParStrgetValue(), slider1.getValue());
      updateFiguresAndSliderValues();
      
    }
    
  }, 1000); // Adjust the interval as needed (e.g., 100ms for a fast loop)
  
}
