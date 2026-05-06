import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_design.dart';
import '../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import 'auth_field_styles.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _errorMessage = null;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );
      if (mounted) context.go(AppRoutes.home);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final insetBottom = MediaQuery.viewInsetsOf(context).bottom;
    final mqW = MediaQuery.sizeOf(context).width;
    final frameCap = AppSpacing.figmaFrameWidth;
    final contentW = mqW < frameCap ? mqW : frameCap;
    final figmaScale = contentW / AppSpacing.figmaFrameWidth;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          filled: false,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppPalette.backgroundDark,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: frameCap,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg * figmaScale,
                  AppSpacing.md * figmaScale,
                  AppSpacing.lg * figmaScale,
                  AppSpacing.lg * figmaScale + insetBottom,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_errorMessage != null) ...[
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      Text(
                        'E-posta',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppPalette.textOnDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      TextFormField(
                        controller: _emailController,
                        style: AuthFieldStyles.fieldText(context),
                        cursorColor: AppPalette.primary,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: AuthFieldStyles.authCapsule(),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'E-posta girin';
                          }
                          if (!v.contains('@')) return 'Geçerli e-posta girin';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Şifre',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppPalette.textOnDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      TextFormField(
                        controller: _passwordController,
                        style: AuthFieldStyles.fieldText(context),
                        cursorColor: AppPalette.primary,
                        obscureText: _obscurePassword,
                        decoration: AuthFieldStyles.authCapsule(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppPalette.textSecondaryLight,
                              size: 22,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.length < 6) {
                            return 'En az 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Center(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppPalette.ctaButton,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(
                              AppSpacing.ctaButtonWidth,
                              AppSpacing.ctaButtonHeight,
                            ),
                            maximumSize: const Size(
                              AppSpacing.ctaButtonWidth,
                              AppSpacing.ctaButtonHeight,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AuthFieldStyles.capsuleRadius,
                              ),
                            ),
                          ),
                          onPressed: _isLoading ? null : _submit,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'GİRİŞ YAP',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => context.push(AppRoutes.register),
                        child: Text(
                          'Hesabınız yok mu? Kayıt olun',
                          style: TextStyle(
                            color: AppPalette.textSecondaryDark,
                            decoration: TextDecoration.underline,
                            decorationColor: AppPalette.textSecondaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
