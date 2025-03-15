import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:diamond_selection_app/widgets/custom_text_row.dart';
import 'package:flutter/material.dart';

class DiamondDetailPage extends StatelessWidget {
  final Diamond diamond;

  const DiamondDetailPage({Key? key, required this.diamond}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diamond Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextRow(
              value: diamond.lotId,
              title: 'Lot ID: ',
            ),
            SizedBox(height: 8),
            CustomTextRow(
              value: "${diamond.size} mm",
              title: 'Size: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: "${diamond.carat}",
              title: 'Carat: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.lab,
              title: 'Lab: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.shape,
              title: 'Shape: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.color,
              title: 'Color: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.clarity,
              title: 'Clarity: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.cut,
              title: 'Cut: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.polish,
              title: 'Polish: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.symmetry,
              title: 'Symmetry: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.fluorescence,
              title: 'Fluorescence: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: "${diamond.discount}%",
              title: 'Discount: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: "\$${diamond.perCaratRate}",
              title: 'Per Carat Rate: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: "\$${diamond.finalAmount}",
              title: 'Final Amount: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.keyToSymbol,
              title: 'Key To Symbol: ',
              isMainRow: false,
            ),
            SizedBox(height: 2),
            CustomTextRow(
              value: diamond.labComment,
              title: 'Lab Comment: ',
              isMainRow: false,
            ),
          ],
        ),
      ),
    );
  }
}
