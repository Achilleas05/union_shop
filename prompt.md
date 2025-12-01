# Dynamic Collection Page – Prompt for AI

I have a Flutter app called **“Union Shop”** that recreates the UPSU Union Shop website. This is coursework from the University of Portsmouth “Union Shop Flutter Coursework” brief, and I am currently implementing the **Intermediate feature**:

> “Dynamic Collection Page: Product listings of a collection populated from data models or services with functioning sorting, filtering, pagination widgets.”

The project structure relevant to this feature is:

- `lib/main.dart` – main app and routing
- `lib/collections_page.dart` – page listing all collections
- `lib/collection_page.dart` – page that shows products for a single collection (this is what we are improving)
- `lib/product_page.dart` – individual product detail pages
- `lib/models/product.dart` – `Product` model
- `lib/models/collection.dart` – `Collection` model (if present)
- `lib/models/fixtures.dart` – in‑memory fixtures for collections and products

## Current `CollectionPage` implementation

The file `lib/collection_page.dart` currently has:

- A `CollectionPage` `StatefulWidget` which receives:
  - `collectionTitle` (a `String`)
  - `collectionProducts` (a `List` of `Product`)
- A header section that changes depending on `collectionTitle`  
  (e.g. “Sale Items”, “Essential Range”, “University Clothing”, “Study Supplies”, “Gift Shop”), with different colour schemes and marketing text.
- A `_buildHeader()` method that shows the collection title and number of products:
  - `"${widget.collectionProducts.length} products in this collection"`.
- A `_buildFilterRow()` method with two dropdowns:
  - **Sort by**: `Featured`, `Price: Low to High`, `Price: High to Low`, `A‑Z`
  - **Filter**: `All products`, `Clothing`, `Accessories`, `Sale items`, `New arrivals`
- A `_buildProductGrid()` method that displays `widget.collectionProducts` in a `GridView.count`:
  - 2 columns on narrow screens, 3 columns on wider screens (using `MediaQuery`).
- A `_buildProductCard(Product product)` which:
  - Shows the product image via `Image.asset(product.imageUrl, ...)`
  - Shows `product.name`
  - Shows current price (and `originalPrice` with strikethrough if present)
  - Shows an optional `product.tag` (e.g. “Sale”) as a coloured label
  - Navigates to `/product/${product.id}` via `context.go(...)` from `go_router`.

At the moment, the dropdowns **do not actually change the list**; they only update `_selectedFilter` and `_selectedSort` state. There is also **no pagination state**; all products are shown at once. The page is already wired with real `Product` models and feels close to the target; it just needs proper logic for sorting, filtering, and pagination.

## Data assumptions / model notes

My `Product` model (in `lib/models/product.dart`) has at least these fields:

- `String id`
- `String name`
- `double price`
- `double? originalPrice` (used for sale items)
- `String imageUrl`
- `String? tag` (e.g. `"Sale"`, `"New"`, `"Bestseller"` or similar)

You can **assume or suggest** reasonable extra fields if needed for filtering, for example:

- `String category` – e.g. `"Clothing"`, `"Accessories"`, `"Study"`, etc.
- `bool isOnSale` – based on whether `originalPrice != null` and `price < originalPrice`.

The exact property names can be adjusted to match best practice, but the implementation should be consistent across `fixtures.dart`, `product.dart`, and `collection_page.dart`.

## What I want this page to do

The final `CollectionPage` should:

1. **Read the products dynamically**

   - Use `collectionProducts` (already passed in) as the base list.
   - No hardcoded product cards inside the widget tree.
   - All display data must come from `Product` instances.

2. **Sorting (functional)**
   Implement the following sort options in the “Sort by” dropdown:

   - `Featured` (default, can be original order or “best” order)
   - `Price: Low to High`
   - `Price: High to Low`
   - `A‑Z` (sort alphabetically by `product.name`)

   When the sort option changes:

   - Recompute the visible product list.
   - Keep current filters applied.
   - Reset pagination to page 1.

