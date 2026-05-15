import 'package:agri_guide_app/feature/crop_recom/presentation/widget/crop_reco_view_body.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CropRecoView extends StatelessWidget {
  const CropRecoView({super.key, required this.loginEntity});

  final LoginEntity loginEntity;

  @override
  Widget build(BuildContext context) {
    // ✅ جرب تاخد الـ lat/lon من ProfileCubit الأول
    // لو البروفايل اتحدث هياخد الإحداثيات الجديدة
    // لو لا هياخدهم من الـ loginEntity الأصلية
    final profileState = context.read<ProfileCubit>().state;

    double lat = loginEntity.latitude;
    double lon = loginEntity.longitude;

    if (profileState is ProfileSuccess) {
      final profileLat = profileState.profileEntity.lat;
      final profileLon = profileState.profileEntity.lon;
      if (profileLat != null && profileLon != null) {
        lat = profileLat;
        lon = profileLon;
      }
    }

    return CropRecoViewBody(lat: lat, lon: lon);
  }
}