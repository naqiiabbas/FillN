import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _bioController = TextEditingController(
    text: "I'm a platform administrator overseeing the entire staffing operations and ensuring smooth workflow for all users.",
  );

  String _gender = 'Male';
  String _language = 'English';
  String _timezone = 'Eastern (EST)';

  static const _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];
  static const _languages = ['English', 'Spanish', 'French', 'German', 'Mandarin', 'Arabic'];
  static const _timezones = [
    'Eastern (EST)',
    'Central (CST)',
    'Mountain (MST)',
    'Pacific (PST)',
    'GMT',
    'CET',
  ];

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: _AvatarCard(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _BasicInfoCard(
                      gender: _gender,
                      onGenderChanged: (v) => setState(() => _gender = v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: _ContactInfoCard(),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: _AddressInfoCard(),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: _EmergencyContactCard(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _PreferencesCard(
                      language: _language,
                      timezone: _timezone,
                      onLanguageChanged: (v) => setState(() => _language = v),
                      onTimezoneChanged: (v) => setState(() => _timezone = v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _AboutMeCard(controller: _bioController),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: _EmploymentInfoCard(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _BottomActions(onCancel: () => Navigator.of(context).maybePop()),
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
            'Edit Profile',
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  const _SectionTitle({
    required this.icon,
    this.iconColor = AppColors.primaryBlue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final bool required;
  const _Label({required this.text, this.required = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFFDC2626),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String value;
  final bool readOnly;
  final IconData? prefix;
  const _Field({required this.value, this.readOnly = false, this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: readOnly,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: readOnly ? AppColors.textSecondary : AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: prefix == null
            ? null
            : Icon(prefix, color: AppColors.textSecondary, size: 18),
        filled: true,
        fillColor: const Color(0xFFF5F5F4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  const _Dropdown({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  void _open(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            for (final opt in options)
              ListTile(
                title: Text(
                  opt,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: opt == value ? FontWeight.w800 : FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                trailing: opt == value
                    ? const Icon(Icons.check, color: AppColors.primaryBlue)
                    : null,
                onTap: () {
                  onChanged(opt);
                  Navigator.of(context).pop();
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _open(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9A9A9A)),
          ],
        ),
      ),
    );
  }
}

class _AvatarCard extends StatelessWidget {
  const _AvatarCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFCD34D),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/avatars/users/2.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Click camera icon to change photo',
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

class _BasicInfoCard extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onGenderChanged;
  const _BasicInfoCard({required this.gender, required this.onGenderChanged});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.person_outline,
            label: 'Basic Information',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Full Name', required: true),
          const SizedBox(height: 6),
          const _Field(value: 'Admin User'),
          const SizedBox(height: 12),
          const _Label(text: 'Role / Position'),
          const SizedBox(height: 6),
          const _Field(value: 'Platform Administrator'),
          const SizedBox(height: 12),
          const _Label(text: 'Employee ID'),
          const SizedBox(height: 6),
          const _Field(value: 'ADM-001', readOnly: true),
          const SizedBox(height: 12),
          const _Label(text: 'Department'),
          const SizedBox(height: 6),
          const _Field(value: 'Platform Administration'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'Date of Birth'),
                    SizedBox(height: 6),
                    _Field(value: '21/02/2026'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Label(text: 'Gender'),
                    const SizedBox(height: 6),
                    _Dropdown(
                      value: gender,
                      options: _EditProfileScreenState._genders,
                      onChanged: onGenderChanged,
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

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.phone_outlined,
            label: 'Contact Information',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Email Address', required: true),
          const SizedBox(height: 6),
          const _Field(value: 'admin@staffing.com', prefix: Icons.mail_outline),
          const SizedBox(height: 12),
          const _Label(text: 'Phone Number', required: true),
          const SizedBox(height: 6),
          const _Field(value: '+1 (555) 123-4567', prefix: Icons.phone_outlined),
        ],
      ),
    );
  }
}

class _AddressInfoCard extends StatelessWidget {
  const _AddressInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.location_on_outlined,
            label: 'Address Information',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Street Address'),
          const SizedBox(height: 6),
          const _Field(value: '123 Admin Street'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'City'),
                    SizedBox(height: 6),
                    _Field(value: 'New York'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'State'),
                    SizedBox(height: 6),
                    _Field(value: 'NY'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'ZIP Code'),
                    SizedBox(height: 6),
                    _Field(value: '10001'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _Label(text: 'Country'),
                    SizedBox(height: 6),
                    _Field(value: 'United States'),
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

class _EmergencyContactCard extends StatelessWidget {
  const _EmergencyContactCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.phone_outlined,
            iconColor: Color(0xFFDC2626),
            label: 'Emergency Contact',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Contact Name'),
          const SizedBox(height: 6),
          const _Field(value: 'Jane Doe'),
          const SizedBox(height: 12),
          const _Label(text: 'Contact Phone'),
          const SizedBox(height: 6),
          const _Field(value: '+1 (555) 999-8888'),
        ],
      ),
    );
  }
}

class _PreferencesCard extends StatelessWidget {
  final String language;
  final String timezone;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onTimezoneChanged;
  const _PreferencesCard({
    required this.language,
    required this.timezone,
    required this.onLanguageChanged,
    required this.onTimezoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.language_outlined,
            label: 'Preferences',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Language'),
          const SizedBox(height: 6),
          _Dropdown(
            value: language,
            options: _EditProfileScreenState._languages,
            onChanged: onLanguageChanged,
          ),
          const SizedBox(height: 12),
          const _Label(text: 'Time Zone'),
          const SizedBox(height: 6),
          _Dropdown(
            value: timezone,
            options: _EditProfileScreenState._timezones,
            onChanged: onTimezoneChanged,
          ),
        ],
      ),
    );
  }
}

class _AboutMeCard extends StatelessWidget {
  final TextEditingController controller;
  const _AboutMeCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.work_outline,
            label: 'About Me',
          ),
          const SizedBox(height: 14),
          const _Label(text: 'Bio / Description'),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Tell us about yourself...',
              hintStyle: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F4),
              contentPadding: const EdgeInsets.all(14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primaryBlue,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${controller.text.length} / 500 characters',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmploymentInfoCard extends StatelessWidget {
  const _EmploymentInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.calendar_today_outlined,
            label: 'Employment Information',
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Join Date',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Jan 2024',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFFEDEDED)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Employee Status',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F8EF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Active',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
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

class _BottomActions extends StatelessWidget {
  final VoidCallback onCancel;
  const _BottomActions({required this.onCancel});

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
                  onPressed: onCancel,
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
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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
