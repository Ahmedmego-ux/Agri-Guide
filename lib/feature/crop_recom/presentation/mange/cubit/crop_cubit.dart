import 'package:agri_guide_app/feature/crop_recom/domain/entity/crop_entity.dart';
import 'package:agri_guide_app/feature/crop_recom/domain/repos/crop_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'crop_state.dart';

class CropCubit extends Cubit<CropState> {
  CropCubit(this.cropRepo) : super(CropInitial());
  final CropRepo cropRepo;
 Future<void> recommendCrop({
    required double lat,
    required double lon,
  }) async {
    
    if (isClosed) return;
    emit(CropLoading());
    try {
      final result = await cropRepo.recommendCrop(lat: lat, lon: lon);
      if (isClosed) return;
      emit(CropSuccess(listCropEntity: result));
    } catch (e) {
      if (isClosed) return;
      emit(CropFailure(errmessage: e.toString()));
    }
  }
}
