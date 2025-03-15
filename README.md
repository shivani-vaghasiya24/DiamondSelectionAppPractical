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
