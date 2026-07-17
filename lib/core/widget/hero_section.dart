import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import '../config/app_cofig.dart';
import '../constant/app_strings.dart';
import '../constant/asset_paths.dart';
import 'gradient_button.dart';

/// Full-height hero: animated aurora background, name, headline, summary,
/// CTA buttons (contact / view projects / download resume) and social links,
/// plus a glassy profile avatar. Layout switches to stacked on mobile.
class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.sectionKey,
    required this.profile,
    required this.onContact,
    required this.onViewProjects,
    super.key,
  });

  final GlobalKey sectionKey;
  final Profile profile;
  final VoidCallback onContact;
  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.height),
      padding: EdgeInsets.fromLTRB(
        context.pagePadding, 140,context.pagePadding,40
        // horizontal: context.pagePadding,
        // vertical: 140,
      ),
      child: Stack(
        children: <Widget>[
          const Positioned.fill(child: _AuroraBackground()),
          Center(
            child: ConstrainedBox(
              constraints:
              const BoxConstraints(maxWidth: AppConfig.maxContentWidth),
              child: context.isMobile
                  ? _buildStacked(context)
                  : _buildRow(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 3, child: _buildText(context)),
        const SizedBox(width: 48),
        Expanded(flex: 2, child: _ProfileAvatar(profile: profile)),
      ],
    );
  }

  Widget _buildStacked(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _ProfileAvatar(profile: profile),
        const SizedBox(height: 40),
        _buildText(context),
      ],
    );
  }
  Widget _buildText(BuildContext context) {
    final CrossAxisAlignment align = context.isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final TextAlign textAlign =
    context.isMobile ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _AvailabilityBadge(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'Hi, I’m',
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (Rect b) => AppColors.auroraGradient.createShader(b),
          child: Text(
            profile.name,
            textAlign: textAlign,
            style: (context.isMobile
                ? context.textTheme.displayMedium
                : context.textTheme.displayLarge)
                ?.copyWith(color: Colors.white),
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.15),
        const SizedBox(height: 16),
        Text(
          profile.headline,
          textAlign: textAlign,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.9),
          ),
        ).animate().fadeIn(delay: 250.ms, duration: 500.ms),
        const SizedBox(height: 20),
        _HeroTagline(tagline: profile.tagline, textAlign: textAlign),
        const SizedBox(height: 28),
        _QuickStats(profile: profile, center: context.isMobile)
            .animate()
            .fadeIn(delay: 450.ms, duration: 500.ms)
            .slideY(begin: 0.15, curve: Curves.easeOutCubic),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment:
          context.isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: <Widget>[
            GradientButton(
              label: AppStrings.contactMe,
              icon: Icons.mail_outline_rounded,
              onPressed: onContact,
            ),
            GradientButton(
              label: AppStrings.viewProjects,
              icon: Icons.folder_open_rounded,
              filled: false,
              onPressed: onViewProjects,
            ),
            GradientButton(
              label: AppStrings.downloadResume,
              icon: Icons.download_rounded,
              filled: false,
              onPressed: () => UrlHelper.openAsset(AppConfig.resumeAssetPath),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms, duration: 500.ms).slideY(begin: 0.2),
        const SizedBox(height: 28),
        _SocialRow(social: profile.social, center: context.isMobile)
            .animate()
            .fadeIn(delay: 750.ms, duration: 500.ms),
      ],
    );
  }
  // Widget _buildText(BuildContext context) {
  //   final CrossAxisAlignment align = context.isMobile
  //       ? CrossAxisAlignment.center
  //       : CrossAxisAlignment.start;
  //   final TextAlign textAlign =
  //   context.isMobile ? TextAlign.center : TextAlign.start;
  //
  //   return Column(
  //     crossAxisAlignment: align,
  //     mainAxisSize: MainAxisSize.min,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(top: 12.0),
  //         child: Text(
  //           'Hi, I’m',
  //           style: context.textTheme.titleMedium?.copyWith(
  //             color: AppColors.primary,
  //           ),
  //         ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
  //       ),
  //       const SizedBox(height: 8),
  //       ShaderMask(
  //         shaderCallback: (Rect b) => AppColors.auroraGradient.createShader(b),
  //         child: Text(
  //           profile.name,
  //           textAlign: textAlign,
  //           style: (context.isMobile
  //               ? context.textTheme.displayMedium
  //               : context.textTheme.displayLarge)
  //               ?.copyWith(color: Colors.white),
  //         ),
  //       ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.15),
  //       const SizedBox(height: 16),
  //       Text(
  //         profile.headline,
  //         textAlign: textAlign,
  //         style: context.textTheme.headlineSmall?.copyWith(
  //           color: context.colors.onSurface.withValues(alpha: 0.9),
  //         ),
  //       ).animate().fadeIn(delay: 250.ms, duration: 500.ms),
  //       const SizedBox(height: 20),
  //       // ConstrainedBox(
  //       //   constraints: const BoxConstraints(maxWidth: 620),
  //       //   child: Text(
  //       //     profile.summary,
  //       //     textAlign: textAlign,
  //       //     maxLines: 10,
  //       //     overflow: TextOverflow.ellipsis,
  //       //     style: context.textTheme.bodyLarge?.copyWith(
  //       //       height: 1.55,
  //       //       letterSpacing: 0.1,
  //       //       color: context.colors.onSurface.withValues(alpha: 0.85),
  //       //     ),
  //       //   ),
  //       // ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
  //       _HeroTagline(tagline: profile.tagline),
  //       const SizedBox(height: 32),
  //       Wrap(
  //         spacing: 16,
  //         runSpacing: 16,
  //         alignment:
  //         context.isMobile ? WrapAlignment.center : WrapAlignment.start,
  //         children: <Widget>[
  //           GradientButton(
  //             label: AppStrings.contactMe,
  //             icon: Icons.mail_outline_rounded,
  //             onPressed: onContact,
  //           ),
  //           GradientButton(
  //             label: AppStrings.viewProjects,
  //             icon: Icons.folder_open_rounded,
  //             filled: false,
  //             onPressed: onViewProjects,
  //           ),
  //           GradientButton(
  //             label: AppStrings.downloadResume,
  //             icon: Icons.download_rounded,
  //             filled: false,
  //             onPressed: () => UrlHelper.open(AppConfig.resumeAssetPath),
  //           ),
  //         ],
  //       ).animate().fadeIn(delay: 550.ms, duration: 500.ms).slideY(begin: 0.2),
  //       const SizedBox(height: 28),
  //       _SocialRow(social: profile.social, center: context.isMobile)
  //           .animate()
  //           .fadeIn(delay: 700.ms, duration: 500.ms),
  //     ],
  //   );
  // }
}
class _HeroTagline extends StatelessWidget {
  const _HeroTagline({required this.tagline, required this.textAlign});

