# 💎 Diamond Selection App

A **Flutter app** for selecting diamonds with filtering, sorting, and cart management features. Uses **BLoC for state management** and **Hive for persistent storage**.

---

## 📁 Project Structure

lib/
│── main.dart                     # Entry point
│
│── helper                        # Diamond data
│   ├── data.dart
│
├── module/diamond/               # Diamond Module
│   ├── bloc/                     # Diamond BLoC (State Management)
│   │   ├── diamond_bloc.dart
│   │   ├── diamond_event.dart
│   │   ├── diamond_state.dart
│   ├── model/                     # Diamond Model
│   │   ├── diamond_model.dart
│   ├── ui/                        # Diamond UI Screens
│       ├── home_page.dart
│       ├── filter_page.dart
│       ├── result_page.dart
│
├── module/cart/                   # Cart Module
│   ├── bloc/                      # Cart BLoC (State Management)
│   │   ├── cart_bloc.dart
│   │   ├── cart_event.dart
│   │   ├── cart_state.dart
│   ├── ui/                         # Cart UI Screens
│       ├── cart_page.dart
│
├── utils/                         # Utilities (Constants, Colors, Strings, Assets, )
│   ├── app_colors.dart
│   ├── app_strings.dart
│   ├── app_styles.dart
│   ├── app_assets.dart
│
├── widgets/                       # Reusable UI Components
│   ├── custom_text_row.dart
│   ├── diamond_tile.dart
│   ├── no_data_widget.dart


---

## 🏗️ State Management (BLoC)

The app uses **BLoC (Business Logic Component)** to manage UI state.

### 1️⃣ **Diamond BLoC (Fetching & Filtering Diamonds)**  
Located in `module/diamond/bloc/`
- **Events:**
  - `LoadDiamonds` → Loads all diamonds
  - `FilterDiamonds` → Filters diamonds based on user input
  - `SortDiamonds` → Sorts diamonds by price or carat
- **State:**
  - `DiamondLoading` → Shows loading indicator
  - `DiamondLoaded` → Displays diamonds on UI
  - `DiamondError` → Handles errors

### 2️⃣ **Cart BLoC (Managing Cart Items)**
Located in `module/cart/bloc/`
- **Events:**
  - `LoadCart` → Loads stored cart items
  - `AddToCart` → Adds a diamond to the cart
  - `RemoveFromCart` → Removes a diamond from the cart
- **State:**
  - `CartLoading` → Shows loading indicator
  - `CartLoaded` → Displays cart items
  - `CartError` → Handles errors

✅ **Cart updates UI in real-time** by listening to BLoC state changes.

---

## 💾 Persistent Storage (Hive)

**Hive** is used for storing cart items locally.

### **How it Works**
- **Storage Box Name:** `"cartBox"`
- **Stored Data:** List of `Diamond` objects
- **Location:** `cart_bloc.dart`

### **Hive Storage Logic**
- **Location:** `cart_bloc.dart`
