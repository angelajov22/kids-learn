import 'package:flutter/material.dart';
import '../models/letter_model.dart';
import '../../../core/services/vibration_service.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/typography.dart';
import '../../../core/accessibility/accessibility_settings.dart';

class LetterCard extends StatefulWidget {
  final LetterModel letter;
  final VoidCallback onTap;
  final int index;

  const LetterCard({
    super.key,
    required this.letter,
    required this.onTap,
    required this.index,
  });

  @override
  State<LetterCard> createState() => _LetterCardState();
}

class _LetterCardState extends State<LetterCard> {
  final _vib = VibrationService();

  bool _isHovering = false;
  bool _isPressed = false;

  void _tap() {
    _vib.lightTap();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AccessibilityScope.of(context).palette;
    final color = palette.itemAccent(widget.index);
    final light = palette.tintedSurface(color, 0.88);

    final scale = _isPressed
        ? 0.97
        : _isHovering
        ? 1.025
        : 1.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!mounted) return;
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        if (!mounted) return;
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (!mounted) return;
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          if (!mounted) return;
          setState(() {
            _isPressed = false;
          });
          _tap();
        },
        onTapCancel: () {
          if (!mounted) return;
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(
              AppDimensions.cardPadding,
            ),
            decoration: BoxDecoration(
              color: light,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: palette.border,
                width: palette.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(
                    alpha: _isHovering ? 0.20 : 0.12,
                  ),
                  blurRadius: _isHovering ? 14 : 8,
                  spreadRadius: _isHovering ? 1 : 0,
                  offset: Offset(
                    0,
                    _isHovering ? 6 : 3,
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _isHovering ? 1.02 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: Text(
                    widget.letter.letter,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.letter.letterLower,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: palette.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.letter.emoji,
                  style: const TextStyle(
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.letter.word,
                  style: TextStyle(
                    fontSize: AppTypeScale.interactive,
                    fontWeight: FontWeight.w700,
                    color: palette.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}