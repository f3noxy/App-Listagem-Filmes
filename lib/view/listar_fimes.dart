import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/controller/filme_api_controller.dart';
import 'package:myapp/view/cadastrar_editar_filme.dart';
import 'package:myapp/view/exibir_filme.dart';
import '../model/filme.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListaFilmesViewState();
}

class _ListaFilmesViewState extends State<ListarFilmes> {
  final filmeController = FilmeApiController();

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
      body: FutureBuilder(
        future: filmeController.findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filmes = snapshot.data;
            return ListView.builder(
              itemCount: filmes!.length,
              itemBuilder: (context, index) {
                return buildItemList(filmes[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CadastrarEditarFilme();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildItemList(Filme filme) {
    return Dismissible(
      key: ValueKey(filme.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        try {
          await filmeController.delete(filme.id!);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Filme ${filme.titulo} apagado com sucesso."),
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro ao apagar: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text("Detalhes"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExibirFilme(idFilme: filme.id!);
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text("Editar"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CadastrarEditarFilme(filme: filme),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shadowColor: Colors.black,
            elevation: 6,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: SizedBox(
              height: 150,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  ClipRRect(
                    child: Image.network(
                      filme.urlImagem,
                      width: 100,
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
                            filme.titulo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            filme.genero,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            filme.duracao,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          RatingBarIndicator(
                            rating: filme.pontuacao,
                            itemBuilder:
                                (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
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
        ),
      ),
    );
  }
}
