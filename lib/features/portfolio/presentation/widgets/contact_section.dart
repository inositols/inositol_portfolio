import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/neon_button.dart';
import '../../../../core/widgets/spotlight_card.dart';
import '../../../../core/utils/launcher.dart';
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
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            "Get In Touch",
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
          "Let's build something remarkable. I am open to full-time remote developer roles, consultant terms, and contract opportunities worldwide.",
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 36),

        // Direct channels
        _buildContactChannel(
          Icons.mail_outline_rounded,
          'Email Me',
          'okama.dev@gmail.com',
          () => Launcher.launchEmail(email: 'okama.dev@gmail.com', subject: 'Inquiry from Portfolio'),
          isDark,
        ),
        _buildContactChannel(
          Icons.chat_bubble_outline_rounded,
          'WhatsApp Chat',
          '+234 812 345 6789',
          () => Launcher.launchWhatsApp(phone: '+2348123456789', text: 'Hi Okwuchukwu, I visited your portfolio...'),
          isDark,
        ),
        _buildContactChannel(
          Icons.link_rounded,
          'LinkedIn Profile',
          'linkedin.com/in/okwuchukwu-okama',
          () => Launcher.launchURL('https://linkedin.com/in/okwuchukwu-okama'),
          isDark,
        ),
        _buildContactChannel(
          Icons.code_rounded,
          'GitHub Profile',
          'github.com/okama-dev',
          () => Launcher.launchURL('https://github.com/okama-dev'),
          isDark,
        ),

        const SizedBox(height: 32),
        // Resume Download Call to Action
        NeonButton(
          onPressed: () => Launcher.launchURL("https://github.com/okama-dev/resume/raw/main/resume.pdf"),
          isSecondary: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download_rounded, size: 16, color: isDark ? Colors.white : Colors.black),
              const SizedBox(width: 8),
              const Text('Download CV / Resume', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
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

  Widget _buildContactChannel(
    IconData icon,
    String label,
    String detail,
    VoidCallback onTap,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
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
