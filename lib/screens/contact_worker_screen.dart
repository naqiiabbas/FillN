import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class ContactWorkerScreen extends StatelessWidget {
  final String name;
  final String avatar;

  const ContactWorkerScreen({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProfileSection(name: name, avatar: avatar),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: [
                            Expanded(
                              child: _MiniStatCard(
                                value: '145',
                                label: 'Total Shifts',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _MiniStatCard(
                                value: '\$12,450',
                                label: 'Total Earnings',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: _PerformanceCard(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: AppColors.primaryBlue,
                    padding: EdgeInsets.fromLTRB(32, topPad + 24, 32, 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
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
                  ),
                ),
              ],
            ),
          ),
          _BottomActions(name: name),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String name;
  final String avatar;

  const _ProfileSection({required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final headerHeight = topPad + 280;
    const cardOverlap = 60.0;
    const avatarSize = 120.0;
    const avatarLeft = 24.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: headerHeight,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            32,
            headerHeight - cardOverlap,
            32,
            0,
          ),
          child: _ProfileCard(
            name: name,
            avatarSize: avatarSize,
            avatarLeft: avatarLeft,
          ),
        ),
        Positioned(
          left: 32 + avatarLeft - 4,
          top: headerHeight - cardOverlap - (avatarSize / 2) - 4,
          child: Container(
            width: avatarSize + 8,
            height: avatarSize + 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Image.asset(
                avatar,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name;
  final double avatarSize;
  final double avatarLeft;

  const _ProfileCard({
    required this.name,
    required this.avatarSize,
    required this.avatarLeft,
  });

  @override
  Widget build(BuildContext context) {
    final reservedAvatarWidth = avatarLeft + avatarSize + 16;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(0, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: reservedAvatarWidth),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Color(0xFF6B6B6B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '2.3 miles away',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.9',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '•',
                            style: TextStyle(color: Color(0xFF9A9A9A)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '247 shifts',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF8F0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB3EBC9)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Active',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.mail_outline,
                  value: 'sarah.johnson@email.com',
                ),
                SizedBox(height: 12),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  value: '+1 (555) 123-4567',
                ),
                SizedBox(height: 12),
                _DetailRow(
                  icon: Icons.location_on_outlined,
                  value: 'New York, NY',
                ),
                SizedBox(height: 12),
                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  value: 'Joined Jan 15, 2025',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const _DetailRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryBlue, size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String value;
  final String label;
  const _MiniStatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          const _PerfRow(
            icon: Icons.check_circle_outline,
            iconColor: Color(0xFF10B981),
            label: 'Completed Shifts',
            value: '142',
          ),
          const SizedBox(height: 10),
          const _PerfRow(
            icon: Icons.cancel_outlined,
            iconColor: Color(0xFFDC2626),
            label: 'Cancelled Shifts',
            value: '3',
          ),
        ],
      ),
    );
  }
}

class _PerfRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  const _PerfRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  final String name;
  const _BottomActions({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      padding: const EdgeInsets.fromLTRB(32, 14, 32, 14),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: () => _showSuspendDialog(context, name),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFDC2626)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFDC2626),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Suspend User',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Send Message',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSuspendDialog(BuildContext context, String name) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (_) => _SuspendDialog(name: name),
  );
}

class _SuspendDialog extends StatelessWidget {
  final String name;
  const _SuspendDialog({required this.name});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDE5E5),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/icons/Suspend_Icon.svg',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Suspend User Account?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'You are about to suspend '),
                  TextSpan(
                    text: name,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const TextSpan(
                    text:
                        "'s account. This will prevent them from accessing the platform.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Reason for Suspension *',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Enter the reason for suspending this user...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
                contentPadding: const EdgeInsets.all(14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primaryBlue,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Yes, Suspend User',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFE5E5E5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
