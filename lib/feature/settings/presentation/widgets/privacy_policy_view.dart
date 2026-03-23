import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
          'Privacy Policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF3949AB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.security_outlined, color: Colors.white, size: 32),
                  SizedBox(height: 10),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Last updated: January 1, 2025',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sections
            _buildSection(
              icon: Icons.info_outline,
              iconColor: const Color(0xFF3949AB),
              iconBg: const Color(0xFFE8EAF6),
              title: '1. Information We Collect',
              content:
                  'We collect information you provide directly to us, such as when you create an account, update your profile, or contact us for support. This includes your name, email address, and location.\n\nWe also collect information about how you use the app, including plant scan images, chat history, and usage patterns to improve our services.',
            ),

            _buildSection(
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF2E9E47),
              iconBg: const Color(0xFFE8F5E9),
              title: '2. How We Use Your Information',
              content:
                  'We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process plant disease diagnoses\n• Send you technical notices and support messages\n• Respond to your comments and questions\n• Monitor and analyze usage trends',
            ),

            _buildSection(
              icon: Icons.share_outlined,
              iconColor: const Color(0xFFE65100),
              iconBg: const Color(0xFFFFF3E0),
              title: '3. Information Sharing',
              content:
                  'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.\n\nWe may share your information with trusted service providers who assist us in operating our app, conducting our business, or serving our users, as long as those parties agree to keep this information confidential.',
            ),

            _buildSection(
              icon: Icons.lock_outline,
              iconColor: const Color(0xFF7B1FA2),
              iconBg: const Color(0xFFF3E5F5),
              title: '4. Data Security',
              content:
                  'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.\n\nAll data is encrypted in transit using SSL/TLS encryption. Plant images are processed securely and are not stored permanently on our servers.',
            ),

            _buildSection(
              icon: Icons.person_outline,
              iconColor: const Color(0xFF1565C0),
              iconBg: const Color(0xFFE3F2FD),
              title: '5. Your Rights',
              content:
                  'You have the right to:\n\n• Access the personal information we hold about you\n• Request correction of inaccurate data\n• Request deletion of your account and data\n• Opt out of marketing communications\n• Data portability',
            ),

            _buildSection(
              icon: Icons.child_care_outlined,
              iconColor: const Color(0xFFE91E63),
              iconBg: const Color(0xFFFCE4EC),
              title: '6. Children\'s Privacy',
              content:
                  'Our app is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe your child has provided us with personal information, please contact us.',
            ),

            _buildSection(
              icon: Icons.update_outlined,
              iconColor: const Color(0xFF00796B),
              iconBg: const Color(0xFFE0F2F1),
              title: '7. Changes to This Policy',
              content:
                  'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.\n\nYour continued use of the app after any changes constitutes your acceptance of the new Privacy Policy.',
            ),

            _buildSection(
              icon: Icons.email_outlined,
              iconColor: const Color(0xFF5D4037),
              iconBg: const Color(0xFFEFEBE9),
              title: '8. Contact Us',
              content:
                  'If you have any questions about this Privacy Policy, please contact us at:\n\nEmail: privacy@agriguide.com\nAddress: AgriGuide Inc., Cairo, Egypt',
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}