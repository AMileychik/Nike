# Nike

## Home module

Overview:

The HomeViewController in this app serves as the main entry screen for the Nike app, displaying various sections such as welcome messages, top picks, promotions, and more. This is achieved through a series of UITableView sections that dynamically load and display data retrieved from the network.

Sections:
    1.    Welcome Section:
    •    Displays a personalized greeting based on the time of day, such as “Good Morning”, “Good Afternoon”, etc.
    •    This section is generated dynamically from a date-based welcome message.
    
    2.    Because You Like Section:
    •    This section presents a list of products or categories tailored to the user’s preferences, such as top picks or favorite items.
    •    The data is provided via a Header and a list of Product models, and the section header can be customized.
    
    3.    Promo Section:
    •    A carousel displaying promotional products or offers.
    •    Tapping on any promo will navigate to detailed information about the promotion.
    
    4.    New From Nike Section:
    •    This section showcases newly released products or collections from Nike, also provided with a Header for categorization.
    •    Tapping on any item in this section navigates to a detailed view of the product.
    
    5.    Stories For You Section:
    •    Displays Nike-related content such as articles, videos, or stories that are curated for the user.
    •    Tapping on a story will lead to more detailed information.
    
    6.    Thank You Section:
    •    A final section that thanks the user for using the app or participating in a promotion, possibly showcasing a product or offer.

Key Components:
    •    ViewModel (HomeViewModel):
    •    Handles the logic for data fetching and state management.
    •    Supports various events like tapping on promotional items, refreshing data, etc.
    •    It updates the UI based on the current state (initial, loading, loaded, error).
    •    Table View (HomeTableView):
    •    A custom UITableView used to display the various sections dynamically.
    •    Each section is represented by a custom table view cell, such as WelcomeCell, PromoCarouselCell, etc.
    •    Navigation:
    •    Various sections can lead to detailed screens, such as product detail screens, promo detail screens, and more.
    •    Navigation is handled via the push method that adds new view controllers to the navigation stack.

Features:
    •    Dynamic Data Fetching:
    •    The app loads data asynchronously from a network service and displays it in the table view sections.
    •    Each section has its own model and header, allowing for dynamic configuration.
    •    Interactive Events:
    •    The app listens for user interactions (e.g., tapping on a product or promotion) and triggers events that navigate to other screens or update the UI.
    •    The HomeViewModel sends events to handle user actions, like tapping on a specific category or refreshing data.
    •    Refresh Control:
    •    The table view includes a refresh control that allows users to pull down to refresh the content.
    •    Activity Indicator:
    •    While data is loading, an activity indicator is displayed in the center of the screen.

ViewController Flow:
    •    HomeViewController:
    •    Acts as the main controller for the home screen.
    •    Initializes with a HomeViewModel and manages a HomeTableView for displaying sections.
    •    Observes changes in the HomeViewModel and updates the UI accordingly (e.g., stopping the activity indicator, refreshing the table).
    •    Handles navigation based on user interactions, using methods like toProductDetailSections, toPromoDetailSections, etc.
    •    HomeTableViewDataSource:
    •    Acts as the data source for the table view.
    •    Each section is dynamically generated based on the HomeSectionsResponse, which is passed from the HomeViewModel.
    •    Event Handling:
    •    Actions such as tapping on a promotion or refreshing data trigger specific events, which are handled by the HomeViewModel and lead to UI changes or navigation actions.

Setup Instructions:
    1.    Model Setup:
    •    Models like Product, NewFromNikeModel, StoriesForYou, etc., represent the data fetched from the server and are used to populate each section of the table view.
    
    2.    Network Service:
    •    The homeLoader (of type NetworkServiceProtocol) is responsible for fetching data. It is injected into the HomeViewModel to handle data loading asynchronously.
    
    3.    Custom TableView Cells:
    •    The app uses custom table view cells such as WelcomeCell, PromoCarouselCell, and others to display each section’s content.
    
    4.    Bind ViewModel to UI:
    •    The HomeViewController binds to the HomeViewModel’s state and responds to changes, like starting the loading indicator when data is being fetched and stopping it when data is loaded.
    
    5.    Navigation:
    •    Use the push method for navigating to detail screens from various sections.

