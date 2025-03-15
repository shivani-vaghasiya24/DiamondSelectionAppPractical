import 'package:diamond_selection_app/module/cart/view/cart_page.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_bloc.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'result_page.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double? _minCarat, _maxCarat;
  String? _lab, _shape, _color, _clarity;

  final TextEditingController _minCaratController = TextEditingController();
  final TextEditingController _maxCaratController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<DiamondBloc>().add(LoadDiamonds());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.addFilterDiamonds),
          actions: [
            IconButton(
              padding: EdgeInsets.all(4),
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
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _minCaratController,
                decoration: InputDecoration(labelText: "Min Carat"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _maxCaratController,
                decoration: InputDecoration(labelText: "Max Carat"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: _lab,
                items: ["GIA", "IGI", "HRD"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _lab = value),
                decoration: InputDecoration(labelText: "Lab"),
              ),
              DropdownButtonFormField<String>(
                value: _shape,
                items: ["BR", "PR", "OV"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _shape = value),
                decoration: InputDecoration(labelText: "Shape"),
              ),
              DropdownButtonFormField<String>(
                value: _color,
                items: ["D", "E", "F", "G", "H"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _color = value),
                decoration: InputDecoration(labelText: "Color"),
              ),
              DropdownButtonFormField<String>(
                value: _clarity,
                items: ["VVS1", "VVS2", "VS1", "VS2"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _clarity = value),
                decoration: InputDecoration(labelText: "Clarity"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<DiamondBloc>().add(FilterDiamonds(
                        minCarat: _minCaratController.text.isNotEmpty
                            ? double.parse(_minCaratController.text)
                            : null,
                        maxCarat: _maxCaratController.text.isNotEmpty
                            ? double.parse(_maxCaratController.text)
                            : null,
                        lab: _lab,
                        shape: _shape,
                        color: _color,
                        clarity: _clarity,
                      ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultPage()),
                  );
                },
                child: Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
