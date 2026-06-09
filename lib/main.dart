import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/controller/person_controller.dart';
import 'package:flutter_hive_type_adpter/controller/theme_controller.dart';
import 'package:flutter_hive_type_adpter/person_hive.dart';
import 'package:flutter_hive_type_adpter/routes/router.dart';
import 'package:flutter_hive_type_adpter/routes/routes.dart';
import 'package:flutter_hive_type_adpter/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  
    WidgetsFlutterBinding.ensureInitialized();//SHeredPreferences com provider, e também serve para hive tmb.

    await Hive.initFlutter();
    Hive.registerAdapter(personHiveAdapter());
    await Hive.openBox<personHive>('usuarios');
    final box = Hive.box<personHive>('usuarios');
    print('Quantidade de registros: ${box.length}');
    print(box.toMap());
    


   final prefsProvider = ThemeController(sharedPreferences: await SharedPreferences.getInstance(),);//SHeredPreferences com provider
   await prefsProvider.getTheme();//SHeredPreferences com provider
   
  runApp(
     MultiProvider(
      providers: [ 
    ChangeNotifierProvider(//Provider
      create: (_) => PersonController(),),
      ChangeNotifierProvider(
        create: (_)  =>prefsProvider),],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final themeController = GetIt.instance<ThemeController>();

  @override
  void initState() {//Criado para inicializar o getTheme do theme_controller para pegar o tema salvo.
    super.initState();
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     final themeProvider = context.watch<ThemeController>();
    return  MaterialApp(
        initialRoute: Routes.initialRoute,
        routes: routes,
        title: 'Flutter Demo',
         themeMode: ThemeMode.light,
         theme:  themeProvider.darkTheme == false ? lightTheme : darkTheme,
        //  theme: lightTheme,
        
      );
      }
    
  }




