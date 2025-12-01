# Union Shop – Requirements

This document describes the features implemented so far in the Union Shop Flutter coursework app, up to and including the **Intermediate: Dynamic Collection Page** feature.

---

## 1. Data Models and Structure

- `Product` model (`lib/models/product.dart`)

  - Fields: `id`, `name`, `imageUrl`, `price`, `originalPrice?`, `tag?`, `description`, `sizes`, `colors`.
  - Helpers used by collection logic:
    - `isOnSale` – true when `originalPrice != null && price < originalPrice`.
    - `isNew` – true when `tag == 'New'`.
    - `category` – simple mapping from id/name to categories like `Clothing`, `Accessories`, `Gift`.

- `Collection` model (`lib/models/collection.dart`)

  - Fields: `id`, `name`, `color`, `icon`, `products` (`List<Product>`).

- Fixtures (`lib/models/fixtures.dart`)
  - `products` – in‑memory list of `Product` instances.
  - `collections` – in‑memory list of `Collection` instances referencing products.

These models and fixtures are the single source of truth for products and collections used across the app.

---

## 2. Basic Features (40%) – ✅

### Static Homepage (5%) ✅

- Mobile‑first homepage in `main.dart` with:
  - App branding and header.
  - Hero/intro content.
  - Static featured products section (hardcoded or from fixtures).

### About Us Page (5%) ✅

- `AboutPage` in `about_page.dart` with:
  - Title and description of the Union Shop.
  - Basic contact or “about” information.
  - Reachable via navigation/header.

### Footer (4%) ✅

- Reusable `Footer` widget in `footer.dart`:
  - Sections for opening hours, help/info links, and offers.
  - Included on major pages (home, collection pages, etc).

### Dummy Collections Page (5%) ✅

- `CollectionsPage` in `collections_page.dart`:
  - Shows a set of collections in a grid/list layout.
  - Uses data from `fixtures.dart` (dynamic) or equivalent structure, instead of hardcoded widgets.
  - Tapping a collection navigates to `CollectionPage`.

### Dummy Collection Page (5%) ✅

- `CollectionPage` in `collection_page.dart`:
  - Header with collection title and marketing text (e.g. Sale Items, Essential Range, University Clothing, Study Supplies, Gift Shop).
  - Two dropdowns for “Sort by” and “Filter”.
  - Product cards laid out in a responsive `GridView`.
  - Initially worked with static/hardcoded behaviour; later extended for the dynamic feature below.

### Dummy Product Page (4%) ✅

- `ProductPage` in `product_page.dart`:
  - Shows product image, title, description, price and optional sale price.
  - Contains dropdowns for size/colour and quantity selection.
  - “Add to cart” or similar button is present (logic not required for basic mark).

### Sale Collection Page (4%) ✅

- Sale page (or “Sale Items” collection) with:
  - Promotional banner explaining discounts.
  - Products that have `originalPrice` and discounted `price`.
  - Visual indication of sale prices.

### Authentication UI (3%) ✅

- Login/signup UI in `login_page.dart` (or similar):
  - Email/password fields and basic form layout.
  - Buttons and links (e.g. login, signup, forgot password) that are UI‑only and do not require backend auth.

### Static Navbar (5%) ✅

- Header/navbar in `header.dart`:
  - Brand/logo and navigation links (Home, Collections, Sale, About, Login, etc).
  - Responsive behaviour so it looks correct on mobile (e.g. collapsing/stacking).

---

## 3. Intermediate Features (so far)

### Dynamic Collections Page (6%) – ✅

**Description**  
Collections overview page populated from the data models/fixtures.

**Requirements implemented**

- `CollectionsPage` reads collections from `fixtures.collections` (or equivalent in models folder).
- Each collection card shows at least:
  - Collection title.
  - Icon/colour or other identifying visual.
- Tapping a collection passes the selected collection’s title and products into `CollectionPage`.
- No collection data is hardcoded in the widget tree; it all comes from model/fixtures.

**Acceptance criteria**

- Adding/removing a collection in `fixtures.dart` automatically changes what appears on `/collections`.
- Navigation from collections overview to a specific `CollectionPage` works.

---

