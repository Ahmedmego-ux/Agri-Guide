part of 'crop_cubit.dart';

sealed class CropState extends Equatable {
  const CropState();

  @override
  List<Object> get props => [];
}

class CropInitial extends CropState {}

class CropLoading extends CropState {}

class CropSuccess extends CropState {
  final List <CropEntity> listCropEntity;
  CropSuccess({required this.listCropEntity});
}

class CropFailure extends CropState {
  final String errmessage;
  CropFailure({required this.errmessage});
}
