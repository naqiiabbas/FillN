import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class _Message {
  final String text;
  final String time;
  final bool fromMe;
  const _Message({
    required this.text,
    required this.time,
    required this.fromMe,
  });
}

class ChatScreen extends StatelessWidget {
  final String name;
  final String? avatar;
  final bool online;
  final Color? logoColor;
  final String? logoText;

  const ChatScreen({
    super.key,
    required this.name,
    this.avatar,
    this.online = false,
    this.logoColor,
    this.logoText,
  });

  static const List<_Message> _messages = [
    _Message(
      text: "Hi! I'm Michael. How can I help you today?",
      time: '09:30 AM',
      fromMe: false,
    ),
    _Message(
      text: 'Hello! I have a leaking pipe under my kitchen sink.',
      time: '09:32 AM',
      fromMe: true,
    ),
    _Message(
      text:
          'I can definitely help with that! Can you describe the leak? Is it a slow drip or steady flow?',
      time: '09:33 AM',
      fromMe: false,
    ),
    _Message(
      text: "It's a slow drip right now, but I'm worried it might get worse.",
      time: '09:35 AM',
      fromMe: true,
    ),
    _Message(
      text:
          "That's a good call to address it early. I can schedule a visit for you. Your sink repair is scheduled for tomorrow at 10 AM. Does that work for you?",
      time: '09:36 AM',
      fromMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _Header(
            name: name,
            avatar: avatar,
            online: online,
            logoColor: logoColor,
            logoText: logoText,
            onBack: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _Bubble(message: _messages[i]),
            ),
          ),
          const _InputBar(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final String? avatar;
  final bool online;
  final Color? logoColor;
  final String? logoText;
  final VoidCallback onBack;
  const _Header({
    required this.name,
    required this.avatar,
    required this.online,
    required this.logoColor,
    required this.logoText,
    required this.onBack,
  });

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
          Row(
            children: [
              _ChatAvatar(
                avatar: avatar,
                online: online,
                logoColor: logoColor,
                logoText: logoText,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      online ? 'Active now' : 'Offline',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final String? avatar;
  final bool online;
  final Color? logoColor;
  final String? logoText;
  const _ChatAvatar({
    required this.avatar,
    required this.online,
    required this.logoColor,
    required this.logoText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (avatar != null)
          ClipOval(
            child: Image.asset(
              avatar!,
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
              color: logoColor ?? AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              logoText ?? '',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        if (online)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryBlue, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  final _Message message;
  const _Bubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final align = message.fromMe ? Alignment.centerRight : Alignment.centerLeft;
    final maxWidth = MediaQuery.of(context).size.width * 0.72;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: message.fromMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: align,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  color: message.fromMe
                      ? AppColors.primaryBlue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: message.fromMe
                      ? null
                      : Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: Text(
                  message.text,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    height: 1.4,
                    color: message.fromMe
                        ? Colors.white
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              message.time,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const Icon(
              Icons.attach_file,
              size: 22,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 14),
            const Icon(
              Icons.image_outlined,
              size: 22,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Type a message...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.send,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
