import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:equatable/equatable.dart';

abstract class DiamondState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiamondLoading extends DiamondState {}

class DiamondLoaded extends DiamondState {
  final List<Diamond> diamonds;
  final SortOption sortOption;

  DiamondLoaded({required this.diamonds, this.sortOption = SortOption.none});

  @override
  List<Object?> get props => [diamonds];
}

class DiamondError extends DiamondState {
  final String message;

  DiamondError(this.message);

  @override
  List<Object?> get props => [message];
}
