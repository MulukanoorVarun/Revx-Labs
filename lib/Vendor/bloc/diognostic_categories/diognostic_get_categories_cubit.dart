import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_categories/diognostic_get_category_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_categories/diognostic_get_catogories_state.dart';

class DiognosticCategoryCubit extends Cubit<DiognosticCategoryState> {
  final DiognosticGetCategoryRepository diognosticRepo;
  DiognosticCategoryCubit({required this.diognosticRepo})
      : super(DiognosticCategoryIntially());

  Future<void> getDiognosticCategorys() async {
    emit(DiognosticCategoryLoading());
    final res = await diognosticRepo.GetDiognosticCategorys();
    try {
      if (res != null) {
        emit(DiognosticCategoryLoaded(res));
      } else {
        emit(DiognosticCategoryError(res?.settings?.message??''));
      }
    } catch (e) {
      emit(DiognosticCategoryError(res?.settings?.message??''));
    }
  }
}
