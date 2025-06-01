import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/controller/filme_api_controller.dart';
import '../model/filme.dart';

class ExibirFilme extends StatelessWidget {
  final int idFilme;

  const ExibirFilme({super.key, required this.idFilme});

  Future<Filme> fetchFilme() {
    return FilmeApiController().findById(idFilme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Filme>(
        future: fetchFilme(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar filme: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Filme não encontrado"));
          }

          final filme = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(filme.urlImagem, height: 380)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          filme.titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(filme.ano, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(filme.genero, style: const TextStyle(color: Colors.grey))),
                      Text(filme.faixaEtaria == "Livre" ? "Livre" : "${filme.faixaEtaria} Anos", style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(filme.duracao, style: const TextStyle(color: Colors.grey))),
                      RatingBarIndicator(
                        rating: filme.pontuacao,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 24.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    filme.descricao,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
