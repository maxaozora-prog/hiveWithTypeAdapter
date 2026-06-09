import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_type_adpter/controller/person_controller.dart';
import 'package:flutter_hive_type_adpter/person_hive.dart';
import 'package:provider/provider.dart';



class Register extends StatefulWidget {
  personHive? person;   //http put tem que criar esse objeto para receber os dados de edição do put e o Person pode ser null então interrogação.
  Register({super.key, required this.person});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final gap = SizedBox(height: 16);
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEditing = false;//http put
  
  @override
  void initState() {//http put
    if (widget.person != null) {
      isEditing = true;
      personHive person = widget.person!;
      nameController.text = person.name;
      ageController.text = person.age.toString();
      emailController.text = person.email;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
     final personProvider = context.watch<PersonController>();
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Formulário"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                //autovalidateMode: AutovalidateMode.always, //Valida em tempo real,a cada letra digitada.
                autovalidateMode: AutovalidateMode.onUserInteraction, //Valida em tempo real somente qdo o usuario interagir.
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Por favor, preencha o nome.";
                  }
                  
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  label: Text("Nome completo"),
                  border: OutlineInputBorder(),
                ),
              ),
             gap,
              TextFormField(
                //autovalidateMode: AutovalidateMode.always,//Valida em tempo real,a cada letra digitada.
                 autovalidateMode: AutovalidateMode.onUserInteraction, //Valida em tempo real somente qdo o usuario interagir.
                keyboardType: TextInputType.number,//Tipo do teclado, o numerico.
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Por favor, preencha a idade.";
                  }
                  return null;
                },
                controller: ageController,
                decoration: InputDecoration(
                  label: Text("Idade"),
                  border: OutlineInputBorder(),
                ),
              ),
               gap,
              TextFormField(
                //autovalidateMode: AutovalidateMode.always,//Valida em tempo real,a cada letra digitada.
                autovalidateMode: AutovalidateMode.onUserInteraction,//Valida em tempo real somente qdo o usuario interagir.
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "Por favor, preencha o email.";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(),
                ),
              ),
            gap,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {//Validação da GlobalKey
                            try {
                            if (!isEditing){
                            final createPerson = personHive(
                              
                              name: nameController.text,
                                age: int.parse(ageController.text),
                               //age: int.tryParse(ageController.text) ?? 0,
                              email: emailController.text,
                            );

                            await personProvider.adicionarPessoa(createPerson);
                            }
                            else {
                            final pessoaAtual = widget.person!;
                           
                              pessoaAtual.name= nameController.text;
                              pessoaAtual.age= int.parse(ageController.text);
                              pessoaAtual.email= emailController.text;
                            
                             await personProvider
                                .atualizarPessoa(pessoaAtual);
                        }
                           
                               if (context.mounted) Navigator.of(context).pop();
                            } catch (e) {
                             debugPrint("ERRO: $e");

                            ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                            content: Text("Erro ao salvar"),
                             ));



                          } 

                          }
                          
                          
                      }
                      ,
                      child: Text("Salvar"),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }
  }
