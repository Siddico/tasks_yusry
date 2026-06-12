// ============================================================
// custom_text_field.dart
// Reusable animated text input widget
// Home Services App — Material Design 3
// ============================================================

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// A premium, animated text field that adapts to light and dark themes.
///
/// Features:
/// - Smooth focus animation (scale + color transition)
/// - Prefix icon with animated color change
/// - Optional suffix widget (e.g. show/hide toggle)
/// - Validation error display with fade-in animation
/// - Full keyboard type and text input action support
class CustomTextField extends StatefulWidget {
  /// Controller for reading / manipulating the field value.
  final TextEditingController controller;

  /// Placeholder label shown inside the field.
  final String hintText;

  /// Icon displayed on the left side of the input.
  final IconData prefixIcon;

  /// Optional widget on the right (e.g. visibility toggle).
  final Widget? suffixIcon;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Keyboard type — defaults to text.
  final TextInputType keyboardType;

  /// Action button on the keyboard.
  final TextInputAction textInputAction;

  /// Validator function; return an error string or null.
  final String? Function(String?)? validator;

  /// Called when the field value changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the field.
  final VoidCallback? onSubmitted;

  /// Autofill hints for system autofill.
  final Iterable<String>? autofillHints;

  /// Whether this field is currently read-only.
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  // Animation controller for the focus scale effect
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
    if (hasFocus) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Interpolate icon color based on focus state
    final Color iconColor = _isFocused
        ? AppColors.primary
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Focus(
        onFocusChange: _onFocusChange,
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          readOnly: widget.readOnly,
          style: AppStyles.bodyLG.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: (_) => widget.onSubmitted?.call(),
          validator: (value) {
            final error = widget.validator?.call(value);
            // Trigger rebuild to show/hide error
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && _errorText != error) {
                setState(() => _errorText = error);
              }
            });
            return error;
          },
          decoration: AppStyles.inputDecoration(
            hint: widget.hintText,
            isDark: isDark,
            prefixIcon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                widget.prefixIcon,
                color: iconColor,
                size: 20,
              ),
            ),
            suffixIcon: widget.suffixIcon,
            errorText: _errorText,
          ),
        ),
      ),
    );
  }
}
