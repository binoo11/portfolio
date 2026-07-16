/// Static UI copy that is NOT sourced from the resume (labels, CTAs, aria text).
/// Resume-derived content lives in the data layer, never here.
class AppStrings {
  const AppStrings._();

  // CTAs
  static const String downloadResume = 'Download Resume';
  static const String contactMe = 'Contact Me';
  static const String viewProjects = 'View Projects';
  static const String getInTouch = 'Get in touch';
  static const String sendMessage = 'Send Message';
  static const String backToTop = 'Back to top';
  static const String retry = 'Retry';

  // Section headings
  static const String aboutHeading = 'About Me';
  static const String skillsHeading = 'Skills & Expertise';
  static const String experienceHeading = 'Experience';
  static const String projectsHeading = 'Featured Projects';
  static const String servicesHeading = 'What I Do';
  static const String educationHeading = 'Education';
  static const String certificationsHeading = 'Certifications';
  static const String contactHeading = 'Let’s Work Together';

  // Contact form
  static const String nameLabel = 'Your name';
  static const String emailLabel = 'Email address';
  static const String messageLabel = 'Message';
  static const String nameRequired = 'Please enter your name';
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Enter a valid email address';
  static const String messageRequired = 'Please enter a message';

  // Empty / error states
  static const String emptyTitle = 'Nothing here yet';
  static const String errorTitle = 'Something went wrong';

  // Accessibility labels
  static const String semanticProfileImage = 'Portrait of Binod Dangi';
  static const String semanticThemeToggle = 'Toggle light and dark theme';
  static const String semanticMenu = 'Open navigation menu';
}