ScreenShots:

## Shop module

Overview

The Shop module is responsible for displaying a variety of products in the app, separated into sections based on categories (men, women, kids). It integrates with a network service to fetch products, handles user interactions like button taps to filter the product view, and allows navigation to detailed product views.

Structure

Components:
    •    ShopSectionBuilder: This class builds the sections of the shop page dynamically based on the selected button type (men, women, or kids). It creates different sections such as “New This Week”, “News”, “Classics Spotlight”, and “Nearby Stores”.
    •    ShopPresenter: The presenter handles the interaction between the view (ShopViewController) and the data model. It loads the product data from the network service and updates the sections. It also manages the currently selected button (men, women, kids) and controls the logic for viewing recently viewed products.
    •    ShopViewController: The main view controller displaying all sections of the shop. It interacts with the presenter to update the UI and show product details when a product is selected.
    •    ShopTableView: The table view that displays the shop sections. It registers custom cells for each section type and dynamically calculates the height of rows based on the content.
    •    ShopTableViewDataSource: The data source for the table view. It provides data to each section and row in the table.
    •    NetworkServiceProtocol: A protocol that defines how product data is fetched from the server.

Features
    •    Section Display: Based on the selected button (men, women, or kids), the shop displays relevant product sections. These sections include:
    •    New This Week
    •    News
    •    New and Featured
    •    Rafael Nadal (for men only)
    •    Classics Spotlight
    •    Nearby Store
    •    Recently Viewed: A special section that shows recently viewed products. This section is only shown for men and women categories and can be removed if no longer needed.
    •    Dynamic Updates: The app reacts to button taps by dynamically updating the displayed sections based on the selected category (men, women, or kids).
    •    Navigation: Tapping on a product navigates to a detailed product view. The app also supports navigation to a list detail screen.


## Favorite module

Description

The Favorite module provides functionality for managing favorite products in the app. It allows users to add and remove products from their favorites list, as well as view the products added to their favorites. The module uses a UITableView to display the list of favorites and a UICollectionView for displaying items in a grid layout.

Module Structure

Main Components:
    1.    FavoriteVC - The main view controller that manages the display of the favorite products list.
    2.    FavoritesTableView - A custom table view that displays sections of favorite products.
    3.    FavoritesTableViewCell - A table view cell that displays product information and includes a collection for displaying grid items.
    4.    FavoriteCollectionViewCell - A collection view cell that displays product information, including an image and description.
    5.    FavoriteSectionBuilder - A utility class for building sections of favorites.

Key Features:
    •    Add to Favorites: Users can add products to their favorites list.
    •    Remove from Favorites: Users can remove products from their favorites.
    •    Editing Mode: The module supports an editing mode for adding/removing products from the favorites.
    •    Preview: Users can tap on a product to view additional details.


## Bag module

Overview

The Bag module in the Nike project handles the functionality of displaying and managing a shopping bag. It includes sections for showing products added to the bag, a total price, and buttons for payment and checkout actions.

This module contains the following main components:
    •    BagSectionBuilder: Builds the sections for the bag based on products and total price.
    •    BagViewController: The view controller responsible for managing the UI of the shopping bag.
    •    BagTableView: A table view displaying products and the total price of the bag.
    •    BagCell: A cell used to display individual products in the shopping bag, with the ability to update the quantity and remove items.
    •    Orders: A protocol used by BagCell to handle actions like deleting items and updating prices.

Components

1. BagSectionBuilder

This class is responsible for creating the sections for the shopping bag:
    •    Products: A list of products in the bag.
    •    Total Price: The total price of the products.

2. BagViewController

BagViewController is the main view controller for managing the shopping bag interface. It displays the list of products in a table view and two action buttons: Pay and Checkout.

Key Features:
    •    Displays the list of products and total price.
    •    Handles Pay and Checkout button actions with a “coming soon” placeholder screen.
    •    Automatically updates the bag when the view appears.

Key Methods:
    •    viewWillAppear(): Updates the bag’s contents when the view appears.
    •    handlePayButtonTap(), handleCheckoutButtonTap(): Trigger actions for payment and checkout.

