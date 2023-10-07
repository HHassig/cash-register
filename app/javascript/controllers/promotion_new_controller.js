import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="promotion-new"
export default class extends Controller {
  connect() {
    // Toggles view of uncessary fields for certain promotion kinds
    const bogo = document.querySelector("#promotion_kind_bogo");
    const bulk = document.querySelector("#promotion_kind_bulk");

    const minQuantity = document.querySelector(".promotion_min_quantity");
    const promoPrice = document.querySelector(".promotion_promo_price");
    const discount = document.querySelector(".promotion_discount");

    // If bulk is checked on edit as default
    if (bulk.checked) {
      minQuantity.style.display = "block";
      promoPrice.style.display = "block";
      discount.style.display = "block";
    }
    bulk.addEventListener("click", function() {
      minQuantity.style.display = "block";
      promoPrice.style.display = "block";
      discount.style.display = "block";
    });
    bogo.addEventListener("click", function() {
      minQuantity.style.display = "none";
      promoPrice.style.display = "none";
      discount.style.display = "none";
    });
  }
}
