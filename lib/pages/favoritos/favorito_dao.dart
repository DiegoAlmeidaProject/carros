
import 'package:carros/pages/favoritos/favorito.dart';

import '../../utils/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";

}