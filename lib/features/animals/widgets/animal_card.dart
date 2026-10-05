import 'package:flutter/material.dart';
import '../models/animal_model.dart';
import '../../../core/accessibility/accessibility_settings.dart';
import '../../../core/services/vibration_service.dart';

class AnimalCard extends StatefulWidget {
  final AnimalModel animal;
  final VoidCallback onTap;
  final int index;

  const AnimalCard({
    super.key,
    required this.animal,
    required this.onTap,
    required this.index,
  });

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  final _vibration = VibrationService();

  bool _isHovering = false;
  bool _isPressed = false;

  void _handleTap() {
    _vibration.lightTap();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AccessibilityScope.of(context).palette;
    final cardColor = palette.itemAccent(widget.index);
    final lightColor = palette.tintedSurface(cardColor);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;

        final imageSize = cardWidth >= 250
            ? 90.0
            : cardWidth >= 180
            ? 78.0
            : 70.0;

        final animalImageSize = cardWidth >= 250
            ? 60.0
            : cardWidth >= 180
            ? 54.0
            : 48.0;

        final titleSize = cardWidth >= 250
            ? 22.0
            : cardWidth >= 180
            ? 20.0
            : 17.0;

        final soundSize = cardWidth >= 250
            ? 17.0
            : cardWidth >= 180
            ? 16.0
            : 14.0;

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
              _handleTap();
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
                padding: EdgeInsets.symmetric(
                  horizontal: cardWidth >= 250 ? 16 : 10,
                  vertical: cardWidth >= 250 ? 16 : 12,
                ),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: palette.border,
                    width: palette.borderWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cardColor.withValues(
                        alpha: _isHovering ? 0.25 : 0.15,
                      ),
                      blurRadius: _isHovering ? 16 : 10,
                      spreadRadius: _isHovering ? 1 : 0,
                      offset: Offset(
                        0,
                        _isHovering ? 7 : 4,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedScale(
                      scale: _isHovering ? 1.02 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          color: palette.controlBackground,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: cardColor.withValues(
                                alpha: _isHovering ? 0.25 : 0.18,
                              ),
                              blurRadius: _isHovering ? 14 : 10,
                              offset: Offset(
                                0,
                                _isHovering ? 5 : 3,
                              ),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            widget.animal.imagePath,
                            width: animalImageSize,
                            height: animalImageSize,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Text(
                              widget.animal.emoji,
                              style: TextStyle(
                                fontSize: animalImageSize * 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.animal.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            color: palette.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.animal.sound,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: soundSize,
                        fontWeight: FontWeight.w700,
                        color: palette.textSecondary,
                      ),
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