import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/widget/section_title.dart';
import 'package:portfolio/core/widget/section_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../feature/portfolio/domain/entities/portfolio_entities.dart';
import 'glass_card.dart';

/// Projects section: responsive grid of project cards. Each card shows a
/// cover image (if any), title, description, tech chips, and a row of
/// link buttons that self-hide when the corresponding URL is absent.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({
    required this.sectionKey,
    required this.projects,
    super.key,
  });

  final GlobalKey sectionKey;
  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionTitle(eyebrow: 'Portfolio', title: 'Featured Projects'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = _columnsFor(constraints.maxWidth);
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: <Widget>[
                  for (int i = 0; i < projects.length; i++)
                    SizedBox(
                      width: _cardWidth(constraints.maxWidth, columns),
                      child: _ProjectCard(project: projects[i], index: i),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  int _columnsFor(double width) {
    if (width >= 1024) return 3;
    if (width >= 768) return 2;
    return 1;
  }

  double _cardWidth(double maxWidth, int columns) {
    const double spacing = 24;
    return (maxWidth - spacing * (columns - 1)) / columns;
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.index});

  final ProjectItem project;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (project.imageUrl != null && project.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  project.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imagePlaceholder(context),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? progress) {
                    if (progress == null) return child;
                    return _imagePlaceholder(context);
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(project.title, style: context.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  project.role,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: context.textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                if (project.features.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 12),
                  ...project.features.take(3).map(
                        (String f) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 7, right: 8),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.brandGradient,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(f, style: context.textTheme.bodySmall),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                  project.techStack.map((String t) => _techChip(context, t)).toList(),
                ),
                const SizedBox(height: 16),
                _linkRow(context),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms, duration: 450.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _imagePlaceholder(BuildContext context) {
    return Container(
      color: context.colors.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, color: context.colors.outline, size: 32),
    );
  }

  Widget _techChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline),
      ),
      child: Text(label, style: context.textTheme.bodySmall),
    );
  }

  Widget _linkRow(BuildContext context) {
    final List<Widget> buttons = <Widget>[
      if (project.hasGithub)
        _linkButton(context, Icons.code_rounded, 'Code', project.githubUrl!),
      if (project.hasLiveDemo)
        _linkButton(context, Icons.open_in_new_rounded, 'Live Demo', project.liveDemoUrl!),
      if (project.hasPlayStore)
        _linkButton(context, Icons.shop_rounded, 'Play Store', project.playStoreUrl!),
      if (project.hasAppStore)
        _linkButton(context, Icons.apple_rounded, 'App Store', project.appStoreUrl!),
      if (project.hasCaseStudy)
        _linkButton(context, Icons.article_outlined, 'Case Study', project.caseStudyUrl!),
    ];

    if (buttons.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 8, runSpacing: 8, children: buttons);
  }

  Widget _linkButton(BuildContext context, IconData icon, String label, String url) {
    return OutlinedButton.icon(
      onPressed: () => _launch(url),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: context.colors.outline),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: context.textTheme.bodySmall,
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