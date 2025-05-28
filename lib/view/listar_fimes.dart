import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controller/filme_controller.dart';
import '../model/filme.dart';

class ListaFilmesView extends StatefulWidget {
  const ListaFilmesView({super.key});

  @override
  State<ListaFilmesView> createState() => _ListaFilmesViewState();
}

class _ListaFilmesViewState extends State<ListaFilmesView> {
  final _filmeController = FilmeController();
  List<Filme> _filmes = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _filmes = _filmeController.getFilmes();
    });
  }

  void _mostrarAlertaGrupo() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Equipe"),
            content: const Text(
              "Wilton Nicolas\nLucas Nascimento\nMatheus Ryan",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
            shadowColor: Colors.black,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _mostrarAlertaGrupo,
            color: Colors.white,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          return buildItemList(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAlertaGrupo,
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildItemList(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.black,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              const SizedBox(width: 15),
              ClipRRect(
                child: Image.network(
                  _filmes[index].urlImagem,
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _filmes[index].titulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _filmes[index].genero,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        _filmes[index].duracao,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      RatingBarIndicator(
                        rating: _filmes[index].pontuacao,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
