/// Central runtime configuration. Environment-specific values live here so
/// nothing is hardcoded across the widget tree (KISS + single source of truth).
class AppConfig {
  const AppConfig._();

  static const String appName = 'Binod Dangi — Senior Flutter Developer';

  /// TODO: set the final deployed URL (used for canonical/OG tags parity).
  static const String siteUrl = 'https://binoo11.github.io';

  /// Path to the downloadable resume PDF served from /assets/resume.
  static const String resumeAssetPath = 'assets/resume/Binod_Dangi_Resume.pdf';

  /// Shared smooth-scroll timing for nav + scroll-to-top.
  static const Duration scrollDuration = Duration(milliseconds: 600);

  /// Global base animation duration for entrance/reveal effects.
  static const Duration animationDuration = Duration(milliseconds: 550);

  /// Max content width on ultra-wide displays to keep line lengths readable.
  static const double maxContentWidth = 1240;
}