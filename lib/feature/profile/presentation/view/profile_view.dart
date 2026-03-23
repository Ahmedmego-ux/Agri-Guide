import 'package:agri_guide_app/feature/profile/presentation/view/widgets/profile_avater.dart';
import 'package:agri_guide_app/feature/profile/presentation/view/widgets/profile_feild_tile.dart';
import 'package:agri_guide_app/feature/profile/presentation/view/widgets/profile_save_button.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  final _firstNameController = TextEditingController(text: 'Ahmed');
  final _lastNameController  = TextEditingController(text: 'Mohamed');
  final _emailController     = TextEditingController(text: 'ahmed@gmail.com');
  final _locationController  = TextEditingController(text: 'Cairo, Egypt');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isEditing = false);
      // حط هنا الـ save logic
    }
  }

  String get _initials {
    final f = _firstNameController.text;
    final l = _lastNameController.text;
    return '${f.isNotEmpty ? f[0] : ''}${l.isNotEmpty ? l[0] : ''}'.toUpperCase();
  }

  String get _fullName =>
      '${_firstNameController.text} ${_lastNameController.text}';

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

            
              ProfileAvatar(
                initials: _initials,
                fullName: _fullName,
              ),

              const SizedBox(height: 28),

            
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
                const Divider(height: 20, indent: 68, color: Color(0xFFEEEEEE)),
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
                    if (!v.contains('@gmail.com')) return 'Invalid email';
                    return null;
                  },
                ),
                const Divider(height: 20, indent: 68, color: Color(0xFFEEEEEE)),
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
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF9E9E9E),
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



