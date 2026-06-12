# 🏆 Flutter Freelance Tasks — Premium UI Collection

![Flutter Version](https://img.shields.io/badge/Flutter-v3.x-02569B?logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-v3.x-0175C2?logo=dart)
![Material Design](https://img.shields.io/badge/Material-Design_3-6750A4?logo=material-design)
![Null Safety](https://img.shields.io/badge/Null_Safety-✅-success)
![Lint](https://img.shields.io/badge/flutter_analyze-No_Issues-brightgreen)

A collection of **production-quality Flutter UI tasks** demonstrating advanced UI/UX development skills — modern design trends, smooth animations, clean architecture, and Material Design 3.

---

## 📦 Task List

| # | Task | Screen | Design Style |
|---|---|---|---|
| 1 | Sport Zone — E-commerce Product Details | `details_screen.dart` | Glassmorphism · RTL Arabic |
| 2 | HomeServe — Home Services Login Screen | `login_screen.dart` | Material 3 · Light/Dark |

---

## 🏠 Task 2 — HomeServe: Home Services Login Screen

![Flutter Version](https://img.shields.io/badge/Flutter-v3.x-02569B?logo=flutter)
![Material Design 3](https://img.shields.io/badge/Material-Design_3-6750A4)
![Light & Dark](https://img.shields.io/badge/Theme-Light_%26_Dark-orange)
![Google Fonts](https://img.shields.io/badge/Font-Inter_(Google_Fonts)-blue)

A fully production-ready **Login Screen UI** for a Home Services mobile application. Built to look and feel like a real commercial app available on the Google Play Store and App Store — no backend, no Firebase, pure Flutter UI excellence.

### ✨ Key Features

- **🎬 Staggered Entrance Animations** — 4-phase sequence: logo (elastic bounce) → heading (slide up) → form card (slide up) → footer (fade in), all driven by a single `AnimationController` with `Interval` curves
- **🌗 Full Light & Dark Mode** — `ThemeMode.system` auto-switches; every color token adapts via dedicated light/dark palettes
- **✅ Real Form Validation** — Email regex check + password minimum length, with animated error display
- **👁️ Password Show/Hide Toggle** — `AnimatedSwitcher` with scale transition + haptic feedback (`HapticFeedback.selectionClick`)
- **⏳ Loading State Button** — `CircularProgressIndicator` replaces label text with `AnimatedSwitcher`, button disables during async
- **⌨️ Keyboard Dismiss** — Full-screen `GestureDetector` with `FocusScope.of(context).unfocus()`
- **🎨 Gradient Text Logo** — "HomeServe" app name rendered via `ShaderMask` with brand gradient
- **💎 Gradient Border Button** — "Create Account" uses a 1.5px gradient-stroke border via nested containers
- **🔘 Press Scale Animations** — Both buttons shrink to 0.95× on tap via `AnimationController`
- **📐 MediaQuery Responsive** — All spacing uses `size.height * factor` for any screen size
- **🔒 Portrait Mode Lock** — `SystemChrome.setPreferredOrientations` for consistent mobile UX
- **🎖️ Trust Badges** — Verified Pros / Insured / 4.9 Rated row in the footer
- **🚦 Status Bar Aware** — `AnnotatedRegion<SystemUiOverlayStyle>` adapts icon brightness to theme

### 🧩 Architecture

```text
lib/
├── main.dart                        ← Entry point, theme config, portrait lock
├── screens/
│   └── login_screen.dart            ← Complete login UI (653 lines)
├── widgets/
│   ├── custom_text_field.dart       ← Animated text input with focus scale
│   ├── primary_button.dart          ← Gradient button + loading state
│   └── secondary_button.dart        ← Gradient-bordered outlined button
└── constants/
    ├── app_colors.dart              ← Full brand palette + gradient definitions
    └── app_styles.dart              ← Typography (Inter), shadows, Material 3 themes

assets/
└── images/
    └── home_services_logo.png       ← Professional AI-generated logo
```

### 🎨 Design System

**Brand Gradient:** `#1565C0` (Deep Blue) → `#00ACC1` (Teal)

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#1565C0` | Buttons, focus rings, links |
| `accent` | `#00ACC1` | Gradient endpoint, badges |
| `backgroundLight` | `#F8FAFF` | Light mode screen |
| `backgroundDark` | `#0A1628` | Dark mode screen |
| `surfaceDark` | `#112240` | Dark mode cards & inputs |
| `error` | `#E53935` | Validation error messages |
| `success` | `#2ECC71` | Login success snackbar |

**Typography:** [Inter](https://fonts.google.com/specimen/Inter) via `google_fonts` — weights 400 / 500 / 600 / 700 / 800 / 900

### 📱 UI Preview

**Light Mode**
- Soft blue-green gradient background `#F0F4FF → #E8F5E9`
- White glassmorphism card with blue drop shadow
- Gradient Login button with `#1565C0` glow shadow
- Gradient-bordered Create Account button

**Dark Mode**
- Deep navy background `#0A1628 → #0D1F3C`
- `#112240` card with `#1E3A5F` border
- All text adapts: `#E8EDF5` primary / `#8BA3C7` secondary

### 🚀 Getting Started

**Prerequisites**
- Flutter SDK ≥ 3.10.1
- Dart SDK (bundled with Flutter)
- Android Studio / VS Code with Flutter & Dart plugins
- A connected Android/iOS device or emulator

**Run the Login Screen**

```bash
# 1. Install dependencies
flutter pub get

# 2. Run in debug mode
flutter run

# 3. Run on a specific device
flutter devices           # list available devices
flutter run -d <device-id>
```

**Build APK**

```bash
# Debug APK (no signing required)
flutter build apk --debug

# Release APK (optimized)
flutter build apk --release

# Split by ABI (smaller file sizes for Play Store)
flutter build apk --split-per-abi --release

# App Bundle (recommended for Google Play)
flutter build appbundle --release
```

> Output: `build/app/outputs/flutter-apk/app-release.apk`

### 🛠️ Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| Flutter | ≥ 3.10.1 | UI framework |
| Dart | ≥ 3.10.1 | Language (Null Safety) |
| Material Design | 3 | Design system |
| `google_fonts` | ^6.2.1 | Inter font family |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

**Code Quality**
- ✅ `flutter analyze` — **No issues found**
- ✅ 100% Null Safety
- ✅ No deprecated Flutter APIs
- ✅ Consistent naming conventions
- ✅ Full documentation comments on every class and method

---

---

## 🏆 Task 1 — Sport Zone: Premium E-commerce Product Details

![RTL Support](https://img.shields.io/badge/RTL-Arabic_First-success)
![UI](https://img.shields.io/badge/UI-Glassmorphism-FF6B35)

A highly polished, production-ready **Product Details Screen** for a premium sports e-commerce mobile application called **"Sport Zone"**. Built to demonstrate advanced UI/UX development skills in Flutter, featuring modern design trends, smooth animations, and a clean, modular architecture.

### ✨ Key Features

- **🇸🇦 RTL First (Arabic):** Natively built to support Right-To-Left layouts using `Directionality` wrappers
- **🧊 Glassmorphism Design:** Modern translucent UI elements with soft shadows and `BackdropFilter` blurs
- **🎨 Premium Brand Identity:** Deep sports blue (`#1A365D`) and vibrant orange (`#FF6B35`)
- **📱 Responsive Layout:** `SafeArea` + `SingleChildScrollView` for all screen sizes
- **🎭 Smooth Animations:** Scale animations, `AnimatedSwitcher` for price, Hero image, `InteractiveViewer` zoom, haptic feedback

### 🧩 Architecture

```text
lib/
├── screens/
│   └── details_screen.dart           # Main assembled screen
├── widgets/
│   ├── custom_app_bar.dart           # Floating translucent app bar
│   ├── product_image_carousel.dart   # Interactive product gallery
│   ├── product_info_section.dart     # Titles, ratings, and price
│   ├── size_selector.dart            # Animated chips for sizes/flavors
│   ├── quantity_selector.dart        # +/- counter
│   ├── product_description.dart      # Expandable text & specs
│   ├── benefits_section.dart         # Glassmorphic trust cards
│   ├── reviews_section.dart          # Rating distribution bars
│   ├── related_products_section.dart # Horizontal cross-sell carousel
│   └── bottom_purchase_bar.dart      # Sticky animated checkout CTA
├── theme/
│   └── theme.dart                    # Material 3 Custom ThemeData
├── constants/
│   └── colors.dart                   # Global brand colors
└── models/
    └── product_model.dart            # Data architecture
```

---

## 🛠️ Shared Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart (Null Safety)
- **State Management:** Core Flutter (`setState`, `ValueNotifier`, `AnimationController`)
- **Design:** Material Design 3
- **Code Quality:** `flutter analyze` — No issues, strict typing, full Null Safety

---

*Built with ❤️ for premium mobile experiences.*
