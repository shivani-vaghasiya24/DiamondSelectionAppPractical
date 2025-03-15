import 'package:diamond_selection_app/helper/data.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  DiamondBloc() : super(DiamondLoading()) {
    on<LoadDiamonds>(_onLoadDiamonds);
    on<SearchDiamonds>(_onSearchDiamonds);
    on<FilterDiamonds>(_onFilterDiamonds);
    on<SortDiamonds>(_onSortDiamonds);
  }
  List<Diamond> filteredDiamonds = [];
  void _onLoadDiamonds(LoadDiamonds event, Emitter<DiamondState> emit) {
    try {
      emit(DiamondLoading());
      final diamonds = DiamondData.getDiamonds();
      emit(DiamondLoaded(diamonds: diamonds));
    } catch (e) {
      emit(DiamondError("Failed to load diamonds"));
    }
  }

  void _onSearchDiamonds(SearchDiamonds event, Emitter<DiamondState> emit) {
    final currentState = state;
    if (currentState is DiamondLoaded) {
      final filtered = currentState.diamonds.where((diamond) {
        return diamond.lotId.contains(event.query) ||
            diamond.shape.toLowerCase().contains(event.query.toLowerCase()) ||
            diamond.color.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      emit(DiamondLoaded(diamonds: filtered));
    }
  }

  void _onFilterDiamonds(FilterDiamonds event, Emitter<DiamondState> emit) {
    final allDiamonds = DiamondData.getDiamonds();
    filteredDiamonds = allDiamonds.where((diamond) {
      return (event.minCarat == null || diamond.carat >= event.minCarat!) &&
          (event.maxCarat == null || diamond.carat <= event.maxCarat!) &&
          (event.lab == null || diamond.lab == event.lab) &&
          (event.shape == null || diamond.shape == event.shape) &&
          (event.color == null || diamond.color == event.color) &&
          (event.clarity == null || diamond.clarity == event.clarity);
    }).toList();

    emit(DiamondLoaded(diamonds: filteredDiamonds));
  }

  void _onSortDiamonds(SortDiamonds event, Emitter<DiamondState> emit) {
    if (state is DiamondLoaded) {
      List<Diamond> sortedDiamonds =
          List.from((state as DiamondLoaded).diamonds);

      switch (event.sortOption) {
        case SortOption.priceAsc:
          sortedDiamonds.sort((a, b) => a.finalAmount.compareTo(b.finalAmount));
          break;
        case SortOption.priceDesc:
          sortedDiamonds.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
          break;
        case SortOption.caratAsc:
          sortedDiamonds.sort((a, b) => a.carat.compareTo(b.carat));
          break;
        case SortOption.caratDesc:
          sortedDiamonds.sort((a, b) => b.carat.compareTo(a.carat));
          break;
        case SortOption.none:
          sortedDiamonds = filteredDiamonds;
          break;
      }

      emit(DiamondLoaded(
          diamonds: sortedDiamonds, sortOption: event.sortOption));
    }
  }
}
