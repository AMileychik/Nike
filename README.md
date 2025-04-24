# Nike App — iOS Pet Project

## Description

**Nike** is a mobile e-commerce app for the Nike brand, developed as a pet project. The app showcases modern approaches to architecture, clean code, and UI/UX design.
Users can browse products, choose categories, add items to favorites or the shopping bag, and place orders.

## Project Highlights

- Utilizes various architectures: **MVVM**, **MVP**, **MVC**.
- **Dependency Injection** implemented via a custom DI container..
- Adheres to **SOLID** and **Clean Code** principles.
- Responsive and modern interface.
- Works with **JSON** and persists state.
- Business logic is covered by unit tests.

## Architecture

| Screen        | Architecture |
|---------------|--------------|
| Home          | MVVM         |
| Shop          | MVP          |
| Detail        | MVC          |
| Favorite      | MVC          |
| Bag           | MVC          |

## Dependency Injection

The project implements DI using `DependencyContainer` and `ScreenFactory`: 

- All dependencies (`URLSession`, `JSONDecoder`, `NetworkService`) are created centrally.
- `ScreenFactory` assembles modules by passing dependencies through initializers.
- This approach reduces coupling, simplifies testing, and improves scalability.

DI is initialized once at the application launch and is used to construct all modules.

## Services

The project uses several services to manage data and network requests:

**NetworkService**
- Load data from `localhost:3001`.
- Returns a `Result` containing `HomeSectionsResponse`, `ShopSectionsResponse` models.
- Absracts networking logic via `NetworkServiceProtocol`.

**FavoritesService / BagService**
- works with `UserDefaults` using `JSONEncoder/Decoder`.
- Supports favorites and cart with state persistence.
- Calculates total amount and item count.
- Implemented via `FavoritesServiceProtocol`, `BagServiceProtocol`. 

## Custom Views

- `CustomButton` — customizable button with icon, color, and action handler.
- `ButtonContainerView` — button with a separator.
- `GradientView` — vertical gradient view.
- `ShadowView` — view with shadow (enabled via a flag).

## Tab Bar

Custom `TabBarController`:

- Four screens: Shop, Home, Favorites, Bag.
- Injected via DI and wrapped in `UINavigationController`.
- Re-tapping the active tab triggers scrollToTop().
- **Home** is selected by default.

## Component-Based UI & Design System (Factory Pattern)

UI components are implemented using the **Factory** pattern, allowing centralized configuration of styles and behaviors for UI elements.

**ImageView**
- Factory-created UIImageView with predefined styles: .common, .product, .favorite, and others.

**Label**
- Custom InsetLabel, generated via a factory with support for styles like .screenTitle, .price, .highlighted, etc.

**StackView**
- UIStackView configured through a factory with variants such as .productCell, .listHeader, .headerStackView.

## Extensions

- `Date+WelcomeText.swift` — greeting text based on the time of day.
- `UICollectionViewCell+Extension.swift` — `reuseCVId` and `ReusableCollectionViewCell` protocol.
- `UICollectionView+Extension.swift` — cell registration and retrieval.
- `UITableViewCell+reuseId.swift` — `reuseId` and `Reusable`.
- `UITableViewCell+dequeueCell.swift` — universal cell retrieval.
- `UIColor+Extension.swift` — color brightness adjustment.
- `ScrollToTop+Extension.swift` — scroll to the top.
- `Array+Extension.swift` — safe access to elements.
- `UIResponder.swift` — `findParentViewController()`.
- `UINavigationController.swift` — appearance configuration and adding search.
- `UIView+Extension.swift` — `makeSeparator()` and `viewController`.

## Constants and Resources based on Flyweight

The **Flyweight** pattern is used to minimize memory usage and centralize repetitive UI configurations.

Centralized UI settings:

- `Layout.swift` — margins and padding.
- `Constants.swift` — logical values, such as the number of banners.
- `Font.swift` — project fonts.
- `Text.swift` — UI strings grouped by screens.
- `Images.swift` — system and custom icons.

## Unit Tests

Business logic coverage using XCTest.

**Tested components:**
- `ShopViewController` — viewDidLoad, UI updates.
- `ShopPresenter` — events, data loading.
- `ProductService` — service calls.

**Methods:**
- Spy objects (e.g., `ShopPresenterSpy`) to track method calls.
- `XCTestExpectation` — waiting for asynchronous events.
- Mocking dependencies through protocols.

## Screens

### Home

- User greeting based on the time of day.
- Sections with product categories for adding to **Favorite** or **Bag**.
- Horizontal promo carousel with smooth progress update (the black part of the indicator smoothly moves and changes width based on the scroll position (UIScrollViewDelegate)).
- Section with video and gradient.
- Introductory sections with products and their descriptions

**Architecture:** MVVM  
**Features:** dynamic greeting, nested collectionViews inside tableView, reusability of sections.

### Home screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/home_screen_1.png" alt="Home Screen 1" width="333"/>
  <img src="Screenshots/home_screen_2.png" alt="Home Screen 2" width="333"/>
  <img src="Screenshots/home_screen_3.png" alt="Home Screen 3" width="333"/>
</div>

---

### Shop

- Category list: Men, Women, Kids.
- Each category contains:
- Products with images and descriptions;
- Introductory banners or product articles.

**Architecture:** MVP  
**Features:** the presenter manages the display logic and business logic, and the screen is scalable for any category.

### Shop screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/shop_screen_1.png" alt="Shop Screen 1" width="333"/>
  <img src="Screenshots/shop_screen_2.png" alt="Shop Screen 2" width="333"/>
  <img src="Screenshots/shop_screen_3.png" alt="Shop Screen 3" width="333"/>
</div>

---

### Detail

- Viewing the product card with a large number of photos.
- Adding to the cart or favorites.
- Switching between product alternatives.

**Architecture:** MVC  
**Features:** image carousel, custom add-to-cart button, product availability status (selected / not selected), using the ProgressHUD library to visualize adding the product to “Favorite” or “Bag”. 

### Detail screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/detail_screen_1.png" alt="Detail Screen 1" width="333"/>
  <img src="Screenshots/detail_screen_2.png" alt="Detail Screen 2" width="333"/>
</div>

---

### Favorite

- List of all favorite products.
- Removal from favorites.
- State is automatically saved.

**Architecture:** MVC  
**Features:** synchronization with Detail, dynamic UI updates..

### Favorite screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/favorite_screen_1.png" alt="Favorite Screen 1" width="333"/>
</div>

---

### Bag

- Added items with the ability to delete by swipe or tap.
- Ability to add items to favorites by swipe directly from the cart.
- Quantity selection for items through a custom QuantityPickerViewController with UIPickerView.
- Calculation of the total amount.

**Architecture:** MVC  
**Features:** real-time price recalculation, convenient item quantity selection, favorites from the bag.

### Bag screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/bag_screen_1.png" alt="Bag Screen 1" width="333"/>
</div>

---

## Future Development Plans

- Authentication and user profile.
- Order placement and submission.
- Dark mode.

---

## Contact

- Developer: Alexander Mileychik
- GitHub: github.com/AMileychik/Nike
- Email: amileychik@gmail.com

---

## Installation

1. Clone the repository using the terminal or Sourcetree with this link: https://github.com/AMileychik/Nike.git

2. Open the .xcodeproj file in Xcode.

3. Install dependencies using SPM.

4. Install Mockoon (https://mockoon.com/download/).

5. Copy the files Home.json and Shop.json from the project (Resources folder), and create http://localhost:3001/shop and http://localhost:3001/home.

6. Start the server on Mockoon (Start server).

7. Build the project on the simulator.
