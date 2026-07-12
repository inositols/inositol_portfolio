import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../../../core/utils/launcher.dart';
import '../../data/models/portfolio_models.dart';

class OpenSourceSection extends StatelessWidget {
  final List<GitHubRepo> githubRepos;

  const OpenSourceSection({super.key, required this.githubRepos});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Text(
              "Open Source & Community",
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
            "I contribute actively to the Flutter ecosystem, maintaining open-source libraries and identifying/solving bugs.",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),

          // Featured Package Highlight Card
          _buildFeaturedPackageCard(context, isDark, isMobile),

          const SizedBox(height: 48),

          // GitHub Heatmap
          _buildGitHubHeatmapCard(isDark, isMobile),

          const SizedBox(height: 48),

          // GitHub Profile Stats & Commits
          _buildGitHubStatsAndCommits(isDark, isMobile),

          const SizedBox(height: 56),

          // GitHub Repos Grid Title
          Text(
            "Recent Repositories & Utilities",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 24),

          // Grid list of GitHub Repos
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 170,
            ),
            itemCount: githubRepos.take(6).length,
            itemBuilder: (context, index) {
              final repo = githubRepos[index];
              return SpotlightCard(
                borderRadius: 12,
                onTap: () => Launcher.launchURL(repo.htmlUrl),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.folder_open_rounded,
                                color: AppColors.accent,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  repo.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            repo.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(repo.language, style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_outline_rounded, size: 14, color: isDark ? Colors.white60 : Colors.black54),
                              const SizedBox(width: 4),
                              Text('${repo.stars}', style: const TextStyle(fontSize: 11)),
                              const SizedBox(width: 12),
                              Icon(Icons.terminal_outlined, size: 13, color: isDark ? Colors.white60 : Colors.black54),
                              const SizedBox(width: 4),
                              Text('${repo.forks}', style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedPackageCard(BuildContext context, bool isDark, bool isMobile) {
    const String installCommand = 'flutter pub add certificate_canvas';

    final packageDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2)),
          ),
          child: const Text(
            'FEATURED FLUTTER PACKAGE',
            style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'certificate_canvas',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          'A performance-optimized Dart & Flutter package to generate and draw high-fidelity digital certificates using HTML Canvas and Flutter CustomPainter. Designed specifically for automated cert rendering with zero layout breakages.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 20),

        // Install Command Container
        GlassContainer(
          blur: 4.0,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          borderRadius: BorderRadius.circular(8),
          color: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.1),
          borderColor: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$ $installCommand',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: installCommand));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Command copied to clipboard!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.success,
                        width: 250,
                      ),
                    );
                  },
                  child: Icon(Icons.copy_rounded, size: 16, color: isDark ? Colors.white60 : Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // Score layout (likes, pub points, popularity)
    final packageScores = Row(
      mainAxisAlignment: isMobile ? MainAxisAlignment.spaceAround : MainAxisAlignment.end,
      children: [
        _buildScoreMetric('130', 'Likes', isDark),
        const SizedBox(width: 24),
        _buildScoreMetric('140/140', 'Pub Points', isDark),
        const SizedBox(width: 24),
        _buildScoreMetric('99%', 'Popularity', isDark),
      ],
    );

    return SpotlightCard(
      borderRadius: 16,
      glowColor: Colors.blueAccent.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  packageDetails,
                  const SizedBox(height: 32),
                  packageScores,
                ],
              )
            : Row(
                children: [
                  Expanded(flex: 6, child: packageDetails),
                  const SizedBox(width: 32),
                  Expanded(flex: 4, child: packageScores),
                ],
              ),
      ),
    );
  }

  Widget _buildScoreMetric(String val, String label, bool isDark) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.primary),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white54 : Colors.black54),
        ),
      ],
    );
  }

  Widget _buildGitHubHeatmapCard(bool isDark, bool isMobile) {
    final months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    final Random rand = Random(42); // Seeded random for consistent look

    return GlassContainer(
      blur: 8.0,
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.bar_chart_rounded, color: AppColors.success, size: 20),
                  SizedBox(width: 8),
                  Text('GitHub Contributions Heatmap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                '1,842 contributions in the last year',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.white60 : Colors.black.withValues(alpha: 0.6)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // The contribution squares grid wrapper (scrollable horizontally on Mobile)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month Labels Row
                Row(
                  children: [
                    const SizedBox(width: 30), // Offset for day labels
                    ...List.generate(months.length, (mIdx) {
                      return SizedBox(
                        width: isMobile ? 32 : 46,
                        child: Text(
                          months[mIdx],
                          style: const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 6),

                // Heatmap Grid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day Labels
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mon', style: TextStyle(fontSize: 9, color: Colors.grey)),
                        SizedBox(height: 10),
                        Text('Wed', style: TextStyle(fontSize: 9, color: Colors.grey)),
                        SizedBox(height: 10),
                        Text('Fri', style: TextStyle(fontSize: 9, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(width: 8),

                    // Grid Columns (Weeks)
                    Row(
                      children: List.generate(isMobile ? 30 : 52, (weekIndex) {
                        return Column(
                          children: List.generate(7, (dayIndex) {
                            // Determine green contribution intensity
                            final int val = rand.nextInt(10);
                            Color sqColor = isDark 
                                ? Colors.white.withValues(alpha: 0.04) 
                                : Colors.black.withValues(alpha: 0.04);
                                
                            if (val > 8) {
                              sqColor = const Color(0xFF216E39); // Very Dark Green
                            } else if (val > 6) {
                              sqColor = const Color(0xFF30A14E); // Medium Green
                            } else if (val > 4) {
                              sqColor = const Color(0xFF40C463); // Light Green
                            } else if (val > 2) {
                              sqColor = const Color(0xFF9BE9A8); // Very Light Green
                            }

                            return Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                color: sqColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGitHubStatsAndCommits(bool isDark, bool isMobile) {
    final languageLegend = [
      {'name': 'Dart', 'percentage': 85.0, 'color': AppColors.primary},
      {'name': 'YAML', 'percentage': 10.0, 'color': Colors.purple},
      {'name': 'HTML/CSS', 'percentage': 5.0, 'color': AppColors.accent},
    ];

    final commits = [
      {
        'title': 'feat(core): implement secure biometrics payload checks',
        'repo': 'crypto_offramp_sdk',
        'time': '2 hours ago',
      },
      {
        'title': 'fix(canvas): resolve canvas scale issues in safari webkit',
        'repo': 'certificate_canvas',
        'time': '1 day ago',
      },
      {
        'title': 'docs(readme): add custom action setup diagrams',
        'repo': 'shorebird_code_push_workflow',
        'time': '3 days ago',
      },
    ];

    final statsCard = GlassContainer(
      blur: 8.0,
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@okama-dev',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Senior Flutter Architect',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Numbers Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatsMetric('626', 'Stars', isDark),
              _buildStatsMetric('1.2k', 'Followers', isDark),
              _buildStatsMetric('42', 'Repos', isDark),
            ],
          ),
          const SizedBox(height: 24),

          // Language bar Title
          const Text(
            'Language Distribution',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Language distribution bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              width: double.infinity,
              child: Row(
                children: languageLegend.map((lang) {
                  return Expanded(
                    flex: (lang['percentage'] as double).toInt(),
                    child: Container(
                      color: lang['color'] as Color,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Legend Row
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: languageLegend.map((lang) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: lang['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${lang['name']} (${(lang['percentage'] as double).toInt()}%)',
                    style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );

    final commitsCard = GlassContainer(
      blur: 8.0,
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.history_rounded, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text(
                'Recent Commits & Activity',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...commits.map((commit) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Icon(Icons.commit_rounded, color: AppColors.accent, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commit['title']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              commit['repo']!,
                              style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '• ${commit['time']!}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );

    return isMobile
        ? Column(
            children: [
              statsCard,
              const SizedBox(height: 24),
              commitsCard,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: statsCard),
              const SizedBox(width: 24),
              Expanded(flex: 5, child: commitsCard),
            ],
          );
  }

  Widget _buildStatsMetric(String val, String label, bool isDark) {
    return Column(
      children: [
        Text(
          val,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54),
        ),
      ],
    );
  }
}
