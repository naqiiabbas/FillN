import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'contact_business_screen.dart';
import 'contact_worker_screen.dart';
import 'shifts_screen.dart';

enum _UserStatus { active, suspended, pending }

class _BusinessItem {
  final String name;
  final String initials;
  final int workers;
  final int shifts;
  final _UserStatus status;
  const _BusinessItem({
    required this.name,
    required this.initials,
    required this.workers,
    required this.shifts,
    required this.status,
  });
}

class _UserItem {
  final String name;
  final double rating;
  final int shifts;
  final _UserStatus status;
  final String avatar;
  const _UserItem({
    required this.name,
    required this.rating,
    required this.shifts,
    required this.status,
    required this.avatar,
  });
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int _navIndex = 1;
  int _tab = 0;

  static const List<_UserItem> _workers = [
    _UserItem(
      name: 'Sarah Johnson',
      rating: 4.8,
      shifts: 145,
      status: _UserStatus.active,
      avatar: 'assets/images/avatars/users/5.png',
    ),
    _UserItem(
      name: 'Linda Thomas',
      rating: 4.5,
      shifts: 120,
      status: _UserStatus.active,
      avatar: 'assets/images/avatars/users/2.png',
    ),
    _UserItem(
      name: 'Emma Davis',
      rating: 4.3,
      shifts: 87,
      status: _UserStatus.suspended,
      avatar: 'assets/images/avatars/users/4.png',
    ),
    _UserItem(
      name: 'Alex Johnson',
      rating: 4.9,
      shifts: 200,
      status: _UserStatus.active,
      avatar: 'assets/images/avatars/users/1.png',
    ),
    _UserItem(
      name: 'David Brown',
      rating: 4.5,
      shifts: 92,
      status: _UserStatus.pending,
      avatar: 'assets/images/avatars/users/3.png',
    ),
  ];

  static const List<_BusinessItem> _businesses = [
    _BusinessItem(
      name: 'TechCorp Solutions',
      initials: 'TC',
      workers: 23,
      shifts: 456,
      status: _UserStatus.active,
    ),
    _BusinessItem(
      name: 'Retail Plus',
      initials: 'RP',
      workers: 18,
      shifts: 312,
      status: _UserStatus.active,
    ),
    _BusinessItem(
      name: 'Hospitality Group',
      initials: 'HG',
      workers: 12,
      shifts: 189,
      status: _UserStatus.suspended,
    ),
    _BusinessItem(
      name: 'Logistics Inc',
      initials: 'LI',
      workers: 31,
      shifts: 523,
      status: _UserStatus.active,
    ),
    _BusinessItem(
      name: 'Healthcare Partners',
      initials: 'HP',
      workers: 15,
      shifts: 267,
      status: _UserStatus.active,
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
              const _UsersHeader(),
              const SizedBox(height: 16),
              const _SearchBar(),
              const SizedBox(height: 16),
              _Tabs(
                index: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
              const SizedBox(height: 16),
              if (_tab == 0)
                ..._workers.map((u) => Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ContactWorkerScreen(
                              name: u.name,
                              avatar: u.avatar,
                            ),
                          ),
                        ),
                        child: _UserCard(item: u),
                      ),
                    ))
              else
                ..._businesses.map((b) => Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ContactBusinessScreen(name: b.name),
                          ),
                        ),
                        child: _BusinessCard(item: b),
                      ),
                    )),
          const SizedBox(height: 16),
        ],
        ),
      ),
      bottomNavigationBar: _UsersBottomNav(
        currentIndex: _navIndex,
        onTap: (i) {
          if (i == 0) {
            Navigator.of(context).pop();
            return;
          }
          if (i == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ShiftsScreen()),
            );
            return;
          }
          setState(() => _navIndex = i);
        },
      ),
    );
  }
}

class _UsersHeader extends StatelessWidget {
  const _UsersHeader();

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
              'User Management',
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
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
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
            Expanded(
              child: _TabButton(
                label: 'Workers',
                active: index == 0,
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _TabButton(
                label: 'Businesses',
                active: index == 1,
                onTap: () => onChanged(1),
              ),
            ),
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
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

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
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final _UserItem item;
  const _UserCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primaryBlue, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              item.avatar,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _StatusPill(status: item.status),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text(
                      item.rating.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('•', style: TextStyle(color: Color(0xFF9A9A9A))),
                    const SizedBox(width: 8),
                    Text(
                      '${item.shifts} shifts',
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
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF9A9A9A),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _BusinessCard extends StatelessWidget {
  final _BusinessItem item;
  const _BusinessCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primaryBlue, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              item.initials,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _StatusPill(status: item.status, businessStyle: true),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${item.workers} workers',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('•', style: TextStyle(color: Color(0xFF9A9A9A))),
                    const SizedBox(width: 8),
                    Text(
                      '${item.shifts} shifts',
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
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF9A9A9A),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final _UserStatus status;
  final bool businessStyle;
  const _StatusPill({required this.status, this.businessStyle = false});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;
    switch (status) {
      case _UserStatus.active:
        bg = businessStyle ? Colors.black : const Color(0xFF10B981);
        fg = Colors.white;
        label = 'active';
        break;
      case _UserStatus.suspended:
        bg = const Color(0xFFDC2626);
        fg = Colors.white;
        label = 'suspended';
        break;
      case _UserStatus.pending:
        bg = const Color(0xFFE5E5E5);
        fg = AppColors.textPrimary;
        label = 'pending';
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

class _UsersBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _UsersBottomNav({required this.currentIndex, required this.onTap});

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
