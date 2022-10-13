import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsuqo/pages/add_product.dart';
import 'package:nsuqo/pages/all_categories.dart';
import 'package:nsuqo/pages/chat_page.dart';
import 'package:nsuqo/pages/filter_by.dart';
import 'package:nsuqo/pages/home_page_categories.dart';
import 'package:nsuqo/pages/home_page_products.dart';
import 'package:nsuqo/pages/home_retailer.dart';
import 'package:nsuqo/pages/messanger.dart';
import 'package:nsuqo/pages/places_picker_ai.dart';
import 'package:nsuqo/pages/product_information.dart';
import 'package:nsuqo/pages/search_page.dart';
import 'package:nsuqo/pages/sign_in.dart';
import 'package:nsuqo/pages/single_category.dart';
import 'package:nsuqo/pages/sub_categories.dart';
import 'package:nsuqo/pages/wholesaler_home.dart';
import 'package:nsuqo/pages/wholesalerinfo.dart';
import 'package:nsuqo/pages/wholesalers.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope ( child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),

      home: const Sign_In(),

    );
  }
}




