import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/banners/banners_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/home/home_cubit.dart';
import 'package:revxpharma/Patient/logic/repository/banners_repository.dart';
import 'package:revxpharma/Patient/logic/repository/diagnostic_center_repository.dart';
import 'package:revxpharma/Patient/screens/HomeScreen.dart';
import 'Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'Patient/logic/repository/category_repository.dart';
import 'data/api_routes/remote_data_source.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[

    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(), // Ensure this is correctly implemented
    ),


    RepositoryProvider<CategoryRepository>(
      create: (context) => CategoryRepositoryImpl(remoteDataSource: context.read(),),
    ),

    RepositoryProvider<BannersRepository>(
      create: (context) => BannersRepositoryImpl(remoteDataSource: context.read(),),
    ),

    RepositoryProvider<DiagnosticCenterRepository>(
      create: (context) => DiagnosticCenterRepositoryImpl(remoteDataSource: context.read(),),
    ),
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(
      create: (context) => InternetStatusBloc(),
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

    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        categoryRepository: context.read<CategoryRepository>(),
        bannersRepository: context.read<BannersRepository>(),
        diagnosticCentersRepository: context.read<DiagnosticCenterRepository>(),
      ),
    ),
  ];
}
