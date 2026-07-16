/// Section identifiers used by NavigationBloc + in-page anchor scrolling.
class SectionId {
  const SectionId._();

  static const String hero = 'hero';
  static const String about = 'about';
  static const String skills = 'skills';
  static const String experience = 'experience';
  static const String projects = 'projects';
  static const String services = 'services';
  static const String education = 'education';
  //static const String certifications = 'certifications';
  static const String contact = 'contact';

  /// Ordered list drives nav rendering and active-section detection.
  static const List<String> ordered = <String>[
    hero,
    about,
    skills,
    experience,
    projects,
    services,
    education,
   // certifications,
    contact,
  ];

  /// Human-readable labels for the nav bar and drawer.
  static const Map<String, String> labels = <String, String>{
    hero: 'Home',
    about: 'About',
    skills: 'Skills',
    experience: 'Experience',
    projects: 'Projects',
    services: 'Services',
    education: 'Education',
    //qcertifications: 'Certifications',
    contact: 'Contact',
  };
}

/// Responsive breakpoints (logical pixels). Shared by Responsive + framework.
class Breakpoints {
  const Breakpoints._();

  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double ultraWide = 1600;
}