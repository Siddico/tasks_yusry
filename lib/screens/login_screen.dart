// ============================================================
// login_screen.dart
// Complete Login UI for Home Services App
// Features: fade-in animation, form validation, show/hide
// password, loading state, keyboard dismiss, light/dark mode
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

/// Login screen — the entry point of the Home Services app.
///
/// This screen demonstrates a production-quality UI pattern including:
/// - Multi-phase fade+slide entrance animation
/// - Email & password validation
/// - Password show/hide toggle with smooth animation
/// - Async login simulation with loading state
/// - Keyboard dismissal on tap outside
/// - Full light/dark theme support
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // ─── Form & Controllers ────────────────────────────────────
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // ─── UI State ──────────────────────────────────────────────
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  // ─── Animation Controllers ─────────────────────────────────
  late AnimationController _masterController;

  // Logo animations
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _logoScale;

  // Heading animations
  late Animation<double> _headingFade;
  late Animation<Offset> _headingSlide;

  // Form card animations
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  // Footer animations
  late Animation<double> _footerFade;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // Start the entrance animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _masterController.forward();
    });
  }

  /// Builds all staggered animations on a single master controller.
  void _setupAnimations() {
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // ── Logo: 0ms → 400ms ──────────────────────────────────
    final CurvedAnimation logoBase = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(logoBase);
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(logoBase);
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    // ── Heading: 200ms → 550ms ─────────────────────────────
    final CurvedAnimation headingBase = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
    );
    _headingFade = Tween<double>(begin: 0, end: 1).animate(headingBase);
    _headingSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(headingBase);

    // ── Card / Form: 350ms → 800ms ─────────────────────────
    final CurvedAnimation cardBase = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.30, 0.80, curve: Curves.easeOutCubic),
    );
    _cardFade = Tween<double>(begin: 0, end: 1).animate(cardBase);
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(cardBase);

    // ── Footer: 700ms → 1000ms ─────────────────────────────
    _footerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _masterController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ─── Validation ────────────────────────────────────────────

  /// Validates email format.
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates password length.
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // ─── Actions ───────────────────────────────────────────────

  /// Simulates an async login request.
  Future<void> _handleLogin() async {
    // Dismiss keyboard before validation
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    // Show success snackbar (replace with navigation in real app)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 12),
            Text('Login successful! Welcome back.'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Navigates to forgot password (stub).
  void _handleForgotPassword() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Password reset email sent!'),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Navigates to registration (stub).
  void _handleCreateAccount() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Create Account screen — coming soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ─── Build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Make status bar icons match the theme
      value: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: GestureDetector(
        // Dismiss keyboard when tapping outside any field
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            // Full-screen gradient background
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.backgroundGradientDark
                  : AppColors.backgroundGradient,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: padding.top + 8,
                  bottom: 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - padding.top - padding.bottom - 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.03),
                      _buildLogoSection(isDark),
                      SizedBox(height: size.height * 0.04),
                      _buildHeadingSection(isDark),
                      SizedBox(height: size.height * 0.04),
                      _buildFormCard(isDark),
                      SizedBox(height: size.height * 0.03),
                      _buildFooter(isDark),
                      SizedBox(height: size.height * 0.02),
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

  // ─── Section Builders ──────────────────────────────────────

  /// Logo + app name section at the top.
  Widget _buildLogoSection(bool isDark) {
    return FadeTransition(
      opacity: _logoFade,
      child: SlideTransition(
        position: _logoSlide,
        child: ScaleTransition(
          scale: _logoScale,
          child: Column(
            children: [
              // Logo container with glassmorphism card
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: isDark
                      ? AppStyles.cardShadowDark
                      : AppStyles.cardShadowLight,
                  gradient: AppColors.primaryGradient,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/images/home_services_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.home_repair_service_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // App name with gradient text
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  'HomeServe',
                  style: AppStyles.headingLG.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Professional Home Services',
                style: AppStyles.bodySM.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Welcome heading and subtitle text.
  Widget _buildHeadingSection(bool isDark) {
    return FadeTransition(
      opacity: _headingFade,
      child: SlideTransition(
        position: _headingSlide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back 👋',
              style: AppStyles.headingXL.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to book trusted professionals for all\nyour home repair and maintenance needs.',
              style: AppStyles.bodyMD.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The main form card with inputs and action buttons.
  Widget _buildFormCard(bool isDark) {
    return FadeTransition(
      opacity: _cardFade,
      child: SlideTransition(
        position: _cardSlide,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(28),
            boxShadow: isDark
                ? AppStyles.cardShadowDark
                : AppStyles.cardShadowLight,
            // Subtle glassmorphism border
            border: Border.all(
              color: isDark
                  ? AppColors.borderDark.withValues(alpha: 0.5)
                  : AppColors.borderLight,
              width: 1,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Email Field ──────────────────────────
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  prefixIcon: Icons.alternate_email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: _validateEmail,
                  onSubmitted: () =>
                      FocusScope.of(context).requestFocus(_passwordFocus),
                ),
                const SizedBox(height: 16),

                // ── Password Field ───────────────────────
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: !_passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  validator: _validatePassword,
                  onSubmitted: _handleLogin,
                  suffixIcon: _buildPasswordToggle(isDark),
                ),
                const SizedBox(height: 8),

                // ── Remember Me + Forgot Password Row ────
                Row(
                  children: [
                    // Remember me checkbox
                    Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (v) =>
                            setState(() => _rememberMe = v ?? false),
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    Text(
                      'Remember me',
                      style: AppStyles.bodyMD.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const Spacer(),
                    // Forgot password link
                    TextButton(
                      onPressed: _handleForgotPassword,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: AppStyles.buttonMD.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Login Button ─────────────────────────
                PrimaryButton(
                  label: 'Login',
                  onPressed: _isLoading ? null : _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),

                // ── Divider ──────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: AppStyles.bodySM.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Create Account Button ────────────────
                SecondaryButton(
                  label: 'Create Account',
                  icon: Icons.person_add_outlined,
                  onPressed: _handleCreateAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Animated show/hide password icon button.
  Widget _buildPasswordToggle(bool isDark) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: IconButton(
        key: ValueKey(_passwordVisible),
        icon: Icon(
          _passwordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        onPressed: () {
          HapticFeedback.selectionClick();
          setState(() => _passwordVisible = !_passwordVisible);
        },
        tooltip: _passwordVisible ? 'Hide password' : 'Show password',
      ),
    );
  }

  /// Bottom footer with terms and social login hint.
  Widget _buildFooter(bool isDark) {
    return FadeTransition(
      opacity: _footerFade,
      child: Column(
        children: [
          // Terms text
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppStyles.bodySM.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              children: [
                const TextSpan(text: 'By continuing, you agree to our '),
                TextSpan(
                  text: 'Terms of Service',
                  style: AppStyles.bodySM.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppStyles.bodySM.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Service badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBadge(Icons.verified_rounded, 'Verified Pros', isDark),
              const SizedBox(width: 20),
              _buildBadge(Icons.shield_outlined, 'Insured', isDark),
              const SizedBox(width: 20),
              _buildBadge(Icons.star_rounded, '4.9 Rated', isDark),
            ],
          ),
        ],
      ),
    );
  }

  /// Small trust badge with icon and label.
  Widget _buildBadge(IconData icon, String label, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.accent,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppStyles.bodySM.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
