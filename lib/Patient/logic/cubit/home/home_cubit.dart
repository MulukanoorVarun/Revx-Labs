import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_repository.dart';
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
  final ProfileRepository profileRepository;

  HomeCubit({
    required this.categoryRepository,
    required this.bannersRepository,
    required this.diagnosticCentersRepository,
    required this.profileRepository,
  }) : super(HomeInitial());

  Future<void> fetchHomeData(lat_lang) async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        categoryRepository.getCategories(),
        bannersRepository.getBanners(),
        diagnosticCentersRepository.getDiagnosticCenters(lat_lang),
        profileRepository.getProfileDetails()
      ]);

      final categories = results[0] as CategoryModel;
      final banners = results[1] as BannersModel;
      final diagnosticCenters = results[2] as DiognisticCenterModel;
      final profileDetails = results[3] as ProfileDetailModel;

      emit(HomeLoaded(categories, banners, diagnosticCenters,profileDetails));
    } catch (e) {
      emit(HomeError("Failed to fetch home data"));
    }
  }
}
