import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/home_page.dart';
import 'package:flutter_hive_type_adpter/register.dart';
import 'package:flutter_hive_type_adpter/routes/routes.dart';



Map<String, WidgetBuilder> routes = {
  Routes.initialRoute: (BuildContext context) => MyWidget(), 
  Routes.register: (BuildContext context) => Register(person: null,), 

  //  Routes.register: (BuildContext context) {//Http put
  //   final params =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //   final person = params?["person"] as Person?;
  //   return Register(
  //     person: person,
  //   );
  // },

};