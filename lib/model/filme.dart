class Filme {
  int? id;
  String urlImagem;
  String titulo;
  String genero;
  String faixaEtaria;
  String duracao;
  double pontuacao;
  String descricao;
  String ano;

  Filme({
    this.id,
    required this.urlImagem,
    required this.descricao,
    required this.ano,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'urlImagem': urlImagem,
      'descricao': descricao,
      'ano': ano,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontucao': pontuacao,
      '_id': id,
    };
  }

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      urlImagem: map['urlImagem'],
      descricao: map['descricao'],
      ano: map['ano'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['genero'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'],
    );
  }
  
}
