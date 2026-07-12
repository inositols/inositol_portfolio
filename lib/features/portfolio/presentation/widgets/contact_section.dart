import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../../../core/utils/launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_state.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<PortfolioBloc>().submitContactForm(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final socialInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability Pulse Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
              ).animate(onPlay: (c) => c.repeat())
               .scale(begin: const Offset(1, 1), end: const Offset(1.6, 1.6), duration: 1000.ms)
               .fadeOut(duration: 1000.ms),
              const SizedBox(width: 8),
              const Text(
                'OPEN FOR HIRING',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.success, letterSpacing: 0.8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Headline
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            "Let's Build Something Great Together",
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1.0,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Subtitle
        Text(
          "Available for Remote, Contract and Full-time Flutter Opportunities.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 32),

        // Description Paragraph
        Text(
          "Whether you need an architect to decouple a massive system, implement a bulletproof offline sync algorithm, optimize animations to hit 120 FPS, or build a secure off-ramp fintech portal—I deliver production-grade results.",
          style: TextStyle(
            fontSize: 14.5,
            height: 1.6,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 40),

        // 7 CTA Buttons Grid / Wrap
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // 1. Hire Me (gradient primary)
            NeonButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              onPressed: () {
                // Focus direct message name input field
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Write your details in the direct message form!'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hire Me', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.mail_outline_rounded, size: 16, color: Colors.white),
                ],
              ),
            ),

            // 2. Schedule a Call (amber outline)
            _buildCTAOutlineButton(
              label: 'Schedule a Call',
              icon: Icons.calendar_today_rounded,
              color: Colors.amber,
              onTap: () => Launcher.launchWhatsApp(phone: '+2349164815270', text: 'Hi Okwuchukwu, I would like to schedule a call with you.'),
              isDark: isDark,
            ),

            // 3. Download Resume (emerald outline)
            _buildCTAOutlineButton(
              label: 'Download Resume',
              icon: Icons.download_rounded,
              color: Colors.teal,
              onTap: () => Launcher.launchURL("https://github.com/inositols/resume/raw/main/resume.pdf"),
              isDark: isDark,
            ),

            // 4. Email Me
            _buildCTASocialButton(
              label: 'Email Me',
              icon: Icons.alternate_email_rounded,
              color: Colors.redAccent,
              onTap: () => Launcher.launchEmail(email: 'okamainnocent2020@gmail.com', subject: 'Collaboration Inquiry'),
              isDark: isDark,
            ),

            // 5. LinkedIn
            _buildCTASocialButton(
              label: 'LinkedIn',
              icon: Icons.link_rounded,
              color: Colors.blueAccent,
              onTap: () => Launcher.launchURL('https://www.linkedin.com/in/innocentokama/'),
              isDark: isDark,
            ),

            // 6. GitHub
            _buildCTASocialButton(
              label: 'GitHub',
              icon: Icons.code_rounded,
              color: isDark ? Colors.white : Colors.black,
              onTap: () => Launcher.launchURL('https://github.com/inositols'),
              isDark: isDark,
            ),

            // 7. WhatsApp
            _buildCTASocialButton(
              label: 'WhatsApp',
              icon: Icons.chat_bubble_outline_rounded,
              color: Colors.green,
              onTap: () => Launcher.launchWhatsApp(phone: '+2349164815270', text: 'Hi Okwuchukwu, let\'s collaborate!'),
              isDark: isDark,
            ),
          ],
        ),
      ],
    );

    final contactForm = BlocConsumer<PortfolioBloc, PortfolioState>(
      listener: (context, state) {
        if (state is PortfolioLoaded && state.contactStatus == ContactStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Message sent successfully! Thank you.'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.success,
              width: 320,
            ),
          );
          _nameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
          context.read<PortfolioBloc>().resetContactStatus();
        }
      },
      builder: (context, state) {
        bool isSubmitting = false;
        if (state is PortfolioLoaded) {
          isSubmitting = state.contactStatus == ContactStatus.submitting;
        }

        return SpotlightCard(
          borderRadius: 16,
          glowColor: AppColors.primary.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send a Message',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Name Field
                  _buildFormInput(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Your full name',
                    icon: Icons.person_outline_rounded,
                    isDark: isDark,
                    validator: (val) => val == null || val.trim().isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  _buildFormInput(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'your.email@example.com',
                    icon: Icons.email_outlined,
                    isDark: isDark,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) return 'Please enter your email';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Subject Field
                  _buildFormInput(
                    controller: _subjectController,
                    label: 'Subject',
                    hint: 'Job Opportunity, Contract, Project Idea...',
                    icon: Icons.label_outline_rounded,
                    isDark: isDark,
                    validator: (val) => val == null || val.trim().isEmpty ? 'Please enter a subject' : null,
                  ),
                  const SizedBox(height: 20),

                  // Message Field
                  _buildFormInput(
                    controller: _messageController,
                    label: 'Message',
                    hint: 'How can I help you?',
                    icon: Icons.message_outlined,
                    isDark: isDark,
                    maxLines: 5,
                    validator: (val) => val == null || val.trim().isEmpty ? 'Please write your message' : null,
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: NeonButton(
                      onPressed: isSubmitting ? () {} : _submitForm,
                      child: isSubmitting
                          ? const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Send Message',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 80,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                socialInfo,
                const SizedBox(height: 48),
                contactForm,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: socialInfo),
                const SizedBox(width: 64),
                Expanded(flex: 5, child: contactForm),
              ],
            ),
    );
  }

  Widget _buildCTAOutlineButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
            border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          blur: 4.0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          borderRadius: BorderRadius.circular(10),
          color: isDark ? Colors.white.withValues(alpha: 0.01) : Colors.black.withValues(alpha: 0.01),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(icon, size: 16, color: isDark ? Colors.white30 : Colors.black.withValues(alpha: 0.3)),
            ),
          ),
        ),
      ],
    );
  }
}
