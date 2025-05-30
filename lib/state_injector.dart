import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment/appointment_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment_details/appointment_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/banners/banners_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_detail/diagnostic_detail_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/home/home_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/repository/DiagnosticDetailsRepository.dart';
import 'package:revxpharma/Patient/logic/repository/LoginRepository.dart';
import 'package:revxpharma/Patient/logic/repository/appointment_repository.dart';
import 'package:revxpharma/Patient/logic/repository/banners_repository.dart';
import 'package:revxpharma/Patient/logic/repository/cart_repository.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import 'package:revxpharma/Patient/logic/repository/patient_register_repository.dart';
import 'package:revxpharma/Patient/logic/repository/patient_repository.dart';
import 'package:revxpharma/Patient/logic/repository/test_details_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_categories/diognostic_get_categories_cubit.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_categories/diognostic_get_category_repository.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_cubit.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_repository.dart';
import 'package:revxpharma/data/api_routes/VendorRemoteDataSource.dart';
import 'Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'Patient/logic/cubit/cart/cart_cubit.dart';
import 'Patient/logic/repository/category_repository.dart';
import 'Vendor/bloc/diognostic_register/register_cubit.dart';
import 'Vendor/bloc/diognostic_register/register_repository.dart';
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

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///   Vendor Repositories /////////

    RepositoryProvider<VendorRemoteDataSource>(
      create: (context) => VendorRemoteDataSourceImpl(),
    ),

    RepositoryProvider<VendorRegisterRepository>(
      create: (context) => VendorRegisterImpl(remoteDataSource: context.read()),
    ),

    RepositoryProvider<DiagnosticTestsRepository>(
      create: (context) =>
          DiagnosticTestsImp(vendorRemoteDataSource: context.read()),
    ),

    RepositoryProvider<VendorRegisterRepository>(
      create: (context) => VendorRegisterImpl(remoteDataSource: context.read()),
    ),

    RepositoryProvider<DiognosticGetCategoryRepository>(
        create: (context) =>
            DiognosticGetCategoryImpl(vendorRemoteDataSource: context.read())),
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
        diagnosticCentersRepository: context.read<DiagnosticCenterRepository>(),
        profileRepository: context.read<ProfileRepository>(),
      ),
    ),
    BlocProvider<TestCubit>(
      create: (context) => TestCubit(context.read<TestRepository>()),
    ),
    BlocProvider<ConditionCubit>(
      create: (context) => ConditionCubit(context.read<ConditionRepository>()),
    ),
    BlocProvider<PatientCubit>(
      create: (context) => PatientCubit(context.read<PatientRepository>()),
    ),

    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        cartRepository: context.read<CartRepository>(),
        testCubit: context.read<TestCubit>(),
      ),
    ),
    BlocProvider<ProfileCubit>(
        create: (context) =>
            ProfileCubit(profileRepository: context.read<ProfileRepository>())),
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

    BlocProvider<TestDetailsCubit>(
      create: (context) =>
          TestDetailsCubit(context.read<TestDetailsRepository>()),
    ),


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Vendor Bloc Providers //

    BlocProvider<VendorRegisterCubit>(
      create: (context) =>
          VendorRegisterCubit(context.read<VendorRegisterRepository>()),
    ),

    BlocProvider<DiagnosticTestsCubit>(
      create: (context) =>
          DiagnosticTestsCubit(context.read<DiagnosticTestsRepository>()),
    ),

    BlocProvider<DiognosticCategoryCubit>(
        create: (context) => DiognosticCategoryCubit(
            diognosticRepo: context.read<DiognosticGetCategoryRepository>()))
  ];
}
