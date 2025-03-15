import 'package:diamond_selection_app/module/cart/bloc/cart_bloc.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_state.dart';
import 'package:diamond_selection_app/module/cart/view/cart_page.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_bloc.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_state.dart';
import 'package:diamond_selection_app/utils/app_colors.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/widgets/diamond_tile.dart';
import 'package:diamond_selection_app/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.filterDiamonds),
            Row(
              children: [
                BlocBuilder<DiamondBloc, DiamondState>(
                  builder: (context, state) {
                    if (state is DiamondLoaded) {
                      return DropdownButton<SortOption>(
                        value: state.sortOption,
                        dropdownColor: AppColors.textColor,
                        underline: SizedBox(),
                        iconEnabledColor: AppColors.secondaryColor,
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 16), // White text
                        onChanged: (newSortOption) {
                          if (newSortOption != null) {
                            context
                                .read<DiamondBloc>()
                                .add(SortDiamonds(newSortOption));
                          }
                        },
                        items: [
                          DropdownMenuItem(
                              value: SortOption.none, child: Text("Sort")),
                          DropdownMenuItem(
                              value: SortOption.priceAsc, child: Text("💲 ↑")),
                          DropdownMenuItem(
                              value: SortOption.priceDesc, child: Text("💲 ↓")),
                          DropdownMenuItem(
                              value: SortOption.caratAsc, child: Text("Ct ↑")),
                          DropdownMenuItem(
                              value: SortOption.caratDesc, child: Text("Ct ↓")),
                          // DropdownMenuItem(
                          //     value: SortOption.none, child: Text("none")),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(
                  width: 3,
                ),
                IconButton(
                  padding: EdgeInsets.all(2),
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocBuilder<DiamondBloc, DiamondState>(
        builder: (context, state) {
          if (state is DiamondLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DiamondLoaded) {
            return state.diamonds.isNotEmpty
                ? ListView.builder(
                    itemCount: state.diamonds.length,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      return DiamondTile(
                        diamond: state.diamonds[index],
                        index: index + 1,
                        isFromFilter: true,
                      );
                    },
                  )
                : NoDataWidget();
          } else {
            return Center(child: Text("No diamonds found"));
          }
        },
      ),
    );
  }
}
