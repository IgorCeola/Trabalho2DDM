import 'package:flutter/material.dart';
import 'package:novo_projeto_flutter/components/produtos.dart';
import 'package:novo_projeto_flutter/data/produto_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.produtoContext});

  final BuildContext produtoContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ingredientesController = TextEditingController();
  TextEditingController imagemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Novo Produto"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3, color: Colors.grey)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Insira o nome do Produto";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Insira os ingredientes do Produto";
                        }
                        return null;
                      },
                      controller: ingredientesController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ingredientes',
                          fillColor: Colors.white70,
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Insira o URL da imagem! ";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: imagemController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.blue)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imagemController.text, errorBuilder:
                          (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                        return Image.asset("assets/images/nophoto.png");
                      }, fit: BoxFit.cover),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        adicionarProduto();
                      }
                    },
                    child: Text("Adicionar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> adicionarProduto() async {
    try {

      FirebaseFirestore firestore = FirebaseFirestore.instance;


      Map<String, dynamic> produto = {
        'nome': nameController.text,
        'ingredientes': ingredientesController.text,
        'url': imagemController.text,
      };


      await firestore.collection('produtos').add(produto);


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto adicionado com sucesso!')),
      );


      Navigator.pop(context);
    } catch (e) {
      // Mostra uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar produto: $e')),

      );

    }
  }
}
