import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  Future<Database> initDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');
    return await openDatabase(path, onCreate: (db, version){
      const sql="CREATE TABLE filmes("
          "_id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "url_imagem TEXT,"
          "descricao TEXT,"
          "ano TEXT,"
          "titulo TEXT,"
          "genero TEXT,"
          "faixa_etaria TEXT,"
          "duracao TEXT,"
          "pontuacao DOUBLE)";
      db.execute(sql);
    }, version: 1);
  }
}