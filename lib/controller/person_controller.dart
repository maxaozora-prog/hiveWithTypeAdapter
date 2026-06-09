import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/message_states.dart';
import 'package:flutter_hive_type_adpter/person_hive.dart';

import 'package:hive_flutter/hive_flutter.dart';



class PersonController extends ChangeNotifier{ 
  
  List<personHive> _person = [];
  List<personHive> get person => _person;
  bool isLoading = false;
  ValueNotifier<MessagesStates> mensagemNotifier = ValueNotifier(IddleMessage());

  late final Box<personHive> usuariosBox;

  PersonController() {
    usuariosBox =Hive.box<personHive>('usuarios');
  }
  



  Future <void> listarPessoas() async {
    isLoading = true;
     print('BOX LENGTH: ${usuariosBox.length}');
     print('BOX DATA: ${usuariosBox.toMap()}');
    
    
    try {
      _person = usuariosBox.values.toList();

  notifyListeners();

    } on Exception catch (error) {
       mensagemNotifier.value =
          ErrorMessage(message: "ocorreu um erro ao buscar pessoas.");
     
      print("error: $error");
    } finally {
      isLoading = false;
      
      notifyListeners();
    }
  }

  Future<void> adicionarPessoa(personHive createPerson) async {
 
     
      try{
        await usuariosBox.add(createPerson);

        mensagemNotifier.value =
          SuccessMessage(message: "Pessoa adicionada com sucesso.");
     
        await usuariosBox.flush(); //força a gravação.
        await listarPessoas();//Para atualizar a lista.
      }
      on Exception catch (error) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
      mensagemNotifier.value =
          ErrorMessage(message: "Ocorreu um erro ao adicionar pessoa");
          print("error: $error");

    }
    
  }

 Future<void> removerPessoa(personHive pessoa) async {
    try {
      
        await pessoa.delete();
      
      mensagemNotifier.value =
          SuccessMessage(message: "Pessoa removida com sucesso.");
       await usuariosBox.flush(); //força a gravação.
       await listarPessoas();
       } on Exception catch (_) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
      mensagemNotifier.value =
          ErrorMessage(message: "Ocorreu um erro ao remover pessoa");
    } finally {
      notifyListeners();
    }
   }
 
 Future<void> atualizarPessoa(personHive criarPessoa) async {
    try {
         await criarPessoa.save();

      mensagemNotifier.value =
          SuccessMessage(message: "Pessoa atualizada com sucesso.");
          await usuariosBox.flush(); //força a gravação.
          await listarPessoas();//Para atualizar a lista.
    // } on Exception catch (error) {
       } on Exception catch (_) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
        mensagemNotifier.value =
          ErrorMessage(message: "Ocorreu um erro ao atualizar pessoa");
    } finally {
      notifyListeners();
    }
  }
  







}