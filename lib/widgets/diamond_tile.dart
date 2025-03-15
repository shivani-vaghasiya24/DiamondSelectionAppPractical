import 'package:diamond_selection_app/module/cart/bloc/cart_bloc.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_event.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_state.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:diamond_selection_app/widgets/custom_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiamondTile extends StatelessWidget {
  final Diamond diamond;
  final int index;
  final bool isFromFilter;

  const DiamondTile(
      {Key? key,
      required this.diamond,
      required this.index,
      this.isFromFilter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Text("$index."),
        titleAlignment: isFromFilter
            ? ListTileTitleAlignment.top
            : ListTileTitleAlignment.center,
        minLeadingWidth: 15,
        title: CustomTextRow(
            isFromFilter: true, title: "Lot ID:", value: diamond.lotId),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextRow(
                isFromFilter: true,
                title: "Carat - Color:",
                value:
                    "${diamond.carat} Ct - ${diamond.color.isNotEmpty ? diamond.color : 'N/A'}"),
            if (isFromFilter)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Shape - Size:",
                      value: "${diamond.shape} - ${diamond.size} mm"),
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Lab - Clarity:",
                      value: "${diamond.lab} - ${diamond.clarity}"),
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Cut - Polish:",
                      value: "${diamond.cut} - ${diamond.polish}"),
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Symmetry - Fluorescence:",
                      value: "${diamond.symmetry} - ${diamond.fluorescence}"),
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Discount - Rate:",
                      value:
                          "(${diamond.discount}%) - (\$${diamond.perCaratRate})"),
                  CustomTextRow(
                      isFromFilter: true,
                      title: "Final Price:",
                      value: "\$${diamond.finalAmount.toStringAsFixed(2)}"),
                  if (diamond.labComment.isNotEmpty)
                    CustomTextRow(
                        isFromFilter: true,
                        title: "Lab Comment:",
                        value: diamond.labComment),
                  if (diamond.keyToSymbol.isNotEmpty)
                    CustomTextRow(
                        isFromFilter: true,
                        title: "Key To Symbol:",
                        value: diamond.keyToSymbol),
                  // Text(
                  //     "Shape: ${diamond.shape.isNotEmpty ? diamond.shape : "N/A"} - Size: ${diamond.size} mm"),
                  // Text("Lab: ${diamond.lab} - Clarity: ${diamond.clarity}"),
                  // Text("Cut: ${diamond.cut} - Polish: ${diamond.polish}"),
                  // Text(
                  //     "Symmetry: ${diamond.symmetry} - Fluorescence: ${diamond.fluorescence}"),
                  // Text(
                  //     "Discount: ${diamond.discount}% - Per Carat Rate: '\$${diamond.perCaratRate}'"),
                  // Text(
                  //     "Lab Comment: ${diamond.labComment} - Key To Symbol: '${diamond.keyToSymbol}'"),
                ],
              )
          ],
        ),
        trailing: Column(
          mainAxisAlignment:
              isFromFilter ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: isFromFilter
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text("\$${diamond.finalAmount.toStringAsFixed(2)}"),
            if (isFromFilter)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${diamond.carat} Ct"),
                    BlocBuilder<CartBloc, CartState>(
                      // buildWhen: (previous, current) => current is CartLoaded,
                      builder: (context, state) {
                        bool isInCart = state is CartLoaded &&
                            state.cartItems
                                .any((d) => d.lotId == diamond.lotId);

                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            isInCart
                                ? Icons.remove_shopping_cart
                                : Icons.add_shopping_cart,
                          ),
                          color: isInCart ? Colors.red : Colors.green,
                          onPressed: () {
                            if (isInCart) {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveFromCart(diamond.lotId));
                            } else {
                              context.read<CartBloc>().add(AddToCart(diamond));
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
