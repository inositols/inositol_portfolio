import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../../../core/utils/launcher.dart';
import '../../data/models/portfolio_models.dart';
import 'project_details_modal.dart';

class ProjectsSection extends StatefulWidget {
  final List<Project> projects;
  final String activeCategory;
  final String searchQuery;
  final Function(String query, String category) onFilterChanged;

  const ProjectsSection({
    super.key,
    required this.projects,
    required this.activeCategory,
    required this.searchQuery,
    required this.onFilterChanged,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showProjectDetails(Project project) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProjectDetailsModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = ['All', 'Mobile', 'Web', 'Package'];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Featured Projects",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Explore production-grade apps designed and delivered by me, showcasing architectural precision and polished UX.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Filters & Search Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 16,
            children: [
              // Search Input
              SizedBox(
                width: isMobile ? double.infinity : 320,
                child: GlassContainer(
                  blur: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      widget.onFilterChanged(val, widget.activeCategory);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search projects by tech or name...',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search_rounded,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                widget.onFilterChanged('', widget.activeCategory);
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),

              // Categories Chips
              Wrap(
                spacing: 8,
                children: categories.map((cat) {
                  final bool isSelected = widget.activeCategory == cat;
                  return ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected 
                            ? Colors.white 
                            : (isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: isDark 
                        ? Colors.white.withValues(alpha: 0.04) 
                        : Colors.black.withValues(alpha: 0.04),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected 
                            ? Colors.transparent 
                            : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08)),
                        width: 1,
                      ),
                    ),
                    onSelected: (_) {
                      widget.onFilterChanged(_searchController.text, cat);
                    },
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Projects List
          if (widget.projects.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_off_outlined,
                      size: 64,
                      color: isDark ? Colors.white30 : Colors.black.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No projects found matching "$_searchController.text"',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.projects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 80),
              itemBuilder: (context, index) {
                final project = widget.projects[index];
                // Alternate image left/right in desktop
                final bool imageOnLeft = index % 2 == 0;
                
                final detailsWidget = _buildProjectDetails(project, isDark, isMobile);
                final mockWidget = _buildProjectMockup(project, isDark);

                return isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mockWidget,
                          const SizedBox(height: 32),
                          detailsWidget,
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: imageOnLeft
                            ? [
                                Expanded(flex: 5, child: mockWidget),
                                const SizedBox(width: 64),
                                Expanded(flex: 5, child: detailsWidget),
                              ]
                            : [
                                Expanded(flex: 5, child: detailsWidget),
                                const SizedBox(width: 64),
                                Expanded(flex: 5, child: mockWidget),
                              ],
                      ).animate().fadeIn(duration: 800.ms, delay: 100.ms).slideY(begin: 0.1, end: 0);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProjectDetails(Project project, bool isDark, bool isMobile) {
    Color projectThemeColor;
    IconData projectIcon;

    switch (project.id) {
      case 'jcommunity':
        projectThemeColor = AppColors.accent;
        projectIcon = Icons.event_available_rounded;
        break;
      case 'bucapay':
        projectThemeColor = AppColors.success;
        projectIcon = Icons.account_balance_wallet_rounded;
        break;
      case 'monami':
        projectThemeColor = Colors.purpleAccent;
        projectIcon = Icons.shopping_bag_rounded;
        break;
      case 'healthlog':
        projectThemeColor = Colors.tealAccent;
        projectIcon = Icons.favorite_rounded;
        break;
      default:
        projectThemeColor = AppColors.primary;
        projectIcon = Icons.developer_mode_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role & Scope
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: projectThemeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: projectThemeColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(projectIcon, size: 12, color: projectThemeColor),
              const SizedBox(width: 6),
              Text(
                project.role,
                style: TextStyle(
                  color: projectThemeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          project.title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          project.subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          project.description,
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 24),

        // Features list
        Text(
          'Key System Modules & Accomplishments:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.features.map((f) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: projectThemeColor.withValues(alpha: 0.05),
                border: Border.all(color: projectThemeColor.withValues(alpha: 0.15)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline_rounded, size: 12, color: projectThemeColor),
                  const SizedBox(width: 6),
                  Text(
                    f,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Tech stack chips
        Text(
          'Core Stack:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((t) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? Colors.transparent : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: projectThemeColor.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                t,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            NeonButton(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              onPressed: () => _showProjectDetails(project),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('View Case Study', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.auto_awesome_mosaic_rounded, size: 14, color: Colors.white),
                ],
              ),
            ),
            if (project.githubUrl != null)
              NeonButton(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                onPressed: () => Launcher.launchURL(project.githubUrl!),
                isSecondary: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.code_rounded, size: 16, color: isDark ? Colors.white : Colors.black),
                    const SizedBox(width: 8),
                    const Text('GitHub', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            if (project.playStoreUrl != null)
              NeonButton(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                onPressed: () => Launcher.launchURL(project.playStoreUrl!),
                isSecondary: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 16, color: isDark ? Colors.white : Colors.black),
                    const SizedBox(width: 8),
                    const Text('Play Store', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            if (project.appStoreUrl != null)
              NeonButton(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                onPressed: () => Launcher.launchURL(project.appStoreUrl!),
                isSecondary: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.apple_rounded, size: 16, color: isDark ? Colors.white : Colors.black),
                    const SizedBox(width: 8),
                    const Text('App Store', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            if (project.liveDemoUrl != null)
              NeonButton(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                onPressed: () => Launcher.launchURL(project.liveDemoUrl!),
                isSecondary: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Live Demo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
                    const SizedBox(width: 8),
                    Icon(Icons.open_in_new_rounded, size: 14, color: isDark ? Colors.white : Colors.black),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectMockup(Project project, bool isDark) {
    return GestureDetector(
      onTap: () => _showProjectDetails(project),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SpotlightCard(
          borderRadius: 16,
          glowColor: AppColors.primary.withValues(alpha: 0.1),
          child: Container(
            height: 380,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Ambient glows inside card
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Render specific vector designs
                Positioned.fill(
                  child: Center(
                    child: _getMockupContent(project.id, isDark),
                  ),
                ),

                // Floating "Click for Case Study" overlay indicator
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: GlassContainer(
                    blur: 6.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    borderRadius: BorderRadius.circular(12),
                    borderColor: Colors.white12,
                    color: Colors.black45,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome_motion_rounded, size: 12, color: AppColors.accent),
                        SizedBox(width: 6),
                        Text(
                          'View Case Study',
                          style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget _getMockupContent(String id, bool isDark) {
    final Color screenBg = isDark ? const Color(0xFF18181C) : Colors.white;
    final Color elementBg = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05);
    final Color textColor = isDark ? Colors.white.withValues(alpha: 0.87) : Colors.black87;

    switch (id) {
      case 'jcommunity':
        // Event QR Scanner mock
        return Container(
          width: 200,
          height: 340,
          decoration: BoxDecoration(
            color: screenBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 3),
          ),
          child: Column(
            children: [
              // Mock phone bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('09:41', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
                    Icon(Icons.battery_std_rounded, size: 10, color: textColor),
                  ],
                ),
              ),
              const Text('QR Attendance Scanner', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              // Scanner box
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.accent, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, size: 70, color: textColor.withValues(alpha: 0.4)),
                      // Moving laser line
                      Container(
                        width: 110,
                        height: 2,
                        color: Colors.redAccent,
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                       .slideY(begin: -25, end: 25, duration: 1500.ms),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Event Ticket Mock
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CHECK-IN SUCCESS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.success)),
                          Text('Okwuchukwu Okama', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 'bucapay':
        // Crypto transfer/wallet mock
        return Container(
          width: 200,
          height: 340,
          decoration: BoxDecoration(
            color: screenBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3), width: 3),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text('BucaPay Wallet', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // Card Mock
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                height: 90,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Balance', style: TextStyle(fontSize: 9, color: Colors.white70)),
                        Icon(Icons.nfc_rounded, color: Colors.white, size: 16),
                      ],
                    ),
                    Text('\$1,894.45', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BTC/USD Wallet', style: TextStyle(fontSize: 8, color: Colors.white70)),
                        Text('**** 9820', style: TextStyle(fontSize: 9, color: Colors.white)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Transaction item mocks
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transactions', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
                    Text('See All', style: TextStyle(fontSize: 9, color: AppColors.accent)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildMockTxItem('Sell BTC', '-\$450.00', 'Success', AppColors.success, textColor, elementBg),
              _buildMockTxItem('Off-ramp bank', '+\$450.00', 'Completed', AppColors.success, textColor, elementBg),
              _buildMockTxItem('Sell Ethereum', '-\$120.00', 'Processing', Colors.orange, textColor, elementBg),
            ],
          ),
        );
      case 'monami':
        // Shop Checkout mock
        return Container(
          width: 200,
          height: 340,
          decoration: BoxDecoration(
            color: screenBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.purple.withValues(alpha: 0.3), width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Monami Shop', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              // Product Item Row
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: elementBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, color: Colors.amber, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Leather Backpack', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                          Text('\$89.00', style: TextStyle(fontSize: 8, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const Icon(Icons.add_circle_outline_rounded, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Cart payment form
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: elementBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Card Details', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                        Icon(Icons.credit_card_rounded, size: 12, color: Colors.purple.withValues(alpha: 0.8)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 18,
                      width: double.infinity,
                      decoration: BoxDecoration(color: screenBg, borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 6),
                      child: const Text('**** **** **** 4810', style: TextStyle(fontSize: 8)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Pay \$89.00', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Success checkout screen slider
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping_outlined, color: AppColors.success, size: 16),
                    SizedBox(width: 8),
                    Text('Order Track ID: #MN-982', style: TextStyle(fontSize: 8, color: AppColors.success, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        );
      case 'healthlog':
        // Chart log mock
        return Container(
          width: 200,
          height: 340,
          decoration: BoxDecoration(
            color: screenBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal.withValues(alpha: 0.3), width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Health Analytics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              // Blood pressure status block
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Pressure', style: TextStyle(fontSize: 8, color: Colors.grey)),
                        Text('120 / 80', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal)),
                      ],
                    ),
                    Text('NORMAL', style: TextStyle(fontSize: 9, color: AppColors.success, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Simulated line chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('Weekly BMI Trend', style: TextStyle(fontSize: 9, color: textColor.withValues(alpha: 0.6), fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Container(
                height: 110,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: elementBg, borderRadius: BorderRadius.circular(8)),
                child: CustomPaint(
                  painter: MockTrendPainter(isDark: isDark),
                ),
              ),
            ],
          ),
        );
      default:
        return const Icon(Icons.developer_board_rounded, size: 60, color: AppColors.primary);
    }
  }

  Widget _buildMockTxItem(String label, String amount, String stateText, Color stateColor, Color textCol, Color bg) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(stateText, style: TextStyle(fontSize: 7, color: stateColor, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(amount, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class MockTrendPainter extends CustomPainter {
  final bool isDark;
  MockTrendPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.teal.withValues(alpha: 0.3), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..cubicTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.4, size.width * 0.75, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.2);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokeDot = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Offset dotPos = Offset(size.width * 0.75, size.height * 0.5);
    canvas.drawCircle(dotPos, 4, strokeDot);
    canvas.drawCircle(dotPos, 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
