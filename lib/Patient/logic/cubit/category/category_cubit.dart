import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/CategoryModel.dart';
import '../../repository/category_repository.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getCategories();
      if(categories!=null){
        emit(CategoryLoaded(categories));
      }else{
        emit(CategoryError("Failed to fetch categories"));
      }
    } catch (e) {
      emit(CategoryError("Failed to fetch categories"));
    }
  }
}