3. **Filtering (functional)**
   Implement functional filtering using the “Filter” dropdown:

   - `All products`
   - `Clothing`
   - `Accessories`
   - `Sale items`
   - `New arrivals`

   The exact conditions can be based on `Product` properties (e.g. `category`, `tag`, `isOnSale`). For example:

   - `Clothing`: products whose category or tag indicates clothing.
   - `Accessories`: similar logic.
   - `Sale items`: products where `originalPrice != null` or `isOnSale == true`.
   - `New arrivals`: products tagged `"New"` or similar.

   When filter changes:

   - Apply the filter to the base list (the products of this collection only).
   - Then apply the selected sort order.
   - Reset pagination to page 1.

4. **Pagination (functional)**

   - Show a fixed number of products per page, e.g. 6 or 8 (please choose a sensible default and expose it as a constant in the state).
   - Compute the total number of pages based on the filtered+sorted list.
   - Add UI controls below the grid:
     - “Previous” and “Next” buttons (or chevron icons).
     - A label like `Page X of Y`.
   - Disable the previous button on the first page, and the next button on the last page.
   - When the user changes page, only the relevant slice of the product list should render.

   The logic should be roughly:

   - `List<Product> _allCollectionProducts` – base list from `widget.collectionProducts`.
   - `List<Product> _filteredAndSortedProducts` – result after applying filter + sort.
   - `List<Product> _pagedProducts` – slice of `_filteredAndSortedProducts` for the current page.

5. **Responsiveness**

   - Keep the existing responsive grid: 2 columns on small screens, 3 on wider screens.
   - Ensure pagination controls and dropdowns still look good on mobile width.

6. **Code quality / coursework expectations**
   - Use `StatefulWidget` + `setState` (no need for external state management).
   - Use clear method names and comments so another developer (e.g. my lecturer) can understand how sorting, filtering, and pagination work together.
   - Keep logic in `collection_page.dart` (or small helpers in `models`/`fixtures`) – no backend, no network calls.
   - Do not break existing routes; `context.go('/product/${product.id}')` should continue working.

## What I want from you (AI)

Given the above:

1. Propose a **high‑level plan** for refactoring `CollectionPage` to support:

   - Functional sorting.
   - Functional filtering.
   - Pagination with page state and controls.

2. Suggest the **exact state fields and helper methods** I should add to `_CollectionPageState`, for example:

   - `late List<Product> _allCollectionProducts;`
   - `late List<Product> _filteredAndSortedProducts;`
   - `String _selectedSort = 'Featured';`
   - `String _selectedFilter = 'All products';`
   - `int _currentPage = 1;`
   - `final int _pageSize = 6;`
   - Methods like:
     - `_applyFilterAndSort()`
     - `_getCurrentPageProducts()`
     - `_onSortChanged(String? value)`
     - `_onFilterChanged(String? value)`
     - `_goToNextPage()`, `_goToPreviousPage()`

3. Provide **concrete Dart code** that:

   - Shows the updated `_CollectionPageState` with:
     - `initState()` that initialises `_allCollectionProducts` from `widget.collectionProducts` and calls `_applyFilterAndSort()`.
     - Implementations of sorting and filtering logic based on sensible assumptions about `Product` fields.
     - Pagination logic (page count, page slice, next/previous functions).
   - Modifies `_buildProductGrid()` to use only the current page’s slice rather than `widget.collectionProducts` directly.
   - Adds a `_buildPaginationControls()` widget under the grid, with proper disabled states.
   - Leaves the existing marketing header sections (SALE / Essential Range / etc.), `CustomHeader`, and `Footer` intact.

4. If needed, suggest **minimal changes** to `Product` (and `fixtures`) to support cleaner filtering, such as adding a `category` field or `isOnSale` boolean. Provide small code snippets for those changes, but do not redesign the entire model layer.

5. Add **short comments** in the code where appropriate to explain:
   - When filters or sort options change, all filtering/sorting is recomputed and current page resets.
   - How the current page slice is calculated.

Please respond with:

- A short bullet‑point plan.
- Then updated / new Dart code blocks I can paste into:
  - `lib/collection_page.dart` (for the widget and state logic).
  - Optionally `lib/models/product.dart` and `lib/models/fixtures.dart` if you introduce new fields needed by the filtering.

Do not change any unrelated pages or routing logic.
