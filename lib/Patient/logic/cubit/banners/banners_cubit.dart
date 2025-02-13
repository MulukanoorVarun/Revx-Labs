import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/banners_repository.dart';
import 'banners_state.dart';

class BannersCubit extends Cubit<BannerState> {
  final BannersRepository bannersRepository;

  BannersCubit(this.bannersRepository) : super(BannerInitial());

  Future<void> fetchBanners() async {
    emit(BannerLoading());
    try {
      final banners = await bannersRepository.getBanners(); // ✅ Correct method call
      emit(BannerLoaded(banners!));
    } catch (e) {
      emit(BannerError("Failed to fetch banners"));
    }
  }
}
