import 'package:flutter/material.dart';
import 'package:loja_luigi_app/model/produto.dart';

class DetalhesProdutoScreen extends StatelessWidget {
  final Produto produto;

  const DetalhesProdutoScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.shopping_bag, size: 100, color: Colors.purple),
            ),
            const SizedBox(height: 20),
            Text(produto.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(produto.marca, style: TextStyle(fontSize: 18, color: Colors.grey)),
            const Divider(),
            const Text("Descrição:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(produto.descricao),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Voltar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}