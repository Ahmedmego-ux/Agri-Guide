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
  final _emailController     = TextEditingController(text: 'ahmed@example.com');
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

              // ─── Avatar ──────────────────────────────────
              ProfileAvatar(
                initials: _initials,
                fullName: _fullName,
              ),

              const SizedBox(height: 28),

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

// ─── ProfileAvatar ────────────────────────────────────────────
class ProfileAvatar extends StatelessWidget {
  final String initials;
  final String fullName;

  const ProfileAvatar({
    super.key,
    required this.initials,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2E9E47),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            fullName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── ProfileFieldTile ─────────────────────────────────────────
class ProfileFieldTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isEditing;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const ProfileFieldTile({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.isEditing,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Field
          Expanded(
            child: isEditing
                ? TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    validator: validator,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                    ),
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: iconColor, width: 1.5),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE24B4A)),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        controller.text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── ProfileSaveButton ────────────────────────────────────────
class ProfileSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E9E47),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}