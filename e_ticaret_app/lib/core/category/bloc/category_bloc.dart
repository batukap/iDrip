import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_ticaret_app/core/category/model/category_model.dart';
import 'package:e_ticaret_app/core/category/repo/category_service.dart';
import 'package:equatable/equatable.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;
  CategoryBloc({required this.categoryService}) : super( CategoryState()) {
    on<CategoryFetched>(_onCategoryFetched);
  }

  FutureOr<void> _onCategoryFetched(
      CategoryFetched event, Emitter<CategoryState> emit) async {
    try {
      final categories = await categoryService.categoryCall();
      return emit(state.copyWith(category: categories));
    } catch (e) {
      throw Exception();
    }
  }
}
