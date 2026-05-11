import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'shift_details_screen.dart';

enum ShiftStatus { ongoing, upcoming, completed }

class ShiftItem {
  final String title;
  final ShiftStatus status;
  final String business;
  final String worker;
  final String dateTime;
  final String location;
  final String? clockIn;
  final String? clockOut;

  const ShiftItem({
    required this.title,
    required this.status,
    required this.business,
    required this.worker,
    required this.dateTime,
    required this.location,
    this.clockIn,
    this.clockOut,
  });
}

class ShiftsScreen extends StatefulWidget {
  const ShiftsScreen({super.key});

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  int _tab = 0;

  static const List<ShiftItem> _ongoing = [
    ShiftItem(
      title: 'Front Desk',
      status: ShiftStatus.ongoing,
      business: 'TechCorp Solutions',
      worker: 'Sarah Johnson',
      dateTime: 'Feb 3, 2026 • 9:00 AM - 5:00 PM',
      location: 'Manhattan, NY',
      clockIn: '9:02 AM',
    ),
    ShiftItem(
      title: 'Sales Associate',
      status: ShiftStatus.ongoing,
      business: 'Retail Plus',
      worker: 'Mike Chen',
      dateTime: 'Feb 3, 2026 • 10:00 AM - 6:00 PM',
      location: 'Brooklyn, NY',
      clockIn: '9:58 AM',
    ),
  ];

  static const List<ShiftItem> _upcoming = [
    ShiftItem(
      title: 'Server',
      status: ShiftStatus.upcoming,
      business: 'Hospitality Group',
      worker: 'Emma Davis',
      dateTime: 'Feb 4, 2026 • 5:00 PM - 11:00 PM',
      location: 'Queens, NY',
    ),
  ];

  static const List<ShiftItem> _completed = [
    ShiftItem(
      title: 'Warehouse Staff',
      status: ShiftStatus.completed,
      business: 'Logistics Inc',
      worker: 'James Wilson',
      dateTime: 'Feb 2, 2026 • 7:00 AM - 3:00 PM',
      location: 'Bronx, NY',
      clockIn: '7:01 AM',
      clockOut: '3:05 PM',
    ),
    ShiftItem(
      title: 'Receptionist',
      status: ShiftStatus.completed,
      business: 'Healthcare Partners',
      worker: 'Lisa Anderson',
      dateTime: 'Feb 2, 2026 • 8:00 AM - 4:00 PM',
      location: 'Manhattan, NY',
      clockIn: '7:55 AM',
      clockOut: '4:02 PM',
    ),
  ];

  List<ShiftItem> get _current => switch (_tab) {
        0 => _ongoing,
        1 => _upcoming,
        _ => _completed,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Header(),
            const SizedBox(height: 16),
            const _SearchBar(),
            const SizedBox(height: 16),
            _Tabs(
              index: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
            const SizedBox(height: 16),
            ..._current.map((s) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ShiftDetailsScreen(item: s),
                      ),
                    ),
                    child: _ShiftCard(item: s),
                  ),
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _ShiftsBottomNav(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            Navigator.of(context).popUntil((r) => r.isFirst);
            return;
          }
          if (i == 1) {
            Navigator.of(context).pop();
            return;
          }
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(32, topPad + 24, 32, 28),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Shift Monitoring',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDC2626),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF9A9A9A), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0xFF9A9A9A),
                  ),
                ),
                style: GoogleFonts.inter(fontSize: 15),
              ),
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(child: _TabButton(label: 'Ongoing', active: index == 0, onTap: () => onChanged(0))),
            Expanded(child: _TabButton(label: 'Upcoming', active: index == 1, onTap: () => onChanged(1))),
            Expanded(child: _TabButton(label: 'Completed', active: index == 2, onTap: () => onChanged(2))),
          ],
        ),
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
          color: active ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ShiftCard extends StatelessWidget {
  final ShiftItem item;
  const _ShiftCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF9A9A9A), size: 22),
            ],
          ),
          const SizedBox(height: 8),
          _StatusPill(status: item.status),
          const SizedBox(height: 14),
          _DetailRow(icon: Icons.business_outlined, value: item.business),
          const SizedBox(height: 8),
          _DetailRow(icon: Icons.person_outline, value: item.worker),
          const SizedBox(height: 8),
          _DetailRow(icon: Icons.access_time, value: item.dateTime),
          const SizedBox(height: 8),
          _DetailRow(icon: Icons.location_on_outlined, value: item.location),
          if (item.clockIn != null) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEDEDED)),
            const SizedBox(height: 14),
            _Footer(item: item),
          ],
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final ShiftStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;
    switch (status) {
      case ShiftStatus.ongoing:
        bg = const Color(0xFFE7F8EF);
        fg = const Color(0xFF10B981);
        label = 'ongoing';
        break;
      case ShiftStatus.upcoming:
        bg = const Color(0xFFE3ECFB);
        fg = AppColors.primaryBlue;
        label = 'upcoming';
        break;
      case ShiftStatus.completed:
        bg = const Color(0xFFEAEAEA);
        fg = AppColors.textPrimary;
        label = 'completed';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
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
        Icon(icon, color: AppColors.primaryBlue, size: 18),
        const SizedBox(width: 12),
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

class _Footer extends StatelessWidget {
  final ShiftItem item;
  const _Footer({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.status == ShiftStatus.ongoing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Clock In: ${item.clockIn}',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'In Progress',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'In: ${item.clockIn}',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          'Out: ${item.clockOut}',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ShiftsBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _ShiftsBottomNav({required this.currentIndex, required this.onTap});

  static const _items = <_NavItem>[
    _NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined),
    _NavItem(label: 'Users', icon: Icons.people_outline),
    _NavItem(label: 'Shifts', icon: Icons.access_time),
    _NavItem(label: 'Payments', icon: Icons.account_balance_wallet_outlined),
    _NavItem(label: 'Reports', icon: Icons.description_outlined),
    _NavItem(label: 'Settings', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < _items.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _items[i].icon,
                        size: 24,
                        color: i == currentIndex
                            ? AppColors.primaryBlue
                            : AppColors.textPrimary,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _items[i].label,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: i == currentIndex
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: i == currentIndex
                              ? AppColors.primaryBlue
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem({required this.label, required this.icon});
}
