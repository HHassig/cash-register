import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items-index"
export default class extends Controller {
  connect() {
    const items = document.querySelectorAll(".item-card");
    let categories = [];
    let categoriesHTML = document.querySelectorAll("#category");
    //set "all" font-size on load
    categoriesHTML[0].style["font-size"] = "1.5em";
    categoriesHTML.forEach((category) => {
      categories.push(category.innerText);
    });
    categoriesHTML.forEach((category) => {
      category.addEventListener("click", function() {
        displayAll(items);
        resetCategories(categoriesHTML);
        category.style["background-color"] = "white";
        category.style["border-radius"] = "1em";
        category.style["padding"] = "0.5em";
        category.style["font-weight"] = "bold";
        category.style["font-size"] = "1.5em";
        displayCategory(category, items);
      });
    });

    // Change value in text field in accordance with "+" or "-"
    items.forEach((item) => {
      let amount = parseInt(item.querySelector(".amount-js").value);
      let plus = item.querySelector(".fa-circle-plus");
      let minus = item.querySelector(".fa-circle-minus");
      plus.addEventListener("click", function() {
        amount += 1;
        item.querySelector(".amount-js").value = amount;
      });
      minus.addEventListener("click", function() {
        amount -= 1;
        if (amount < 0) {
          amount = 0;
        }
        item.querySelector(".amount-js").value = amount;
      });
    });

    function displayCategory(category, items) {
      items.forEach((item) => {
        // hide cards that arent the same category as selected
        if (item.querySelector(".category-hidden").innerText !== category.innerText) {
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
    function resetCategories(categoriesHTML) {
      categoriesHTML.forEach((category) => {
        category.style["background-color"] = "white";
        category.style["border-radius"] = "1em";
        category.style["padding"] = "0.5em";
        category.style["font-weight"] = "normal";
        category.style["font-size"] = "1em";
      });
    }
  }
}
