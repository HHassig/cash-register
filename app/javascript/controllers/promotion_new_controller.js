import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="promotion-new"
export default class extends Controller {
  connect() {
    const bogo = document.querySelector("#promotion_kind_bogo");
    const bulk = document.querySelector("#promotion_kind_bulk");
    const minQuantity = document.querySelector(".promotion_min_quantity");
    const promoPrice = document.querySelector(".promotion_promo_price");
    bulk.addEventListener("click", function() {
      minQuantity.style.display = "block";
      promoPrice.style.display = "block";
    });
    bogo.addEventListener("click", function() {
      minQuantity.style.display = "none";
      promoPrice.style.display = "none";
    });
  }
}
