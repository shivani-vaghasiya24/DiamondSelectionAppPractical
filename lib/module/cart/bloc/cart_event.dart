import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Diamond diamond;
  AddToCart(this.diamond);
}

class RemoveFromCart extends CartEvent {
  final String lotId;
  RemoveFromCart(this.lotId);
}
