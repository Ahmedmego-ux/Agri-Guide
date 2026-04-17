import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/market/presentation/view/market_view.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
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

        return
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  fullName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (cityName.isNotEmpty)
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
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MarketView())),
              child: SvgPicture.asset('assets/market_icon.svg',width: 40,height: 60,))
            ]);
            
      },
    );
  }
}