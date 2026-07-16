// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioModel _$PortfolioModelFromJson(Map<String, dynamic> json) =>
    PortfolioModel(
      profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      skillGroups: (json['skillGroups'] as List<dynamic>)
          .map((e) => SkillGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>)
          .map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      education: (json['education'] as List<dynamic>)
          .map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List<dynamic>)
          .map((e) => CertificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PortfolioModelToJson(PortfolioModel instance) =>
    <String, dynamic>{
      'profile': instance.profile.toJson(),
      'skillGroups': instance.skillGroups.map((e) => e.toJson()).toList(),
      'experience': instance.experience.map((e) => e.toJson()).toList(),
      'projects': instance.projects.map((e) => e.toJson()).toList(),
      'services': instance.services.map((e) => e.toJson()).toList(),
      'education': instance.education.map((e) => e.toJson()).toList(),
      'certifications': instance.certifications.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
    };

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  name: json['name'] as String,
  headline: json['headline'] as String,
  summary: json['summary'] as String,
  yearsExperience: (json['yearsExperience'] as num).toInt(),
  social: SocialLinksModel.fromJson(json['social'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'headline': instance.headline,
      'summary': instance.summary,
      'yearsExperience': instance.yearsExperience,
      'social': instance.social,
    };

SocialLinksModel _$SocialLinksModelFromJson(Map<String, dynamic> json) =>
    SocialLinksModel(
      email: json['email'] as String,
      phone: json['phone'] as String,
      location: json['location'] as String,
      linkedin: json['linkedin'] as String?,
      github: json['github'] as String?,
      whatsapp: json['whatsapp'] as String?,
    );

Map<String, dynamic> _$SocialLinksModelToJson(SocialLinksModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'location': instance.location,
      'linkedin': instance.linkedin,
      'github': instance.github,
      'whatsapp': instance.whatsapp,
    };

SkillGroupModel _$SkillGroupModelFromJson(Map<String, dynamic> json) =>
    SkillGroupModel(
      category: json['category'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SkillGroupModelToJson(SkillGroupModel instance) =>
    <String, dynamic>{'category': instance.category, 'skills': instance.skills};

ExperienceModel _$ExperienceModelFromJson(Map<String, dynamic> json) =>
    ExperienceModel(
      company: json['company'] as String,
      position: json['position'] as String,
      duration: json['duration'] as String,
      location: json['location'] as String,
      responsibilities: (json['responsibilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      keyProjects:
          (json['keyProjects'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ExperienceModelToJson(ExperienceModel instance) =>
    <String, dynamic>{
      'company': instance.company,
      'position': instance.position,
      'duration': instance.duration,
      'location': instance.location,
      'responsibilities': instance.responsibilities,
      'technologies': instance.technologies,
      'keyProjects': instance.keyProjects,
    };

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
  title: json['title'] as String,
  description: json['description'] as String,
  role: json['role'] as String,
  techStack: (json['techStack'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  features: (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  imageUrl: json['imageUrl'] as String?,
  githubUrl: json['githubUrl'] as String?,
  liveDemoUrl: json['liveDemoUrl'] as String?,
  playStoreUrl: json['playStoreUrl'] as String?,
  appStoreUrl: json['appStoreUrl'] as String?,
  caseStudyUrl: json['caseStudyUrl'] as String?,
  challenges: json['challenges'] as String?,
  solutions: json['solutions'] as String?,
);

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'role': instance.role,
      'techStack': instance.techStack,
      'features': instance.features,
      'imageUrl': instance.imageUrl,
      'githubUrl': instance.githubUrl,
      'liveDemoUrl': instance.liveDemoUrl,
      'playStoreUrl': instance.playStoreUrl,
      'appStoreUrl': instance.appStoreUrl,
      'caseStudyUrl': instance.caseStudyUrl,
      'challenges': instance.challenges,
      'solutions': instance.solutions,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
  title: json['title'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
    };

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) =>
    EducationModel(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      'degree': instance.degree,
      'institution': instance.institution,
      'duration': instance.duration,
      'description': instance.description,
    };

CertificationModel _$CertificationModelFromJson(Map<String, dynamic> json) =>
    CertificationModel(
      title: json['title'] as String,
      issuer: json['issuer'] as String,
      date: json['date'] as String,
      credentialUrl: json['credentialUrl'] as String?,
    );

Map<String, dynamic> _$CertificationModelToJson(CertificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'issuer': instance.issuer,
      'date': instance.date,
      'credentialUrl': instance.credentialUrl,
    };
