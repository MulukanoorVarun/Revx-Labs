import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/banners/banners_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_repository.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_detail/diagnostic_detail_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/home/home_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_repository.dart';
import 'package:revxpharma/Patient/logic/repository/DiagnosticDetailsRepository.dart';
import 'package:revxpharma/Patient/logic/repository/banners_repository.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import 'Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'Patient/logic/repository/category_repository.dart';
import 'data/api_routes/remote_data_source.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<RemoteDataSource>(
      create: (context) =>
          RemoteDataSourceImpl(), // Ensure this is correctly implemented
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
      // Then create TestRepository using RemoteDataSource
      create: (context) => TestRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
    RepositoryProvider<ConditionRepository>(
      create: (context) => ConditionImpl(
        remoteDataSource: context.read(),
      ),
    ),
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
      ),
    ),
    BlocProvider<TestCubit>(
      create: (context) => TestCubit(context.read<TestRepository>()),
    ),
    BlocProvider<ConditionCubit>(
      create: (context) => ConditionCubit(context.read<ConditionRepository>()),
    ),
  ];
}
