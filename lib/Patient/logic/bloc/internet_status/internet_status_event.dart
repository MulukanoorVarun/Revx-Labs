part of 'internet_status_bloc.dart';

abstract class InternetStatusEvent extends Equatable {
  const InternetStatusEvent();

  @override
  List<Object?> get props => [];
}

// Event for detecting internet is back
class InternetStatusBackEvent extends InternetStatusEvent {}

// Event for detecting internet is lost
class InternetStatusLostEvent extends InternetStatusEvent {}

// ✅ New Event: Trigger manual internet check
class CheckInternetEvent extends InternetStatusEvent {}
