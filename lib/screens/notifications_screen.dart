import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class _NotificationItem {
  final Color dotColor;
  final String title;
  final String subtitle;
  final String time;
  final bool unread;
  const _NotificationItem({
    required this.dotColor,
    required this.title,
    required this.subtitle,
    required this.time,
    this.unread = false,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const List<_NotificationItem> _items = [
    _NotificationItem(
      dotColor: Color(0xFFF59E0B),
      title: 'New shift dispute',
      subtitle: 'Sarah Johnson reported an issue',
      time: '5 min ago',
      unread: true,
    ),
    _NotificationItem(
      dotColor: Color(0xFF10B981),
      title: 'Payment processed',
      subtitle: '\$2,450 received from TechCorp',
      time: '15 min ago',
      unread: true,
    ),
    _NotificationItem(
      dotColor: AppColors.primaryBlue,
      title: 'New business verification',
      subtitle: 'Retail Plus requires verification',
      time: '1 hour ago',
    ),
    _NotificationItem(
      dotColor: Color(0xFFF59E0B),
      title: 'Worker suspended',
      subtitle: 'John Smith account suspended',
      time: '2 hours ago',
    ),
    _NotificationItem(
      dotColor: Color(0xFF10B981),
      title: 'Weekly report ready',
      subtitle: 'Download your weekly analytics',
      time: '3 hours ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(onBack: () => Navigator.of(context).maybePop()),
            const SizedBox(height: 16),
            ..._items.map((n) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                  child: _NotificationCard(item: n),
                )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  const _Header({required this.onBack});

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
            'Notification',
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

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;
  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.unread ? const Color(0xFFE9F0FB) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: item.unread
              ? const Color(0xFFC7D6F1)
              : const Color(0xFFE5E5E5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: item.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.time,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
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
