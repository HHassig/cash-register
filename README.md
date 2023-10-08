<a name="readme-top"></a>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/hhassig/cash-register">
    <img src="https://i.imgur.com/E9z1Wne.jpg" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Hassig Cash Register</h3>

  <p align="center">
    A simple cash register app allowing users (and guests) to add items to a cart and calculate their subtotal
    <br />
    <a href="https://hassig-cash-register.fly.dev" target="_blank">View Demo</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#Showcase">Showcase</a></li>
    <li><a href="#limitations">Limitations</a></li>
    <li><a href="#learning">Learning</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<center><img src="https://i.imgur.com/5lQhjEs.png" alt="Logo" width="50%"></center>
<br />
This cash register was built using Ruby on Rails after a 9-week web development bootcamp as part of a job application

#### Some features:
- A **guest** can create and pay a transaction but will be unable to see history
- A **user** can be an administrartor or not
- A **user** can add select the amount of items desired and add to cart
- A **user** can hover and see their cart (items, price, subtotal), and see current promos on the items index page
- A **user** can navigate to "promotions" (all, active, expired), as well as transaction history and individual transactions
- A **user** can mark a transaction as "paid" in order to start a new transaction
- A **user's** cart is simply the last unpaid transaction of that user
- An **administrator** can create new promotions, edit promotion information, and toggle promotions between active/inactive
- An **administrator** can edit, unlist, and create an item for sale


<!-- Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `github_username`, `repo_name`, `twitter_handle`, `linkedin_username`, `email_client`, `email`, `project_title`, `project_description` -->
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

<a href="https://getbootstrap.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/bootstrap/bootstrap-plain-wordmark.svg" alt="bootstrap" width="40" height="40"/> </a>
<a href="https://www.w3schools.com/css/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/css3/css3-original-wordmark.svg" alt="css3" width="40" height="40"/> </a>
<a href="https://www.w3.org/html/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/html5/html5-original-wordmark.svg" alt="html5" width="40" height="40"/> </a>
<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg" alt="javascript" width="40" height="40"/> </a>
<a href="https://www.postgresql.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original-wordmark.svg" alt="postgresql" width="40" height="40"/> </a>
<a href="https://rubyonrails.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a>
<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a>
<a href="https://fly.io" target="_blank" rel="noreferrer"> <img src="https://fly.io/static/images/brand/logo-portrait-dark.svg" alt="ruby" width="40" height="40"/> </a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

* Ruby on Rails
  ```sh
  brew install rbenv
  rbenv install 3.1.2
  rbenv global 3.1.2
  ```

* PostgreSQL

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/HHassig/cash-register.git
   ```
2. Install Ruby gems
   ```sh
   bundle install
   ```
3. Manage database
   ```sh
   bin/rails db:drop
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```
4. Start the server
   ```sh
   bin/rails s
   ```
5. Open <a href="http://localhost:3000" target="_blank">localhost:3000</a> in your browser
6. Login info:
  - admin@test.com
  - 123456

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage
- Total bill is presented, complete with all applicable sales and promotions
- Users can see when an item is added to their cart, are able to see if a promotion has been applied, and save their transactions
- A new transaction is initiated when the user marks their current transaction as "paid" (to be later implemented as a full-fledged payment funnel)
- An unpaid transaction is loaded on page reload
- Flow:
  - A basket is a group of one item that the customer has decided to add to cart
  - Should the user add more of this item, it displays as one basket, but is multiple condensed baskets on the backend
    - This allows separation and more organization of line-items on the transaction and will help later when editing the cart
  - A transaction consists of at least one basket
    - The link between the two allows the transaction model to be created and added to as the user desires, until marked as "paid"
  - Item info and promotion info pop-up on hover and are also available in the individual view pages
  - A piggy bank icon appears on an item card if there is an active promotion on said item, providing the user with relevant information
  - Select how many items are desired and click the <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/f0c25837a3fe0e03783b939559e088abcbfb3c4b/svgs/solid/cart-plus.svg" width="20" height="20" color="purple"> icon
  - To check out:
    - Hover over the <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/f0c25837a3fe0e03783b939559e088abcbfb3c4b/svgs/solid/cart-shopping.svg" width="20" height="20" color="purple"> icon in the top right corner
    - Click the <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/f0c25837a3fe0e03783b939559e088abcbfb3c4b/svgs/solid/credit-card.svg" width="20" height="20" color="purple"> icon to begin the checkout process
    - Your cart will exist in this state on the root page until this transaction is marked as "paid

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Showcase -->
## Showcase

### Show/Hide Categories
<center><img src="https://fittechtravel.com/cash-register/categories.gif" width="80%"></center>

### Complete Checkout
<center><img src="https://fittechtravel.com/cash-register/full.gif" width="80%"></center>

### Promotion New/Sort
<center><img src="https://fittechtravel.com/cash-register/promotions.gif" width="80%"></center>

<!-- Limitations -->
## Limitations
- A **user** cannot edit or remove items from cart
- A nefarious actor might be able to play with prices when adding to basket
  - This could be solved by adding a validation method to prices, not within the time-frame of this project
- Item inventory is not updated when a purchase is marked as paid
  - There is also no "temporary" inventory for items in carts but not paid for
- SKU could be more robust to scale past ~20 items
  - SKU.item_id, for example?
  - However, items inherently have an id from the database, so this might be redundant
- For simplicity, a users cart is an unpaid/unfinished transaction
- An **item** on "buy 1 get 1" promo is doubled on cart-add while price is kept the same
  - If a **user** knows of the promo and desired amount, **user** has to submit half the amount, which is an easy error to make and not **user** friendly
  - Since a **user** cannot edit the cart, this is an issue
- As the inventory grows, the ability to search for an both items and promotions will be necessary

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Learning -->
## Learning

* Address <a href="#limitations">limitations</a>
* Keep Javascript and Rails better organized along the way
  * At timesitems_index_controller.js was a mess of variables and flow that is unreadable to others
  * Simpler code, better comments, consistent names (and less variables)
* Practice makes perfect

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
