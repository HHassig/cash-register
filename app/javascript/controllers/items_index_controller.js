import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items-index"
export default class extends Controller {
  connect() {
    const items = document.querySelectorAll(".item-card");
    let categories = [];
    let categoriesHTML = document.querySelectorAll("#category");
    categoriesHTML.forEach((category) => {
      categories.push(category.innerText);
    });
    categoriesHTML.forEach((category) => {
      category.addEventListener("click", function() {
        displayAll(items);
        displayCategory(category, items);
      });
    });
    function displayCategory(category, items) {
      items.forEach((item) => {
        // hide cards that arent the same category as selected
        if (item.querySelector(".category-hidden").innerText !== category.innerText) {
          console.log(item);
          item.style.display = "none";
        }
        if (category.innerText == "All") {
          displayAll(items);
        }
      });
    }
    function displayAll(items) {
      items.forEach((item) => {
        item.style.display = "block";
      });
    }
  }
}
