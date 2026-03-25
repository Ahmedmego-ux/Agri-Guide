import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/domain/entitys/profile_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_feild_tile.dart';

import 'package:agri_guide_app/feature/profile/presentation/widgets/profile_save_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatefulWidget {
  final LoginEntity loginEntity;
  
  
  const ProfileViewBody({super.key,required this.loginEntity});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  // Controllers
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


       void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);
  }
  void _saveChanges() async{
    if (_formKey.currentState!.validate()) {
     
    final currentState = context.read<ProfileCubit>().state;

  final updatedProfile = ProfileEntity(
    id:  widget.loginEntity.id,  
    firstName: _firstNameController.text.trim(),
    lastName: _lastNameController.text.trim(),
    email: _emailController.text.trim(),
    location: _locationController.text.trim(),
  );
 await context.read<ProfileCubit>().updateData(profile: updatedProfile);

  setState(() => _isEditing = false);

    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        
        actions: [
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              _isEditing ? 'Cancel' : 'Edit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isEditing
                    ? const Color(0xFFE24B4A)
                    : const Color(0xFF2E9E47),
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
           if (state is ProfileSuccessUpdate) { 
    ErrorHandler.showSuccessSnackBar(context, 'Profile updated successfully');
  }
        },
        builder: (context, state) {
         
          if (state is ProfileLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading profile...'),
                ],
              ),
            );
          }

          
          if (state is ProfileFaliure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load profile',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errmessage,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().getProfileData();
                    },
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
                            radius: 50,
                            backgroundColor: Colors.green.shade100,
                            child: Text(
                              _initials,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _fullName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  //  const SizedBox(height: 32),
                    
                   
                    // ─── PERSONAL INFO ───────────────────────────
                _buildSectionHeader('PERSONAL INFO'),
                _buildFormGroup([
                  ProfileFieldTile(
                    controller: _firstNameController,
                    label: 'First Name',
                    icon: Icons.person_outline,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: const Color(0xFF2E9E47),
                    isEditing: _isEditing,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const Divider(height: 1, indent: 68, color: Color(0xFFEEEEEE)),
                  ProfileFieldTile(
                    controller: _lastNameController,
                    label: 'Last Name',
                    icon: Icons.person_outline,
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: const Color(0xFF2E9E47),
                    isEditing: _isEditing,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                ]),
               
                // ─── CONTACT ─────────────────────────────────
                _buildSectionHeader('CONTACT'),
                _buildFormGroup([
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
                      if (!v.contains('@')) return 'Invalid email';
                      return null;
                    },
                  ),
                  const Divider(height: 1, indent: 68, color: Color(0xFFEEEEEE)),
                  ProfileFieldTile(
                    controller: _locationController,
                    label: 'Location',
                    icon: Icons.location_on_outlined,
                    iconBg: const Color(0xFFFFF3E0),
                    iconColor: const Color(0xFFE65100),
                    isEditing: _isEditing,
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                ]),
               
                const SizedBox(height: 8),
               
                // ─── Save Button ──────────────────────────────
                if (_isEditing)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ProfileSaveButton(onPressed: _saveChanges),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
          letterSpacing: 0.8,
        ),
      ),
    );
  }
  Widget _buildFormGroup(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }
  
}