import 'package:flutter/material.dart';
import 'package:novo_projeto_flutter/components/produtos.dart';

class produtoInherited extends InheritedWidget {
  produtoInherited({
    super.key,
    required super.child,
  });

  final List<Produto> produtoList = [


  ];

  void newProduto(String nome, String ingredientes, String url){

  }

  static produtoInherited of(BuildContext context) {
    final produtoInherited? result =
        context.dependOnInheritedWidgetOfExactType<produtoInherited>();
    assert(result != null, 'No produtoInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(produtoInherited oldWidget) {
    return oldWidget.produtoList.length != produtoList.length;
  }
}
