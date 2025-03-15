import 'package:equatable/equatable.dart';

enum SortOption { none, priceAsc, priceDesc, caratAsc, caratDesc }

abstract class DiamondEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDiamonds extends DiamondEvent {}

class SearchDiamonds extends DiamondEvent {
  final String query;

  SearchDiamonds(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterDiamonds extends DiamondEvent {
  final double? minCarat;
  final double? maxCarat;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;

  FilterDiamonds(
      {this.minCarat,
      this.maxCarat,
      this.lab,
      this.shape,
      this.color,
      this.clarity});

  @override
  List<Object?> get props => [minCarat, maxCarat, lab, shape, color, clarity];
}

class SortDiamonds extends DiamondEvent {
  final SortOption sortOption;

  SortDiamonds(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}