### Dynamic Collection Page (6%) – ✅

**Description**  
Product listings of a single collection populated from models/fixtures with functioning sorting, filtering, and pagination widgets.

**Files involved**

- `lib/collection_page.dart`
- `lib/models/product.dart`
- `lib/models/fixtures.dart`
- `lib/models/collection.dart`

**Behaviour implemented**

- `CollectionPage` receives:

  - `collectionTitle` – used for UI and marketing banners.
  - `collectionProducts` – list of `Product` instances for that collection.

- Internal state in `_CollectionPageState`:

  - `_allCollectionProducts` – base list from `collectionProducts`.
  - `_filteredAndSortedProducts` – list after applying filter and sort.
  - `_selectedFilter` – one of: `All products`, `Clothing`, `Accessories`, `Sale items`, `New arrivals`.
  - `_selectedSort` – one of: `Featured`, `Price: Low to High`, `Price: High to Low`, `A-Z`.
  - `_currentPage`, `_pageSize`, `_totalPages` – pagination state.

- Functional **filtering**:

  - Filter dropdown triggers `_onFilterChanged`, which calls `_applyFilterAndSort()`.
  - Filtering rules use `Product` helpers:
    - `Clothing` → `category == 'Clothing'`.
    - `Accessories` → `category == 'Accessories'`.
    - `Sale items` → `isOnSale == true` or `tag == 'Sale'`.
    - `New arrivals` → `isNew == true`.
    - `All products` → no extra filter.

- Functional **sorting**:

  - Sort dropdown triggers `_onSortChanged`, which calls `_applyFilterAndSort()`.
  - Sorting rules:
    - `Featured` → keep original order.
    - `Price: Low to High` → sort by `price` ascending.
    - `Price: High to Low` → sort by `price` descending.
    - `A-Z` → sort by `name` alphabetically (case‑insensitive).

- **Pagination**:

  - A fixed `_pageSize` (e.g. 6 products per page).
  - `_currentPageItems()` returns only the products for the current page.
  - `_totalPages` computed from `_filteredAndSortedProducts.length` and `_pageSize`.
  - Pagination controls under the grid:
    - Previous/Next buttons that call `_goToPreviousPage()` / `_goToNextPage()`.
    - Text label like “Page X of Y”.
    - Buttons disabled on first/last page.
  - Whenever filter or sort changes, `_currentPage` resets to 1.

- **Rendering**:
  - Header shows collection title and the count of `_filteredAndSortedProducts`.
  - Product grid renders only the current page slice.
  - Cards still navigate to the `ProductPage` via `go_router`.

**Acceptance criteria**

- All products shown on `CollectionPage` come from the models/fixtures, not hardcoded widgets.
- Changing “Filter” updates which products are visible.
- Changing “Sort by” updates the order of visible products.
- Pagination controls allow cycling through pages when there are more items than `_pageSize`.
- Product count text matches the filtered list, and navigation to product detail remains functional.

---

### Functional Product Pages (6%) – ✅

**Description**  
Product detail pages populated from the shared data models/fixtures, with **working size and colour dropdowns** and a **quantity counter**. The “Add to Cart” buttons are present but not required to perform any real cart logic for this feature.

**Files involved**

- `lib/product_page.dart`
- `lib/models/product.dart`
- `lib/models/fixtures.dart`
- `lib/main.dart` (route definition for `/product/:id`)

**Behaviour implemented**

- Routing:

  - `GoRoute(path: '/product/:id', builder: (context, state) => const ProductPage())` is defined in `main.dart`.
  - Collection and other listing pages navigate using `context.go('/product/${product.id}')`, passing only the product ID.

- Product loading:

  - `ProductPage` no longer takes a `Product` via constructor.
  - In `_ProductPageState`, the page:
    - Reads the `id` from the GoRouter path parameters.
    - Looks up the matching `Product` from the `products` list in `fixtures.dart`.
    - If no product is found, shows a simple “Product not found” message and a button to go back to collections.

- UI behaviour:
  - Layout remains responsive:
    - Mobile: image on top, details below in a column.
    - Wider screens: image on the left, details on the right in a row.
  - Price section:
    - Shows original price with strikethrough when

---
