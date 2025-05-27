import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/ConditionTests/condition_test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/ConditionTests/condition_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/RadiologyTests/radiology_test_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/RegularTest/regular_test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment/appointment_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment_details/appointment_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/banners/banners_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/delete_account/DeleteAccountCubit.dart';
import 'package:revxpharma/Patient/logic/cubit/delete_account/DeleteAccountRepository.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_detail/diagnostic_detail_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/home/home_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/prescritpionUpload/PrescriptionUploadCubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/repository/DiagnosticDetailsRepository.dart';
import 'package:revxpharma/Patient/logic/repository/LoginRepository.dart';
import 'package:revxpharma/Patient/logic/repository/PrescriptionUploadRepository.dart';
import 'package:revxpharma/Patient/logic/repository/appointment_repository.dart';
import 'package:revxpharma/Patient/logic/repository/banners_repository.dart';
import 'package:revxpharma/Patient/logic/repository/cart_repository.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import 'package:revxpharma/Patient/logic/repository/patient_register_repository.dart';
import 'package:revxpharma/Patient/logic/repository/patient_repository.dart';
import 'package:revxpharma/Patient/logic/repository/test_details_repository.dart';
import 'Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'Patient/logic/cubit/RegularTest/regular_test_repository.dart';
import 'Patient/logic/cubit/cart/cart_cubit.dart';
import 'Patient/logic/repository/category_repository.dart';
import 'data/api_routes/remote_data_source.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(),
    ),
    RepositoryProvider<CategoryRepository>(
      create: (context) => CategoryRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ConditionTestRepository>(
      create: (context) => ConditionTestRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<BannersRepository>(
      create: (context) => BannersRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<DiagnosticCenterRepository>(
      create: (context) => DiagnosticCenterRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<DiagnosticDetailsRepository>(
      create: (context) => DiagnosticDetailsRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<TestRepository>(
      create: (context) => TestRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<RegularTestRepository>(
      create: (context) => RegularTestRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ConditionRepository>(
      create: (context) => ConditionImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<PatientRepository>(
      create: (context) => PatientRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<CartRepository>(
      create: (context) => CartRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<PatientRepository>(
      create: (context) => PatientRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ProfileRepository>(
        create: (context) => ProfileImpl(remoteDataSource: context.read())),
    RepositoryProvider<AppointmentRepository>(
      create: (context) =>
          AppointmentRepositoryImpl(remoteDataSource: context.read()),
    ),
    RepositoryProvider<LoginRepository>(
      create: (context) => LoginImpl(remoteDataSource: context.read()),
    ),
    RepositoryProvider<PatientRegisterRepository>(
      create: (context) =>
          PatientRegisterImpl(remoteDataSource: context.read()),
    ),
    RepositoryProvider<TestDetailsRepository>(
        create: (context) =>
            TestDetailsRepositoryImpl(remoteDataSource: context.read())),
    RepositoryProvider<RadiologyTestRepository>(
        create: (context) =>
            RadiologyTestRepositoryImpl(remoteDataSource: context.read())),
    RepositoryProvider<PrescriptionUploadRepository>(
        create: (context) =>
            PrescriptionUploadRepositoryImpl(remoteDataSource: context.read())),
    RepositoryProvider<Deleteaccountrepository>(
        create: (context) =>
            DeleteaccountrepositoryImpl(remoteDataSource: context.read())),

  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(
      create: (context) => InternetStatusBloc(),
    ),
    BlocProvider<LocationCubit>(
      create: (context) => LocationCubit(),
    ),
    BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit(
        context.read<CategoryRepository>(),
      ),
    ),
    BlocProvider<BannersCubit>(
      create: (context) => BannersCubit(
        context.read<BannersRepository>(),
      ),
    ),
    BlocProvider<DiagnosticCentersCubit>(
      create: (context) => DiagnosticCentersCubit(
        context.read<DiagnosticCenterRepository>(),
      ),
    ),
    BlocProvider<DiagnostocDetailCubit>(
      create: (context) => DiagnostocDetailCubit(
        context.read<DiagnosticDetailsRepository>(),
      ),
    ),
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
          categoryRepository: context.read<CategoryRepository>(),
          bannersRepository: context.read<BannersRepository>(),
          diagnosticCentersRepository:
              context.read<DiagnosticCenterRepository>(),
          profileRepository: context.read<ProfileRepository>(),
          regularTestRepository: context.read<RegularTestRepository>(),
          radiologyTestRepository: context.read<RadiologyTestRepository>(),
          conditionTestRepository: context.read<ConditionTestRepository>()),
    ),
    BlocProvider<TestCubit>(
      create: (context) => TestCubit(context.read<TestRepository>()),
    ),
    BlocProvider<RadiologyTestCubit>(
      create: (context) =>
          RadiologyTestCubit(context.read<RadiologyTestRepository>()),
    ),
    BlocProvider<RegularTestCubit>(
      create: (context) =>
          RegularTestCubit(context.read<RegularTestRepository>()),
    ),
    BlocProvider<ConditionCubit>(
      create: (context) => ConditionCubit(context.read<ConditionRepository>()),
    ),
    BlocProvider<PatientCubit>(
      create: (context) => PatientCubit(context.read<PatientRepository>()),
    ),
    // Moved TestDetailsCubit BEFORE CartCubit
    BlocProvider<TestDetailsCubit>(
      create: (context) =>
          TestDetailsCubit(context.read<TestDetailsRepository>()),
    ),
    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        cartRepository: context.read<CartRepository>(),
        testCubit: context.read<TestCubit>(),
        testDetailsCubit: context.read<TestDetailsCubit>(),
      ),
    ),
    BlocProvider<ProfileCubit>(
      create: (context) =>
          ProfileCubit(profileRepository: context.read<ProfileRepository>()),
    ),
    BlocProvider<AppointmentCubit>(
      create: (context) =>
          AppointmentCubit(context.read<AppointmentRepository>()),
    ),
    BlocProvider<AppointmentDetailsCubit>(
      create: (context) =>
          AppointmentDetailsCubit(context.read<AppointmentRepository>()),
    ),
    BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(context.read<LoginRepository>()),
    ),
    BlocProvider<PatientRegisterCubit>(
      create: (context) =>
          PatientRegisterCubit(context.read<PatientRegisterRepository>()),
    ),
    BlocProvider<UploadPrescriptionCubit>(
      create: (context) =>
          UploadPrescriptionCubit(context.read<PrescriptionUploadRepository>()),
    ),
    BlocProvider<DeleteAccountCubit>(
      create: (context) =>
          DeleteAccountCubit(context.read<Deleteaccountrepository>()),
    ),
    BlocProvider<ConditionTestCubit>(
      create: (context) =>
          ConditionTestCubit(context.read<ConditionTestRepository>()),
    ),
  ];
}
