import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/app_design.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/models/user_profile.dart';
import '../providers/auth_provider.dart';
import '../../profile/providers/user_profile_provider.dart';
import 'auth_field_styles.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _errorMessage = null;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
          );
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user != null) {
        final profileRepo = ref.read(userProfileRepositoryProvider);
        await profileRepo.createProfile(UserProfile(
          uid: user.uid,
          displayName: _nameController.text.trim(),
          email: user.email,
        ));
      }
      if (mounted) context.go(AppRoutes.home);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  void _goToLogin() => context.go(AppRoutes.login);

  TextStyle get _labelStyle => const TextStyle(
        color: AppPalette.textOnDark,
        fontWeight: FontWeight.w700,
        fontSize: 13,
        letterSpacing: 0.6,
      );

  @override
  Widget build(BuildContext context) {
    final insetBottom = MediaQuery.viewInsetsOf(context).bottom;

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
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.lg + insetBottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: SizedBox(
                      width: AppSpacing.registerTitleWidth,
                      height: AppSpacing.registerTitleHeight,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppAssets.createAccountTitle,
                          filterQuality: FilterQuality.high,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded || frame != null) {
                              return child;
                            }
                            return Center(
                              child: Text(
                                'CREATE ACCOUNT',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: AppPalette.primary,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                              ),
                            );
                          },
                          errorBuilder: (_, _, _) => SizedBox(
                            width: AppSpacing.registerTitleWidth,
                            height: AppSpacing.registerTitleHeight,
                            child: Center(
                              child: Text(
                                'CREATE ACCOUNT',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppPalette.primary,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                      fontSize: 22,
                                      height: 1.05,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
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
                  Text('EMAIL', style: _labelStyle),
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
                  Text('USERNAME', style: _labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  TextFormField(
                    controller: _nameController,
                    style: AuthFieldStyles.fieldText(context),
                    cursorColor: AppPalette.primary,
                    textCapitalization: TextCapitalization.words,
                    decoration: AuthFieldStyles.authCapsule(),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Kullanıcı adı girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('PASSWORD', style: _labelStyle),
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
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _isLoading ? null : _submit,
                      child: SizedBox(
                        width: AppSpacing.registerCtaWidth,
                        height: AppSpacing.registerCtaHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                AppAssets.createAccountButton,
                                width: AppSpacing.registerCtaWidth,
                                height: AppSpacing.registerCtaHeight,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => FilledButton(
                                  onPressed: _isLoading ? null : _submit,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppPalette.ctaButton,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: AppPalette.ctaButton
                                        .withValues(alpha: 0.6),
                                    minimumSize: const Size(
                                      AppSpacing.registerCtaWidth,
                                      AppSpacing.registerCtaHeight,
                                    ),
                                    maximumSize: const Size(
                                      AppSpacing.registerCtaWidth,
                                      AppSpacing.registerCtaHeight,
                                    ),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppSpacing.registerCtaHeight / 2,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'CREATE AN ACCOUNT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (_isLoading)
                              const SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _goToLogin,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              'Already have an account',
                              style: TextStyle(
                                color: AppPalette.textOnDark
                                    .withValues(alpha: 0.92),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: AppPalette.textOnDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppPalette.textOnDark,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: AppPalette.textOnDark,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
