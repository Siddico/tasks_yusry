// ============================================================
// secondary_button.dart
// Outlined "Create Account" button with tap animation
// Home Services App — Material Design 3
// ============================================================

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// A full-width outlined secondary button with:
/// - Gradient border using a custom painter
/// - Press / tap scale animation
/// - Theme-aware label color
/// - Accessible disabled state
class SecondaryButton extends StatefulWidget {
  /// Button label text.
  final String label;

  /// Called when tapped.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Height of the button. Defaults to 58.
  final double height;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 58,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.onPressed != null) _pressController.reverse();
  }

  void _onTapUp(_) => _pressController.forward();
  void _onTapCancel() => _pressController.forward();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.primaryLight : AppColors.primary;

    return AnimatedBuilder(
      animation: _pressController,
      builder: (context, child) {
        return Transform.scale(
          scale: _pressController.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.onPressed,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: widget.onPressed == null ? 0.5 : 1.0,
              child: _GradientBorderButton(
                height: widget.height,
                isDark: isDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: AppStyles.buttonLG.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Internal widget that renders a gradient-stroke border container.
class _GradientBorderButton extends StatelessWidget {
  final Widget child;
  final double height;
  final bool isDark;

  const _GradientBorderButton({
    required this.child,
    required this.height,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        // 1.5px gradient border thickness
        padding: const EdgeInsets.all(1.5),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(14.5),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
