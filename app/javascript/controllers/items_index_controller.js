import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items-index"
export default class extends Controller {
  connect() {
    const items = document.querySelectorAll(".item-card");
    const cart = document.querySelector(".hover-popup-cart");
    let subTotal = 0.0;
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

    // cartItems = [amount, itemID, itemName, itemPrice]
    let cartItems = [];
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
      // Add quantiy of items to "cart"
      item.querySelector(".fa-cart-plus").addEventListener("click", function() {
        // Get item info from rails into JS
        let itemsLocation = cart.querySelector(".cart-items")
        let itemName = item.querySelector("#item-name").innerText;
        let itemID = parseInt(item.querySelector("#item-id-hidden").innerText);
        let itemPrice = item.querySelector("#item-price").innerText;

        //remove euro sign (will need to work with other currencies in future?)
        let currencySign = itemPrice[0];
        itemPrice = parseFloat(itemPrice.substring(1));
        console.log(itemPrice);

        // Add to cart on click
        if (amount > 0) {
          //check for duplicate items
          cartItems = consolidateDuplicates(cartItems, amount, itemID, itemName, itemPrice);
          itemsLocation.innerText = "";
          subTotal = 0.0;
          cartItems.forEach((cartItem) => {
            itemsLocation.insertAdjacentHTML("beforeend", `<div class="cart-item">
              <p id="cart-amount"><strong>${cartItem["quantity"]}</strong></p>
              <p id="cart-name">${cartItem["name"]}</p>
              <p id="cart-price">${currencySign}${(cartItem["quantity"] * cartItem["price"]).toFixed(2)}</p>
              </div>`);
            subTotal += (cartItem["quantity"] * cartItem["price"]);
          });

          // Create basket item in DB
          item.querySelector("#basket_item_id").value = itemID;
          item.querySelector("#basket_transaction_id").value = document.querySelector("#transaction-id-hidden").innerText;
          item.querySelector("#basket_quantity").value = amount;
          console.log(item.querySelector("#basket_promotion_id"));
          item.querySelector("#basket_promotion_id").value = item.querySelector(".promotion-hidden").innerText;
          item.querySelector(".basket-submit").click();
        }
        // push subtotal display
        printSubTotal(subTotal, currencySign);
      });
    });


    // Add listener to credit card ("pay") icon
    let payIcon = document.querySelector(".fa-credit-card");
    payIcon.addEventListener("click", function() {
      // let transactionSubTotal = document.querySelector("#transaction_subtotal");
      // transactionSubTotal.value = "6.66";
      // let transactionItemID = document.querySelector("#transaction_item_id");
      // transactionItemID.value = "6";
      // document.querySelector(".transaction-submit").click();
    });

    function consolidateDuplicates(cartItems, amount, itemID, itemName, itemPrice) {
      let unique = true;
      cartItems.forEach((cartItem) => {
        if (cartItem["id"] === itemID) {
          unique = false;
        }
      });
      if (!unique && cartItems.length > 0) {
        cartItems.forEach((cartItem) => {
          if (cartItem["id"] === itemID) {
            cartItem["quantity"] += amount;
          }
        });
      }
      if (cartItems.length < 1 || unique) {
        cartItems.push({quantity: amount, id: itemID, name: itemName, price: itemPrice});
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
        if (item.querySelector("#category-hidden").innerText !== category.innerText) {
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
