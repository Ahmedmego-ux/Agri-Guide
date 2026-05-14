import 'package:easy_localization/easy_localization.dart';
import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/core/service/location_service.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/home/presentation/manger/cubit/weather_cubit.dart';
import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_feild_tile.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _locationController = TextEditingController();
  }

  void _updateControllers(ProfileEntity profile) {
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _emailController.text = profile.email;
    _locationController.text = profile.location;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String get _initials {
    final f = _firstNameController.text;
    final l = _lastNameController.text;
    return '${f.isNotEmpty ? f[0] : ''}${l.isNotEmpty ? l[0] : ''}'
        .toUpperCase();
  }

  String get _fullName =>
      '${_firstNameController.text} ${_lastNameController.text}';

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  void _saveChanges() async {
    final locationName = _locationController.text.trim();
    double? lat;
    double? lon;

    final coords =
        await LocationService().getCoordinatesFromCity(locationName);

    if (coords != null) {
      lat = coords['lat'];
      lon = coords['lon'];
    }

    if (_formKey.currentState!.validate()) {
      final updatedProfile = ProfileEntity(
        id: context.read<ProfileCubit>().userId,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        location: locationName,
        lat: lat,
        lon: lon,
      );

      context.read<WeatherCubit>().getWeather(lat, lon);

      await context
          .read<ProfileCubit>()
          .updateData(profile: updatedProfile);

      setState(() => _isEditing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final isRTL =
        Directionality.of(context) == TextDirection.RTL;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFaliure) {
            ErrorHandler.showErrorSnackBar(
              context,
              state.errmessage,
            );
          }

          if (state is DeleteSuccess) {
            ErrorHandler.showErrorSnackBar(
              context,
              'accountDeleted'.tr(),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginView()),
              (route) => false,
            );
          }

          if (state is ProfileSuccessUpdate) {
            ErrorHandler.showSuccessSnackBar(
              context,
              'profileUpdatedSuccess'.tr(),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: cs.primary),
                  const SizedBox(height: 16),
                  Text('loadingProfile'.tr()),
                ],
              ),
            );
          }

          if (state is ProfileFaliure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48, color: cs.error),
                  const SizedBox(height: 16),
                  Text('failedToLoadProfile'.tr()),
                  const SizedBox(height: 8),
                  Text(state.errmessage),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context
                        .read<ProfileCubit>()
                        .getProfileData(),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileSuccess) {
            if (_firstNameController.text.isEmpty) {
              _updateControllers(state.profileEntity);
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                          16, 52, 16, 28),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -20,
                            right: -20,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Colors.white.withOpacity(0.07),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pop(context),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    isRTL
                                        ? Icons
                                            .arrow_forward_ios_rounded
                                        : Icons
                                            .arrow_back_ios_rounded,
                                    color: cs.onPrimary,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Text(
                                'myProfile'.tr(),
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: cs.onPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              GestureDetector(
                                onTap: _toggleEdit,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 7),
                                  decoration: BoxDecoration(
                                    color: _isEditing
                                        ? cs.error
                                            .withOpacity(0.15)
                                        : Colors.white
                                            .withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _isEditing
                                        ? 'cancel'.tr()
                                        : 'edit'.tr(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _isEditing
                                          ? cs.error
                                          : cs.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(top: 52),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 84,
                                    height: 84,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                          .withOpacity(0.25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _initials,
                                        style: theme.textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                          color: cs.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _fullName,
                                    style: theme
                                        .textTheme.titleLarge
                                        ?.copyWith(
                                      color: cs.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildSectionHeader(
                              context, 'personalInfo'.tr()),

                          _buildFormGroup(context, [
                            ProfileFieldTile(
                              controller: _firstNameController,
                              label: 'firstName'.tr(),
                              icon: Icons.person_outline,
                              iconBg: cs.primaryContainer,
                              iconColor:
                                  cs.onPrimaryContainer,
                              isEditing: _isEditing,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'required'.tr()
                                  : null,
                            ),
                            ProfileFieldTile(
                              controller: _lastNameController,
                              label: 'lastName'.tr(),
                              icon: Icons.person_outline,
                              iconBg: cs.primaryContainer,
                              iconColor:
                                  cs.onPrimaryContainer,
                              isEditing: _isEditing,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'required'.tr()
                                  : null,
                            ),
                          ]),

                          _buildSectionHeader(
                              context, 'contact'.tr()),

                          _buildFormGroup(context, [
                            ProfileFieldTile(
                              controller: _emailController,
                              label: 'email'.tr(),
                              icon: Icons.email_outlined,
                              iconBg: const Color(0xFFE8EAF6),
                              iconColor: const Color(0xFF3949AB),
                              isEditing: _isEditing,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'required'.tr();
                                }
                                return null;
                              },
                            ),
                            ProfileFieldTile(
                              controller: _locationController,
                              label: 'location'.tr(),
                              icon: Icons.location_on_outlined,
                              iconBg: const Color(0xFFFFF3E0),
                              iconColor:
                                  const Color(0xFFE65100),
                              isEditing: _isEditing,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'required'.tr()
                                  : null,
                            ),
                          ]),

                          if (_isEditing)
                            ProfileButton(
                              value: 'saveChanges'.tr(),
                              onPressed: _saveChanges,
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileButton(
                                    value: 'logout'.tr(),
                                    onPressed: () async{
                                        await Supabase.instance.client.auth.signOut();
                                      Navigator
                                          .pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                LoginView()),
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ProfileButton(
                                    value:
                                        'deleteAccount'.tr(),
                                    onPressed: () => context
                                        .read<ProfileCubit>()
                                        .deletData(
                                          userId: context
                                              .read<
                                                  ProfileCubit>()
                                              .userId,
                                        ),
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildFormGroup(BuildContext context, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: items),
    );
  }
}