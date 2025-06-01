import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../controller/filme_api_controller.dart';
import '../model/filme.dart';

class CadastrarEditarFilme extends StatefulWidget {
  final Filme? filme;

  const CadastrarEditarFilme({super.key, this.filme});

  @override
  State<CadastrarEditarFilme> createState() => _CadastrarEditarFilmeState();
}

class _CadastrarEditarFilmeState extends State<CadastrarEditarFilme> {
  final _key = GlobalKey<FormState>();

  final _edtUrlImagem = TextEditingController();
  final _edtTitulo = TextEditingController();
  final _edtGenero = TextEditingController();
  final _edtDuracao = TextEditingController();
  final _edtAno = TextEditingController();
  final _edtDescricao = TextEditingController();
  final _filmeController = FilmeApiController();

  @override
  void initState() {
    super.initState();
    final filme = widget.filme;
    if (filme != null) {
      _edtUrlImagem.text = filme.urlImagem;
      _edtTitulo.text = filme.titulo;
      _edtGenero.text = filme.genero;
      _edtDuracao.text = filme.duracao;
      _edtAno.text = filme.ano;
      _edtDescricao.text = filme.descricao;
      _faixaSelecionada = int.tryParse(filme.faixaEtaria) ?? 0;
      _nota = filme.pontuacao;
    }
  }

  final List<int> _faixasEtarias = [0, 10, 12, 14, 16, 18];
  int _faixaSelecionada = 0;
  double _nota = 4.0;

  @override
  void dispose() {
    _edtUrlImagem.dispose();
    _edtTitulo.dispose();
    _edtGenero.dispose();
    _edtDuracao.dispose();
    _edtAno.dispose();
    _edtDescricao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filme == null ? 'Cadastrar Filme' : 'Editar Filme', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              TextFormField(
                controller: _edtUrlImagem,
                decoration: InputDecoration(labelText: 'Url Imagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _edtTitulo,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _edtGenero,
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Faixa Etária'),
                value: _faixaSelecionada,
                items:
                    _faixasEtarias
                        .map(
                          (idade) => DropdownMenuItem(
                            value: idade,
                            child: Text(
                              idade == 0 ? 'Livre' : idade.toString(),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (valor) {
                  setState(() {
                    _faixaSelecionada = valor!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _edtDuracao,
                decoration: InputDecoration(labelText: 'Duração'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text("Nota:"),
              SmoothStarRating(
                rating: _nota,
                size: 32,
                color: Colors.lightBlue,
                borderColor: Colors.lightBlue,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                onRatingChanged: (valor) {
                  setState(() {
                    _nota = valor;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _edtAno,
                decoration: InputDecoration(labelText: 'Ano'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _edtDescricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
        onPressed: () async {
        final valid = _key.currentState!.validate();
        if (!valid) return;

        final filmeEditado = Filme(
          id: widget.filme?.id,
          urlImagem: _edtUrlImagem.text,
          titulo: _edtTitulo.text,
          genero: _edtGenero.text,
          faixaEtaria: "$_faixaSelecionada",
          duracao: _edtDuracao.text,
          pontuacao: _nota,
          ano: _edtAno.text,
          descricao: _edtDescricao.text,
        );

        try {
          if (widget.filme == null) {
            await _filmeController.save(filmeEditado);
            _mostrarMensagem("Filme cadastrado com sucesso.", Colors.green);
          } else {
            await _filmeController.update(filmeEditado);
            _mostrarMensagem("Filme atualizado com sucesso.", Colors.blue);
          }

          if (!mounted) return;
          Navigator.pop(context);
        } catch (e) {
          _mostrarMensagem("Erro ao salvar: $e", Colors.red);
        }
      },
        child: Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  void _mostrarMensagem(String texto, Color cor) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), backgroundColor: cor),
    );
  }

}
