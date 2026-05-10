import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'auth_scaffold.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _reset() {
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: AuthCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create New Password',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your new password',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            const FieldLabel(text: 'Password'),
            const SizedBox(height: 8),
            AppTextField(
              controller: _passwordController,
              hint: 'Enter your password',
              icon: Icons.lock_outline,
              obscureText: _obscure1,
              suffix: IconButton(
                onPressed: () => setState(() => _obscure1 = !_obscure1),
                icon: Icon(
                  _obscure1
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const FieldLabel(text: 'Password'),
            const SizedBox(height: 8),
            AppTextField(
              controller: _confirmController,
              hint: 'Enter your password',
              icon: Icons.lock_outline,
              obscureText: _obscure2,
              suffix: IconButton(
                onPressed: () => setState(() => _obscure2 = !_obscure2),
                icon: Icon(
                  _obscure2
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Reset Password', onPressed: _reset),
          ],
        ),
      ),
    );
  }
}
