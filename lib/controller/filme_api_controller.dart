import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/config/filme_api_config.dart';
import '../model/filme.dart';

class FilmeApiController {
  Future<List<Filme>> findAll() async {
    final response = await http.get(
      Uri.parse("${FilmeApiConfig.url}/filmes"),
      headers: FilmeApiConfig.headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<Filme> filmes = [];
      for (var map in jsonData) {
        filmes.add(Filme.fromJson(map));
      }

      return filmes;
    } else {
      throw HttpException(
        "Erro ao consultar os filmes, por favor contate o administrador",
      );
    }
  }

  Future<Filme> findById(int id) async {
    final response = await http.get(
      Uri.parse("${FilmeApiConfig.url}/filmes/$id"),
      headers: FilmeApiConfig.headers,
    );

    if (response.statusCode == 200) {
      return Filme.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(
        "Erro ao consultar o filme, por favor contate o administrador",
      );
    }
  }

  Future<int> save(Filme filme) async {
    final response = await http.post(
      Uri.parse("${FilmeApiConfig.url}/filmes"),
      headers: FilmeApiConfig.headers,
      body: jsonEncode(filme.toMap()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Filme.fromJson(jsonDecode(response.body)).id!;
    } else {
      throw HttpException(
        "Erro ao salvar o filme, por favor contate o administrador",
      );
    }
  }

  Future<int> update(Filme filme) async {
    final response = await http.put(
      Uri.parse("${FilmeApiConfig.url}/filmes/${filme.id}"),
      headers: FilmeApiConfig.headers,
      body: jsonEncode(filme.toMap()),
    );

    if (response.statusCode == 200) {
      return Filme.fromJson(jsonDecode(response.body)).id!;
    } else {
      throw HttpException(
        "Erro ao atualizar o filme, por favor contate o administrador",
      );
    }
  }

  Future<int> delete(int id) async {
    final response = await http.delete(
      Uri.parse("${FilmeApiConfig.url}/filmes/$id"),
      headers: FilmeApiConfig.headers,
    );

    if (response.statusCode == 200) {
      return Filme.fromJson(jsonDecode(response.body)).id!;
    } else {
      throw HttpException(
        "Erro ao deletar o filme, por favor contate o administrador",
      );
    }
  }
}
