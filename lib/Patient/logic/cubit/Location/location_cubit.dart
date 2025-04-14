import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import '../../../../Utils/Preferances.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  /// Check if location permission and services are enabled
  Future<void> checkLocationPermission() async {
    emit(LocationLoading());

    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!isServiceEnabled) {
        emit(LocationPermissionDenied(message: 'Please enable GPS/location services.'));
        return;
      }

      if (permission == LocationPermission.denied) {
        emit(LocationPermissionDenied());
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError('Location permission is permanently denied. Please enable it in settings.'));
        return;
      }

      await _getLatLong();
    } catch (e) {
      emit(LocationError('Failed to check location permissions: ${e.toString()}'));
    }
  }

  /// Request location permission from user
  Future<void> requestLocationPermission() async {
    emit(LocationLoading());

    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        isServiceEnabled = await Geolocator.openLocationSettings();
        if (!isServiceEnabled) {
          emit(LocationPermissionDenied(message: 'GPS must be enabled to proceed.'));
          return;
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationPermissionDenied());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError('Location permission is permanently denied. Please enable it in settings.'));
        return;
      }

      await _getLatLong();
    } catch (e) {
      emit(LocationError('Failed to request location permission: ${e.toString()}'));
    }
  }

  /// Fetch user's current latitude and longitude
  Future<void> _getLatLong() async {
    try {
      // Set platform-specific accuracy
      LocationAccuracy accuracy = Platform.isAndroid ? LocationAccuracy.high : LocationAccuracy.best;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy,
        timeLimit: const Duration(seconds: 10),
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw Exception('Location fetch timed out');
      });

      // Reverse geocode with fallback
      String locationName = await _getLocationName(position.latitude, position.longitude);
      String latlngs = '${position.latitude},${position.longitude}';

      // Save to preferences
       PreferenceService().saveString('LocName', locationName);
       PreferenceService().saveString('latlngs', latlngs);

      emit(LocationLoaded(locationName: locationName, latlng: latlngs));
    } catch (e) {
      emit(LocationError('Failed to fetch location: ${e.toString()}'));
    }
  }

  /// Reverse geocode coordinates to a readable address
  Future<String> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.street ?? ''}, ${placemark.subLocality ?? placemark.locality ?? 'Unknown'}'.trim();
      }
      return await PreferenceService().getString('LocName') ?? 'Gachibowli, Hyderabad';
    } catch (e) {
      return await PreferenceService().getString('LocName') ?? 'Gachibowli, Hyderabad';
    }
  }
}