import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menu_items/providers/item_notifier.dart';
import 'package:menu_items/routes.dart';
import 'package:menu_items/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemNotifier()..getAllData(),
      child: MaterialApp(
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
