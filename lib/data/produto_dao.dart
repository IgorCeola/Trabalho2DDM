import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoDao {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> excluirProduto(String id) async {
    try {
      await _db.collection('produtos').doc(id).delete();  // Exclui o documento pelo ID
    } catch (e) {
      print("Erro ao excluir o produto: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getProdutos() async {
    try {
      var result = await _db.collection('produtos').get();
      return result.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      return [];
    }
  }


}
