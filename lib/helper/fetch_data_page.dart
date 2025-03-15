import 'dart:convert';
import 'dart:developer';

import 'package:diamond_selection_app/helper/local_excel_loader.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:diamond_selection_app/utils/app_colors.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FetchDataPage extends StatefulWidget {
  const FetchDataPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FetchDataPage> createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  List<Diamond> diamonds = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var data = await LocalExcelLoader.loadExcelData();
    setState(() {
      diamonds = data.map((map) => Diamond.fromMap(map)).toList();
      // Convert list of Diamonds to JSON
      String jsonString =
          jsonEncode(diamonds.map((diamond) => diamond.toJson()).toList());
      log("Diamods Data $jsonString");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the FetchDataPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            AppStrings.appName,
            style: AppStyles.textStyle16.copyWith(
              color: AppColors.primaryColor,
            ),
          )),
      body: diamonds.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: diamonds.length,
              itemBuilder: (context, index) {
                var diamond = diamonds[index];
                return ListTile(
                  title: Text("Lot ID: ${diamond.lotId}"),
                  subtitle:
                      Text("Carat: ${diamond.carat} - Color: ${diamond.color}"),
                );
              },
            ),
    );
  }
}
