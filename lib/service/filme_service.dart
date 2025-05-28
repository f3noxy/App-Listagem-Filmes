import '../model/filme.dart';

class FilmeService {
  static final _filmes = [
    Filme(
      urlImagem: "https://i.ebayimg.com/images/g/ZX4AAOSw~AFgu0hz/s-l1200.jpg",
      titulo: "Yu Yu Hakusho - Os Invasores do Inferno",
      genero: "Anime",
      faixaEtaria: "10",
      duracao: "30min",
      pontuacao: 5,
      ano: "1993",
      descricao: "Anime foda"
    )
  ];

  List<Filme> get filmes {
    return List.unmodifiable(_filmes);
  }

  void adicionar(Filme filme) {
    _filmes.add(filme);
  }
  
}
