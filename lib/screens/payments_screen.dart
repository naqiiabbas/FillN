import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/notification_bell.dart';
import 'escrow_screen.dart';
import 'transaction_details_screen.dart';
import 'wallet_screen.dart';

enum _TxType { payout, received }

enum _TxStatus { completed, pending }

class _Transaction {
  final _TxType type;
  final String person;
  final double amount;
  final _TxStatus status;
  final String dateTime;
  final String method;
  const _Transaction({
    required this.type,
    required this.person,
    required this.amount,
    required this.status,
    required this.dateTime,
    required this.method,
  });
}

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  static const List<_Transaction> _txs = [
    _Transaction(
      type: _TxType.payout,
      person: 'Sarah Johnson',
      amount: -148.00,
      status: _TxStatus.completed,
      dateTime: 'Feb 3, 2026 at 2:30 PM',
      method: 'Bank Transfer',
    ),
    _Transaction(
      type: _TxType.payout,
      person: 'Mike Chen',
      amount: -215.50,
      status: _TxStatus.completed,
      dateTime: 'Feb 3, 2026 at 1:15 PM',
      method: 'Bank Transfer',
    ),
    _Transaction(
      type: _TxType.received,
      person: 'TechCorp Solutions',
      amount: 2450.00,
      status: _TxStatus.completed,
      dateTime: 'Feb 3, 2026 at 10:00 AM',
      method: 'Credit Card',
    ),
    _Transaction(
      type: _TxType.payout,
      person: 'Emma Davis',
      amount: -180.00,
      status: _TxStatus.pending,
      dateTime: 'Feb 2, 2026 at 4:45 PM',
      method: 'Bank Transfer',
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
            const _Header(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: _WalletToggle(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: _SummaryCard(
                icon: Icons.attach_money,
                accent: Color(0xFF10B981),
                tint: Color(0xFFDFF6EA),
                label: 'Total Transactions',
                value: '\$284K',
                trendIcon: Icons.trending_up,
                trend: '+23%',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: _SummaryCard(
                icon: Icons.access_time,
                accent: Color(0xFFF59E0B),
                tint: Color(0xFFFEF3DF),
                label: 'Pending Payouts',
                value: '\$12.4K',
                trendIcon: Icons.trending_up,
                trend: '8 requests',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: _SummaryCard(
                icon: Icons.check_circle_outline,
                accent: Color(0xFF8B5CF6),
                tint: Color(0xFFEDE2FB),
                label: 'Processed Today',
                value: '\$8.2K',
                trendIcon: Icons.trending_up,
                trend: '24 payments',
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                width: double.infinity,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text(
                  'Transaction History',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ..._txs.map((t) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TransactionDetailsScreen(
                          isPayout: t.type == _TxType.payout,
                          person: t.person,
                          amount: t.amount,
                          dateTime: t.dateTime,
                          paymentMethod: t.method,
                        ),
                      ),
                    ),
                    child: _TransactionCard(item: t),
                  ),
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
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
              'Payments & Wallet',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const NotificationBell(),
        ],
      ),
    );
  }
}

class _WalletToggle extends StatelessWidget {
  const _WalletToggle();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Builder(
            builder: (context) => _ToggleButton(
              label: 'My Wallet',
              icon: Icons.account_balance_wallet_outlined,
              color: AppColors.primaryBlue,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const WalletScreen()),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Builder(
            builder: (context) => _ToggleButton(
              label: 'Escrow',
              icon: Icons.shield_outlined,
              color: const Color(0xFF10B981),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EscrowScreen()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _ToggleButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final Color tint;
  final String label;
  final String value;
  final IconData trendIcon;
  final String trend;
  const _SummaryCard({
    required this.icon,
    required this.accent,
    required this.tint,
    required this.label,
    required this.value,
    required this.trendIcon,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.4),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(trendIcon, size: 16, color: accent),
              const SizedBox(width: 4),
              Text(
                trend,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final _Transaction item;
  const _TransactionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isPayout = item.type == _TxType.payout;
    final amountColor =
        item.amount < 0 ? const Color(0xFFDC2626) : const Color(0xFF10B981);
    final amountStr = item.amount < 0
        ? '-\$${(-item.amount).toStringAsFixed(2)}'
        : '+\$${item.amount.toStringAsFixed(2)}';

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isPayout
                      ? const Color(0xFFFDE5E5)
                      : const Color(0xFFDFF6EA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isPayout ? Icons.north_east : Icons.south_west,
                  color: isPayout
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPayout ? 'Payout' : 'Payment Received',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Color(0xFF6B6B6B),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            item.person,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amountStr,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: amountColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _StatusPill(status: item.status),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.dateTime,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                item.method,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final _TxStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final completed = status == _TxStatus.completed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: completed ? Colors.black : const Color(0xFFEAEAEA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        completed ? 'completed' : 'pending',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: completed ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

