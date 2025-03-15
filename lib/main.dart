import 'dart:convert';
import 'dart:developer';

import 'package:diamond_selection_app/helper/local_excel_loader.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_bloc.dart';
import 'package:diamond_selection_app/module/cart/bloc/cart_event.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_bloc.dart';
import 'package:diamond_selection_app/module/diamond/bloc/diamond_event.dart';
import 'package:diamond_selection_app/module/diamond/model/diamond_model.dart';
import 'package:diamond_selection_app/module/diamond/view/home_page.dart';
import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:diamond_selection_app/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(DiamondAdapter());
  await Hive.openBox<Diamond>('cartBox');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => DiamondBloc()..add(LoadDiamonds()),
      ),
      BlocProvider(
        create: (context) => CartBloc()..add(LoadCart()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
          fontFamily: "Roboto",
          useMaterial3: false,
          primaryColor: AppColors.primaryColor),
      home: HomePage(),
    );
  }
}
