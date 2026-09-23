# key_value_table_demo

A showcase and screenshot companion app for the [`key_value_table`](https://pub.dev/packages/key_value_table) Flutter package.

---

## Features

- **Light & Dark Theme Toggle:** Easily toggle between light and dark Material 3 themes directly from the AppBar.
- **Adaptive Responsive Layout:**
  - **Wide screens (> 860px):** 2-column side-by-side grid.
  - **Mobile screens (≤ 860px):** Single-column scrollable feed.
- **Showcase Cards:**
  1. **Physician Profile Card:** Automatic intrinsic column alignment with varying key lengths and colon separators.
  2. **Order Summary Card:** Custom rich widgets including badges, status chips, and payment method rows.
  3. **Server Diagnostics Card:** Zebra-striping (`alternateRowColor`), custom arrow separators (`→`), and interactive `onRowTap` with clipboard copy and floating `SnackBar`.
  4. **App Specifications Card:** Custom `TableBorder` dividers and custom separator character (`::`) with custom styling.

---

## Getting Started

### Prerequisites

Ensure Flutter is installed and set up on your machine:

```bash
flutter --version
```

### Install Dependencies

```bash
flutter pub get
```

### Run Across Platforms

```bash
# Web
flutter run -d chrome

# Desktop (Linux / macOS / Windows)
flutter run -d linux

# Mobile (Android / iOS)
flutter run -d <device-id>
```

### Run Tests

```bash
flutter test
```
