import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());
  final CategoryRepository categoryRepository = CategoryRepository();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryGetAll) {
      yield CategoryProgressIndicator();
      List<Category>? categories = await categoryRepository.getAll();
      yield CategoryGetAllSuccess(categories: categories);
    }
  }
}
