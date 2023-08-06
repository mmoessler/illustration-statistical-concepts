
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

var activeTabId; // define as global variable
activeTabId = "tabLinkL1N1Id";

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
  // store the ID of the currently active tab
  activeTabId = tabContentId;

  // add the specific color to the button used to open the tab content
  document.getElementById(tabLinkId).style.backgroundColor = color;

}

// set start page
document.getElementById("tabLinkL1N1Id").click();
// initialize figure and slider
updateFiguresAndSliderValues();
