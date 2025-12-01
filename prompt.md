```markdown
# Functional Product Pages – Prompt for AI

I have a Flutter app called "Union Shop" that recreates the UPSU Union Shop website. This is coursework from the University of Portsmouth "Union Shop Flutter Coursework" brief. I am implementing the **Intermediate feature**:

> "Functional Product Pages: Product pages populated from data models or services with functioning dropdowns and counters (add to cart buttons do not have to work yet)"

## Current project structure
```

lib/
├── main.dart – main app and routing (go_router)
├── product_page.dart – product detail page (needs fixing)
├── collection_page.dart – collection pages (working, navigates to product pages)
├── models/
│ ├── product.dart – Product model with sizes/colors
│ ├── fixtures.dart – allProducts list and collections
│ └── collection.dart – Collection model
├── header.dart, footer.dart – reusable widgets
└── collections_page.dart – collections overview

```

## Current data models

**Product model** (`lib/models/product.dart`):
```

class Product {
final String id;
final String name;
final String imageUrl;
final double price;
final double? originalPrice;
final String? tag;
final String description;
final List<String> sizes; // e.g. ['S', 'M', 'L', 'XL']
final List<String> colors; // e.g. ['Navy', 'Black', 'Grey']
// ... getters for filtering (isOnSale, isNew, category)
}

```

**Fixtures** (`lib/models/fixtures.dart`):
- `const List<Product> products = [...]` – 4 real products with `sizes`/`colors` populated
- Each product has unique `id` like `'hoodie-1'`, `'beanie-1'`, etc.

## Current ProductPage implementation (`lib/product_page.dart`)

**What's good**:
- Responsive layout (mobile: vertical, desktop: image left + details right)
- Shows `product.name`, `price`, `originalPrice` (with strikethrough), `description`, `tag`
- **Has working dropdowns and counter**:
  - Size dropdown (`_selectedSize`)
  - Color dropdown (`_selectedColor`)
  - Quantity counter (`_quantity`) with +/- buttons
- "Add to Cart" and "Buy Now" buttons (can remain non-functional)

**What's broken**:
- Dropdowns use **hardcoded** options: `['S', 'M', 'L', 'XL']` and `['Black', 'Navy', 'Grey', 'White']`
- Should use `product.sizes` and `product.colors` from the actual Product
- Falls back to `_createDummyProduct()` if no product passed
- Expects `Product? product` constructor param but navigation sends `product.id` string

**Navigation from collection_page.dart**:
```

context.go('/product/${product.id}'); // sends product ID only

```

## What I want ProductPage to do

The `ProductPage` should:

1. **Load Product by ID from fixtures**
   - Read `productId` from GoRouter route arguments (like `collection_page.dart` does)
   - Find matching `Product` in `fixtures.products` using the ID
   - No more dummy fallback – always load real product data

2. **Functional dropdowns using real product data**
   - Size dropdown shows **exactly** `product.sizes` (e.g. `['S', 'M', 'L', 'XL']` for hoodie)
   - Color dropdown shows **exactly** `product.colors` (e.g. `['Navy', 'Black', 'Grey']`)
   - Maintain `_selectedSize` and `_selectedColor` state as before

3. **Keep existing working features**
   - Quantity counter (+/- buttons) stays exactly the same
   - Responsive layout (mobile/desktop) unchanged
   - Price display (sale/original) unchanged
   - Image, description, tag display unchanged
   - "Add to Cart"/"Buy Now" buttons unchanged (non-functional OK)

4. **Route handling**
   - GoRouter route: `/product/:id`
   - Extract `id` from route params
   - Find `Product? product = fixtures.products.firstWhere((p) => p.id == id)`

## Implementation constraints

- Import `fixtures.dart` to access `products` list
- Use `GoRouterState.of(context).pathParameters['id']` to get product ID
- Handle case where product ID not found (show error or fallback)
- Keep all existing styling, layout, and responsive behaviour
- State management stays simple `StatefulWidget` + `setState`
- No cart integration needed (buttons stay non-functional)
- Code must be consistent with existing app style

## What I want from the AI

1. **High-level plan** for refactoring `ProductPage`:
   - How to extract product ID from route
   - How to load Product from fixtures
   - How to replace hardcoded dropdown lists with `product.sizes/colors`

2. **Concrete Dart code** for `lib/product_page.dart`:
   - Updated constructor (no more `Product? product` param)
   - `initState()` or similar to load product by ID
   - Updated `_buildOptionsSection()` to use real `product.sizes`/`product.colors`
   - Error handling for missing product ID or product not found
   - All existing UI/layout preserved

3. **Small helper if needed**:
   - Static method to find Product by ID from fixtures
   - Or direct lookup in `initState()`

4. **No changes needed to**:
   - `collection_page.dart` navigation (already correct)
   - `fixtures.dart` (data is perfect)
   - `main.dart` routing (assuming `/product/:id` route exists)
   - Any styling or layout

**Respond with**:
- Short bullet-point plan
- Complete updated `lib/product_page.dart` file I can copy-paste
- Any minimal supporting code (e.g. import statements)
- Explanation of key changes in comments

Do not change navigation, styling, or unrelated pages.
```
