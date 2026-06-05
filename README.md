# 🛒 Premium Flutter E-Commerce Showcase (Siddiq Shop)

A highly polished, responsive, and modern E-Commerce Home Screen application built in Flutter with Material 3. The project demonstrates senior-level clean architecture, reusable custom widgets, offline-first search/category filters, stateful wishlist toggles, and robust widget testing.

---

## 📋 Requirements Checklist & Verification Status

Here is how the original requirements from the user's task are implemented in this codebase:

| Requirement | Implementation Details | File References | Status |
| :--- | :--- | :--- | :---: |
| **1. Create a Home Screen showing list/grid of products** | Provides a dual-view switcher between a dynamic responsive grid and a horizontal list layout. | [home_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/home_screen.dart) |  `Implemented` |
| **2. Each card contains image, name, price, and Add to Cart button** | Features high-quality cached images, bold Orange pricing, name labels, and custom clickable cart triggers with animated badge updates. | [product_card.dart](file:///d:/Flutter%20Projects/yusry/lib/widgets/product_card.dart) |  `Implemented` |
| **3. Design Style: Modern E-Commerce UI, minimal, clean layout, responsive** | Structured around clean padding, standard Material 3 spacing, and responsive flexboxes that dynamically resize grid column spans (2 to 5 columns depending on display width). | [home_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/home_screen.dart) |  `Implemented` |
| **4. Color Palette: White background, Black text, Orange accent** | Set up using a white surface, Slate Black headings (`#0F172A`), Slate Grey subtexts (`#64748B`), and vibrant Orange accent (`#FF6B00`). | [theme.dart](file:///d:/Flutter%20Projects/yusry/lib/core/theme.dart) |  `Implemented` |
| **5. Developer Requirements: Reusable widgets, clean architecture, null safety** | Split into domain-specific subdirectories (`models`, `widgets`, `screens`, `data`). Follows strict null safety and clean naming conventions. | [lib/](file:///d:/Flutter%20Projects/yusry/lib) |  `Implemented` |
| **6. Splash Screen, Carousel Slider, Details View** | Added splash page transition with scaling brand text, dynamic auto-scrolling promo carousel with indicator dots, and fully interactive specifications selector details screen. | [splash_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/splash_screen.dart)<br>[details_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/details_screen.dart) |  `Implemented` |

---

## 📱 Project Overview & Features

This application transforms a generic mobile template into a high-fidelity shopping experience, utilizing a curated color palette (Orange accent, White background, Slate Black headings) and optimized component layers.

### Key Implemented Features:
1. **Interactive Splash Screen (`lib/screens/splash_screen.dart`)**:
   - Branding text ("Siddiq SHOP") with a smooth scale-pulse loading transition.
   - Dynamic gradient color transitions (Slate-to-Orange) and custom slide/fade navigation.
2. **Modern E-Commerce App Bar & Cart Count**:
   - Features a clean Material 3 header showing the brand icon and title.
   - An animated cart count badge that increments reactively upon clicking "Add to Cart".
3. **Interactive Promotion Slider / Carousel**:
   - Auto-scrolling banner slideshow displaying seasonal codes (`SUMMER50`, `STEPUP20`, `SMARTHOME`) and curated marketing headers.
   - Seamless indicators showing active banner indexes.
   - Integrated error boundaries (shoppers see a premium fallback gradient instead of broken image links).
4. **Offline Category Filter chips (`lib/widgets/category_chip.dart`)**:
   - Scrollable row of chips (`All`, `Electronics`, `Footwear`, `Accessories`, `Fashion`, `Home`).
   - Dynamic item filtering based on selected categories.
5. **Interactive debounced Search Bar (`lib/widgets/search_bar.dart`)**:
   - Pill-shaped query search with filter tuning sheet triggers.
   - Debounced input listeners (300ms) to simulate server-side API query matching and trigger loaders.
6. **Simulated Shimmer Skeletons**:
   - Custom pulsing opacity animations to simulate network fetch times whenever category filters or search filters change.
7. **Responsive Grid / List Layout Switcher**:
   - Supports switching views between a **Responsive Grid** (columns adjust from 2 to 5 columns depending on screen size) and a **Horizontal List view**.
8. **Premium Product Cards (`lib/widgets/product_card.dart`)**:
   - Clean, rounded corner borders with subtle shadows.
   - MouseRegion hover effects (web support: card raises and borders highlight in orange).
   - Instant favorites (wishlist) icon toggle syncing with custom snackbars.
   - Distinct orange-highlighted prices.
9. **Interactive Product Details Screen (`lib/screens/details_screen.dart`)**:
   - Full product page with Hero image transitions.
   - Category-specific configuration selectors (e.g. shoe sizes for Footwear, storage gigabytes for Electronics, color options).
   - Glassmorphic sticky bottom action bar containing "Buy Now" and "Add to Cart" buttons.

---

## 🎨 Color Palette & Typography

* **Primary Color**: `#FF6B00` (Vibrant E-Commerce Orange)
* **Background Color**: `#FFFFFF` (Surface and Scaffold Background)
* **Text Headings Color**: `#0F172A` (Slate Black for readability)
* **Secondary Text Color**: `#64748B` (Slate Grey)
* **Card Shadows**: Subtle `#0F172A` shadows with an alpha of `0.03` to `0.08` depending on hover/elevation status.

---

## 📂 Scalable Directory Structure

The codebase is organized in a scalable, feature-focused structure:

```text
lib/
├── core/
│   └── theme.dart          # Light mode ThemeData configuration and color scheme
├── data/
│   └── dummy_products.dart # Curated list of e-commerce items with Unsplash image sources
├── models/
│   └── product_model.dart  # Immutable ProductModel schema with copyWith modifications
├── screens/
│   ├── splash_screen.dart  # Branding intro loading page
│   ├── home_screen.dart    # Grid/List hub with banner, search filters, and loaders
│   └── details_screen.dart # Interactive specs configurator, hero transition, buy controls
├── widgets/
│   ├── category_chip.dart  # Scrollable horizontal chip selectors
│   ├── custom_button.dart  # Multi-state primary button (supports loaders)
│   ├── product_card.dart   # Individual product layout with mouseRegion hover triggers
│   └── search_bar.dart     # Input text bar with filter tuner actions
└── main.dart               # Initial bootstrapper
```

---

## 🧪 Testing Suite (`test/widget_test.dart`)

The project contains a complete, robust widget test that simulates:
1. Splash screen booting and checking name credentials.
2. Chronological simulation of timer-based transition to the `HomeScreen`.
3. Validation of search headers, lists, grid visibility, and specific products.
4. Auto-scrolling, viewport resizing (`1080x2400`), and tapping to push the `DetailsScreen`.
5. Checking options, back button pop, and return state verification.

*To bypass standard `NetworkImage` HTTP blocks in widget tests, the test suite implements a dynamic `noSuchMethod` HttpClient override returning transparent 1x1 png streams.*

---

## 🚀 How to Run the Project

1. **Get Dependencies**:
   ```bash
   flutter pub get
   ```
2. **Run Tests**:
   ```bash
   flutter test
   ```
3. **Execute the Application**:
   - For web (Chrome):
     ```bash
     flutter run -d chrome
     ```
   - For general targets:
     ```bash
     flutter run
     ```
