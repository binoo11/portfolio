import 'package:equatable/equatable.dart';

/// Pure domain entities — no JSON, no Flutter, no framework deps (SRP + clean
/// architecture boundary). All fields are immutable; Equatable powers value
/// equality so BLoC state comparisons are correct and rebuilds stay minimal.

/// Root aggregate handed to the presentation layer.
class Portfolio extends Equatable {
  const Portfolio({
    required this.profile,
    required this.skillGroups,
    required this.experience,
    required this.projects,
    required this.services,
    required this.education,
    required this.certifications,
    required this.languages,
  });

  final Profile profile;
  final List<SkillGroup> skillGroups;
  final List<ExperienceItem> experience;
  final List<ProjectItem> projects;
  final List<ServiceItem> services;
  final List<EducationItem> education;
  final List<CertificationItem> certifications;
  final List<String> languages;

  @override
  List<Object?> get props => <Object?>[
    profile,
    skillGroups,
    experience,
    projects,
    services,
    education,
    certifications,
    languages,
  ];
}

class Profile extends Equatable {
  const Profile({
    required this.name,
    required this.headline,
    required this.summary,
    required this.yearsExperience,
    required this.social,
  });

  final String name;
  final String headline;
  final String summary;
  final int yearsExperience;
  final SocialLinks social;

  @override
  List<Object?> get props =>
      <Object?>[name, headline, summary, yearsExperience, social];
}

class SocialLinks extends Equatable {
  const SocialLinks({
    required this.email,
    required this.phone,
    required this.location,
    this.linkedin,
    this.github,
    this.whatsapp,
  });

  final String email;
  final String phone;
  final String location;
  final String? linkedin;
  final String? github;
  final String? whatsapp;

  @override
  List<Object?> get props =>
      <Object?>[email, phone, location, linkedin, github, whatsapp];
}

class SkillGroup extends Equatable {
  const SkillGroup({required this.category, required this.skills});

  final String category;
  final List<String> skills;

  @override
  List<Object?> get props => <Object?>[category, skills];
}

class ExperienceItem extends Equatable {
  const ExperienceItem({
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.responsibilities,
    required this.technologies,
    this.keyProjects = const <String>[],
  });

  final String company;
  final String position;
  final String duration;
  final String location;
  final List<String> responsibilities;
  final List<String> technologies;
  final List<String> keyProjects;

  @override
  List<Object?> get props => <Object?>[
    company,
    position,
    duration,
    location,
    responsibilities,
    technologies,
    keyProjects,
  ];
}

class ProjectItem extends Equatable {
  const ProjectItem({
    required this.title,
    required this.description,
    required this.role,
    required this.techStack,
    required this.features,
    this.imageUrl,
    this.githubUrl,
    this.liveDemoUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.caseStudyUrl,
    this.challenges,
    this.solutions,
  });

  final String title;
  final String description;
  final String role;
  final List<String> techStack;
  final List<String> features;

  // All optional. The UI hides any button/element whose value is null.
  final String? imageUrl;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? caseStudyUrl;
  final String? challenges;
  final String? solutions;

  bool get hasGithub => githubUrl != null && githubUrl!.isNotEmpty;
  bool get hasLiveDemo => liveDemoUrl != null && liveDemoUrl!.isNotEmpty;
  bool get hasPlayStore => playStoreUrl != null && playStoreUrl!.isNotEmpty;
  bool get hasAppStore => appStoreUrl != null && appStoreUrl!.isNotEmpty;
  bool get hasCaseStudy => caseStudyUrl != null && caseStudyUrl!.isNotEmpty;

  @override
  List<Object?> get props => <Object?>[
    title,
    description,
    role,
    techStack,
    features,
    imageUrl,
    githubUrl,
    liveDemoUrl,
    playStoreUrl,
    appStoreUrl,
    caseStudyUrl,
    challenges,
    solutions,
  ];
}

class ServiceItem extends Equatable {
  const ServiceItem({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;

  /// Semantic icon key resolved to an IconData in the presentation layer,
  /// keeping the domain free of Flutter imports.
  final String icon;

  @override
  List<Object?> get props => <Object?>[title, description, icon];
}

class EducationItem extends Equatable {
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
  });

  final String degree;
  final String institution;
  final String duration;
  final String? description;

  @override
  List<Object?> get props =>
      <Object?>[degree, institution, duration, description];
}

class CertificationItem extends Equatable {
  const CertificationItem({
    required this.title,
    required this.issuer,
    required this.date,
    this.credentialUrl,
  });

  final String title;
  final String issuer;
  final String date;
  final String? credentialUrl;

  @override
  List<Object?> get props =>
      <Object?>[title, issuer, date, credentialUrl];
}