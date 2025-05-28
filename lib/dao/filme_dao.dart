import 'package:myapp/database/database_helper.dart';
import '../model/filme.dart';

class FilmeDao {
  late DatabaseHelper dbHelper;

  FilmeDao() {
    dbHelper = DatabaseHelper();
  }

  Future<int> save(Filme filme) async {
    final db = await dbHelper.initDB();
    try {
      return await db.insert('filmes', filme.toMap());
    } catch (e) {
      return -1;
    } finally {
      db.close();
    }
  }

  Future<List<Filme>?> findAll() async {
    final db = await dbHelper.initDB();
    try {
      final listMap = await db.query('filmes');
      List<Filme> filmes = [];
      for (var map in listMap) {
        filmes.add(Filme.fromMap(map));
      }
      return filmes;
    } catch (e) {
      return null;
    } finally {
      db.close();
    }
  }
}
