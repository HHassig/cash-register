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

<p align="center"><img src="https://i.imgur.com/5lQhjEs.png" alt="Logo" width="50%"></p>
<br />
This cash register was built using Ruby on Rails after a 9-week web development bootcamp as part of a job application.

#### Some features:
- A **guest** can create and pay a transaction but will be unable to see history
- A **user** can be an administrator or not
- A **user** can add select the amount of items desired and add to cart
- A **user** can hover and see their cart (items, price, subtotal), and see current promos on the items index page
- A **user** can navigate to "promotions" (all, active, expired), as well as transaction history and individual transactions
- A **user** can mark a transaction as "paid" in order to start a new transaction
- A **user's** cart is simply the last unpaid transaction of that user
- An **administrator** can create new promotions, edit promotion information, and toggle promotions between active/inactive
- An **administrator** can edit, unlist, and create an item for sale
- An **administrator** cannot destroy a promotion or item as it would not make sense to track transaction history and not have references to past inventory and promotions

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
6. Login info (no need for tight security for a demo):
  - Administrator
    - admin@test.com
    - 123456
  - User
    - user@test.com
    - 123456


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage
- Total bill is presented, complete with all applicable sales and promotions
- Users can
    - See when an item is added to their cart
    - See if a promotion has been applied
    - Remove items from cart
- A new transaction is initiated when the user marks their current transaction as "paid" (to be later implemented as a full-fledged payment funnel)
- An unpaid transaction is loaded on page reload (might be the current (unpaid) transaction)
- Flow:
  - A basket is a group of one item that the customer has decided to add to cart
  - Should the user add more of this item, it displays as one basket, but is multiple condensed baskets on the backend
    - This allows separation and more organization of line-items on the transaction and will help later when editing the cart
  - A transaction consists of at least one basket
    - The link between the two allows the transaction model to be created and added to as the user desires, until marked as "paid"
  - Item info and promotion info pop-up on hover and are also available in the individual view pages
  - A piggy bank <img src="https://i.imgur.com/TMcAVdr.png" width="20" height="20"> icon appears on an item card if there is an active promotion on said item, providing the user with relevant information
  - Select how many items are desired and click the <img src="https://i.imgur.com/0bIItu9.png" width="20" height="20"> icon
  - To check out:
    - Hover over the <img src="https://i.imgur.com/WXMK23M.png" width="20" height="20"> icon in the top right corner
    - Click the <img src="https://i.imgur.com/SqAbOLu.png" height="20"> icon to begin the checkout process
    - Your cart will exist in this state on the <a href="https://hassig-cash-register.fly.dev">root page</a> until this transaction is marked as "paid

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Showcase -->
## Showcase

### Show/Hide Categories
<center><img src="https://raw.githubusercontent.com/HHassig/gif-hosting-cash-register/master/categories.gif" width="80%"></center>

### Complete Checkout
<center><img src="https://raw.githubusercontent.com/HHassig/gif-hosting-cash-register/master/full.gif" width="80%"></center>

### Promotion New/Sort
<center><img src="https://raw.githubusercontent.com/HHassig/gif-hosting-cash-register/master/promotions.gif" width="80%"></center>

<!-- Limitations -->
## Limitations
- A user cannot remove items from their cart until going to the transaction#show page
  - This is a feature that would require more javascript coding and I ran out of time
  - To do this, I would need to create a javascript function that calls the rails function of basket#destroy and passes the correct parameters
  - This is a **POST** request
- There is no guest checkout
  - This is because al guests would be grouped together as owning every guest transaction, regardless of guestsID
  - This can be solved later with **cookies**
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
- Images should be hosted on a proper image service that links better to rails, such as cloudinary
    -It is easier to upload the photo file itself rather than a URL to the image
- A **user's** unpaid cart does not get recalculated if a **promotion** is added or activated during the transaction
- An **item** cannot be added to a cart on any page except items/index
  - It would make sense to add an item to cart from the items/show page (low-hanging fruit for later)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Learning -->
## Learning

* Address <a href="#limitations">limitations</a>
* Would love to optimize the function that condenses baskets
* Rails services keep the app clean and easily readable, very fun to experiment with and utilize
* Keep Javascript organized along the way
  * At timesitems_index_controller.js was a mess of variables and flow that is unreadable to others
  * Simpler code, better comments, consistent names (and less variables)
  * Refactoring for JavaScript is next on my learning list
    * Finding the equivalent of Rails service functions, for example
* Practice makes perfect
* This was my first introduction to TDD and first time seriously using rspec
* As a result, I started creating tests too late compared to best practices
  * Instead, my tests involved being a user in the UI checking my work
  * Next time I will start testing earlier, better, and more often, saving later headaches
  * I think I did a good job given the constraints and definitely want to utilize this practice going forward
  * **Measure twice, cut once!**
* RSpec **success**:
  * <img src="https://fittechtravel.com/cash-register/rspec.png" alt="Rspec" width="80%">


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
