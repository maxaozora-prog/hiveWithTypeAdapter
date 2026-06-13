import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/controller/person_controller.dart';
import 'package:flutter_hive_type_adpter/controller/theme_controller.dart';
import 'package:flutter_hive_type_adpter/message_states.dart';
import 'package:flutter_hive_type_adpter/person_dialog.dart';
import 'package:flutter_hive_type_adpter/routes/routes.dart';
import 'package:provider/provider.dart';



class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  
  late PersonController personProvider;
  late ThemeController themeProvider;

  

  @override
  void initState() {//Injeção de dependencia.
  super.initState();
   personProvider = context.read<PersonController>();//Tem que ser read ao inves de watch.
   themeProvider = context.read<ThemeController>();
    
   
    // WidgetsBinding.instance.addPostFrameCallback((_) { //Com o hive.
    // context.read<PersonController>().listarPessoas();
    // });

     Future.microtask(() {    //Substitui o codigo de cima.
     personProvider.listarPessoas();
     });
  
  //  context.read<PersonController>().listarPessoas();//Provider
   themeProvider.mensagemNotifier.addListener(_onThemeMensagem);//ValueNotifier.
   personProvider.mensagemNotifier.addListener(_onPessoaMensagem);//ValueNotifier.
  }

   void _onPessoaMensagem() {//ValueNotifier.
    
    final value = personProvider.mensagemNotifier.value;

    if (value is SuccessMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(value.message),
        ),
      );
    } else if (value is ErrorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(value.message),
        ),
      );
    }
  }

  void _onThemeMensagem() {//ValueNotifier.
    

        final value = themeProvider.mensagemNotifier.value;
    if (value is SuccessMessage) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(value.message),
        ),
      );
    } else if (value is ErrorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(value.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final personProvider = context.watch<PersonController>();//Algoritimo do provider. Funciona somente dentro do build.
    final themeProvider = context.watch<ThemeController>();
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: themeProvider.darkTheme,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            Text(themeProvider.darkTheme == false ? "Tema Claro" : "Tema Escuro"),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Iniciando..."),
      ),
      
       body: _buildBody(personProvider),
      
    //   body:   
    //   personProvider.isLoading?
    //    const Center(child: CircularProgressIndicator()):
    

    // personProvider.person.isEmpty?
    //   Center(
    //     child: Text(
    //       "Nenhuma pessoa cadastrada",
    //       style: TextStyle(fontSize: 20),
    //     ),
    //   ):
    

    //  ListView.builder(
    //   itemCount: personProvider.person.length,
    //   itemBuilder: (context, index) {
    //     return GestureDetector(
    //       onTap: () {
    //         showDialog(
    //           context: context,
    //           builder: (context) {
    //             return PersonDialog(
    //               person: personProvider.person[index],
    //             );
    //           },
    //         );
    //       },
    //       child: ListTile(
    //         title: Text(personProvider.person[index].name),
    //         subtitle: Text(personProvider.person[index].email),
    //       ),
    //     );
    //   },
    // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.register);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
       padding: EdgeInsets.all(8),
         child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.buscar);
        },
        child: Text('Buscar Cadastro'),
      ),
    ),
      ),
    );
  }

  Widget _buildBody(PersonController personProvider) {
    if (personProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (personProvider.person.isEmpty) {
      return Center(
        child: Text(
          "Nenhuma pessoa cadastrada",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      itemCount: personProvider.person.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PersonDialog(
                  person: personProvider.person[index],
                );
              },
            );
          },
          child: ListTile(
            title: Text(personProvider.person[index].name),
            subtitle: Text(personProvider.person[index].email),
          ),
        );
      },
    );
  }
    @override
    void dispose() {
    personProvider.mensagemNotifier.removeListener(_onPessoaMensagem);//ValueNotifier.
    themeProvider.mensagemNotifier.removeListener(_onThemeMensagem);//ValueNotifier.
    super.dispose();
  }
}
