import 'package:diamond_selection_app/module/cart/bloc/cart_event.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_state.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/widgets/custom_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return Center(child: Text(AppStrings.yourCartIsEmpty));
            }

            double totalCarat = cartItems.fold(0, (sum, d) => sum + d.carat);
            double totalPrice =
                cartItems.fold(0, (sum, d) => sum + d.finalAmount);
            double avgPrice =
                cartItems.isNotEmpty ? totalPrice / cartItems.length : 0;
            double avgDiscount = cartItems.isNotEmpty
                ? cartItems.fold(0.0, (sum, d) => sum + d.discount) /
                    cartItems.length
                : 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final diamond = cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: Text("${index + 1}."),
                          minLeadingWidth: 15,
                          title: Text("Lot ID: ${diamond.lotId}"),
                          subtitle: Text(
                              "Carat: ${diamond.carat} Ct | \$${diamond.finalAmount}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveFromCart(diamond.lotId));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Summary :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextRow(
                          title: "Total Carat: ",
                          value: "${totalCarat.toStringAsFixed(2)} Ct"),
                      CustomTextRow(
                          title: "Total Price: ",
                          value: "\$${totalPrice.toStringAsFixed(2)}"),
                      CustomTextRow(
                          title: "Avg Price: ",
                          value: "\$${avgPrice.toStringAsFixed(2)}"),
                      CustomTextRow(
                          title: "Avg Discount: ",
                          value: "${avgDiscount.toStringAsFixed(2)}%"),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
