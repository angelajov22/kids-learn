import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../data/colors_shapes_data.dart';
import '../models/color_shape_model.dart';
import '../widgets/color_shape_card.dart';
import '../../../core/accessibility/accessibility_settings.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/services/vibration_service.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/typography.dart';

class ColorsShapesScreen extends StatefulWidget {
  const ColorsShapesScreen({super.key});

  @override
  State<ColorsShapesScreen> createState() => _ColorsShapesScreenState();
}

class _ColorsShapesScreenState extends State<ColorsShapesScreen> {
  String _tab = 'colors';

  final _vib = VibrationService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  ColorShapeModel? _selected;

  bool _isBannerExpanded = false;
  bool _isMuted = false;

  List<ColorShapeModel> get _items =>
      _tab == 'colors'
          ? ColorsShapesData.colors
          : ColorsShapesData.shapes;

  Future<void> _playAudio(ColorShapeModel item) async {
    if (_isMuted || item.audioPath.isEmpty) return;

    try {
      final asset = item.audioPath.replaceFirst('assets/', '');

      debugPrint('Playing asset: $asset');

      await _audioPlayer.stop();
      await _audioPlayer.setSourceAsset(asset);
      await _audioPlayer.resume();
    } catch (e) {
      debugPrint('AUDIO ERROR: $e');
    }
  }

  Future<void> _onTap(ColorShapeModel item) async {
    setState(() => _selected = item);
    _vib.success();

    await _playAudio(item);
  }

