import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/portfolio_entities.dart';

part 'portfolio_models.g.dart';

/// DTO layer. Mirrors the domain entities 1:1 with JSON (de)serialization so
/// the local source can later be swapped for a remote dio/JSON API with zero
/// domain or presentation changes. Run build_runner to generate the .g.dart.
///
///   dart run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
class PortfolioModel {
  const PortfolioModel({
    required this.profile,
    required this.skillGroups,
    required this.experience,
    required this.projects,
    required this.services,
    required this.education,
    required this.certifications,
    required this.languages,
  });

  final ProfileModel profile;
  final List<SkillGroupModel> skillGroups;
  final List<ExperienceModel> experience;
  final List<ProjectModel> projects;
  final List<ServiceModel> services;
  final List<EducationModel> education;
  final List<CertificationModel> certifications;
  final List<String> languages;

  factory PortfolioModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioModelFromJson(json);
  Map<String, dynamic> toJson() => _$PortfolioModelToJson(this);

  Portfolio toEntity() => Portfolio(
    profile: profile.toEntity(),
    skillGroups:
    skillGroups.map((SkillGroupModel e) => e.toEntity()).toList(),
    experience:
    experience.map((ExperienceModel e) => e.toEntity()).toList(),
    projects: projects.map((ProjectModel e) => e.toEntity()).toList(),
    services: services.map((ServiceModel e) => e.toEntity()).toList(),
    education: education.map((EducationModel e) => e.toEntity()).toList(),
    certifications: certifications
        .map((CertificationModel e) => e.toEntity())
        .toList(),
    languages: languages,
  );
}

@JsonSerializable()
class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.headline,
    required this.tagline,
    required this.summary,
    required this.yearsExperience,
    required this.social,
  });

  final String name;
  final String headline;
  final String tagline;
  final String summary;
  final int yearsExperience;
  final SocialLinksModel social;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  Profile toEntity() => Profile(
    name: name,
    headline: headline,
    tagline: tagline,
    summary: summary,
    yearsExperience: yearsExperience,
    social: social.toEntity(),
  );
}

@JsonSerializable()
class SocialLinksModel {
  const SocialLinksModel({
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

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinksModelToJson(this);

  SocialLinks toEntity() => SocialLinks(
    email: email,
    phone: phone,
    location: location,
    linkedin: linkedin,
    github: github,
    whatsapp: whatsapp,
  );
}

@JsonSerializable()
class SkillGroupModel {
  const SkillGroupModel({required this.category, required this.skills});

  final String category;
  final List<String> skills;

  factory SkillGroupModel.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SkillGroupModelToJson(this);

  SkillGroup toEntity() => SkillGroup(category: category, skills: skills);
}

@JsonSerializable()
class ExperienceModel {
  const ExperienceModel({
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

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);

  ExperienceItem toEntity() => ExperienceItem(
    company: company,
    position: position,
    duration: duration,
    location: location,
    responsibilities: responsibilities,
    technologies: technologies,
    keyProjects: keyProjects,
  );
}

@JsonSerializable()
class ProjectModel {
  const ProjectModel({
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
  final String? imageUrl;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? caseStudyUrl;
  final String? challenges;
  final String? solutions;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

  ProjectItem toEntity() => ProjectItem(
    title: title,
    description: description,
    role: role,
    techStack: techStack,
    features: features,
    imageUrl: imageUrl,
    githubUrl: githubUrl,
    liveDemoUrl: liveDemoUrl,
    playStoreUrl: playStoreUrl,
    appStoreUrl: appStoreUrl,
    caseStudyUrl: caseStudyUrl,
    challenges: challenges,
    solutions: solutions,
  );
}

@JsonSerializable()
class ServiceModel {
  const ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  ServiceItem toEntity() =>
      ServiceItem(title: title, description: description, icon: icon);
}

@JsonSerializable()
class EducationModel {
  const EducationModel({
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
  });

  final String degree;
  final String institution;
  final String duration;
  final String? description;

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);
  Map<String, dynamic> toJson() => _$EducationModelToJson(this);

  EducationItem toEntity() => EducationItem(
    degree: degree,
    institution: institution,
    duration: duration,
    description: description,
  );
}

@JsonSerializable()
class CertificationModel {
  const CertificationModel({
    required this.title,
    required this.issuer,
    required this.date,
    this.credentialUrl,
  });

  final String title;
  final String issuer;
  final String date;
  final String? credentialUrl;

  factory CertificationModel.fromJson(Map<String, dynamic> json) =>
      _$CertificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$CertificationModelToJson(this);

  CertificationItem toEntity() => CertificationItem(
    title: title,
    issuer: issuer,
    date: date,
    credentialUrl: credentialUrl,
  );
}