  final String tagline;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = context.isMobile ? double.infinity : 580;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        tagline,
        textAlign: textAlign,
        style: context.textTheme.bodyLarge?.copyWith(
          height: 1.6,
          letterSpacing: 0.1,
          fontSize: context.isMobile ? 16 : 17.5,
          color: context.colors.onSurface.withValues(alpha: 0.78),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 300.ms, duration: 600.ms)
        .slideY(begin: 0.15, curve: Curves.easeOutCubic);
  }
}
class _QuickStats extends StatelessWidget {
  const _QuickStats({required this.profile, this.center = false});

  final Profile profile;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 16,
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      children: <Widget>[
        _statItem(context, '${profile.yearsExperience}+', 'Years shipping'),
        _statItem(context, '7', 'Industry domains'),
        _statItem(context, '20+', 'Apps in production'),
      ],
    );
  }

  Widget _statItem(BuildContext context, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect b) => AppColors.auroraGradient.createShader(b),
          child: Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
class _AvailabilityBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primary.withValues(alpha: 0.16),
            AppColors.secondary.withValues(alpha: 0.10),
          ],
        ),
        border: Border.all(
          color: Colors.greenAccent.withValues(alpha: 0.35),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.greenAccent.withValues(alpha: 0.12),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _PulsingDot(),
          const SizedBox(width: 10),
          Text(
            'Open to new opportunities',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurface.withValues(alpha: 0.92),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.4, curve: Curves.easeOutCubic)
        .then()
        .shimmer(duration: 1800.ms, color: Colors.white.withValues(alpha: 0.15));
  }
}

