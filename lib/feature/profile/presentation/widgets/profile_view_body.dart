import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/core/service/location_service.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/auth/presentation/view/login_view.dart';
import 'package:agri_guide_app/feature/home/presentation/manger/cubit/weather_cubit.dart';
import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_feild_tile.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart';

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
    double ?lon;
    
    final coords =
        await LocationService().getCoordinatesFromCity(locationName);
        print(coords);

    if (coords != null) {
      lat = coords['lat'];
      lon = coords['lon'];
     
      print("jjjjjjjjjjjjjjj$lat jjjjjjjj$lon");
    } else {
     
      print('Could not get coordinates for $locationName');
    }
    if (_formKey.currentState!.validate()) {
      final updatedProfile = ProfileEntity(
        id: context.read<ProfileCubit>().userId,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        location:locationName,
        lat: lat,
        lon: lon
      );
       context.read<WeatherCubit>().getWeather(lat,lon);
      await context.read<ProfileCubit>().updateData(profile: updatedProfile);
      setState(() => _isEditing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.appBarTheme.foregroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Profile'),
        actions: [
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              _isEditing ? 'Cancel' : 'Edit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isEditing ? cs.error : cs.surface,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFaliure) {
            ErrorHandler.showErrorSnackBar(context, state.errmessage);
          }
           if (state is DeleteSuccess) {
             Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginView(),
                                  ),
                                  (route) => false,
                                );
            ErrorHandler.showErrorSnackBar(context, 'Account Deleted');
          }
          if (state is ProfileSuccessUpdate) {
            ErrorHandler.showSuccessSnackBar(
              context,
              'Profile updated successfully',
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
                  Text('Loading profile...', style: theme.textTheme.bodyMedium),
                ],
              ),
            );
          }

          if (state is ProfileFaliure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: cs.error),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errmessage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProfileCubit>().getProfileData(),
                    child: const Text('Retry'),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: cs.primaryContainer,
                            child: Text(
                              _initials,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: cs.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _fullName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSectionHeader(context, 'PERSONAL INFO'),
                    SizedBox(height: 10),
                    _buildFormGroup(context, [
                      ProfileFieldTile(
                        controller: _firstNameController,
                        label: 'First Name',
                        icon: Icons.person_outline,
                        iconBg: cs.primaryContainer,
                        iconColor: cs.onPrimaryContainer,
                        isEditing: _isEditing,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      Divider(
                        height: 15,
                        indent: 68,
                        color: theme.dividerTheme.color,
                      ),
                      ProfileFieldTile(
                        controller: _lastNameController,
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        iconBg: cs.primaryContainer,
                        iconColor: cs.onPrimaryContainer,
                        isEditing: _isEditing,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ]),
                    _buildSectionHeader(context, 'CONTACT'),
                    _buildFormGroup(context, [
                      ProfileFieldTile(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        iconBg: const Color(0xFFE8EAF6),
                        iconColor: const Color(0xFF3949AB),
                        isEditing: _isEditing,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (!v.contains('@gmail')) return 'Your Email Isnot Type Of Gmail';
                          return null;
                        },
                      ),
                      Divider(
                        height: 15,
                        indent: 68,
                        color: theme.dividerTheme.color,
                      ),
                      ProfileFieldTile(
                        controller: _locationController,
                        label: 'Location',
                        icon: Icons.location_on_outlined,
                        iconBg: const Color(0xFFFFF3E0),
                        iconColor: const Color(0xFFE65100),
                        isEditing: _isEditing,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ]),
                    const SizedBox(height: 32),
                    if (_isEditing)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ProfileButton(
                          value: "Save Changes",
                          onPressed: _saveChanges,
                        ),
                      ),

                    if (!_isEditing)
                      Row(
                        children: [
                          Expanded(
                            child: ProfileButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginView(),
                                  ),
                                  (route) => false,
                                );
                              },
                              icon: Icons.delete,
                              iconColor: const Color(0xffE7000B),
                              textColor: const Color(0xffE7000B),
                              backgroundColor: const Color(0xffFEF2F2),
                              value: "Log Out",
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: ProfileButton(
                              onPressed: () =>context.read<ProfileCubit>().deletData(userId: context.read<ProfileCubit>().userId),
                              icon: Icons.logout,
                              backgroundColor: Color(0xffF3F4F6),
                              iconColor: Color(0xff4A5565),
                              textColor: Color(0xff4A5565),
                              value: "Delet Acount",
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: cs.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildFormGroup(BuildContext context, List<Widget> items) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }
}
