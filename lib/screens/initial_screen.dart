import 'package:flutter/material.dart';
import 'package:novo_projeto_flutter/components/produtos.dart';
import 'package:novo_projeto_flutter/data/produto_dao.dart';
import 'package:novo_projeto_flutter/screens/form_screen.dart';

class inicialScreen extends StatefulWidget {
  const inicialScreen({super.key});

  @override
  State<inicialScreen> createState() => _inicialScreenState();
}

class _inicialScreenState extends State<inicialScreen> {
  final ProdutoDao _produtoDao = ProdutoDao();
  late Future<List<Map<String, dynamic>>> _produtosFuture;

  @override
  void initState() {
    super.initState();
    _produtosFuture = _produtoDao.getProdutos();
  }

  void _atualizarProdutos() {
    setState(() {
      _produtosFuture = _produtoDao.getProdutos(); // Atualiza os produtos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _produtosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }

          List<Map<String, dynamic>> produtos = snapshot.data!;

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              var produto = produtos[index];
              return Produto(
                produto['id'] ??
                produto['nome'] ?? 'Nome não disponível',
                produto['ingredientes'] ?? 'Ingredientes não disponíveis',
                produto['imagem'] ?? '',
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(produtoContext: context),
            ),
          ).then((_) {

            _atualizarProdutos();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
