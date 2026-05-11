import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'chat_screen.dart';

enum _ContactKind { worker, business }

class _Conversation {
  final String name;
  final _ContactKind kind;
  final String preview;
  final String time;
  final int unread;
  final bool online;
  final String? avatar;
  final Color? logoColor;
  final String? logoText;
  const _Conversation({
    required this.name,
    required this.kind,
    required this.preview,
    required this.time,
    this.unread = 0,
    this.online = false,
    this.avatar,
    this.logoColor,
    this.logoText,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _tab = 0;

  static const List<_Conversation> _all = [
    _Conversation(
      name: 'Mike Chen',
      kind: _ContactKind.worker,
      preview: "Thank you! I'll be there on time.",
      time: '2 mins ago',
      unread: 2,
      online: true,
      avatar: 'assets/images/avatars/users/4.png',
    ),
    _Conversation(
      name: 'TechCorp Solutions',
      kind: _ContactKind.business,
      preview: 'We need 5 additional staff members for our t…',
      time: '15 mins ago',
      unread: 1,
      online: true,
      logoColor: Color(0xFFDC2626),
      logoText: 'b',
    ),
    _Conversation(
      name: 'Mike Chen',
      kind: _ContactKind.worker,
      preview: 'Can I reschedule my shift for tomorrow?',
      time: '1 hour ago',
      avatar: 'assets/images/avatars/users/1.png',
    ),
    _Conversation(
      name: 'Retail Plus',
      kind: _ContactKind.business,
      preview: 'The workers you sent were excellent!',
      time: '2 hours ago',
      logoColor: Color(0xFF1F2937),
      logoText: 'BELLE',
    ),
    _Conversation(
      name: 'Emma Davis',
      kind: _ContactKind.worker,
      preview: "I've completed my profile verification.",
      time: '3 hours ago',
      unread: 3,
      online: true,
      avatar: 'assets/images/avatars/users/5.png',
    ),
    _Conversation(
      name: 'Hospitality Group',
      kind: _ContactKind.business,
      preview: 'Payment has been processed successfully.',
      time: '5 hours ago',
      logoColor: Color(0xFF2563EB),
      logoText: 'P&G',
    ),
  ];

  int get _workersCount =>
      _all.where((c) => c.kind == _ContactKind.worker).length;
  int get _businessesCount =>
      _all.where((c) => c.kind == _ContactKind.business).length;
  int get _unreadCount => _all.where((c) => c.unread > 0).length;

  List<_Conversation> get _filtered {
    switch (_tab) {
      case 1:
        return _all.where((c) => c.kind == _ContactKind.worker).toList();
      case 2:
        return _all.where((c) => c.kind == _ContactKind.business).toList();
      case 3:
        return _all.where((c) => c.unread > 0).toList();
      default:
        return _all;
    }
  }

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
              child: _FilterBar(
                index: _tab,
                onChanged: (i) => setState(() => _tab = i),
                workers: _workersCount,
                businesses: _businessesCount,
                unread: _unreadCount,
              ),
            ),
            const SizedBox(height: 16),
            ..._filtered.map((c) => Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          name: c.name,
                          avatar: c.avatar,
                          online: c.online,
                          logoColor: c.logoColor,
                          logoText: c.logoText,
                        ),
                      ),
                    ),
                    child: _ConversationCard(item: c),
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
            'Messages',
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white, width: 1.2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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

class _FilterBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final int workers;
  final int businesses;
  final int unread;
  const _FilterBar({
    required this.index,
    required this.onChanged,
    required this.workers,
    required this.businesses,
    required this.unread,
  });

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
          Expanded(child: _Chip(label: 'All', active: index == 0, onTap: () => onChanged(0))),
          Expanded(child: _Chip(label: 'Workers ($workers)', active: index == 1, onTap: () => onChanged(1))),
          Expanded(child: _Chip(label: 'Businesses ($businesses)', active: index == 2, onTap: () => onChanged(2))),
          Expanded(child: _Chip(label: 'Unread ($unread)', active: index == 3, onTap: () => onChanged(3))),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.active, required this.onTap});

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
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ConversationCard extends StatelessWidget {
  final _Conversation item;
  const _ConversationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(item: item),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (item.kind == _ContactKind.business) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                        ),
                        child: Text(
                          'Business',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF9A9A9A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.time,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (item.unread > 0) ...[
            const SizedBox(width: 8),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '${item.unread}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final _Conversation item;
  const _Avatar({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (item.avatar != null)
          ClipOval(
            child: Image.asset(
              item.avatar!,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          )
        else
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: item.logoColor ?? AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              item.logoText ?? '',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        if (item.online)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
