import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../../../core/services/vibration_service.dart';
import '../../../core/accessibility/accessibility_settings.dart';

class PlantCard extends StatefulWidget {
  final PlantModel plant;
  final VoidCallback onTap;
  final int index;

  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
    required this.index,
  });

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
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
    final light = palette.tintedSurface(color);

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
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: light,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: palette.border,
                width: palette.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _isHovering ? 1.02 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: palette.controlBackground,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(
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
                        widget.plant.imagePath,
                        width: 58,
                        height: 58,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Text(
                          widget.plant.emoji,
                          style: const TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.plant.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.plant.category,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}