import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/particle_background.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_state.dart';
import '../bloc/theme/theme_cubit.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/open_source_section.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/blog_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/floating_navbar.dart';
import '../../../../core/widgets/expanding_fab.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _scrollProgress = 0.0;
  int _activeIndex = 0;
  bool _showBackToTop = false;

  double _lastScrollOffset = 0.0;
  bool _isNavbarVisible = true;

  // Global Keys for scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _openSourceKey = GlobalKey();
  final GlobalKey _blogKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _heroKey,
      _aboutKey,
      _skillsKey,
      _projectsKey,
      _experienceKey,
      _openSourceKey,
      _blogKey,
      _contactKey,
    ];

    _scrollController.addListener(_onScroll);

    // Load portfolio data
    context.read<PortfolioBloc>().loadPortfolioData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Calculate scroll progress percentage
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    setState(() {
      _scrollProgress = maxScroll > 0
          ? (currentScroll / maxScroll).clamp(0.0, 1.0)
          : 0.0;
      _showBackToTop = currentScroll > 500;
    });

    // Detect active section on screen (closest to top of viewport)
    int newActiveIndex = _activeIndex;
    double minDistance = double.maxFinite;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          // Focus on items close to the top of screen (dy ~ 100 to account for nav bars)
          final double distance = (position.dy - 120).abs();
          if (distance < minDistance) {
            minDistance = distance;
            newActiveIndex = i;
          }
        }
      }
    }

    if (newActiveIndex != _activeIndex) {
      setState(() {
        _activeIndex = newActiveIndex;
      });
    }

    // Scroll Direction detection for Navbar Auto-hide
    final bool isScrollingDown = currentScroll > _lastScrollOffset;
    if (isScrollingDown && currentScroll > 150) {
      if (_isNavbarVisible) {
        setState(() {
          _isNavbarVisible = false;
        });
      }
    } else {
      if (!_isNavbarVisible) {
        setState(() {
          _isNavbarVisible = true;
        });
      }
    }
    _lastScrollOffset = currentScroll;
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;

    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = context.watch<ThemeCubit>().isDarkMode;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: isMobile ? _buildMobileDrawer(isDark) : null,
      body: Stack(
        children: [
          // Ambient Particle & Glow background
          Positioned.fill(
            child: ParticleBackground(
              child: BlocBuilder<PortfolioBloc, PortfolioState>(
                builder: (context, state) {
                  if (state is PortfolioInitial || state is PortfolioLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is PortfolioError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: AppColors.error),
                      ),
                    );
                  } else if (state is PortfolioLoaded) {
                    return _buildScrollableContent(state, isMobile);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          // Scroll Progress Indicator Bar at the absolute top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              alignment: Alignment.centerLeft,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.05),
              child: FractionallySizedBox(
                widthFactor: _scrollProgress,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                ),
              ),
            ),
          ),

          // Floating Glassmorphic Navbar (Sticky, animated hide/show)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: _isNavbarVisible ? (isMobile ? 12 : 24) : -80,
            left: 0,
            right: 0,
            child: FloatingNavbar(
              activeIndex: _activeIndex,
              onTabSelected: _scrollToSection,
              isDarkMode: isDark,
              onThemeToggle: () => context.read<ThemeCubit>().toggleTheme(),
              onHireMePressed: () => _scrollToSection(7),
              onMenuPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),

          // Floating Back-to-Top FAB (shifted up to accommodate contact FAB)
          Positioned(
            bottom: isMobile ? 80 : 160,
            right: 24,
            child: AnimatedOpacity(
              opacity: _showBackToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Visibility(
                visible: _showBackToTop,
                child: FloatingActionButton(
                  mini: isMobile,
                  onPressed: () => _scrollToSection(0),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.keyboard_arrow_up_rounded),
                ),
              ),
            ),
          ),

          // Expanding Contact FAB
          Positioned(
            bottom: isMobile ? 16 : 88,
            right: 24,
            child: const ExpandingFab(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent(PortfolioLoaded state, bool isMobile) {
    return RawScrollbar(
      controller: _scrollController,
      thumbColor: isDark(context)
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.black.withValues(alpha: 0.15),
      thickness: 6,
      radius: const Radius.circular(8),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              children: [
                // 1. Hero
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onViewProjects: () => _scrollToSection(3),
                    onHireMe: () => _scrollToSection(7),
                  ),
                ),

                // 2. About
                Container(key: _aboutKey, child: const AboutSection()),

                // 3. Skills
                Container(
                  key: _skillsKey,
                  child: SkillsSection(skills: state.skills),
                ),

                // 4. Projects
                Container(
                  key: _projectsKey,
                  child: ProjectsSection(
                    projects: state.filteredProjects,
                    activeCategory: state.activeCategory,
                    searchQuery: state.searchQuery,
                    onFilterChanged: (query, category) {
                      context.read<PortfolioBloc>().filterProjects(
                        query,
                        category,
                      );
                    },
                  ),
                ),

                // 5. Experience
                Container(
                  key: _experienceKey,
                  child: ExperienceSection(experiences: state.experiences),
                ),

                // 6. Open Source
                Container(
                  key: _openSourceKey,
                  child: OpenSourceSection(githubRepos: state.githubRepos),
                ),

                // Achievements Stats (Transitions directly after Open Source)
                const AchievementsSection(),

                // Testimonials
                TestimonialSection(testimonials: state.testimonials),

                // 7. Blog
                Container(
                  key: _blogKey,
                  child: BlogSection(blogs: state.blogs),
                ),

                // 8. Contact
                Container(key: _contactKey, child: const ContactSection()),

                // Footer
                const FooterSection(),

                // Add bottom padding for Desktop view so floating dock doesn't obscure the footer content
                if (!isMobile) const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildMobileDrawer(bool isDark) {
    final List<String> titles = [
      'Home',
      'About',
      'Skills',
      'Projects',
      'Experience',
      'Open Source',
      'Blog',
      'Contact',
    ];

    return Drawer(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Navigation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: isDark ? Colors.amber : Colors.indigo,
                    ),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10),

            // Navigation Links
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  final bool isActive = _activeIndex == index;
                  return ListTile(
                    title: Text(
                      titles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppColors.primary
                            : (isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                    trailing: isActive
                        ? const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: AppColors.primary,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      _scrollToSection(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