  Future<void> _toggleMute() async {
    setState(() => _isMuted = !_isMuted);
    await _audioPlayer.setVolume(_isMuted ? 0 : 1);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AccessibilityScope.of(context).palette;

    return PageScaffold(
      title: '🎨 Бои и Форми',
      gradientColors: palette.colorsShapesGradient.colors,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isPhone = constraints.maxWidth < 600;

          return Column(
            children: [
              _buildTabs(isPhone),
              if (_selected != null) _buildSelectedBanner(isPhone),
              Expanded(
                child: _buildGrid(isPhone),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabs(bool isPhone) {
    final palette = AccessibilityScope.of(context).palette;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isPhone ? 20 : 60,
        vertical: isPhone ? 16 : 10,
      ),
      padding: EdgeInsets.all(isPhone ? 4 : 3),
      decoration: BoxDecoration(
        color: palette.controlBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: palette.border,
          width: palette.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: palette.border.withOpacity(0.12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          _tabBtn('colors', '🎨 Бои', isPhone),
          _tabBtn('shapes', '🔷 Форми', isPhone),
        ],
      ),
    );
  }

  Widget _tabBtn(
      String key,
      String label,
      bool isPhone,
      ) {
    final active = _tab == key;
    final palette = AccessibilityScope.of(context).palette;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tab = key;
            _selected = null;
            _isBannerExpanded = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: isPhone ? 12 : 9,
          ),
          decoration: BoxDecoration(
            color: active
                ? palette.selected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: active
                ? Border.all(
              color: palette.border,
              width: palette.borderWidth,
            )
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isPhone
                  ? AppTypeScale.interactive
                  : 15,
              fontWeight: FontWeight.w700,
              color: active
                  ? palette.onCard
                  : palette.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedBanner(bool isPhone) {
    final item = _selected!;
    final palette = AccessibilityScope.of(context).palette;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.fromLTRB(
        isPhone ? 16 : 50,
        4,
        isPhone ? 16 : 50,
        10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isPhone
            ? (_isBannerExpanded ? 20 : 16)
            : (_isBannerExpanded ? 16 : 14),
        vertical: isPhone
            ? (_isBannerExpanded ? 18 : 12)
            : (_isBannerExpanded ? 14 : 10),
      ),
      decoration: BoxDecoration(
        color: palette.selectedBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: palette.selected,
          width: palette.borderWidth + 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.type == ItemType.color)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isBannerExpanded
                      ? (isPhone ? 64 : 56)
                      : (isPhone ? 48 : 42),
                  height: _isBannerExpanded
                      ? (isPhone ? 64 : 56)
                      : (isPhone ? 48 : 42),
                  decoration: BoxDecoration(
                    color: item.displayColor,
                    shape: BoxShape.circle,
                  ),
                )
              else if (item.id == 'triangle' ||
                  item.id == 'rectangle' ||
                  item.id == 'pentagon' ||
                  item.id == 'hexagon')
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isBannerExpanded
                      ? (isPhone ? 64 : 56)
                      : (isPhone ? 48 : 42),
                  height: _isBannerExpanded
                      ? (isPhone ? 64 : 56)
                      : (isPhone ? 48 : 42),
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.contain,
                  ),
                )
              else
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: _isBannerExpanded
                        ? (isPhone ? 54 : 46)
                        : (isPhone ? 40 : 34),
                  ),
                  child: Text(item.emoji),
                ),
              SizedBox(width: isPhone ? 14 : 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: _isBannerExpanded
                            ? (isPhone ? 28 : 24)
                            : (isPhone ? 22 : 19),
                        fontWeight: FontWeight.w800,
                        color: palette.textPrimary,
                      ),
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: _isBannerExpanded
                            ? (isPhone ? 18 : 16)
                            : (isPhone ? 15 : 13),
                        color: palette.textSecondary,
                        height: 1.35,
                      ),
                      child: Text(
                        item.description,
                        maxLines: isPhone ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: isPhone ? 44 : 38,
                height: isPhone ? 44 : 38,
                child: Container(
                  decoration: BoxDecoration(
                    color: palette.selected.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        _isBannerExpanded =
                        !_isBannerExpanded;
                      });
                    },
                    icon: Icon(
                      _isBannerExpanded
                          ? Icons.zoom_out_rounded
                          : Icons.zoom_in_rounded,
                      color: palette.selected,
                      size: isPhone ? 24 : 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isPhone ? 16 : 10),
          Row(
            children: [
              if (item.audioPath.isNotEmpty)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                    _isMuted ? null : () => _playAudio(item),
                    icon: Icon(
                      Icons.volume_up_rounded,
                      size: isPhone ? 22 : 18,
                    ),
                    label: Text(
                      'Слушни повторно',
                      style: TextStyle(
                        fontSize: isPhone ? 17 : 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: palette.selected,
                      disabledBackgroundColor: Colors.white70,
                      disabledForegroundColor: Colors.grey,
                      elevation: 0,
                      minimumSize: Size.fromHeight(
                        isPhone ? 56 : 44,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          isPhone ? 16 : 12,
                        ),
                      ),
                    ),
                  ),
                ),
              if (item.audioPath.isNotEmpty)
                SizedBox(width: isPhone ? 10 : 8),
              Container(
                width: isPhone ? 46 : 40,
                height: isPhone ? 46 : 40,
                decoration: BoxDecoration(
                  color: palette.selected.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: _toggleMute,
                  icon: Icon(
                    _isMuted
                        ? Icons.notifications_off_rounded
                        : Icons.notifications_active_rounded,
                    color: palette.selected,
                    size: isPhone ? 22 : 19,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(bool isPhone) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: EdgeInsets.fromLTRB(
            isPhone ? 20 : 70,
            isPhone ? 8 : 12,
            isPhone ? 20 : 70,
            isPhone ? 20 : 24,
          ),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            AppDimensions.responsiveColumnCount(
              availableWidth: constraints.maxWidth,
              minimumCardWidth: isPhone ? 220 : 190,
            ),
            crossAxisSpacing: isPhone ? 16 : 18,
            mainAxisSpacing: isPhone ? 16 : 18,
            childAspectRatio: isPhone ? 0.88 : 1.12,
          ),
          itemCount: _items.length,
          itemBuilder: (_, i) {
            final item = _items[i];

            return ColorShapeCard(
              item: item,
              selected: _selected == item,
              onTap: () => _onTap(item),
            );
          },
        );
      },
    );
  }
}