3. BagTableView

A custom table view that displays both product items and the total price. It also allows for swipe actions (e.g., deleting an item or adding it to favorites).

Key Features:
    •    Displays products and total price in separate sections.
    •    Allows for swipe actions on product cells: Delete or Add to Favorites.

Methods:
    •    updateSections(with:): Updates the sections of the table view.
    •    updateTotalPrice(with:): Updates the total price displayed in the table view.

4. BagCell

BagCell is used to display individual products in the shopping bag. It includes functionality for changing the quantity of a product and updating the price dynamically.

Key Features:
    •    Displays product details such as name, description, price, and image.
    •    Allows the user to change the quantity of a product, which automatically updates the price.
    •    Handles swipe actions for deleting the item or adding it to favorites.

5. Orders Protocol

This protocol is implemented by the BagCell to handle actions such as removing items from the bag and updating the price when the quantity changes.

⸻
How to Use
    1.    Displaying the Bag:
Use the BagViewController to manage the display of the shopping bag. The BagSectionBuilder will create the necessary sections for products and total price.
    2.    Handling Product Quantity:
The user can change the quantity of a product using the BagCell’s quantity button. This will automatically update the total price.
    3.    Deleting Items:
Users can swipe to delete items from the shopping bag. The product will be removed from the list, and the total price will be updated accordingly.
    4.    Payment and Checkout:
The BagViewController provides buttons for payment and checkout actions, which currently show a “coming soon” screen.

⸻
Dependencies
    •    BagService: A service class responsible for fetching, saving, and calculating the total price of products in the bag.
    •    FavoritesService: A service for managing favorite items.


## Detail module

Overview

This module is responsible for displaying detailed product information in the Nike iOS application. It includes a variety of sections such as product descriptions, sizes, categories, promotional content, and recommendations.

Contents
    •    DetailViewController.swift
Manages the layout and data of the detail screen. Responsible for configuring the view and loading appropriate sections using DetailSectionBuilder.
    •    DetailSectionBuilder.swift
A utility class that constructs an array of DetailSection enums based on the provided models. Each function builds sections for specific use cases like products, promotions, stories, and recommendations.
    •    DetailTableView.swift
A customized UITableView that uses DetailTableViewDataSource as its data source. It handles registering cells and updating the UI based on new data.
    •    DetailTableViewDataSource.swift
The data source for the DetailTableView. Uses the DetailSection enum to determine which cell to return and how to populate it. It also manages logic for button actions such as adding to favorites or to a bag.

⸻

Main Features
    •    Modular Section Building:
DetailSectionBuilder dynamically builds the UI sections depending on the type of product or content (promo, shop, new releases, etc.).
    •    Clean Separation of Concerns:
View logic is separated from data generation and UI configuration for easier maintenance and scalability.
    •    Flexible Content Rendering:
Supports a wide range of section types such as:
    •    Product info
    •    Subcategories and categories
    •    Product size and description
    •    Action buttons (e.g. add to bag/favorites)
    •    Auto-scrolling promo banners
    •    “Complete the look” suggestions
    •    Stories and shop items

⸻

Getting Started

To use this module:
    1.    Call the appropriate updateXDetailSections() function in DetailViewController, depending on the type of content you want to display.
    2.    Make sure models like Product, Header, Categories, etc., are populated with correct data.
    3.    The table will automatically update using updateSections() and render the data.

Notes
    •    Each section is represented as a case in the DetailSection enum.
    •    Each section is rendered with a specific UITableViewCell class (e.g., DetailButtons, PromoCarouselCell, etc.).
    •    The DetailTableViewDataSource handles internal actions via closures for favorites and cart functionality.

# ScreenShots

## Home Screen
![Home Screen](Screenshots/home_screen_1.png)

## Shop Screen
![Shop Screen](Screenshots/shop_screen.png)

## Favorite Screen
![Favorite Screen](Screenshots/favorite_screen.png)

## Bag Screen
![Bag Screen](Screenshots/bag_screen.png)

## Detail Screen
![Detail Screen](Screenshots/detail_screen.png)
