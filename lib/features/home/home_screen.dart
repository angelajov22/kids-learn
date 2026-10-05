import 'package:flutter/material.dart';
import '../../core/accessibility/accessibility_settings.dart';
import '../../core/accessibility/accessible_palette.dart';
import '../../core/services/vibration_service.dart';
import '../animals/screens/animals_screen.dart';
import '../colors_shapes/screens/colors_shapes_screen.dart';
import '../alphabet/screens/alphabet_screen.dart';
import '../plants/screens/plants_screen.dart';
import '../quiz/screens/quiz_screen.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleCtrl;
  late Animation<double> _titleAnim;

  final _vib = VibrationService();
  String? _hoveredCard;
  bool _quizHovered = false;

  @override
  void initState() {
    super.initState();

    _titleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _titleAnim = CurvedAnimation(
      parent: _titleCtrl,
      curve: Curves.elasticOut,
    );

    _titleCtrl.forward();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  void _navigate(Widget screen) {
    _vib.lightTap();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => screen,
        transitionsBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: anim,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AccessibilityScope.of(context).palette;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: palette.backgroundGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              final isPhone = width < 600;
              final compact = height < 700;

              final isTablet = width >= 600 && (width < 1000 || height > width);

              final titleFontSize = isTablet
                  ? (width * 0.04).clamp(34.0, 46.0)
                  : (width * 0.082).clamp(30.0, 34.0);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Semantics(
                          label: 'Учи и слушај',
                          excludeSemantics: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      palette.cardGradients[0].colors.first,
                                      palette.cardGradients[1].colors.first,
                                      palette.cardGradients[2].colors.first,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: palette
                                          .cardGradients[0].colors.first
                                          .withValues(alpha: 0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.graphic_eq_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    palette.cardGradients[0].colors.first,
                                    palette.cardGradients[1].colors.first,
                                    palette.cardGradients[2].colors.first,
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  'Учи и слушај',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: isPhone ? 20 : 24,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/logo_finki.png',
                          height: isPhone ? 28 : 38,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: isPhone
                        ? 26
                        : compact
                        ? 14
                        : 24,
                  ),
                  _buildTitle(
                    compact: compact,
                    titleFontSize: titleFontSize,
                    palette: palette,
                  ),
                  SizedBox(height: isPhone ? 8 : 6),
                  _buildAccessibilityButton(palette),
                  SizedBox(height: isPhone ? 10 : 18),
                  if (isPhone)
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                top: 2,
                                bottom: 12,
                              ),
                              child: _buildPhoneTopics(palette),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildQuizButton(
                            compact: false,
                            palette: palette,
                          ),
                          const SizedBox(height: 8),
                          _buildFooter(palette),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
                  else if (isTablet)
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: _buildTabletTopics(palette),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: ConstrainedBox(
                              constraints:
                              const BoxConstraints(maxWidth: 560),
                              child: _buildQuizButton(
                                compact: compact,
                                palette: palette,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          _buildFooter(palette),
                          const SizedBox(height: 5),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: _buildDesktopTopics(palette),
                          ),
                          const SizedBox(height: 8),
                          _buildQuizButton(
                            compact: true,
                            palette: palette,
                          ),
                          const SizedBox(height: 5),
                          _buildFooter(palette),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({
    required bool compact,
    required double titleFontSize,
    required AccessiblePalette palette,
  }) {
    return ScaleTransition(
      scale: _titleAnim,
      child: Column(
        children: [
          Container(
            width: compact ? 72 : 92,
            height: compact ? 72 : 92,
            decoration: BoxDecoration(
              gradient: palette.quizGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: palette.primary.withValues(alpha: 0.35),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '🎓',
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          SizedBox(height: compact ? 12 : 16),
          Text(
            'Учи со Забава!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Избери тема за учење',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilityButton(AccessiblePalette palette) {
    return Semantics(
      button: true,
      label: 'Пристапност. Отвори поставки за пристапност.',
      excludeSemantics: true,
      child: OutlinedButton.icon(
        onPressed: _showAccessibilitySettings,
        icon: const Icon(Icons.visibility_outlined),
        label: const Text('Пристапност'),
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.textPrimary,
          backgroundColor: palette.controlBackground,
          side: BorderSide(
            color: palette.border,
            width: palette.borderWidth,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 11,
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  void _showAccessibilitySettings() {
    _vib.lightTap();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final settings = AccessibilityScope.of(sheetContext);
        final palette = settings.palette;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Пристапност',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Режим на бои',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                for (final mode in ColorVisionMode.values)
                  _ColorModeOption(
                    mode: mode,
                    selected: settings.colorVisionMode == mode,
                    palette: palette,
                    onTap: () {
                      settings.setColorVisionMode(mode);
                      _vib.lightTap();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneTopics(AccessiblePalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildMenuCard(
            title: 'Животни',
            subtitle: 'Запознај ги!',
            emoji: '🐾',
            gradient: palette.cardGradients[0],
            palette: palette,
            height: 130,
            onTap: () => _navigate(const AnimalsScreen()),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            title: 'Бои и Форми',
            subtitle: 'Учи бои!',
            emoji: '🎨',
            gradient: palette.cardGradients[1],
            palette: palette,
            height: 130,
            onTap: () => _navigate(const ColorsShapesScreen()),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            title: 'Азбука',
            subtitle: 'Научи букви!',
            emoji: '🔤',
            gradient: palette.cardGradients[2],
            palette: palette,
            height: 130,
            onTap: () => _navigate(const AlphabetScreen()),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            title: 'Овошје и зеленчук',
            subtitle: 'Запознај ги!',
            emoji: '🍓',
            gradient: palette.cardGradients[3],
            palette: palette,
            height: 130,
            onTap: () => _navigate(const PlantsScreen()),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDesktopTopics(AccessiblePalette palette) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
        constraints.maxWidth > 1100 ? 1100.0 : constraints.maxWidth;

        final cardWidth = (availableWidth - 18) / 2;

        return Center(
          child: SizedBox(
            width: availableWidth,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 18,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildMenuCard(
                    title: 'Животни',
                    subtitle: 'Запознај ги!',
                    emoji: '🐾',
                    gradient: palette.cardGradients[0],
                    palette: palette,
                    height: 125,
                    onTap: () => _navigate(const AnimalsScreen()),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMenuCard(
                    title: 'Бои и Форми',
                    subtitle: 'Учи бои!',
                    emoji: '🎨',
                    gradient: palette.cardGradients[1],
                    palette: palette,
                    height: 125,
                    onTap: () => _navigate(const ColorsShapesScreen()),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMenuCard(
                    title: 'Азбука',
                    subtitle: 'Научи букви!',
                    emoji: '🔤',
                    gradient: palette.cardGradients[2],
                    palette: palette,
                    height: 125,
                    onTap: () => _navigate(const AlphabetScreen()),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMenuCard(
                    title: 'Овошје и зеленчук',
                    subtitle: 'Запознај ги!',
                    emoji: '🍓',
                    gradient: palette.cardGradients[3],
                    palette: palette,
                    height: 125,
                    onTap: () => _navigate(const PlantsScreen()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletTopics(AccessiblePalette palette) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 18.0;

        final availableWidth =
        (constraints.maxWidth - 56).clamp(280.0, 1100.0).toDouble();
        final cardWidth = (availableWidth - spacing) / 2;
        final cardHeight =
        ((constraints.maxHeight - spacing - 42) / 2)
            .clamp(125.0, 210.0)
            .toDouble();

        final heightScale = (cardHeight / 145).clamp(0.9, 1.3).toDouble();
        final widthScale = (cardWidth / 340).clamp(0.85, 1.3).toDouble();
        final scale = heightScale < widthScale ? heightScale : widthScale;

        return Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: availableWidth,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: _buildMenuCard(
                      title: 'Животни',
                      subtitle: 'Запознај ги!',
                      emoji: '🐾',
                      gradient: palette.cardGradients[0],
                      palette: palette,
                      height: cardHeight,
                      scale: scale,
                      onTap: () => _navigate(const AnimalsScreen()),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: _buildMenuCard(
                      title: 'Бои и Форми',
                      subtitle: 'Учи бои!',
                      emoji: '🎨',
                      gradient: palette.cardGradients[1],
                      palette: palette,
                      height: cardHeight,
                      scale: scale,
                      onTap: () => _navigate(const ColorsShapesScreen()),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: _buildMenuCard(
                      title: 'Азбука',
                      subtitle: 'Научи букви!',
                      emoji: '🔤',
                      gradient: palette.cardGradients[2],
                      palette: palette,
                      height: cardHeight,
                      scale: scale,
                      onTap: () => _navigate(const AlphabetScreen()),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: _buildMenuCard(
                      title: 'Овошје и зеленчук',
                      subtitle: 'Запознај ги!',
                      emoji: '🍓',
                      gradient: palette.cardGradients[3],
                      palette: palette,
                      height: cardHeight,
                      scale: scale,
                      onTap: () => _navigate(const PlantsScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuizButton({
    required bool compact,
    required AccessiblePalette palette,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!mounted) return;
        setState(() {
          _quizHovered = true;
        });
      },
      onExit: (_) {
        if (!mounted) return;
        setState(() {
          _quizHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          _navigate(const QuizScreen());
        },
        child: AnimatedScale(
          scale: _quizHovered ? 1.035 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: compact ? 360 : double.infinity,
            height: compact ? 62 : 74,
            decoration: BoxDecoration(
              gradient: palette.quizGradient,
              borderRadius: BorderRadius.circular(compact ? 20 : 24),
              border: Border.all(
                color: palette.border,
                width: palette.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: palette.quizGradient.colors.first.withValues(
                    alpha: _quizHovered ? 0.65 : 0.4,
                  ),
                  blurRadius: _quizHovered ? 24 : 16,
                  spreadRadius: _quizHovered ? 2 : 0,
                  offset: Offset(0, _quizHovered ? 8 : 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  top: -5,
                  child: Opacity(
                    opacity: 0.2,
                    child: Text(
                      '🧠',
                      style: TextStyle(fontSize: compact ? 65 : 80),
                    ),
                  ),
                ),
                Positioned.fill(
                  right: compact ? 30 : 46,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🧠',
                          style: TextStyle(fontSize: compact ? 22 : 30),
                        ),
                        SizedBox(width: compact ? 8 : 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Квиз',
                              style: TextStyle(
                                fontSize: compact ? 18 : 24,
                                fontWeight: FontWeight.w900,
                                color: palette.onCard,
                              ),
                            ),
                            Text(
                              'Тестирај ги знаењата!',
                              style: TextStyle(
                                fontSize: compact ? 12 : 16,
                                fontWeight: FontWeight.w500,
                                color: palette.onCardSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required String emoji,
    required LinearGradient gradient,
    required AccessiblePalette palette,
    required VoidCallback onTap,
    double height = 145,
    double scale = 1.0,
  }) {
    final isHovered = _hoveredCard == title;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!mounted) return;
        setState(() {
          _hoveredCard = title;
        });
      },
      onExit: (_) {
        if (!mounted) return;
        setState(() {
          if (_hoveredCard == title) {
            _hoveredCard = null;
          }
        });
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: isHovered ? 1.025 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            height: height,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: palette.border,
                width: palette.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withValues(
                    alpha: isHovered ? 0.55 : 0.4,
                  ),
                  blurRadius: isHovered ? 24 : 16,
                  spreadRadius: isHovered ? 2 : 0,
                  offset: Offset(0, isHovered ? 8 : 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 4,
                  bottom: -18 * scale,
                  child: AnimatedScale(
                    scale: isHovered ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 180),
                    child: AnimatedOpacity(
                      opacity: isHovered ? 0.34 : 0.25,
                      duration: const Duration(milliseconds: 180),
                      child: Text(
                        emoji,
                        style: TextStyle(
                          fontSize: (height >= 130 ? 86 : 70) * scale,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22 * scale,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      AnimatedScale(
                        scale: isHovered ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 180),
                        child: Container(
                          width: 68 * scale,
                          height: 68 * scale,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            emoji,
                            style: TextStyle(fontSize: 42 * scale),
                          ),
                        ),
                      ),
                      SizedBox(width: 20 * scale),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 23 * scale,
                                height: 1.1,
                                fontWeight: FontWeight.w900,
                                color: palette.onCard,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w600,
                                color: palette.onCardSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 180),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 28 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(AccessiblePalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 8,
      ),
      child: Text(
        '🌟 Учи, Играј, Расти! 🌟',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: palette.textSecondary,
        ),
      ),
    );
  }
}

class _ColorModeOption extends StatelessWidget {
  const _ColorModeOption({
    required this.mode,
    required this.selected,
    required this.palette,
    required this.onTap,
  });

  final ColorVisionMode mode;
  final bool selected;
  final AccessiblePalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = selected ? 'избрано' : 'не е избрано';

    return Semantics(
      button: true,
      selected: selected,
      label: '${mode.label}, $status',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? palette.selectedBackground
                  : palette.controlBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? palette.selected : palette.border,
                width: selected
                    ? palette.borderWidth + 1
                    : palette.borderWidth,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected ? palette.selected : palette.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    mode.label,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                      selected ? FontWeight.w900 : FontWeight.w600,
                      color: palette.textPrimary,
                    ),
                  ),
                ),
                if (selected)
                  Text(
                    'Избрано',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: palette.selected,
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