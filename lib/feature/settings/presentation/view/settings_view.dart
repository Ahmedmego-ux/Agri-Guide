
import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/view/profile_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/help_faq_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/privacy_policy_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_item.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_toggle_item.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
   final LoginEntity loginEntity;

 SettingsView({super.key,required this.loginEntity});
 

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;

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
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── PROFILE ───────────────────────────────────
            _buildSectionHeader('PROFILE'),
            _buildSettingsGroup([
              SettingItem(
                icon: Icons.person_outline,
                iconBg: const Color(0xFFE8F5E9),
                iconColor: const Color(0xFF2E9E47),
                title: 'Account',
                subtitle: 'Manage your profile',
                onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfileView(loginEntity: widget.loginEntity,))),
              ),
            ]),
            SizedBox(height: 30,),

            // ─── PREFERENCES ───────────────────────────────
            _buildSectionHeader('PREFERENCES'),
            _buildSettingsGroup([
              SettingItem(
                icon: Icons.language_outlined,
                iconBg: const Color(0xFFE8EAF6),
                iconColor: const Color(0xFF3949AB),
                title: 'Language',
                subtitle: 'English',
                onTap: () {},
              ),
              const Divider(height: 10, indent: 68, endIndent: 0, color: Color(0xFFEEEEEE)),
              SettingToggleItem(
                icon: Icons.dark_mode_outlined,
                iconBg: const Color(0xFFEDE7F6),
                iconColor: const Color(0xFF673AB7),
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                value: _isDarkMode,
                onChanged: (val) => setState(() => _isDarkMode = val),
              ),
            ]),
             SizedBox(height: 30,),

            // ─── SUPPORT ───────────────────────────────────
            _buildSectionHeader('SUPPORT'),
            _buildSettingsGroup([
              SettingItem(
                icon: Icons.help_outline,
                iconBg: const Color(0xFFFFF8E1),
                iconColor: const Color(0xFFF9A825),
                title: 'Help & FAQ',
                subtitle: 'Get answers to common questions',
                 onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>HelpFaqView())),
              ),
              const Divider(height: 10, indent: 68, endIndent: 0, color: Color(0xFFEEEEEE)),
              SettingItem(
                icon: Icons.security_outlined,
                iconBg: const Color(0xFFF3F3F3),
                iconColor: const Color(0xFF757575),
                title: 'Privacy Policy',
                subtitle: 'Learn how we protect your data',
                 onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyView())),
              ),
            ]),

            const SizedBox(height: 32),
           
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
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

  Widget _buildSettingsGroup(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }
}


