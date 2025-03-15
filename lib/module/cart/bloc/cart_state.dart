import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Diamond> cartItems;
  CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
