import 'package:flutter_bloc/flutter_bloc.dart';
import 'Patient/logic/bloc/internet_status/internet_status_bloc.dart';


class StateInjector {
  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(
      create: (context) => InternetStatusBloc(),
    ),
  ];
}
