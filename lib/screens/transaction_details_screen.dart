import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final bool isPayout;
  final String person;
  final double amount;
  final String dateTime;
  final String paymentMethod;
  final String transactionId;
  final String shift;

  const TransactionDetailsScreen({
    super.key,
    required this.isPayout,
    required this.person,
    required this.amount,
    required this.dateTime,
    required this.paymentMethod,
    this.transactionId = 'TXN-20260203-0042',
    this.shift = 'Front Desk - TechCorp Solutions',
  });

  @override
  Widget build(BuildContext context) {
    final accent = isPayout ? const Color(0xFFDC2626) : const Color(0xFF10B981);
    final tint = isPayout ? const Color(0xFFFDE5E5) : const Color(0xFFDFF6EA);
    final title = isPayout ? 'Payout Sent' : 'Payment Received';
    final amountStr = isPayout
        ? '-\$${amount.abs().toStringAsFixed(2)}'
        : '+\$${amount.abs().toStringAsFixed(2)}';
    final gross = amount.abs();
    const fee = 2.00;
    final net = (gross - fee).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(onBack: () => Navigator.of(context).maybePop()),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _SummaryCard(
                      accent: accent,
                      tint: tint,
                      title: title,
                      amount: amountStr,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _InfoCard(
                      title: 'Transaction Information',
                      rows: [
                        _Row(label: 'Transaction ID', value: transactionId),
                        _Row(label: 'Date & Time', value: dateTime),
                        _Row(label: 'Recipient', value: person),
                        _Row(label: 'Payment Method', value: paymentMethod),
                        _Row(label: 'Bank Account', value: '****4532'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _InfoCard(
                      title: 'Shift Details',
                      rows: [
                        _Row(label: 'Shift', value: shift),
                        const _Row(label: 'Hours Worked', value: '8.0 hrs'),
                        const _Row(label: 'Hourly Rate', value: '\$18.50'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _InfoCard(
                      title: 'Payment Breakdown',
                      rows: [
                        _Row(
                          label: 'Gross Amount',
                          value: '\$${gross.toStringAsFixed(2)}',
                        ),
                        const _Row(
                          label: 'Processing Fee',
                          value: '-\$2.00',
                          valueColor: Color(0xFFDC2626),
                        ),
                        _Row(
                          label: 'Net Amount',
                          value: '\$$net',
                          boldLabel: true,
                          valueColor: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _BottomActions(onBack: () => Navigator.of(context).maybePop()),
        ],
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
            'Transaction Details',
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

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: child,
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final Color accent;
  final Color tint;
  final String title;
  final String amount;
  const _SummaryCard({
    required this.accent,
    required this.tint,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: tint,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                accent == const Color(0xFFDC2626)
                    ? Icons.north_east
                    : Icons.south_west,
                color: accent,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              amount,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: Color(0xFF10B981),
                ),
                const SizedBox(width: 6),
                Text(
                  'completed',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
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

class _Row {
  final String label;
  final String value;
  final Color? valueColor;
  final bool boldLabel;
  const _Row({
    required this.label,
    required this.value,
    this.valueColor,
    this.boldLabel = false,
  });
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_Row> rows;
  const _InfoCard({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < rows.length; i++) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    rows[i].label,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: rows[i].boldLabel
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    rows[i].value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: rows[i].valueColor ?? AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            if (i < rows.length - 1)
              const Divider(height: 24, color: Color(0xFFEDEDED)),
          ],
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final VoidCallback onBack;
  const _BottomActions({required this.onBack});

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
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE5E5E5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Back to Payments',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Download Receipt',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
