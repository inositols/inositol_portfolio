import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/launcher.dart';
import '../../data/models/portfolio_models.dart';

class ProjectDetailsModal extends StatefulWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  State<ProjectDetailsModal> createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<ProjectDetailsModal> {
  int _currentScreenIndex = 0;
  final int _totalScreens = 3;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12.0 : 40.0,
        vertical: isMobile ? 12.0 : 24.0,
      ),
      child: GlassContainer(
        blur: 24.0,
        width: isMobile ? double.infinity : 1100.0,
        height: size.height * 0.9,
        borderRadius: BorderRadius.circular(24),
        borderColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
        color: isDark ? const Color(0xFB09090B) : const Color(0xFBFAFAFB),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation & Title Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.project.category.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.project.role,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: isDark ? Colors.white10 : Colors.black12,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, color: Colors.white10),

            // Main Body Content
            Expanded(
              child: isMobile
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCarouselBlock(isDark, true),
                          const SizedBox(height: 24),
                          _buildProjectMetaCard(isDark),
                          const SizedBox(height: 24),
                          _buildStorytellingBlocks(isDark),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Pane: Mockup & Quick Actions
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                _buildCarouselBlock(isDark, false),
                                const SizedBox(height: 24),
                                _buildProjectMetaCard(isDark),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Right Pane: Case Study Content
                        Expanded(
                          flex: 6,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeroHeader(),
                                const SizedBox(height: 24),
                                _buildStorytellingBlocks(isDark),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.98, 0.98));
  }

  // The custom responsive mockup carousel
  Widget _buildCarouselBlock(bool isDark, bool isMobileLayout) {
    final double mockupHeight = isMobileLayout ? 380 : 440;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Arrow
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () {
                setState(() {
                  _currentScreenIndex = (_currentScreenIndex - 1 + _totalScreens) % _totalScreens;
                });
              },
            ),
            const SizedBox(width: 8),

            // Phone Container
            Container(
              width: mockupHeight * 0.58,
              height: mockupHeight,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.black26,
                  width: 6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Simulated screen content
                  Positioned.fill(
                    child: _buildSimulatedScreen(widget.project.id, _currentScreenIndex, isDark),
                  ),

                  // Phone Status Bar notch overlay
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: mockupHeight * 0.24,
                        height: 16,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F0F13) : const Color(0xFFE5E7EB),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Simulated Home Bar Indicator
                  Positioned(
                    bottom: 6,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: mockupHeight * 0.22,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white38 : Colors.black38,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right Arrow
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onPressed: () {
                setState(() {
                  _currentScreenIndex = (_currentScreenIndex + 1) % _totalScreens;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_totalScreens, (index) {
            final bool isSelected = index == _currentScreenIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : Colors.grey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          _getScreenTitle(widget.project.id, _currentScreenIndex),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white38 : Colors.black38,
          ),
        ),
      ],
    );
  }

  // Interactive simulated screen widget
  Widget _buildSimulatedScreen(String id, int pageIndex, bool isDark) {
    final Color screenBg = isDark ? const Color(0xFF070709) : Colors.white;
    final Color elementBg = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05);
    final Color textCol = isDark ? Colors.white : Colors.black87;

    switch (id) {
      case 'jcommunity':
        if (pageIndex == 0) {
          // Dashboard Screen
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu_rounded, size: 16),
                    Text('J.Community Sync', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textCol)),
                    const Icon(Icons.cloud_done_rounded, size: 14, color: AppColors.success),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in Campaign', style: TextStyle(fontSize: 8, color: Colors.white70)),
                      SizedBox(height: 2),
                      Text('Google Developer Fest', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sync Queue:', style: TextStyle(fontSize: 7.5, color: Colors.white70)),
                          Text('0 Pending', style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w900, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text('Real-time Stats', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 6),
                _buildMockStatRow('Total Attendees', '8,421', 'Goal: 10k', isDark),
                _buildMockStatRow('Offline Scans', '2,140', 'Synced: 100%', isDark),
                _buildMockStatRow('Volunteers Logged', '45 Active', 'Target: 50', isDark),
              ],
            ),
          );
        } else if (pageIndex == 1) {
          // QR Scanner Screen
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_back_rounded, size: 16),
                    const SizedBox(width: 8),
                    Text('Attendance Scanner', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                  ],
                ),
                const SizedBox(height: 36),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accent, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner_rounded, size: 70, color: textCol.withValues(alpha: 0.3)),
                        Container(
                          width: 120,
                          height: 2,
                          color: Colors.redAccent,
                        ).animate(onPlay: (c) => c.repeat(reverse: true))
                         .slideY(begin: -30, end: 30, duration: 1500.ms),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Align barcode / QR within frame', style: TextStyle(fontSize: 8, color: textCol.withValues(alpha: 0.6))),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: elementBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.wifi_off_rounded, color: AppColors.warning, size: 14),
                      SizedBox(width: 6),
                      Text('Running offline check-in mode', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Verification Ticket Screen
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Icon(Icons.stars_rounded, color: AppColors.accent, size: 28),
                const SizedBox(height: 8),
                const Text('CHECK-IN VERIFIED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.accent)),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: elementBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ATTENDEE DETAIL', style: TextStyle(fontSize: 7, color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Okwuchukwu Okama', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textCol)),
                      const SizedBox(height: 8),
                      const Text('TICKET TYPE', style: TextStyle(fontSize: 7, color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('VIP Speaker Pass', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textCol)),
                      const SizedBox(height: 8),
                      const Text('VALIDATION SECURE', style: TextStyle(fontSize: 7, color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(Icons.offline_pin_rounded, color: AppColors.success, size: 14),
                          SizedBox(width: 4),
                          Text('100% Cryptographic Signed Offline', style: TextStyle(fontSize: 8, color: AppColors.success, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 40),
              ],
            ),
          );
        }
      case 'bucapay':
        if (pageIndex == 0) {
          // Dashboard
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BucaPay', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: textCol)),
                    const Icon(Icons.fingerprint_rounded, size: 16, color: AppColors.accent),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Available Balance', style: TextStyle(fontSize: 8, color: Colors.white70)),
                      SizedBox(height: 4),
                      Text('\$84,920.50', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                      SizedBox(height: 10),
                      Text('Connected Bank: Access Bank PLC', style: TextStyle(fontSize: 7.5, color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text('Exchange Tickers', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 6),
                _buildMockTickerRow('Bitcoin', 'BTC', '\$64,250.00', '+2.4%', AppColors.success, isDark),
                _buildMockTickerRow('Ethereum', 'ETH', '\$3,480.12', '-0.8%', AppColors.error, isDark),
                _buildMockTickerRow('Solana', 'SOL', '\$142.30', '+8.1%', AppColors.success, isDark),
              ],
            ),
          );
        } else if (pageIndex == 1) {
          // Off-ramp form
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Instant Off-ramp', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 16),
                _buildMockInputField('Select Crypto Asset', 'BTC (Bitcoin)', isDark),
                const SizedBox(height: 10),
                _buildMockInputField('Amount to Liquidate', '0.5 BTC (\$32,125.00)', isDark),
                const SizedBox(height: 10),
                _buildMockInputField('Payout Bank Account', 'Access Bank - 0984******', isDark),
                const SizedBox(height: 24),
                Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline, size: 12, color: Colors.white),
                      SizedBox(width: 6),
                      Text('Verify Biometrics & Transfer', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Transaction History
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payout History', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 16),
                _buildMockHistoryItem('Sold 0.12 BTC', 'Access Bank Payout', '+\$7,710.00', 'Success', AppColors.success, isDark),
                _buildMockHistoryItem('Sold 0.45 BTC', 'Access Bank Payout', '+\$28,912.50', 'Success', AppColors.success, isDark),
                _buildMockHistoryItem('Sold 1.25 ETH', 'Standard Bank Payout', '+\$4,350.15', 'Success', AppColors.success, isDark),
                _buildMockHistoryItem('Sold 0.05 BTC', 'Pending Verification', '+\$3,212.50', 'Processing', Colors.orange, isDark),
              ],
            ),
          );
        }
      case 'monami':
        if (pageIndex == 0) {
          // Catalog Grid
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.search, size: 14),
                    Text('Monami Shop', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                    const Icon(Icons.shopping_cart_outlined, size: 14),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Featured Catalog', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildMockProductCard('Leather Jacket', '\$189.00', Icons.checkroom, isDark),
                      _buildMockProductCard('Premium Watch', '\$249.00', Icons.watch, isDark),
                      _buildMockProductCard('Audio Pods', '\$129.00', Icons.headphones, isDark),
                      _buildMockProductCard('Travel Pack', '\$99.00', Icons.backpack, isDark),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (pageIndex == 1) {
          // Shopping Cart
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Cart (2 items)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 16),
                _buildMockCartItem('Leather Jacket', '1x', '\$189.00', isDark),
                _buildMockCartItem('Audio Pods', '1x', '\$129.00', isDark),
                const Spacer(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal:', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                    Text('\$318.00', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: textCol)),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Checkout with Stripe', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          // Stripe checkout page
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 14),
                    const SizedBox(width: 8),
                    Text('Stripe Payment Gateway', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: textCol)),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Pay with Card', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildMockInputField('Card Number', '4242 4242 4242 4242', isDark),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildMockInputField('Expiry', '12 / 29', isDark)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildMockInputField('CVC', '123', isDark)),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  height: 32,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user_rounded, size: 12, color: Colors.white),
                      SizedBox(width: 6),
                      Text('Confirm Payment (\$318.00)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      case 'healthlog':
        if (pageIndex == 0) {
          // Vitals Logger page
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.medical_services_outlined, size: 14),
                    Text('Local Vital Logger', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                    const Icon(Icons.vpn_key_rounded, size: 14, color: AppColors.success),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Log Vitals (Offline Encrypted)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 12),
                _buildMockLoggerInput('Blood Pressure', '120/80 mmHg', Icons.heart_broken_rounded, Colors.redAccent, isDark),
                const SizedBox(height: 8),
                _buildMockLoggerInput('Blood Sugar', '95 mg/dL', Icons.bubble_chart_rounded, Colors.teal, isDark),
                const SizedBox(height: 8),
                _buildMockLoggerInput('BMI Calculator', '23.1', Icons.monitor_weight_outlined, Colors.blueAccent, isDark),
                const Spacer(),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Encrypt & Save Data', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          );
        } else if (pageIndex == 1) {
          // Graph page
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vitals History Chart', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: elementBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Systolic Average', style: TextStyle(fontSize: 7, color: Colors.grey)),
                      Text('118 mmHg (Optimal)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.success)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: elementBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomPaint(
                      painter: MockTrendPainterInsidePhone(isDark: isDark),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Local AI Insights page
          return Container(
            color: screenBg,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('On-device Health Advisor', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textCol)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.psychology_rounded, size: 14, color: Colors.teal),
                          SizedBox(width: 6),
                          Text('Privacy-Safe Insights', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.teal)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your blood pressure measurements have remained optimal over the past 2 weeks. Analysis indicates continuous cardiorespiratory stability. Recommendation: maintain current light cardio schedule.',
                        style: TextStyle(fontSize: 8, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, size: 14, color: Colors.orange),
                          SizedBox(width: 6),
                          Text('Hydration Note', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.orange)),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Your vital logging trends correlate optimal readings with morning periods. Ensure drinking at least 500ml water within 30 minutes of waking.',
                        style: TextStyle(fontSize: 8, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      default:
        return const Center(child: Icon(Icons.phone_android_rounded));
    }
  }

  // Helper title strings for slides
  String _getScreenTitle(String id, int pageIndex) {
    switch (id) {
      case 'jcommunity':
        if (pageIndex == 0) return 'Admin Sync Dashboard';
        if (pageIndex == 1) return 'Offline QR Scanner Screen';
        return 'Attendee Ticket Verification';
      case 'bucapay':
        if (pageIndex == 0) return 'Multicurrency Wallet Feed';
        if (pageIndex == 1) return 'Fiat Off-ramp Checkout';
        return 'Payout Audit Ledger';
      case 'monami':
        if (pageIndex == 0) return 'Responsive Products Feed';
        if (pageIndex == 1) return 'Local Shopping Cart Drawer';
        return 'Stripe Payments Gateway';
      case 'healthlog':
        if (pageIndex == 0) return 'Local Vitals Data Logger';
        if (pageIndex == 1) return 'High-density Charts Monitor';
        return 'On-device Privacy AI Insights';
      default:
        return 'App Screen Mockup';
    }
  }

  Widget _buildMockStatRow(String label, String value, String sub, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(fontSize: 6, color: Colors.grey)),
            ],
          ),
          Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.accent)),
        ],
      ),
    );
  }

  Widget _buildMockTickerRow(String name, String code, String rate, String pct, Color pctColor, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              Text(code, style: const TextStyle(fontSize: 6.5, color: Colors.grey)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(rate, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              Text(pct, style: TextStyle(fontSize: 6.5, color: pctColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMockInputField(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 7, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          height: 22,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white12),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 6),
          child: Text(value, style: const TextStyle(fontSize: 8.5)),
        ),
      ],
    );
  }

  Widget _buildMockHistoryItem(String title, String subtitle, String amount, String state, Color stateColor, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 6, color: Colors.grey)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              Text(state, style: TextStyle(fontSize: 6.5, color: stateColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMockProductCard(String name, String price, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 24, color: AppColors.accent),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(fontSize: 7, color: AppColors.accent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMockCartItem(String name, String qty, String price, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              Text('Qty: $qty', style: const TextStyle(fontSize: 6.5, color: Colors.grey)),
            ],
          ),
          Text(price, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMockLoggerInput(String label, String value, IconData icon, Color iconColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 7, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // Project metadata sidebar card containing core links
  Widget _buildProjectMetaCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform badges
          const Text('PLATFORM METADATA', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.devices_other_rounded, size: 16, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Cross-platform Target: ${widget.project.category}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Tech stack
          const Text('TECHNOLOGY CORE', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.project.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Action Link Buttons
          const Text('LIVE ASSETS', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          const SizedBox(height: 12),
          Column(
            children: [
              if (widget.project.liveDemoUrl != null)
                _buildAssetButton('Live Web Demo', Icons.open_in_new_rounded, AppColors.accent, () {
                  Launcher.launchURL(widget.project.liveDemoUrl!);
                }, isDark),
              if (widget.project.githubUrl != null)
                _buildAssetButton('GitHub Repository', Icons.code_rounded, AppColors.primary, () {
                  Launcher.launchURL(widget.project.githubUrl!);
                }, isDark),
              if (widget.project.playStoreUrl != null)
                _buildAssetButton('Google Play Store', Icons.play_arrow_rounded, AppColors.success, () {
                  Launcher.launchURL(widget.project.playStoreUrl!);
                }, isDark),
              if (widget.project.appStoreUrl != null)
                _buildAssetButton('Apple App Store', Icons.apple_rounded, Colors.grey, () {
                  Launcher.launchURL(widget.project.appStoreUrl!);
                }, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetButton(String text, IconData icon, Color color, VoidCallback onTap, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // The premium Header image/gradient
  Widget _buildHeroHeader() {
    Color startColor;
    Color endColor;

    switch (widget.project.id) {
      case 'jcommunity':
        startColor = AppColors.primary;
        endColor = AppColors.accent;
        break;
      case 'bucapay':
        startColor = AppColors.accent;
        endColor = Colors.teal;
        break;
      case 'monami':
        startColor = Colors.deepPurple;
        endColor = Colors.pinkAccent;
        break;
      case 'healthlog':
        startColor = Colors.teal;
        endColor = Colors.green;
        break;
      default:
        startColor = AppColors.primary;
        endColor = AppColors.accent;
    }

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ENGINEERING CASE STUDY',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.project.subtitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Storytelling block renderer containing all standard sections
  Widget _buildStorytellingBlocks(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionBlock('OVERVIEW', widget.project.description, isDark),
        _buildSectionBlock('THE PROBLEM', widget.project.problemStatement, isDark),
        _buildSectionBlock('MY ROLE', widget.project.roleDescription, isDark),
        _buildSectionBlock('ARCHITECTURE', widget.project.architectureDescription, isDark),
        _buildSectionBlock('TECHNICAL CHALLENGES', widget.project.challengesDescription, isDark),
        _buildSectionBlock('SOLUTION', widget.project.solutionDescription, isDark),
        _buildSectionBlock('RESULT', widget.project.resultDescription, isDark),
        _buildSectionBlock('LESSONS LEARNED', widget.project.lessonsLearned, isDark),
      ],
    );
  }

  Widget _buildSectionBlock(String title, String content, bool isDark) {
    if (content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white.withValues(alpha: 0.8) : Colors.black.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw trendline chart within the phone screen mockup
class MockTrendPainterInsidePhone extends CustomPainter {
  final bool isDark;
  MockTrendPainterInsidePhone({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint1 = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final linePaint2 = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint1 = Paint()
      ..shader = LinearGradient(
        colors: [Colors.redAccent.withValues(alpha: 0.15), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path1 = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.25, size.height * 0.35)
      ..lineTo(size.width * 0.5, size.height * 0.45)
      ..lineTo(size.width * 0.75, size.height * 0.3)
      ..lineTo(size.width, size.height * 0.38);

    final path2 = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width * 0.25, size.height * 0.75)
      ..lineTo(size.width * 0.5, size.height * 0.68)
      ..lineTo(size.width * 0.75, size.height * 0.72)
      ..lineTo(size.width, size.height * 0.65);

    final fillPath1 = Path.from(path1)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath1, fillPaint1);
    canvas.drawPath(path1, linePaint1);
    canvas.drawPath(path2, linePaint2);

    // Draw dots
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokeDot = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.3), 3, strokeDot);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.3), 1.8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
