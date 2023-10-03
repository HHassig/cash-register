import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items-show"
export default class extends Controller {
  connect() {
    // Change value in text field in accordance with "+" or "-"
    const item = document.querySelector(".item-show-card");
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
  }
}
