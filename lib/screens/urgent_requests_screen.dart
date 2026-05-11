import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'urgent_request_details_screen.dart';

enum UrgentPriority { critical, high, medium }

class UrgentRequest {
  final String title;
  final UrgentPriority priority;
  final String posted;
  final String expiresIn;
  final int positions;
  final String business;
  final String schedule;
  final String location;
  final String reason;
  final int respondedCount;
  final int totalCount;
  final int accepted;
  final int declined;
  final int pending;
  final double hourlyRate;
  const UrgentRequest({
    required this.title,
    required this.priority,
    required this.posted,
    required this.expiresIn,
    required this.positions,
    required this.business,
    required this.schedule,
    required this.location,
    required this.reason,
    required this.respondedCount,
    required this.totalCount,
    required this.accepted,
    required this.declined,
    required this.pending,
    required this.hourlyRate,
  });
}

class UrgentRequestsScreen extends StatefulWidget {
  const UrgentRequestsScreen({super.key});

  @override
  State<UrgentRequestsScreen> createState() => _UrgentRequestsScreenState();
}

class _UrgentRequestsScreenState extends State<UrgentRequestsScreen> {
  int _tab = 0;

  static const List<UrgentRequest> _active = [
    UrgentRequest(
      title: 'ER Nurse',
      priority: UrgentPriority.critical,
      posted: 'Posted 5 mins ago',
      expiresIn: '55 mins',
      positions: 2,
      business: 'City Hospital Emergency',
      schedule: 'Feb 11, 2026 • 6:00 PM - 2:00 AM',
      location: 'Downtown Medical, Manhattan, NY',
      reason: 'Staff shortage due to emergency influx',
      respondedCount: 3,
      totalCount: 8,
      accepted: 2,
      declined: 1,
      pending: 5,
      hourlyRate: 45.00,
    ),
    UrgentRequest(
      title: 'Front Desk Manager',
      priority: UrgentPriority.high,
      posted: 'Posted 15 mins ago',
      expiresIn: '45 mins',
      positions: 1,
      business: 'Grand Hotel & Suites',
      schedule: 'Feb 11, 2026 • 3:00 PM - 11:00 PM',
      location: 'Midtown, Manhattan, NY',
      reason: 'Manager called in sick, busy check-in period',
      respondedCount: 6,
      totalCount: 12,
      accepted: 4,
      declined: 2,
      pending: 6,
      hourlyRate: 32.00,
    ),
    UrgentRequest(
      title: 'IT Support Specialist',
      priority: UrgentPriority.critical,
      posted: 'Posted 2 mins ago',
      expiresIn: '58 mins',
      positions: 1,
      business: 'TechStart Solutions',
      schedule: 'Feb 11, 2026 • Now - 8:00 PM',
      location: 'Financial District, NY',
      reason: 'Server outage, immediate support needed',
      respondedCount: 1,
      totalCount: 6,
      accepted: 1,
      declined: 0,
      pending: 5,
      hourlyRate: 55.00,
    ),
    UrgentRequest(
      title: 'Line Cook',
      priority: UrgentPriority.high,
      posted: 'Posted 30 mins ago',
      expiresIn: '30 mins',
      positions: 2,
      business: 'Downtown Restaurant Group',
      schedule: 'Feb 11, 2026 • 5:00 PM - 10:00 PM',
      location: 'SoHo, Manhattan, NY',
      reason: 'Two cooks no-show during dinner rush',
      respondedCount: 8,
      totalCount: 15,
      accepted: 5,
      declined: 3,
      pending: 7,
      hourlyRate: 28.00,
    ),
    UrgentRequest(
      title: 'Warehouse Supervisor',
      priority: UrgentPriority.medium,
      posted: 'Posted 45 mins ago',
      expiresIn: '15 mins',
      positions: 1,
      business: 'Logistics Express Inc',
      schedule: 'Feb 11, 2026 • Now - 6:00 PM',
      location: 'Brooklyn, NY',
      reason: 'Unexpected shipment arrival needs supervision',
      respondedCount: 4,
      totalCount: 8,
      accepted: 3,
      declined: 1,
      pending: 4,
      hourlyRate: 35.00,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _SearchBar(),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _Tabs(
                index: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
            ),
            const SizedBox(height: 16),
            ..._active.map((r) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UrgentRequestDetailsScreen(item: r),
                      ),
                    ),
                    child: _RequestCard(item: r),
                  ),
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
            'Urgent Requests',
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

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: Color(0xFF9A9A9A)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Search urgent requests...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _Tabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1EF),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(child: _TabButton(label: 'Active (5)', active: index == 0, onTap: () => onChanged(0))),
          Expanded(child: _TabButton(label: 'Filled (2)', active: index == 1, onTap: () => onChanged(1))),
          Expanded(child: _TabButton(label: 'Expired (1)', active: index == 2, onTap: () => onChanged(2))),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabButton({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

Color priorityAccent(UrgentPriority p) {
  switch (p) {
    case UrgentPriority.critical:
      return const Color(0xFFDC2626);
    case UrgentPriority.high:
      return const Color(0xFFF59E0B);
    case UrgentPriority.medium:
      return const Color(0xFFF59E0B);
  }
}

String priorityLabel(UrgentPriority p) {
  switch (p) {
    case UrgentPriority.critical:
      return 'critical priority';
    case UrgentPriority.high:
      return 'high priority';
    case UrgentPriority.medium:
      return 'medium priority';
  }
}

Color priorityPillBg(UrgentPriority p) {
  switch (p) {
    case UrgentPriority.critical:
      return const Color(0xFFFDE5E5);
    case UrgentPriority.high:
      return const Color(0xFFFEF3DF);
    case UrgentPriority.medium:
      return const Color(0xFFFEF3DF);
  }
}

class _RequestCard extends StatelessWidget {
  final UrgentRequest item;
  const _RequestCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final accent = priorityAccent(item.priority);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: accent, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF9A9A9A), size: 22),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityPillBg(item.priority),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  priorityLabel(item.priority),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  item.posted,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3DF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, size: 18, color: Color(0xFFB45309)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Expires in: ${item.expiresIn}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFB45309),
                    ),
                  ),
                ),
                Text(
                  '${item.positions} position${item.positions > 1 ? 's' : ''}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _MetaRow(icon: Icons.business_outlined, value: item.business),
          const SizedBox(height: 6),
          _MetaRow(icon: Icons.access_time, value: item.schedule),
          const SizedBox(height: 6),
          _MetaRow(icon: Icons.location_on_outlined, value: item.location),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason:',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.reason,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _ResponsesBlock(item: item, accent: accent),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const _MetaRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primaryBlue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResponsesBlock extends StatelessWidget {
  final UrgentRequest item;
  final Color accent;
  const _ResponsesBlock({required this.item, required this.accent});

  @override
  Widget build(BuildContext context) {
    final pct = (item.respondedCount / item.totalCount * 100).round();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Worker Responses',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _Pill(icon: Icons.check, color: const Color(0xFF10B981), value: '${item.accepted}'),
              const SizedBox(width: 8),
              _Pill(icon: Icons.close, color: const Color(0xFFDC2626), value: '${item.declined}'),
              const SizedBox(width: 8),
              _Pill(icon: Icons.timer_outlined, color: const Color(0xFFF59E0B), value: '${item.pending}'),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: item.respondedCount / item.totalCount,
              minHeight: 6,
              backgroundColor: const Color(0xFFE5E5E5),
              valueColor: AlwaysStoppedAnimation(accent),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.respondedCount}/${item.totalCount} responded ($pct%)',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '\$${item.hourlyRate.toStringAsFixed(2)}/hr',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  const _Pill({required this.icon, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
