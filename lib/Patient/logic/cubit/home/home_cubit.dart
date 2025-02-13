import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import '../../../../Models/BannersModel.dart';
import '../../../../Models/CategoryModel.dart';
import '../../../../Models/DiognisticCenterModel.dart';
import '../../repository/category_repository.dart';
import '../../repository/banners_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository categoryRepository;
  final BannersRepository bannersRepository;
  final DiagnosticCenterRepository diagnosticCentersRepository;

  HomeCubit({
    required this.categoryRepository,
    required this.bannersRepository,
    required this.diagnosticCentersRepository,
  }) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading()); // 🔄 Set loading state

    try {
      final results = await Future.wait([
        categoryRepository.getCategories(),
        bannersRepository.getBanners(),
        diagnosticCentersRepository.getDiagnosticCenters(),
      ]);

      final categories = results[0] as CategoryModel;
      final banners = results[1] as BannersModel;
      final diagnosticCenters = results[2] as DiognisticCenterModel;

      emit(HomeLoaded(categories, banners, diagnosticCenters)); // ✅ Data fetched successfully
    } catch (e) {
      emit(HomeError("Failed to fetch home data"));
    }
  }
}
