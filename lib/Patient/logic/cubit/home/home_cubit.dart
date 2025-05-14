import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:revxpharma/Models/ConditionModel.dart';
import 'package:revxpharma/Models/ProfileDetailModel.dart';
import 'package:revxpharma/Models/TestModel.dart';
import 'package:revxpharma/Patient/logic/cubit/ConditionTests/condition_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_repository.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import '../../../../Models/BannersModel.dart';
import '../../../../Models/CategoryModel.dart';
import '../../../../Models/DiognisticCenterModel.dart';
import '../../repository/category_repository.dart';
import '../../repository/banners_repository.dart';
import '../RegularTest/regular_test_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository categoryRepository;
  final BannersRepository bannersRepository;
  final DiagnosticCenterRepository diagnosticCentersRepository;
  final ProfileRepository profileRepository;
  final RegularTestRepository regularTestRepository;
  final RadiologyTestRepository radiologyTestRepository;
  final ConditionTestRepository conditionTestRepository;

  HomeCubit({
    required this.categoryRepository,
    required this.bannersRepository,
    required this.diagnosticCentersRepository,
    required this.profileRepository,
    required this.regularTestRepository,
    required this.radiologyTestRepository,
    required this.conditionTestRepository,
  }) : super(HomeInitial());

  Future<void> fetchHomeData(lat_lang,page) async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        categoryRepository.getCategories(""),
        bannersRepository.getBanners(),
        diagnosticCentersRepository.getDiagnosticCenters(lat_lang),
        profileRepository.getProfileDetails(),
        regularTestRepository.getRegularTest(lat_lang, '', '', page, '', '', ''),
        radiologyTestRepository.getRadiologyTest(lat_lang, '', '', page, '', '', ''),
        conditionTestRepository.getConditionTest()
      ]);

      final categories = results[0] as CategoryModel;
      final banners = results[1] as BannersModel;
      final diagnosticCenters = results[2] as DiognisticCenterModel;
      final profileDetails = results[3] as ProfileDetailModel;
      final fetchRegularTest = results[4] as TestModel;
      final fetchRadiology = results[5] as TestModel;
      final conditionTest = results[6] as ConditionModel;

      emit(HomeLoaded(categories, banners, diagnosticCenters, profileDetails,
          fetchRegularTest, fetchRadiology,conditionTest));
    } catch (e) {
      emit(HomeError("Failed to fetch home data"));
    }
  }
}
