
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
    var audioTextDiv = document.getElementById("audioTextFigure01OverallId");
    var audioShowPar = document.getElementById("audioShowTextFigure01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audioTextDiv = document.getElementById("audioTextFigure02OverallId");
    var audioShowPar = document.getElementById("audioShowTextFigure02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audioTextDiv = document.getElementById("audioTextFigure03OverallId");
    var audioShowPar = document.getElementById("audioShowTextFigure03Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audioTextDiv = document.getElementById("audioTextFigure04OverallId");
    var audioShowPar = document.getElementById("audioShowTextFigure04Id");
  } else {
    var audioTextDiv = document.getElementById("audioTextNoText");
  }
  
  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";

  var silentSpan = "audioTextSilentCl"; 
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");

  var index = 0;

  // function to read out each <span> with a delay in between
  function readSpans() {

    if (index < audioTextSpa.length) {

      var span = audioTextSpa[index];
      var speech = new SpeechSynthesisUtterance("whatever");

      if (!span.classList.contains(silentSpan)) {

        var spanText = span.textContent;
        var speech = new SpeechSynthesisUtterance(spanText);
        speechSynthesis.speak(speech);

        speech.onend = function() {
          setTimeout(function() {
            index++;
            readSpans();
          }, 1000);
        };
        
      } else {
        index++;
        readSpans();
      }
    } else {      
      audioShowPar.style.display = "none";
    }
  }

  // start reading out the spans
  readSpans();
  
}

// // animate slider 1 out of 4
// animateButton01Click = function(org, start, stop) {

//   if (activeTabId == "tabContentL1N1Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure01Slider1Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure01Id");
//   } else if (activeTabId == "tabContentL1N2Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure02Slider1Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure02Id");
//   } else if (activeTabId == "tabContentL1N3Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure03Slider1Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure03Id");
//   } else if (activeTabId == "tabContentL1N4Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure04Slider1Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure04Id");
//   } else {
//     var audioTextDiv = document.getElementById("audioTextNoText");
//   }

//   audioShowPar.innerHTML = audioTextDiv.innerHTML;
//   audioShowPar.style.display = "block";

//   var silentSpan = "audioTextSilentCl"; 
//   var audioTextSpa = audioTextDiv.getElementsByTagName("span");

//   var index = 0;

//   // function to read out each <span> with a delay in between
//   function readSpans() {

//     if (index < audioTextSpa.length) {

//       var span = audioTextSpa[index];
//       var speech = new SpeechSynthesisUtterance("whatever");

//       if (!span.classList.contains(silentSpan)) {

//         var spanText = span.textContent;
//         var speech = new SpeechSynthesisUtterance(spanText);
//         speechSynthesis.speak(speech);

//         speech.onend = function() {
//           setTimeout(function() {
//             index++;
//             readSpans();
//           }, 1000);
//         };
        
//       } else {
//         index++;
//         readSpans();
//       }
//     } else {      
//       audioShowPar.style.display = "none";
//     }
//   }

//   // start reading out the spans
//   readSpans();
  
//   // iteration over sliders
//   var ind = start;
//   var loopSliderValue02 = slider02.getValue();
//   var loopSliderValue03 = slider03.getValue();
//   var loopSliderValue04 = slider04.getValue();
//   var outerInterval = setInterval(function() {
//     var loopSliderValue01 = ind;
//     slider01.setValue(ind);
//     sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
//     ind++;    
//     if (ind > stop) {
//       var innerInterval = setInterval(function() {
//         slider01.setValue(ind);
//         slider01.setValue(org);
//         sliderLoop(org, loopSliderValue02, loopSliderValue03, loopSliderValue04);
//         clearInterval(innerInterval);
//       }, 1000);
//       clearInterval(outerInterval);      
//     }    
//   }, 1000);
// }

// // animate slider 2 out of 4
// animateButton02Click = function(org, start, stop) {   

//   if (activeTabId == "tabContentL1N1Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure01Slider2Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure01Id");
//   } else if (activeTabId == "tabContentL1N2Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure02Slider2Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure02Id");
//   } else if (activeTabId == "tabContentL1N3Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure03Slider2Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure03Id");
//   } else if (activeTabId == "tabContentL1N4Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure04Slider2Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure04Id");
//   } else {
//     var audioTextDiv = document.getElementById("audioTextNoText");
//   }

//   audioShowPar.innerHTML = audioTextDiv.innerHTML;
//   audioShowPar.style.display = "block";

//   var silentSpan = "audioTextSilentCl"; 
//   var audioTextSpa = audioTextDiv.getElementsByTagName("span");

//   var index = 0;

//   // function to read out each <span> with a delay in between
//   function readSpans() {

//     if (index < audioTextSpa.length) {

//       var span = audioTextSpa[index];
//       var speech = new SpeechSynthesisUtterance("whatever");

//       if (!span.classList.contains(silentSpan)) {

//         var spanText = span.textContent;
//         var speech = new SpeechSynthesisUtterance(spanText);
//         speechSynthesis.speak(speech);

//         speech.onend = function() {
//           setTimeout(function() {
//             index++;
//             readSpans();
//           }, 1000);
//         };
        
//       } else {
//         index++;
//         readSpans();
//       }
//     } else {      
//       audioShowPar.style.display = "none";
//     }
//   }

//   // start reading out the spans
//   readSpans();
  
//   // iteration over sliders
//   var ind = start;
//   var loopSliderValue01 = slider01.getValue();
//   var loopSliderValue03 = slider03.getValue();
//   var loopSliderValue04 = slider04.getValue();
//   var outerInterval = setInterval(function() {
//     var loopSliderValue02 = ind;
//     slider02.setValue(ind);
//     sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
//     ind++;
//     if (ind > stop) {
//       var innerInterval = setInterval(function() {
//         slider02.setValue(ind);
//         slider02.setValue(org);            
//         sliderLoop(loopSliderValue01, org, loopSliderValue03, loopSliderValue04);
//         clearInterval(innerInterval);
//       }, 1000);        
//       clearInterval(outerInterval);
//     }
//   }, 1000);
// }

// // animate slider 3 out of 4
// animateButton03Click = function(org, start, stop) {   

//   if (activeTabId == "tabContentL1N1Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure01Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure01Id");
//   } else if (activeTabId == "tabContentL1N2Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure02Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure02Id");
//   } else if (activeTabId == "tabContentL1N3Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure03Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure03Id");
//   } else if (activeTabId == "tabContentL1N4Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure04Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure04Id");
//   } else {
//     var audioTextDiv = document.getElementById("audioTextNoText");
//   }

//   audioShowPar.innerHTML = audioTextDiv.innerHTML;
//   audioShowPar.style.display = "block";

//   var silentSpan = "audioTextSilentCl"; 
//   var audioTextSpa = audioTextDiv.getElementsByTagName("span");

//   var index = 0;

//   // function to read out each <span> with a delay in between
//   function readSpans() {

//     if (index < audioTextSpa.length) {

//       var span = audioTextSpa[index];
//       var speech = new SpeechSynthesisUtterance("whatever");

//       if (!span.classList.contains(silentSpan)) {

//         var spanText = span.textContent;
//         var speech = new SpeechSynthesisUtterance(spanText);
//         speechSynthesis.speak(speech);

//         speech.onend = function() {
//           setTimeout(function() {
//             index++;
//             readSpans();
//           }, 1000);
//         };
        
//       } else {
//         index++;
//         readSpans();
//       }
//     } else {      
//       audioShowPar.style.display = "none";
//     }
//   }

//   // start reading out the spans
//   readSpans();
  
//   // iteration over sliders
//   var ind = start;
//   var loopSliderValue01 = slider01.getValue();
//   var loopSliderValue02 = slider02.getValue();
//   var loopSliderValue04 = slider04.getValue();
//   var outerInterval = setInterval(function() {
//     var loopSliderValue03 = ind;
//     slider03.setValue(ind);
//     sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
//     ind++;
//     if (ind > stop) {
//       var innerInterval = setInterval(function() {
//         slider03.setValue(ind);
//         slider03.setValue(org);            
//         sliderLoop(loopSliderValue01, loopSliderValue02, org, loopSliderValue04);
//         clearInterval(innerInterval);
//       }, 1000);        
//       clearInterval(outerInterval);
//     }
//   }, 1000);
// }

// // animate slider 4 out of 4
// animateButton04Click = function(org, start, stop) { 

//   if (activeTabId == "tabContentL1N1Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure01Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure01Id");
//   } else if (activeTabId == "tabContentL1N2Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure02Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure02Id");
//   } else if (activeTabId == "tabContentL1N3Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure03Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure03Id");
//   } else if (activeTabId == "tabContentL1N4Id") {
//     var audioTextDiv = document.getElementById("audioTextFigure04Slider3Id");
//     var audioShowPar = document.getElementById("audioShowTextFigure04Id");
//   } else {
//     var audioTextDiv = document.getElementById("audioTextNoText");
//   }

//   audioShowPar.innerHTML = audioTextDiv.innerHTML;
//   audioShowPar.style.display = "block";

//   var silentSpan = "audioTextSilentCl"; 
//   var audioTextSpa = audioTextDiv.getElementsByTagName("span");

//   var index = 0;

//   // function to read out each <span> with a delay in between
//   function readSpans() {

//     if (index < audioTextSpa.length) {

//       var span = audioTextSpa[index];
//       var speech = new SpeechSynthesisUtterance("whatever");

//       if (!span.classList.contains(silentSpan)) {

//         var spanText = span.textContent;
//         var speech = new SpeechSynthesisUtterance(spanText);
//         speechSynthesis.speak(speech);

//         speech.onend = function() {
//           setTimeout(function() {
//             index++;
//             readSpans();
//           }, 1000);
//         };
        
//       } else {
//         index++;
//         readSpans();
//       }
//     } else {      
//       audioShowPar.style.display = "none";
//     }
//   }

//   // start reading out the spans
//   readSpans();
  
//   // iteration over sliders
//   var ind = start;
//   var loopSliderValue01 = slider01.getValue();
//   var loopSliderValue02 = slider02.getValue();
//   var loopSliderValue03 = slider03.getValue();
//   var outerInterval = setInterval(function() {
//     var loopSliderValue04 = ind;
//     slider04.setValue(ind);
//     sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, loopSliderValue04);
//     ind++;
//     if (ind > stop) {
//       var innerInterval = setInterval(function() {
//         slider04.setValue(ind);
//         slider04.setValue(org);            
//         sliderLoop(loopSliderValue01, loopSliderValue02, loopSliderValue03, org);
//         clearInterval(innerInterval);
//       }, 1000);        
//       clearInterval(outerInterval);
//     }
//   }, 1000);
// }



// animate slider 1 out of 4
animateButton01Click = function() {   

  if (activeTabId == "tabContentL1N1Id") {
    var audioTextDiv = document.getElementById("audioTextFigure01Slider1Id");
    var audioShowPar = document.getElementById("audioShowTextFigure01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audioTextDiv = document.getElementById("audioTextFigure02Slider1Id");
    var audioShowPar = document.getElementById("audioShowTextFigure02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audioTextDiv = document.getElementById("audioTextFigure03Slider1Id");
    var audioShowPar = document.getElementById("audioShowTextFigure03Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audioTextDiv = document.getElementById("audioTextFigure04Slider1Id");
    var audioShowPar = document.getElementById("audioShowTextFigure04Id");
  } else {
    var audioTextDiv = document.getElementById("audioTextNoText");
  }

  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";

  var silentSpan = "audioTextSilentCl"; 
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");

  var stopLoop = false;
  var index = 0;

  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var speech = new SpeechSynthesisUtterance("whatever");
      if (!span.classList.contains(silentSpan)) {
        var spanText = span.textContent;
        var speech = new SpeechSynthesisUtterance(spanText);
        speechSynthesis.speak(speech);
        speech.onend = function() {
          setTimeout(function() {
            index++;
            readSpans();
          }, 1000);
        };          
      } else {
        index++;
        readSpans();
      }
    // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        slider01.setValue(slider01.options.value);
        sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  // start reading out the spans
  readSpans();
  
  // iteration over sliders (sider specific)
  var direction = 1; // 1 for increment, -1 for decrement
  var minValue = slider01.options.min;
  var maxValue = slider01.options.max;

  var loopInterval = setInterval(function() {
    // Get the current value of the slider
    var value = slider01.getValue();  
    // Do something with the current value (you can replace this with your custom logic)

    //sliderLoop(slider01.getValue(), value);
    
    // Check if the event to stop the loop has been triggered
    if (stopLoop) {
      slider01.setValue(slider01.options.value);
      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
      clearInterval(loopInterval);      
    } else {
      // Check if the slider value reaches the minimum or maximum
      if (value === maxValue || value === minValue) {
          // Change the direction to move the slider back and forth
          direction *= -1;
      }
      // Increment or decrement the slider value based on the direction
      slider01.setValue(value + direction);

      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());

    }

  }, 1000); // Adjust the interval as needed (e.g., 100ms for a fast loop)

}

// animate slider 2 out of 4
animateButton02Click = function() {   

  if (activeTabId == "tabContentL1N1Id") {
    var audioTextDiv = document.getElementById("audioTextFigure01Slider2Id");
    var audioShowPar = document.getElementById("audioShowTextFigure01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audioTextDiv = document.getElementById("audioTextFigure02Slider2Id");
    var audioShowPar = document.getElementById("audioShowTextFigure02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audioTextDiv = document.getElementById("audioTextFigure03Slider2Id");
    var audioShowPar = document.getElementById("audioShowTextFigure03Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audioTextDiv = document.getElementById("audioTextFigure04Slider2Id");
    var audioShowPar = document.getElementById("audioShowTextFigure04Id");
  } else {
    var audioTextDiv = document.getElementById("audioTextNoText");
  }

  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";

  var silentSpan = "audioTextSilentCl"; 
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");

  var stopLoop = false;
  var index = 0;

  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var speech = new SpeechSynthesisUtterance("whatever");
      if (!span.classList.contains(silentSpan)) {
        var spanText = span.textContent;
        var speech = new SpeechSynthesisUtterance(spanText);
        speechSynthesis.speak(speech);
        speech.onend = function() {
          setTimeout(function() {
            index++;
            readSpans();
          }, 1000);
        };          
      } else {
        index++;
        readSpans();
      }
    // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        slider02.setValue(slider02.options.value);
        sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  // start reading out the spans
  readSpans();
  
  // iteration over sliders (sider specific)
  var direction = 1; // 1 for increment, -1 for decrement
  var minValue = slider02.options.min;
  var maxValue = slider02.options.max;

  var loopInterval = setInterval(function() {
    // Get the current value of the slider
    var value = slider02.getValue();  
    // Do something with the current value (you can replace this with your custom logic)

    //sliderLoop(slider01.getValue(), value);
    
    // Check if the event to stop the loop has been triggered
    if (stopLoop) {
      slider02.setValue(slider02.options.value);
      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
      clearInterval(loopInterval);      
    } else {
      // Check if the slider value reaches the minimum or maximum
      if (value === maxValue || value === minValue) {
          // Change the direction to move the slider back and forth
          direction *= -1;
      }
      // Increment or decrement the slider value based on the direction
      slider02.setValue(value + direction);

      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());

    }

  }, 1000); // Adjust the interval as needed (e.g., 100ms for a fast loop)

}

// animate slider 3 out of 4
animateButton03Click = function() {   

  if (activeTabId == "tabContentL1N1Id") {
    var audioTextDiv = document.getElementById("audioTextFigure01Slider3Id");
    var audioShowPar = document.getElementById("audioShowTextFigure01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audioTextDiv = document.getElementById("audioTextFigure02Slider3Id");
    var audioShowPar = document.getElementById("audioShowTextFigure02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audioTextDiv = document.getElementById("audioTextFigure03Slider3Id");
    var audioShowPar = document.getElementById("audioShowTextFigure03Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audioTextDiv = document.getElementById("audioTextFigure04Slider3Id");
    var audioShowPar = document.getElementById("audioShowTextFigure04Id");
  } else {
    var audioTextDiv = document.getElementById("audioTextNoText");
  }

  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";

  var silentSpan = "audioTextSilentCl"; 
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");

  var stopLoop = false;
  var index = 0;

  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var speech = new SpeechSynthesisUtterance("whatever");
      if (!span.classList.contains(silentSpan)) {
        var spanText = span.textContent;
        var speech = new SpeechSynthesisUtterance(spanText);
        speechSynthesis.speak(speech);
        speech.onend = function() {
          setTimeout(function() {
            index++;
            readSpans();
          }, 1000);
        };          
      } else {
        index++;
        readSpans();
      }
    // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        slider03.setValue(slider03.options.value);
        sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  // start reading out the spans
  readSpans();
  
  // iteration over sliders (sider specific)
  var direction = 1; // 1 for increment, -1 for decrement
  var minValue = slider03.options.min;
  var maxValue = slider03.options.max;

  var loopInterval = setInterval(function() {
    // Get the current value of the slider
    var value = slider03.getValue();  
    // Do something with the current value (you can replace this with your custom logic)

    //sliderLoop(slider01.getValue(), value);
    
    // Check if the event to stop the loop has been triggered
    if (stopLoop) {
      slider03.setValue(slider03.options.value);
      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
      clearInterval(loopInterval);      
    } else {
      // Check if the slider value reaches the minimum or maximum
      if (value === maxValue || value === minValue) {
          // Change the direction to move the slider back and forth
          direction *= -1;
      }
      // Increment or decrement the slider value based on the direction
      slider03.setValue(value + direction);

      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());

    }

  }, 1000); // Adjust the interval as needed (e.g., 100ms for a fast loop)

}

// animate slider 4 out of 4
animateButton04Click = function() {   

  if (activeTabId == "tabContentL1N1Id") {
    var audioTextDiv = document.getElementById("audioTextFigure01Slider4Id");
    var audioShowPar = document.getElementById("audioShowTextFigure01Id");
  } else if (activeTabId == "tabContentL1N2Id") {
    var audioTextDiv = document.getElementById("audioTextFigure02Slider4Id");
    var audioShowPar = document.getElementById("audioShowTextFigure02Id");
  } else if (activeTabId == "tabContentL1N3Id") {
    var audioTextDiv = document.getElementById("audioTextFigure03Slider4Id");
    var audioShowPar = document.getElementById("audioShowTextFigure03Id");
  } else if (activeTabId == "tabContentL1N4Id") {
    var audioTextDiv = document.getElementById("audioTextFigure04Slider4Id");
    var audioShowPar = document.getElementById("audioShowTextFigure04Id");
  } else {
    var audioTextDiv = document.getElementById("audioTextNoText");
  }

  audioShowPar.innerHTML = audioTextDiv.innerHTML;
  audioShowPar.style.display = "block";

  var silentSpan = "audioTextSilentCl"; 
  var audioTextSpa = audioTextDiv.getElementsByTagName("span");

  var stopLoop = false;
  var index = 0;

  // function to read out each <span> with a delay in between
  function readSpans() {      
    if (index < audioTextSpa.length) {
      var span = audioTextSpa[index];
      var speech = new SpeechSynthesisUtterance("whatever");
      if (!span.classList.contains(silentSpan)) {
        var spanText = span.textContent;
        var speech = new SpeechSynthesisUtterance(spanText);
        speechSynthesis.speak(speech);
        speech.onend = function() {
          setTimeout(function() {
            index++;
            readSpans();
          }, 1000);
        };          
      } else {
        index++;
        readSpans();
      }
    // finished with reading out spans
    } else {
      audioShowPar.style.display = "none";  
      var intervalLoop = setInterval(function() {
        stopLoop = true;      
        slider04.setValue(slider04.options.value);
        sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
        clearInterval(intervalLoop);      
      }, 1000);
    }
  }
  // start reading out the spans
  readSpans();
  
  // iteration over sliders (sider specific)
  var direction = 1; // 1 for increment, -1 for decrement
  var minValue = slider04.options.min;
  var maxValue = slider04.options.max;

  var loopInterval = setInterval(function() {
    // Get the current value of the slider
    var value = slider04.getValue();  
    // Do something with the current value (you can replace this with your custom logic)

    //sliderLoop(slider01.getValue(), value);
    
    // Check if the event to stop the loop has been triggered
    if (stopLoop) {
      slider04.setValue(slider04.options.value);
      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());
      clearInterval(loopInterval);      
    } else {
      // Check if the slider value reaches the minimum or maximum
      if (value === maxValue || value === minValue) {
          // Change the direction to move the slider back and forth
          direction *= -1;
      }
      // Increment or decrement the slider value based on the direction
      slider04.setValue(value + direction);

      sliderLoop(slider01.getValue(), slider02.getValue(), slider03.getValue(), slider04.getValue());

    }

  }, 1000); // Adjust the interval as needed (e.g., 100ms for a fast loop)

}