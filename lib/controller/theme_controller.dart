import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/message_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  bool darkTheme = false;
  ValueNotifier<MessagesStates> mensagemNotifier =ValueNotifier(IddleMessage());

  ThemeController({//Construtor da classe com o sharedPreferences.
    required this.sharedPreferences,
  });

 

  void toggleTheme(bool value) async {

     try{
      darkTheme = !darkTheme;
      await sharedPreferences.setBool("theme", darkTheme);
      mensagemNotifier.value = SuccessMessage(
          message: "Tema mudado para ${darkTheme ? 'escuro' : 'claro'}.");
      notifyListeners();
     } on Exception catch (error) {
      mensagemNotifier.value = ErrorMessage(message: error.toString());
      notifyListeners();
    }}
  

  Future<void> getTheme() async {//Algoritimo para buscar o valor do tema salvo no sharedPreferences.
    final theme = sharedPreferences.getBool("theme");//Buscando por theme

    if (theme != null) {
      darkTheme = theme;
      notifyListeners();
    }
  }
}