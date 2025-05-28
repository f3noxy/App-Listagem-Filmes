import '../service/filme_service.dart';
import '../model/filme.dart';

class FilmeController {
  final _service = FilmeService();

  List<Filme> getFilmes() {
    return _service.filmes;
  }

  void adicionar(String urlImagem, String titulo, String genero,
  String faixaEtaria, String duracao, double pontuacao, String drescricao, String ano){
    _service.adicionar(Filme(ano: ano,
      urlImagem: urlImagem,
      titulo: titulo,
      genero: genero, 
      faixaEtaria: faixaEtaria, 
      duracao: duracao, 
      pontuacao: pontuacao, 
      descricao: drescricao)
    );
  }
}
