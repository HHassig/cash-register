import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items-index"
export default class extends Controller {
  connect() {
    // Get all categories and set listeners
    const categoriesHTML = document.querySelectorAll(".category");
    initializeCategories(categoriesHTML);

    // Iterate over each item and do all the math
    // itemIteration(items, cart, 0.0, cartItems);
    const items = document.querySelectorAll(".item-card");
    const cart = document.querySelector(".hover-popup-cart");
    let subTotal = 0.0;
    let cartItems = getOldItems(document.querySelectorAll(".cart-item"));

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

      // Add # of items to "cart"
      item.querySelector(".fa-cart-plus").addEventListener("click", function() {
        // Get item info from rails into JS
        let itemHash = {
          location: cart.querySelector(".cart-items"),
          name: item.querySelector("#item-name").innerText,
          id: parseInt(item.querySelector("#item-id").innerText),
          price: parseFloat((item.querySelector("#item-price").innerText).substring(1)),
          amount: amount
        }

        // Promo info
        let promoHash = {
              id: parseInt(item.querySelector("#promotion-id").innerText),
              newPrice: parseFloat(item.querySelector("#promotion-price").innerText),
              minimum: parseInt(item.querySelector("#promotion-minimum").innerText),
              kind: item.querySelector("#promotion-kind").innerText,
              itemID: itemHash["id"]};

        // Buy 1 Get 1 math
        if (promoHash["kind"] === "bogo") {
          itemHash["amount"] *= 2;
          itemHash["price"] /= 2;
        }

        // Add to cart on click
        if (itemHash["amount"] > 0) {
          //check for duplicate items
          cartItems = consolidateDuplicates(cartItems, itemHash, promoHash);

          itemHash["location"].innerText = "";
          subTotal = 0.0;
          cartItems.forEach((cartItem) => {
            let basketTotal = cartItem["quantity"] * cartItem["price"];
            // Check for Promos!
            if (parseInt(cartItem["id"]) === promoHash["itemID"] && promoHash["minimum"] <= parseInt(cartItem["quantity"]) && promoHash["kind"] == "bulk") {
              cartItem["price"] = promoHash["newPrice"];
              basketTotal = cartItem["quantity"] * cartItem["price"];
            }

            itemHash["location"].insertAdjacentHTML("beforeend", `<div class="cart-item">
              <p id="cart-amount"><strong>${cartItem["quantity"]}</strong></p>
              <p id="cart-name">${cartItem["name"]}</p>
              <p id="cart-subtotal">€${(parseFloat(basketTotal).toFixed(2))}</p>
              </div>`);
            subTotal += (basketTotal);
            createBasket(cartItem, item, itemHash["price"], itemHash["amount"]);
            if (parseInt(cartItem["id"]) === promoHash["itemID"] && promoHash["kind"] === "bogo") {
              // Reset bogo additions
              // amount /= 2;
              itemHash["price"] *= 2;
            }
          });
          //Animate cart plus icon
          animate(item.querySelector(".fa-cart-plus"));
        }
        // push subtotal display
        printSubTotal(subTotal, "€");
      });
    });


    //
    // Functions
    //

    function initializeCategories(categoriesHTML) {
      //Set "all" font-size on load
      categoriesHTML[0].style["font-size"] = "1.5em";
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
    }

    function getOldItems(oldCart) {
      let cartItems = []
      oldCart.forEach((oldItem) => {
        cartItems.push({quantity: parseInt(oldItem.querySelector("#cart-amount").innerText),
                        id: parseInt(oldItem.querySelector("#cart-item-id").innerText),
                        name: oldItem.querySelector("#cart-name").innerText,
                        price: oldItem.querySelector("#cart-item-price").innerText,
                        promoID: parseInt(oldItem.querySelector("#cart-promo-id").innerText),
                        totalPrice: parseFloat((oldItem.querySelector("#cart-subtotal").innerText).substring(1))});
      });
      return cartItems;
    }

    function createBasket(cartItem, item, itemPrice, amount) {
      let itemID = parseInt(item.querySelector("#item-id").innerText);
      let cartItemID = cartItem["id"];
      if (itemID == cartItemID) {
        item.querySelector("#basket_item_id").value = item.querySelector("#item-id").innerText;
        item.querySelector("#basket_transaction_id").value = document.querySelector("#transaction-id").innerText;
        item.querySelector("#basket_quantity").value = amount;
        item.querySelector("#basket_promotion_id").value = cartItem["promoID"];
        item.querySelector("#basket_subtotal").value = cartItem["price"] * amount;
        item.querySelector("#basket_cost_per_item").value = itemPrice;
        item.querySelector(".basket-submit").click();
      }
    }

    function consolidateDuplicates(cartItems, itemHash, promoHash) {
      let unique = true;
      cartItems.forEach((cartItem) => {
        if (cartItem["id"] === itemHash["id"]) {
          unique = false;
        }
      });
      // Add quantity and update total price if item isn't unique
      if (!unique && cartItems.length > 0) {
        cartItems.forEach((cartItem) => {
          if (cartItem["id"] === itemHash["id"]) {
            cartItem["quantity"] += itemHash["amount"];
            cartItem["totalPrice"] = cartItem["quantity"] * cartItem["price"]
          }
        });
      } else {
        // Add everything about item if item is unique
        cartItems.push({quantity: itemHash["amount"],
                        id: itemHash["id"],
                        name: itemHash["name"],
                        price: itemHash["price"],
                        promoID: promoHash["id"],
                        totalPrice: itemHash["price"] * itemHash["quantity"]});
      }
      return cartItems;
    }
    function printSubTotal(subTotal, currencySign) {
      cart.querySelector(".subtotal").innerText = "";
      cart.querySelector(".subtotal").insertAdjacentHTML("beforeend", `<div class="subtotal-line">
      <h6>Total</h6>
      <h6><strong>${currencySign}${subTotal.toFixed(2)}</strong></h6>
      </div>`);
    }
    function displayCategory(category, items) {
      items.forEach((item) => {
        // hide cards that arent the same category as selected
        if (item.querySelector("#category-sorter").innerText !== category.innerText) {
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

    async function animate(html) {
      html.style.color = "teal";
      html.style.fontSize = "2em";
      await sleep(1500);
      html.style.color = "black";
      html.style.fontSize = "1.5em";
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

    function sleep(ms) {
      // console.log(`Sleeping for ${ms/1000} seconds...`);
      return new Promise(resolve => setTimeout(resolve, ms));
    }
  }
}
