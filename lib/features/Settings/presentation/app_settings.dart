import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // white background
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ← back arrow + title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => GoRouter.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'App Settings',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Save progress banner
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2CC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          const Icon(Icons.person_outline, size: 32),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Save your progress!',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: implement sign up
                          GoRouter.of(context).push('/signup');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Section: APP SETTINGS
                Text(
                  'APP SETTINGS',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 8),
                _buildTile(
                  context,
                  label: 'App Language',
                  icon: Icons.open_in_new,
                  onTap: () => GoRouter.of(context).push('/app-language'),
                ),
                const Divider(height: 1),

                _buildTile(
                  context,
                  label: 'Reminders',
                  icon: Icons.chevron_right,
                  onTap: () => GoRouter.of(context).push('/reminders'),
                ),
                const Divider(height: 1),

                const SizedBox(height: 32),

                // Section: EMCSQUARE
                Text(
                  'EMCSQUARE',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 8),
                _buildTile(
                  context,
                  label: 'Privacy policy',
                  icon: Icons.chevron_right,
                  onTap: () => GoRouter.of(context).push('/privacy-policy'),
                ),
                const Divider(height: 1),

                _buildTile(
                  context,
                  label: 'Terms & Conditions',
                  icon: Icons.chevron_right,
                  onTap: () => GoRouter.of(context).push('/terms-conditions'),
                ),
                const Divider(height: 1),

                _buildTile(
                  context,
                  label: 'Contact EMCSQUARE',
                  icon: Icons.chevron_right,
                  onTap: () => GoRouter.of(context).push('/contact'),
                ),
                const Divider(height: 1),

                _buildTile(
                  context,
                  label: 'Manage Subscription',
                  icon: Icons.chevron_right,
                  onTap: () => GoRouter.of(context).push('/manage-subscription'),
                ),
                const Divider(height: 1),

                const SizedBox(height: 48),

                // bottom logo + version
                Center(
                  child: Column(
                    children: [
                      // replace with your actual logo asset if you have one
                      Icon(Icons.bolt, size: 32, color: Colors.black),
                      const SizedBox(height: 8),
                      Text(
                        'Version 1.1.7 (122)',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '© 2025 EMCSQUARE Coach Inc.  User ID: 999fc1e7-f07b-46a3-8e0c-56cd260bb601',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(icon, color: Colors.black54),
      onTap: onTap,
    );
  }
}
