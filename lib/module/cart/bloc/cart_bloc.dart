import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_event.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_state.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:hive/hive.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  static const String cartBoxName = "cartBox"; // Hive storage key

  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final box = await Hive.openBox<Diamond>(cartBoxName);
      final cartItems = box.values.toList().reversed.toList();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError("Failed to load cart"));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = List<Diamond>.from(currentState.cartItems)
        ..insert(0, event.diamond);

      final box = await Hive.openBox<Diamond>(cartBoxName);
      await box.put(event.diamond.lotId, event.diamond);
      add(LoadCart());
      // emit(CartLoaded(updatedCart));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = List<Diamond>.from(currentState.cartItems)
        ..removeWhere((d) => d.lotId == event.lotId);

      final box = await Hive.openBox<Diamond>(cartBoxName);
      await box.delete(event.lotId);
      add(LoadCart());
      // emit(CartLoaded(updatedCart));
    }
  }
}
