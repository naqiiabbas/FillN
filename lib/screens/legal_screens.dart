import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class _LegalSection {
  final String title;
  final String body;
  const _LegalSection(this.title, this.body);
}

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScaffold(
      title: 'Terms of Service',
      sections: [
        _LegalSection(
          '1. Acceptance of Terms',
          'By accessing and using this staffing platform, you accept and agree to be bound by the terms and provision of this agreement.',
        ),
        _LegalSection(
          '2. Use License',
          'Permission is granted to temporarily access the platform for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
        ),
        _LegalSection(
          '3. User Accounts',
          'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',
        ),
        _LegalSection(
          '4. Privacy Policy',
          'Your use of the platform is also governed by our Privacy Policy. Please review our Privacy Policy to understand our practices.',
        ),
        _LegalSection(
          '5. Modifications',
          "We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.",
        ),
        _LegalSection(
          '6. Contact Information',
          'For questions about the Terms of Service, please contact us at legal@staffing.com',
        ),
      ],
      lastUpdated: 'Last updated: February 4, 2026',
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScaffold(
      title: 'Privacy Policy',
      sections: [
        _LegalSection(
          'Information We Collect',
          'We collect information you provide directly to us, such as when you create an account, update your profile, or contact us for support.',
        ),
        _LegalSection(
          'How We Use Your Information',
          'We use the information we collect to provide, maintain, and improve our services, to process transactions, and to communicate with you.',
        ),
        _LegalSection(
          'Information Sharing',
          'We do not share your personal information with third parties except as described in this privacy policy or with your consent.',
        ),
        _LegalSection(
          'Data Security',
          'We take reasonable measures to help protect information about you from loss, theft, misuse and unauthorized access, disclosure, alteration and destruction.',
        ),
        _LegalSection(
          'Your Rights',
          'You have the right to access, update, or delete your personal information at any time through your account settings.',
        ),
        _LegalSection(
          'Contact Us',
          'If you have any questions about this Privacy Policy, please contact us at privacy@staffing.com',
        ),
      ],
      lastUpdated: 'Last updated: February 4, 2026',
    );
  }
}

class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScaffold(
      title: 'Compliance Information',
      sections: [
        _LegalSection(
          'GDPR Compliance',
          'We are committed to complying with the General Data Protection Regulation (GDPR) for users in the European Union. You have the right to access, rectify, and erase your personal data.',
        ),
        _LegalSection(
          'CCPA Compliance',
          'For California residents, we comply with the California Consumer Privacy Act (CCPA). You have the right to know what personal information we collect and request deletion of your data.',
        ),
        _LegalSection(
          'SOC 2 Type II',
          'Our platform is SOC 2 Type II certified, ensuring that we maintain high standards for security, availability, and confidentiality of customer data.',
        ),
        _LegalSection(
          'Data Retention',
          'We retain personal data only for as long as necessary to fulfill the purposes outlined in our Privacy Policy, unless a longer retention period is required by law.',
        ),
        _LegalSection(
          'International Transfers',
          'When we transfer personal data internationally, we ensure appropriate safeguards are in place to protect your information.',
        ),
        _LegalSection(
          'Compliance Contact',
          'For compliance-related inquiries, please contact compliance@staffing.com',
        ),
      ],
      lastUpdated: 'Last updated: February 4, 2026',
    );
  }
}

class _LegalScaffold extends StatelessWidget {
  final String title;
  final List<_LegalSection> sections;
  final String lastUpdated;

  const _LegalScaffold({
    required this.title,
    required this.sections,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              title: title,
              onBack: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < sections.length; i++) ...[
                      Text(
                        sections[i].title,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sections[i].body,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.55,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (i < sections.length - 1) const SizedBox(height: 18),
                    ],
                    const SizedBox(height: 18),
                    Text(
                      lastUpdated,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  const _Header({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(32, topPad + 16, 32, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Back',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
