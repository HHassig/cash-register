import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="promotions-index"
export default class extends Controller {
  connect() {
    const promotions = document.querySelectorAll(".item-card");
    const categoriesHTML = document.querySelectorAll("#category");
    //set "all" font-size on load
    categoriesHTML[0].style["font-size"] = "1.5em";
    //array of all menu options
    let categories = [];
    categoriesHTML.forEach((category) => {
      categories.push(category.innerText);
    });
    displayCategory(categoriesHTML[0], promotions);
    categoriesHTML.forEach((category) => {
      category.addEventListener("click", function() {
        displayAll(promotions);
        resetCategories(categoriesHTML);
        category.style["background-color"] = "white";
        category.style["border-radius"] = "1em";
        category.style["padding"] = "0.5em";
        category.style["font-weight"] = "bold";
        category.style["font-size"] = "1.5em";
        displayCategory(category, promotions);
      });
    });

    function displayAll(promotions) {
      promotions.forEach((promotion) => {
        promotion.style.display = "block";
      });
    }

    function resetCategories(categoriesHTML) {
      categoriesHTML.forEach((category) => {
        category.style["background-color"] = "white";
        category.style["border-radius"] = "1em";
        category.style["padding"] = "0.5em";
        category.style["font-weight"] = "normal";
        category.style["font-size"] = "1em";
      });
    }

    function displayCategory(category, promotions) {
      promotions.forEach((promotion) => {
        // hide cards that arent the same category as selected
        if (promotion.querySelector("#category-hidden").innerText !== category.innerText) {
          promotion.style.display = "none";
        }
        if (category.innerText == "All") {
          displayAll(promotions);
        }
      });
    }
  }
}