import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../core/utils/scroll_utils.dart';
import '../../../../core/widget/about_section.dart';
import '../../../../core/widget/certification_section.dart';
import '../../../../core/widget/contact_section.dart';
import '../../../../core/widget/education_section.dart';
import '../../../../core/widget/error_view.dart';
import '../../../../core/widget/experience_section.dart';
import '../../../../core/widget/footer_section.dart';
import '../../../../core/widget/hero_section.dart';
import '../../../../core/widget/loading_view.dart';
import '../../../../core/widget/mobile_drawer.dart';
import '../../../../core/widget/nav_bar.dart';
import '../../../../core/widget/projects_sections.dart';
import '../../../../core/widget/scroll_to_top_button.dart';
import '../../../../core/widget/service_section.dart';
import '../../../../core/widget/skills_section.dart';

import '../../../navigation/presentation/bloc/navigation_bloc.dart';
import '../../../navigation/presentation/bloc/navigation_event.dart';
import '../../../navigation/presentation/bloc/navigation_state.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';


/// The single-page portfolio. Owns the scroll controller and the GlobalKeys
/// for each section, listens to scroll to update the active section + the
/// back-to-top button, and reacts to nav tap requests by smooth-scrolling.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  /// One GlobalKey per section, keyed by SectionId for O(1) lookup.
  final Map<String, GlobalKey> _sectionKeys = <String, GlobalKey>{
    for (final String id in SectionId.ordered) id: GlobalKey(),
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// On each scroll frame: toggle back-to-top and compute the active section
  /// by finding the last section whose top has crossed a threshold offset.
  void _onScroll() {
    final NavigationBloc bloc = context.read<NavigationBloc>();
    final double offset = _scrollController.offset;

    bloc.add(ScrollOffsetChanged(offset > 600));

    const double activationLine = 160;
    String active = SectionId.hero;
    for (final String id in SectionId.ordered) {
      final BuildContext? ctx = _sectionKeys[id]!.currentContext;
      if (ctx == null) continue;
      final RenderObject? box = ctx.findRenderObject();
      if (box is! RenderBox) continue;
      final double dy = box.localToGlobal(Offset.zero).dy;
      if (dy <= activationLine) active = id;
    }
    bloc.add(SectionChanged(active));
  }

  Future<void> _scrollTo(String sectionId) async {
    final GlobalKey? key = _sectionKeys[sectionId];
    if (key == null) return;
    await ScrollUtils.scrollToKey(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // Mobile navigation drawer; hidden on desktop where the nav bar shows all.
      endDrawer: BlocListener<NavigationBloc, NavigationState>(
        listenWhen: (NavigationState p, NavigationState c) =>
        c.requestedSection != null &&
            c.requestedSection != p.requestedSection,
        listener: (BuildContext context, NavigationState state) {
          if (state.requestedSection != null) {
            _scrollTo(state.requestedSection!);
          }
        },
        child: MobileDrawer(
          onSelect: (String id) {
            Navigator.of(context).maybePop();
            context.read<NavigationBloc>().add(SectionRequested(id));
          },
        ),
      ),
      body: BlocConsumer<NavigationBloc, NavigationState>(
        // Only rebuild/scroll when a section is actually requested.
        listenWhen: (NavigationState p, NavigationState c) =>
        c.requestedSection != null &&
            c.requestedSection != p.requestedSection,
        listener: (BuildContext context, NavigationState state) {
          if (state.requestedSection != null) {
            _scrollTo(state.requestedSection!);
          }
        },
        buildWhen: (_, __) => false,
        builder: (BuildContext context, _) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildContent(),
              // Sticky nav bar overlays the scrolling content.
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: NavBar(
              //     onSelect: (String id) => context
              //         .read<NavigationBloc>()
              //         .add(SectionRequested(id)),
              //     onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              //   ),
              // ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavBar(
                  onSelect: (String id) => context
                      .read<NavigationBloc>()
                      .add(SectionRequested(id)),
                  onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),
              // Floating scroll-to-top button (bottom-right).
              Positioned(
                right: 24,
                bottom: 24,
                child: ScrollToTopButton(
                  onTap: () => ScrollUtils.scrollToTop(_scrollController),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (BuildContext context, PortfolioState state) {
        if (state.isLoading) {
          return const LoadingView(message: 'Loading portfolio…');
        }
        if (state.isFailure) {
          return ErrorView(
            message: state.errorMessage ?? 'Unknown error',
            onRetry: () =>
                context.read<PortfolioBloc>().add(const PortfolioLoaded()),
          );
        }

        final portfolio = state.portfolio!;
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              HeroSection(
                sectionKey: _sectionKeys[SectionId.hero]!,
                profile: portfolio.profile,
                onContact: () => context
                    .read<NavigationBloc>()
                    .add(const SectionRequested(SectionId.contact)),
                onViewProjects: () => context
                    .read<NavigationBloc>()
                    .add(const SectionRequested(SectionId.projects)),
              ),
              AboutSection(
                sectionKey: _sectionKeys[SectionId.about]!,
                profile: portfolio.profile,
                experienceCount: portfolio.experience.length,
                projectCount: portfolio.projects.length,
              ),
              SkillsSection(
                sectionKey: _sectionKeys[SectionId.skills]!,
                skillGroups: portfolio.skillGroups,
              ),
              ExperienceSection(
                sectionKey: _sectionKeys[SectionId.experience]!,
                experience: portfolio.experience,
              ),
              ProjectsSection(
                sectionKey: _sectionKeys[SectionId.projects]!,
                projects: portfolio.projects,
              ),
              ServicesSection(
                sectionKey: _sectionKeys[SectionId.services]!,
                services: portfolio.services,
              ),
              //ProjectsSection,ServicesSection,Certifications,ContactSection,FooterSection
              EducationSection(
                sectionKey: _sectionKeys[SectionId.education]!,
                education: portfolio.education,
              ),
              // Certifications hides itself when the list is empty.
              // CertificationsSection(
              //   sectionKey: _sectionKeys[SectionId.certifications]!,
              //   certifications: portfolio.certifications,
              // ),
              ContactSection(
                sectionKey: _sectionKeys[SectionId.contact]!,
                social: portfolio.profile.social,
              ),
              FooterSection(profile: portfolio.profile),
            ],
          ),
        );
      },
    );
  }
}