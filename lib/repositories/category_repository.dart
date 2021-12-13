import 'package:baseproject/models/category.dart';
import 'package:baseproject/repositories/repositories.dart';

class CategoryRepository extends Repository {
  Future<List<Category>?> getAll() async {
    Map response = await httpManager.get(url: '/category/index');
    List responseRaw = response['data'];
    List<Category> categories = responseRaw.map((e) {
      return Category.fromJson(e);
    }).toList();
    return categories;
  }
}
