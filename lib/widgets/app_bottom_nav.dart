import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/dashboard_screen.dart';
import '../screens/payments_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/shifts_screen.dart';
import '../screens/users_screen.dart';
import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  static const _items = <_NavItem>[
    _NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined),
    _NavItem(label: 'Users', icon: Icons.people_outline),
    _NavItem(label: 'Shifts', icon: Icons.access_time),
    _NavItem(label: 'Payments', icon: Icons.account_balance_wallet_outlined),
    _NavItem(label: 'Reports', icon: Icons.description_outlined),
    _NavItem(label: 'Settings', icon: Icons.settings_outlined),
  ];

  Widget _build(int i) {
    switch (i) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const UsersScreen();
      case 2:
        return const ShiftsScreen();
      case 3:
        return const PaymentsScreen();
      case 4:
        return const ReportsScreen();
      case 5:
        return const SettingsScreen();
    }
    return const DashboardScreen();
  }

  void _onTap(BuildContext context, int i) {
    if (i == currentIndex) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, a, b) => _build(i),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

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
                  onTap: () => _onTap(context, i),
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
