// ============================================================
// primary_button.dart
// Gradient primary action button with loading state
// Home Services App — Material Design 3
// ============================================================

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// A full-width gradient primary button with:
/// - Press / tap scale animation
/// - Loading spinner state
/// - Smooth gradient background
/// - Accessible disabled state
class PrimaryButton extends StatefulWidget {
  /// Button label text.
  final String label;

  /// Called when tapped (set to null when [isLoading] is true).
  final VoidCallback? onPressed;

  /// Shows a circular progress indicator instead of the label.
  final bool isLoading;

  /// Override the default gradient.
  final LinearGradient? gradient;

  /// Height of the button. Defaults to 58.
  final double height;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.gradient,
    this.height = 58,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

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
    _scaleAnimation = _pressController;
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.onPressed != null && !widget.isLoading) {
      _pressController.reverse();
    }
  }

  void _onTapUp(_) => _pressController.forward();
  void _onTapCancel() => _pressController.forward();

  bool get _isDisabled => widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: _isDisabled ? null : widget.onPressed,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isDisabled && !widget.isLoading ? 0.6 : 1.0,
              child: Container(
                height: widget.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: _isDisabled && !widget.isLoading
                      ? null
                      : (widget.gradient ?? AppColors.primaryGradient),
                  color: _isDisabled && !widget.isLoading
                      ? Colors.grey.shade400
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isDisabled ? [] : AppStyles.buttonShadow,
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: widget.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            widget.label,
                            key: ValueKey(widget.label),
                            style: AppStyles.buttonLG.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
