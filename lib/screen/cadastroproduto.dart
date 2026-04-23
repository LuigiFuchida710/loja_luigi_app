import 'package:flutter/material.dart';
import 'dart:io';
import 'package:loja_luigi_app/screen/leitor_codigo_barras.dart';
import 'package:loja_luigi_app/widget/seletor_imagem.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  File? _imagemAtual;
  final _codigoBarrasController = TextEditingController();

  Future<void> _lerCodigoBarras() async {
    final String? resultado = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (context) => const LeitorCodigoBarras()),
    );

    _codigoBarrasController.text =
        resultado?.isNotEmpty == true ? resultado! : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Produto"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                SeletorImagem(
                  imagemAtual: _imagemAtual,
                  quandoImagemSelecionada: (img) {
                    setState(() {
                      _imagemAtual = img;
                    });
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _codigoBarrasController,
                  decoration: InputDecoration(
                    labelText: "Código de Barras",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: _lerCodigoBarras,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nome do Produto",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Marca",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 3,
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: '1', child: Text("Eletrônicos")),
                    DropdownMenuItem(value: '2', child: Text("Acessórios")),
                    DropdownMenuItem(value: '3', child: Text("Games")),
                    DropdownMenuItem(value: '4', child: Text("Outros")),
                  ],
                  onChanged: (value) {},
                  initialValue: '1',
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Produto cadastrado (simulação)"),
                        ),
                      );
                    },
                    child: const Text("Salvar Produto"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}