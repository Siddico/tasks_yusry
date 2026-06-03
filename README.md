# Premium Mobile UI Showcase

A simple, highly polished Flutter mobile application designed with a professional, clean, and creative user interface. The app implements a standard mobile navigation flow with two main screens: a **Main Screen** (with a list of items) and a **Detail Screen** (displaying details for the selected item), preceded by an engaging **Splash Screen**.

---

## 📱 Project Overview

The goal of this project is to showcase a modern, high-fidelity mobile user interface layout. The application is completely offline, lightweight, and built with Material Design 3. It utilizes a static data model to focus strictly on visual layout, smooth transitions, and premium UX aesthetics.

### Key Requirements Addressed:
1. **Main Screen**: Displays a curated list of featured items with custom cards.
2. **Navigation**: Seamless transition from the Main Screen to the Detail Screen upon selecting an item.
3. **Detail Screen**: Displays rich, basic information about the selected item.
4. **Offline-First & Visual Focus**: No complex backend or external API dependency, making the interface reliable and fast.
5. **Polished Experience**: Includes a Splash Screen, responsive list layouts, Hero animations, and custom page transitions.

---

## ✨ Features & Applied Enhancements

- **Brand New Splash Screen (`lib/screens/splash_screen.dart`)**:
  - Interactive, modern gradient background.
  - Scale animations on the app logo/icon and title.
  - Automated transition to the Main Screen using a custom slide and fade route transition.
- **Interactive Main Screen (`lib/screens/home_screen.dart`)**:
  - Premium header card featuring styled category tags (`Material 3`, `Hero Animation`, `Responsive UI`).
  - Interactive scrollable list using `CustomScrollView` and sliver widgets for native bouncing scrolling.
  - Dynamically displays list items mapped from a local data store.
  - Dynamic empty state layout helper built in.
- **Dynamic Detail Screen (`lib/screens/details_screen.dart`)**:
  - Displays a large header featuring the selected item's icon, title, and short description mapped on a matching vibrant gradient background.
  - Clean card structure grouping the detailed description and metadata table (Category, Highlight, Design Style).
  - Back-navigation via the app bar and a dedicated "Back to Home" button.
- **Hero & Custom Transitions**:
  - Smooth `Hero` animations matching the icon from the list item card directly to the detail header.
  - Custom page slide/fade route transitions.
- **Material 3 Theme System (`lib/core/theme.dart`)**:
  - Custom color palette built using a Slate and primary blue color scheme.
  - Modern typography hierarchy and customized cards, shapes, and scaffold background styles.

---

## 📂 Project Structure

```text
lib/
├── core/
│   └── theme.dart          # App design tokens, styles, and typography
├── data/
│   └── sample_data.dart    # Hardcoded local data items list
├── models/
│   └── item_model.dart     # Immutable item model definition
├── screens/
│   ├── splash_screen.dart  # Opening screen with loading indicator and scale animations
│   ├── home_screen.dart    # Main screen showing header card and interactive items list
│   └── details_screen.dart # Detail screen displaying rich info about selected items
├── widgets/
│   └── item_card.dart      # Reusable styled item card widget with Hero animations
└── main.dart               # Entry point of the application
```

---

## 🛠️ File & Code Reference Guide

- **[lib/main.dart](file:///d:/Flutter%20Projects/yusry/lib/main.dart)**: Boots the app, registers the theme system, and launches the splash screen.
- **[lib/core/theme.dart](file:///d:/Flutter%20Projects/yusry/lib/core/theme.dart)**: Contains the light mode `ThemeData` setup with customized font styles, colors, and global widget styles.
- **[lib/models/item_model.dart](file:///d:/Flutter%20Projects/yusry/lib/models/item_model.dart)**: Defines the structured `ItemModel` representing each item (including `id`, `title`, `shortDescription`, `description`, `icon`, `accentColor`, `category`, and `highlight`).
- **[lib/data/sample_data.dart](file:///d:/Flutter%20Projects/yusry/lib/data/sample_data.dart)**: Contains 5 pre-configured high-quality items representing common tasks in project lifecycles (Strategy, UI/UX, Build, Testing, Delivery).
- **[lib/screens/splash_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/splash_screen.dart)**: A visual loading screen that transitions smoothly to the home page.
- **[lib/screens/home_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/home_screen.dart)**: The main hub screen showing the header banner and items list.
- **[lib/screens/details_screen.dart](file:///d:/Flutter%20Projects/yusry/lib/screens/details_screen.dart)**: Shows deep-dive details, descriptions, and highlights of a selected list item.
- **[lib/widgets/item_card.dart](file:///d:/Flutter%20Projects/yusry/lib/widgets/item_card.dart)**: The component that renders an item block on the list, complete with ripple effects, rounded borders, custom colored icon boxes, and arrow indicators.

---

## 🚀 How to Run the App

1. **Prerequisites**: Make sure Flutter SDK is installed and set up in your environment path.
2. **Get Dependencies**: Run `flutter pub get` from the project root directory.
3. **Select a Target/Device**:
   - Run on Chrome or Edge browser (web-app):
     ```bash
     flutter run -d chrome
     ```
   - Run on a connected emulator or physical mobile device:
     ```bash
     flutter run
     ```
