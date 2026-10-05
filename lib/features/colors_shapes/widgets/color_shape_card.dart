import 'package:flutter/material.dart';

import '../models/color_shape_model.dart';
import '../../../core/services/vibration_service.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/accessibility/accessibility_settings.dart';

class ColorShapeCard extends StatefulWidget {
  final ColorShapeModel item;
  final VoidCallback onTap;
  final bool selected;

  const ColorShapeCard({
    super.key,
    required this.item,
    required this.onTap,
    this.selected = false,
  });

  @override
  State<ColorShapeCard> createState() => _ColorShapeCardState();
}

class _ColorShapeCardState extends State<ColorShapeCard> {
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
    final light = palette.tintedSurface(
      widget.item.displayColor,
      0.88,
    );

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
              color: widget.selected ? palette.selectedBackground : light,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.selected ? palette.selected : palette.border,
                width: widget.selected
                    ? palette.borderWidth + 1
                    : palette.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: palette.border.withValues(
                    alpha: _isHovering
                        ? 0.18
                        : widget.selected
                        ? 0.18
                        : 0.10,
                  ),
                  blurRadius: _isHovering
                      ? 14
                      : widget.selected
                      ? 10
                      : 6,
                  spreadRadius: _isHovering ? 1 : 0,
                  offset: Offset(
                    0,
                    _isHovering ? 6 : 3,
                  ),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: AnimatedScale(
                    scale: widget.selected
                        ? 1.01
                        : _isHovering
                        ? 1.02
                        : 1.0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.item.type == ItemType.color)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: widget.selected ? 82 : 74,
                            height: widget.selected ? 82 : 74,
                            decoration: BoxDecoration(
                              color: widget.item.displayColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: palette.border.withValues(
                                    alpha: 0.18,
                                  ),
                                  blurRadius: _isHovering ? 14 : 10,
                                  offset: Offset(
                                    0,
                                    _isHovering ? 6 : 4,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (widget.item.id == 'triangle' ||
                            widget.item.id == 'rectangle' ||
                            widget.item.id == 'pentagon' ||
                            widget.item.id == 'hexagon')
                          SizedBox(
                            width: widget.selected ? 72 : 68,
                            height: widget.selected ? 72 : 68,
                            child: Image.asset(
                              widget.item.imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Text(
                                widget.item.emoji,
                                style: TextStyle(
                                  fontSize: widget.selected ? 54 : 50,
                                ),
                              ),
                            ),
                          )
                        else
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            style: TextStyle(
                              fontSize: widget.selected ? 54 : 50,
                            ),
                            child: Text(widget.item.emoji),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          widget.item.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppDimensions.cardTitleFont - 3,
                            fontWeight: FontWeight.w800,
                            color: palette.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.selected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: AnimatedScale(
                      scale: widget.selected ? 1 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: palette.selected,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: palette.onCard,
                        ),
                      ),
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