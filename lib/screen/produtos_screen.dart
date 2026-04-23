import 'package:flutter/material.dart';
import 'package:loja_luigi_app/model/produto.dart';
import 'package:loja_luigi_app/screen/cadastroproduto.dart';
import 'package:loja_luigi_app/screen/detalhes_produto_screen.dart'; 
import 'package:loja_luigi_app/services/produto_service.dart';
import 'package:loja_luigi_app/services/session_service.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final _service = ProdutoService();
  late Future<List<Produto>> _listaProdutos;

  final _pesquisa = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listaProdutos = listarProdutos();
  }

  Future<List<Produto>> listarProdutos() async {
    String token = await SessionService().obterToken();
    return await _service.listarProdutos(token);
  }

  void _filtrarProdutos() {
    String busca = _pesquisa.text.trim().toLowerCase();
    setState(() {
      _listaProdutos = listarProdutos().then(
        (p) => p.where((produto) {
          return produto.nome.toLowerCase().contains(busca) ||
              produto.marca.toLowerCase().contains(busca);
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo - Loja do Luigi"),
        backgroundColor: Colors.purple,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _pesquisa,
              decoration: InputDecoration(
                hintText: 'Buscar itens da loja...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => _filtrarProdutos(),
            ),
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _listaProdutos = listarProdutos();
          });
        },
        child: FutureBuilder<List<Produto>>(
          future: _listaProdutos,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final produtos = snapshot.data!;

            if (produtos.isEmpty) {
              return const Center(
                child: Text("Nenhum item encontrado na loja."),
              );
            }

            return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];

                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(produto.nome),
                    subtitle: Text(
                      '${produto.descricao} • ${produto.marca}',
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.shopping_bag, color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesProdutoScreen(produto: produto),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CadastroProdutoScreen(),
            ),
          );
        },
      ),
    );
  }
}