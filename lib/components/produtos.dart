import 'package:flutter/material.dart';

class Produto extends StatefulWidget {
  final String nome;
  final String ingredientes;
  final String imagem;

  const Produto(this.nome, this.ingredientes, this.imagem, {super.key});

  @override
  State<Produto> createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  int nivel = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            height: 140,
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.black,
                      width: 72,
                      height: 100,
                      child: Image.network(widget.imagem,fit: BoxFit.cover,),
                    ),
                    SizedBox(
                        width: 200,
                        child: Text(
                          widget.nome,
                          style: const TextStyle(
                              fontSize: 24, overflow: TextOverflow.ellipsis),
                        )),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nivel++;
                              });
                            },
                            child: const Icon(Icons.arrow_drop_up)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                nivel--;
                              });
                            },
                            child: const Icon(Icons.arrow_drop_down)),

                      ],
                    )
                  ],
                ),
              ),
              Text('Nível $nivel')
            ],
          )
        ],
      ),
    );
  }
}
