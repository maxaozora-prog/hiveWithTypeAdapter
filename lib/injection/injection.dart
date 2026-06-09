// import 'package:get_it/get_it.dart';
// import 'package:purobaido/controller/person_controller.dart';
// import 'package:purobaido/controller/theme_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// Future<void> injector() async { //Com o sharedPreferences.
//   final i = GetIt.instance;


//   i.registerSingleton<PersonController>(PersonController());

  
//  i.registerSingleton<ThemeController>(ThemeController(
//      sharedPreferences: await SharedPreferences.getInstance(),
//     // sharedPreferences: i(),//Codigo aderido na aula de ajuste de injeção de dependencia.
//   ));



// }