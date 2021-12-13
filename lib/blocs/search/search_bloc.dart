import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());
  ProductRepository productRepository = ProductRepository();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchGet) {
      yield SearchLoading();
      List<Product> products = await productRepository.search(event.keyword);
      yield SearchGetSuccess(products: products, keyword: event.keyword);
    }
    if (event is SearchSort) {
      if (state is SearchGetSuccess) {
        SearchGetSuccess searchGetSuccess = state as SearchGetSuccess;
        switch (event.type) {
          case 'up_to_date':
            searchGetSuccess.products.sort((a, b) {
              return b.id.compareTo(a.id);
            });
            yield SearchGetSuccess(
              products: searchGetSuccess.products,
              keyword: searchGetSuccess.keyword,
            );
            break;
          case 'high_to_low':
            searchGetSuccess.products.sort((a, b) {
              return a.price.compareTo(b.price);
            });
            yield SearchGetSuccess(
              products: searchGetSuccess.products,
              keyword: searchGetSuccess.keyword,
            );
            break;
          case 'low_to_high':
            searchGetSuccess.products.sort((a, b) {
              return b.price.compareTo(a.price);
            });
            yield SearchGetSuccess(
              products: searchGetSuccess.products,
              keyword: searchGetSuccess.keyword,
            );
            break;
          case 'evaluation':
            searchGetSuccess.products.sort((a, b) {
              return b.score!.compareTo(a.score!);
            });
            yield SearchGetSuccess(
              products: searchGetSuccess.products,
              keyword: searchGetSuccess.keyword,
            );
            break;
        }
      }
    }
  }
}
