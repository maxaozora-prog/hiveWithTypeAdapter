import 'package:flutter/material.dart';
import 'package:flutter_hive_type_adpter/person_hive.dart';
import 'package:hive/hive.dart';


class TelaBusca extends StatefulWidget {
  const TelaBusca({super.key});

  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  final TextEditingController _controller = TextEditingController();

  // String resultado = '';
  bool carregando = false;
  // String idade= "";
  // String email= "";
  List<personHive> resultados = [];

  late final Box<personHive> usuariosBox= Hive.box<personHive>('usuarios');

  Future<void> buscarItem() async {
    setState(() {
      carregando = true;
      // resultado = '';
      // idade= "";
      // email= "";
       resultados.clear();

    });

   try {
    final textoDigitado = _controller.text.trim().toLowerCase();

    final query = usuariosBox.values.where((usuario) {
      final nome = usuario.name.toLowerCase();

      // Gera as iniciais do nome
      final iniciais = usuario.name
          .split(' ')   //Divide. Se o nome for "João Pedro Silva", vai ficar ["João", "Pedro", "Silva"].
          .where((p) => p.isNotEmpty)  
          .map((p) => p[0].toLowerCase()) //Pegando a primeira letra de cada palavra: ["j", "p", "s"]
          .join(); //junta tudo.

      return nome.contains(textoDigitado) ||
             iniciais.startsWith(textoDigitado);
    }).toList();

    if (query.isNotEmpty) {
      // final usuario = query.first;

      setState(() {
        // resultado = usuario.name;
        // idade = usuario.age.toString();
        // email = usuario.email;
        resultados = query;
      });
    // } else {
    //   setState(() {
    //     resultado = 'Item não encontrado';
    //   });
     }
  } catch (e) {
    print(e);
  }

  setState(() {
    carregando = false;
  });
}

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Busca Firestore'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: _controller,
    //           decoration: const InputDecoration(
    //             labelText: 'Digite o nome para a busca',
    //             border: OutlineInputBorder(),
    //           ),
    //         ),

    //         const SizedBox(height: 16),

    //         ElevatedButton(
    //           onPressed: buscarItem,
    //           child: const Text('Buscar'),
    //         ),

    //         const SizedBox(height: 24),

    //         if (carregando)
    //           const CircularProgressIndicator()
    //         else
    //           Text(
    //             resultado,
    //             style: const TextStyle(
    //               fontSize: 22,
    //               fontWeight: FontWeight.bold,
    //             ),
                
    //           ),
    //           SizedBox(height:10),
    //           if (idade.isNotEmpty)
    //             Text(
    //             "Idade : $idade",
    //             style: const TextStyle(
    //               fontSize: 22,
    //               fontWeight: FontWeight.bold,
    //             ),
                
    //           ),
    //           SizedBox(height:10),
    //             Text(
    //             email,
    //             style: const TextStyle(
    //               fontSize: 22,
    //               fontWeight: FontWeight.bold,
    //             ),
                
    //           ),
              
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
  appBar: AppBar(
    title: const Text('Busca Hive'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [

        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Digite o nome',
          ),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: buscarItem,
          child: const Text('Buscar'),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: resultados.isEmpty
              ? const Center(
                  child: Text('Nenhum usuário encontrado'),
                )
              : ListView.builder(
                  itemCount: resultados.length,
                  itemBuilder: (context, index) {
                    final usuario = resultados[index];

                    return ListTile(
                      title: Text(usuario.name),
                      subtitle: Text("${usuario.email}, Idade: ${usuario.age.toString()}" ),
                    );
                  },
                ),
        ),
      ],
    ),
  ),
);





  }
}