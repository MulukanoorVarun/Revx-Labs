import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/CategoryModel.dart';
import '../../repository/category_repository.dart';  // ✅ Import CategoryModel here

part 'category_state.dart';  // ✅ This must be after the imports

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getCategories();
      emit(CategoryLoaded(categories!));
    } catch (e) {
      emit(CategoryError("Failed to fetch categories"));
    }
  }
}
