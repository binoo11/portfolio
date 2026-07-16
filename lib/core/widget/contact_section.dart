import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Contact section: social/contact info on one side, a validated message
/// form on the other. The form composes a mailto: link on submit rather than
/// hitting a backend, since this is a static portfolio site.
class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.sectionKey,
    required this.social,
    super.key,
  });

  final GlobalKey sectionKey;
  final SocialLinks social;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: "Let's Talk", title: 'Get In Touch'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool isWide = constraints.maxWidth >= 768;
              final Widget info = _ContactInfo(social: social);
              final Widget form = const _ContactForm();

              if (!isWide) {
                return Column(children: <Widget>[info, const SizedBox(height: 24), form]);
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 4, child: info),
                  const SizedBox(width: 24),
                  Expanded(flex: 6, child: form),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({required this.social});

  final SocialLinks social;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Have a project in mind, or just want to say hi? My inbox is always open.',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _row(context, icon: Icons.email_outlined, label: social.email,
              onTap: () => _launch('mailto:${social.email}')),
          const SizedBox(height: 16),
          _row(context, icon: Icons.phone_outlined, label: social.phone,
              onTap: () => _launch('tel:${social.phone}')),
          const SizedBox(height: 16),
          _row(context, icon: Icons.location_on_outlined, label: social.location),
          if (social.linkedin != null || social.github != null || social.whatsapp != null) ...<Widget>[
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                if (social.linkedin != null)
                  _socialIcon(context, Icons.business_center_outlined, social.linkedin!),
                if (social.github != null)
                  _socialIcon(context, Icons.code_rounded, social.github!),
                if (social.whatsapp != null)
                  _socialIcon(context, Icons.chat_bubble_outline_rounded,
                      'https://wa.me/${social.whatsapp}'),
              ],
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 450.ms).slideX(begin: -0.08, end: 0);
  }

  Widget _row(BuildContext context,
      {required IconData icon, required String label, VoidCallback? onTap}) {
    final Widget content = Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
      ],
    );
    if (onTap == null) return content;
    return InkWell(onTap: onTap, child: content);
  }

  Widget _socialIcon(BuildContext context, IconData icon, String url) {
    return InkWell(
      onTap: () => _launch(url),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colors.outline),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  static final RegExp _emailPattern = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');

  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _field(context, controller: _nameController, label: 'Name',
                validator: (String? v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your name' : null),
            const SizedBox(height: 16),
            _field(context, controller: _emailController, label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (String? v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter your email';
                  if (!_emailPattern.hasMatch(v.trim())) return 'Enter a valid email';
                  return null;
                }),
            const SizedBox(height: 16),
            _field(context, controller: _messageController, label: 'Message', maxLines: 5,
                validator: (String? v) => (v == null || v.trim().length < 10)
                    ? 'Message should be at least 10 characters'
                    : null),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitting ? null : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _submitting
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : const Text('Send Message'),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 450.ms).slideX(begin: 0.08, end: 0);
  }

  Widget _field(BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: context.colors.surfaceContainerHighest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);

    final String subject = Uri.encodeComponent('Portfolio contact from ${_nameController.text.trim()}');
    final String body = Uri.encodeComponent(
      '${_messageController.text.trim()}\n\nFrom: ${_nameController.text.trim()} (${_emailController.text.trim()})',
    );
    final Uri mailto = Uri.parse('mailto:?subject=$subject&body=$body');

    try {
      if (await canLaunchUrl(mailto)) {
        await launchUrl(mailto);
        _formKey.currentState?.reset();
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}