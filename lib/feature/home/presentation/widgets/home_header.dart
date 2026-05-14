import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/market/presentation/view/market_view.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.loginEntity});
  final LoginEntity loginEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String firstName = loginEntity.firstName;
        String lastName = loginEntity.lastName;
        String cityName = loginEntity.cityName;

        if (state is ProfileSuccess) {
          firstName = state.profileEntity.firstName;
          lastName = state.profileEntity.lastName;
          cityName = state.profileEntity.location;
        }

        final String fullName = '$firstName $lastName'.trim();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: greeting + name + city
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                       'welcome'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('🌿', style: TextStyle(fontSize: 14, height: 1.0)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  fullName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (cityName.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        cityName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),

          //   // Market icon avatar
          //   GestureDetector(
          //     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MarketView())),
          //     child: CircleAvatar(
          //       radius: 25,
          //       child: SvgPicture.asset('assets/market_icon_v2.svg',width: 40,height: 60,)))
           ],
          ),
        );
      },
    );
  }
}