/// Layered pulsing dot: a solid core + an expanding, fading ring behind it
/// — reads as a proper "live" indicator instead of a static circle.
class _PulsingDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.greenAccent.withValues(alpha: 0.35),
            ),
          )
              .animate(onPlay: (AnimationController c) => c.repeat())
              .scaleXY(
            begin: 0.6,
            end: 1.8,
            duration: 1600.ms,
            curve: Curves.easeOut,
          )
              .fadeOut(duration: 1600.ms, curve: Curves.easeOut),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.greenAccent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.greenAccent.withValues(alpha: 0.6),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}/// Soft animated gradient blobs behind the hero. Uses flutter_animate to
/// gently drift/scale, giving a premium "living" background without video.
class _AuroraBackground extends StatelessWidget {
  const _AuroraBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -80,
          left: -60,
          child: _blob(AppColors.primary.withValues(alpha: 0.35), 320)
              .animate(onPlay: (AnimationController c) => c.repeat(reverse: true))
              .moveY(begin: 0, end: 40, duration: 6.seconds, curve: Curves.easeInOut)
              .scaleXY(begin: 1, end: 1.1, duration: 6.seconds),
        ),
        Positioned(
          bottom: -100,
          right: -40,
          child: _blob(AppColors.secondary.withValues(alpha: 0.30), 380)
              .animate(onPlay: (AnimationController c) => c.repeat(reverse: true))
              .moveY(begin: 0, end: -50, duration: 7.seconds, curve: Curves.easeInOut)
              .scaleXY(begin: 1.05, end: 0.95, duration: 7.seconds),
        ),
        Positioned(
          top: 120,
          right: 160,
          child: _blob(AppColors.accent.withValues(alpha: 0.22), 240)
              .animate(onPlay: (AnimationController c) => c.repeat(reverse: true))
              .moveX(begin: 0, end: 30, duration: 8.seconds, curve: Curves.easeInOut),
        ),
      ],
    );
  }

  Widget _blob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final double size = context.isMobile ? 220 : 340;
    return Semantics(
      image: true,
      label: AppStrings.semanticProfileImage,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.auroraGradient,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 60,
              spreadRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: ClipOval(
          child: Container(
            color: context.colors.surface,
            alignment: Alignment.center,
            // TODO: replace with a real profile photo at AssetPaths.profile.
            // Using initials keeps the UI premium until the image is added.
            child:Image.asset(
             context.isMobile? AssetPaths.profile:AssetPaths.ovalProfile,
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
            // Text(
            //   'BD',
            //   style: context.textTheme.displayMedium?.copyWith(
            //     foreground: Paint()
            //       ..shader = AppColors.auroraGradient.createShader(
            //         Rect.fromLTWH(0, 0, size, size),
            //       ),
            //   ),
            // ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .scaleXY(begin: 0.85, end: 1, curve: Curves.easeOutBack);
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow({required this.social, this.center = false});

  final SocialLinks social;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final List<Widget> icons = <Widget>[
      if (social.github != null)
        _SocialIcon(
          icon: Icons.code_rounded,
          tooltip: 'GitHub',
          onTap: () => UrlHelper.open(social.github!),
        ),
      if (social.linkedin != null)
        _SocialIcon(
          icon: Icons.business_center_rounded,
          tooltip: 'LinkedIn',
          onTap: () => UrlHelper.open(social.linkedin!),
        ),
      _SocialIcon(
        icon: Icons.mail_outline_rounded,
        tooltip: social.email,
        onTap: () => UrlHelper.email(social.email),
      ),
      if (social.whatsapp != null)
        _SocialIcon(
          icon: Icons.chat_bubble_outline_rounded,
          tooltip: 'WhatsApp',
          onTap: () => UrlHelper.open(social.whatsapp!),
        ),
    ];

    return Row(
      mainAxisAlignment:
      center ? MainAxisAlignment.center : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: icons,
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: Tooltip(
          message: widget.tooltip,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hovering
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : context.colors.surfaceContainerHighest,
                border: Border.all(
                  color: _hovering
                      ? AppColors.primary
                      : context.colors.outline,
                ),
              ),
              child: Icon(
                widget.icon,
                size: 20,
                color:
                _hovering ? AppColors.primary : context.colors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}