import 'package:diamond_selection_app/module/cart/bloc/cart_bloc.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_state.dart';
import 'package:diamond_selection_app/module/cart/view/cart_page.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_bloc.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_state.dart';
import 'package:diamond_selection_app/module/diamond/view/diamond_detail_page.dart';
import 'package:diamond_selection_app/module/diamond/view/filter_page.dart';
import 'package:diamond_selection_app/utils/app_colors.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:diamond_selection_app/widgets/diamond_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.diamondSelecton),
        actions: [
          IconButton(
            padding: EdgeInsets.all(4),
            constraints: BoxConstraints(),
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int cartItemCount = 0;
              if (state is CartLoaded) {
                cartItemCount = state.cartItems.length;
              }

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    padding: EdgeInsets.only(top: 10),
                    // constraints: BoxConstraints(),
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                  ),
                  if (cartItemCount > 0) // Show dot only if items exist in cart
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cartItemCount.toString()}",
                          style: AppStyles.textStyle12.copyWith(
                              color: AppColors.secondaryColor, fontSize: 10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: "Search by Lot ID, Shape, or Color",
          //       border: OutlineInputBorder(),
          //       suffixIcon: Icon(Icons.search),
          //     ),
          //     onChanged: (query) {
          //       context.read<DiamondBloc>().add(SearchDiamonds(query));
          //     },
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<DiamondBloc, DiamondState>(
              builder: (context, state) {
                if (state is DiamondLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DiamondLoaded) {
                  return ListView.builder(
                    itemCount: state.diamonds.length,
                    padding: EdgeInsets.only(top: 8),
                    itemBuilder: (context, index) {
                      final diamond = state.diamonds[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DiamondDetailPage(
                                diamond: diamond,
                              ),
                            ),
                          );
                        },
                        child: DiamondTile(
                          diamond: diamond,
                          index: index + 1,
                        ),
                      );
                    },
                  );
                } else if (state is DiamondError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text("No Diamonds Found"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
