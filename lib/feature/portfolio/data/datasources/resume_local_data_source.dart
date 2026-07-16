import '../../domain/entities/portfolio_entities.dart';

/// Contract for the portfolio content source. Returning domain entities keeps
/// the boundary clean; a RemoteDataSource (dio + JSON) can implement the same
/// interface later without touching domain or presentation.
abstract interface class ResumeLocalDataSource {
  Portfolio load();
}

/// Content populated VERBATIM from Binod Dangi's ATS resume. Nothing invented.
/// Where the resume lacked data (project images, live/store links, challenges,
/// certifications), fields are left null/empty with a TODO so the UI hides
/// those elements automatically.
class ResumeLocalDataSourceImpl implements ResumeLocalDataSource {
  const ResumeLocalDataSourceImpl();

  @override
  Portfolio load() {
    return const Portfolio(
      profile: Profile(
        name: 'Binod Dangi',
        headline:
        'Senior Flutter Developer  ·  Mobile Application Developer  ·  Flutter Lead Engineer',
        summary:
        'Senior Flutter Developer with 4 years of experience architecting and '
            'delivering production-grade cross-platform mobile applications for '
            'Android and iOS across ride-hailing, food delivery, marketplace, '
            'e-learning, fintech, and e-commerce domains. Deep expertise in Flutter, '
            'Dart, Kotlin, Clean Architecture, MVVM, Riverpod, and Bloc, combined '
            'with strong hands-on experience in real-time systems (Socket.IO, WebRTC), '
            'live GPS tracking, video streaming, offline-first design, and payment '
            'gateway integrations. Proven track record of leading end-to-end mobile '
            'product delivery — from architecture design and API collaboration '
            'through CI/CD automation and App Store / Play Store releases. Adept at '
            'collaborating with distributed, cross-functional teams and consistently '
            'delivering scalable, performant, and maintainable mobile applications.',
        yearsExperience: 4,
        social: SocialLinks(
          email: 'binoddangi624@gmail.com',
          phone: '+977-9861116780',
          location: 'Kathmandu, Nepal',
          linkedin: 'https://linkedin.com/in/binod-dangi-04711619b',
          github: 'https://github.com/binoo11',
          whatsapp: 'https://wa.me/9779861116780',
        ),
      ),
      skillGroups: <SkillGroup>[
        SkillGroup(
          category: 'Mobile Development',
          skills: <String>[
            'Flutter',
            'Dart',
            'Kotlin',
            'Java',
            'Android SDK',
            'iOS Deployment',
          ],
        ),
        SkillGroup(
          category: 'Architecture & Patterns',
          skills: <String>[
            'Clean Architecture',
            'MVVM',
            'Repository Pattern',
            'Modular Architecture',
          ],
        ),
        SkillGroup(
          category: 'State Management',
          skills: <String>['Riverpod', 'Bloc/Cubit', 'Provider', 'GetX'],
        ),
        SkillGroup(
          category: 'Real-Time & Streaming',
          skills: <String>[
            'Socket.IO',
            'WebRTC',
            'Live GPS Tracking',
            'Video Streaming',
            'Offline Playback',
          ],
        ),
        SkillGroup(
          category: 'Backend Integration',
          skills: <String>[
            'REST APIs',
            'Firebase Auth',
            'Firestore',
            'FCM',
            'Analytics',
            'Crashlytics',
          ],
        ),
        SkillGroup(
          category: 'Data & Storage',
          skills: <String>[
            'Hive',
            'SharedPreferences',
            'WorkManager',
            'Offline-First Architecture',
          ],
        ),
        SkillGroup(
          category: 'Maps & Location',
          skills: <String>[
            'Google Maps SDK',
            'Google Places API',
            'Geolocation',
            'Route Visualization',
          ],
        ),
        SkillGroup(
          category: 'Payments & Notifications',
          skills: <String>[
            'Khalti Payment Gateway',
            'Firebase Cloud Messaging',
            'Push Notifications',
          ],
        ),
        SkillGroup(
          category: 'DevOps & Tooling',
          skills: <String>[
            'Git',
            'GitHub Actions',
            'CI/CD Pipelines',
            'Fastlane',
            'App Store / Play Store Releases',
          ],
        ),
        SkillGroup(
          category: 'Project Management',
          skills: <String>['Agile', 'Scrum', 'Jira', 'ClickUp'],
        ),
      ],
      experience: <ExperienceItem>[
        ExperienceItem(
          company: 'Janak Tech Pvt. Ltd.',
          position: 'Senior Mobile Application Developer',
          duration: 'Jan 2026 – Present',
          location: 'Kathmandu, Nepal',
          responsibilities: <String>[
            'Architected and led development of marketplace, ride-hailing, and food delivery Flutter applications for Android and iOS.',
            'Engineered real-time ride request dispatching, live order tracking, and driver location synchronization using Socket.IO, reducing latency and improving dispatch accuracy.',
            'Integrated WebRTC-based in-app voice communication, enabling seamless driver-passenger coordination without third-party calling costs.',
            'Designed and implemented live GPS tracking and route visualization using Google Maps SDK, supporting multi-stop delivery workflows.',
            'Established Clean Architecture and modular project structures, improving codebase maintainability and onboarding speed.',
            'Collaborated with backend engineers to define REST API contracts and socket event schemas, accelerating integration cycles.',
            'Managed Play Store and App Store release pipelines including versioning, staged rollouts, and compliance reviews.',
          ],
          technologies: <String>[
            'Flutter',
            'Dart',
            'Riverpod',
            'Socket.IO',
            'WebRTC',
            'Firebase',
            'Google Maps SDK',
            'REST APIs',
            'CI/CD',
          ],
        ),
        ExperienceItem(
          company: 'eVidhya',
          position: 'Mobile Application Developer',
          duration: 'Jan 2025 – Dec 2025',
          location: 'Nepal',
          responsibilities: <String>[
            'Built a cross-platform e-learning application with adaptive video streaming, enabling high-quality content delivery on variable network conditions.',
            'Implemented offline learning capabilities using WorkManager for background media downloads and Hive for local content storage, increasing course completion rates for low-connectivity users.',
            'Integrated Firebase Cloud Messaging (FCM) for personalized push notifications, driving a measurable increase in daily active learner engagement.',
            'Leveraged Firebase Analytics and Crashlytics to monitor user behavior and application stability, resolving critical crashes proactively before public releases.',
            'Published and maintained Android and iOS application releases with consistent delivery across sprint cycles.',
          ],
          technologies: <String>[
            'Flutter',
            'Dart',
            'Hive',
            'WorkManager',
            'Firebase (FCM, Analytics, Crashlytics)',
            'Video Streaming',
          ],
        ),
        ExperienceItem(
          company: 'SobizTrend',
          position: 'Mobile Application Developer',
          duration: 'Oct 2023 – Dec 2024',
          location: 'Nepal',
          responsibilities: <String>[
            'Developed and maintained a suite of Flutter applications across e-commerce, agritech, news, and events verticals, delivering consistent UI/UX across platforms.',
            'Integrated Khalti Payment Gateway into marketplace and e-commerce applications, enabling secure and localized digital transactions.',
            'Implemented real-time messaging and location-based feature sets, improving user engagement within marketplace and events applications.',
            'Optimized application rendering performance and reduced cold start times through lazy loading, widget tree restructuring, and build caching improvements.',
          ],
          technologies: <String>[
            'Flutter',
            'Dart',
            'Khalti Payment Gateway',
            'Firebase',
            'REST APIs',
            'Google Maps SDK',
          ],
          keyProjects: <String>[
            'Smart Dai',
            'KrishiGyan',
            'Sobij Marketplace',
            'Sobij Events',
            'Online Nepal',
          ],
        ),
        ExperienceItem(
          company: 'Ideapreneur Nepal',
          position: 'Mobile Application Developer',
          duration: 'Nov 2022 – Oct 2023',
          location: 'Nepal',
          responsibilities: <String>[
            'Developed fintech mobile applications for investment tracking, expense management, and stock market dashboards, serving individual and institutional users.',
            'Built financial analytics modules with real-time market data visualization, supporting data-driven investment decisions for end users.',
            'Implemented Firebase Analytics, Crashlytics, and push notification pipelines to ensure high application reliability and proactive issue resolution.',
          ],
          technologies: <String>[
            'Flutter',
            'Dart',
            'Firebase',
            'REST APIs',
            'Financial APIs',
            'Bloc',
          ],
        ),
        ExperienceItem(
          company: 'VJ Consulting',
          position: 'Mobile Application Developer',
          duration: 'Jun 2022 – Nov 2022',
          location: 'Nepal',
          responsibilities: <String>[
            'Developed Android mobile application features for a ride-sharing platform using Kotlin, including Google Maps and Google Places API integration for location-aware ride matching.',
            'Delivered core booking, driver tracking, and fare estimation features within a fast-paced startup environment.',
          ],
          technologies: <String>[
            'Kotlin',
            'Java',
            'Google Maps SDK',
            'Google Places API',
            'REST APIs',
          ],
        ),
        ExperienceItem(
          company: 'ApplyJob.com',
          position: 'Android Developer',
          duration: 'Nov 2021 – Jun 2022',
          location: 'Nepal',
          responsibilities: <String>[
            'Maintained and enhanced a job portal Android application, integrating Firebase Cloud Messaging (FCM) for real-time job alert notifications and improving user retention.',
            'Delivered iterative API integration improvements, enhancing job search and application submission workflows.',
          ],
          technologies: <String>[
            'Android',
            'Java',
            'Firebase (FCM)',
            'REST APIs',
          ],
        ),
        ExperienceItem(
          company: 'Utech IT Professionals',
          position: 'Android Developer',
          duration: 'Jun 2021 – Aug 2021',
          location: 'Nepal',
          responsibilities: <String>[
            'Developed Android applications using Java and Kotlin with MVVM architecture, REST API integration, and local data storage solutions.',
          ],
          technologies: <String>['Java', 'Kotlin', 'MVVM', 'REST APIs'],
        ),
      ],
      projects: <ProjectItem>[
        ProjectItem(
          title: 'Safe Ride',
          description:
          'Real-time ride-hailing application with live GPS tracking and Socket.IO-powered dispatch.',
          role: 'Lead Flutter Developer',
          techStack: <String>[
            'Flutter',
            'Socket.IO',
            'Google Maps SDK',
            'WebRTC',
            'REST APIs',
          ],
          features: <String>[
            'Live GPS tracking',
            'Real-time dispatch',
            'In-app voice (WebRTC)',
            'Route visualization',
          ],
          // TODO: add githubUrl / liveDemoUrl / playStoreUrl / appStoreUrl if available.
        ),
        ProjectItem(
          title: 'Zstro AI',
          description:
          'AI-integrated mobile application combining intelligent search with a Flutter-based cross-platform interface.',
          role: 'Flutter Developer',
          techStack: <String>['Flutter', 'Dart', 'REST APIs', 'AI Integration'],
          features: <String>['Intelligent search', 'Cross-platform UI'],
          // TODO: add project links if available.
        ),
        ProjectItem(
          title: 'Chalk Duster',
          description:
          'E-learning platform with adaptive video streaming, offline playback, and background content download.',
          role: 'Mobile Application Developer',
          techStack: <String>[
            'Flutter',
            'Hive',
            'WorkManager',
            'Video Streaming',
            'Firebase',
          ],
          features: <String>[
            'Adaptive video streaming',
            'Offline playback',
            'Background downloads',
          ],
          // TODO: add project links if available.
        ),
        ProjectItem(
          title: 'MoneyMitra',
          description:
          'Fintech application providing investment tracking, stock market dashboards, and personal expense analytics.',
          role: 'Mobile Application Developer',
          techStack: <String>['Flutter', 'Bloc', 'Firebase', 'Financial APIs'],
          features: <String>[
            'Investment tracking',
            'Stock dashboards',
            'Expense analytics',
          ],
          // TODO: add project links if available.
        ),
        ProjectItem(
          title: 'KrishiGyan',
          description:
          'Agritech application delivering agricultural information and services.',
          role: 'Mobile Application Developer',
          techStack: <String>['Flutter', 'Firebase', 'REST APIs'],
          features: <String>['Agritech content', 'Localized UX'],
          // TODO: add project links if available.
        ),
      ],
      services: <ServiceItem>[
        ServiceItem(
          title: 'Flutter Development',
          description:
          'Production-grade Flutter apps with Clean Architecture and BLoC.',
          icon: 'flutter',
        ),
        ServiceItem(
          title: 'Cross-Platform Apps',
          description:
          'Single codebase for Android and iOS with native-quality UX.',
          icon: 'devices',
        ),
        ServiceItem(
          title: 'Firebase Integration',
          description:
          'Auth, Firestore, FCM, Analytics, and Crashlytics wired end-to-end.',
          icon: 'cloud',
        ),
        ServiceItem(
          title: 'REST API Integration',
          description:
          'Robust networking with dio, typed models, and error handling.',
          icon: 'api',
        ),
        ServiceItem(
          title: 'App Optimization',
          description:
          'Lower cold-start, lazy loading, and widget-tree performance tuning.',
          icon: 'speed',
        ),
        ServiceItem(
          title: 'UI Implementation',
          description:
          'Pixel-accurate, responsive, animated interfaces from any design.',
          icon: 'brush',
        ),
        ServiceItem(
          title: 'Bug Fixing',
          description:
          'Diagnose and resolve crashes with Crashlytics-driven insight.',
          icon: 'bug',
        ),
        ServiceItem(
          title: 'Maintenance & Releases',
          description:
          'CI/CD, Fastlane, staged rollouts, Play Store and App Store delivery.',
          icon: 'rocket',
        ),
        ServiceItem(
          title: 'Consultation',
          description: 'Architecture reviews and mobile delivery strategy.',
          icon: 'chat',
        ),
      ],
      education: <EducationItem>[
        EducationItem(
          degree:
          'BSc. Computer Science and Information Technology (CSIT)',
          institution: 'Vedas College, Lalitpur, Nepal',
          duration: '2015 – 2020',
        ),
      ],
      // TODO: the resume lists no certifications. Add real ones here to populate
      // the section; while empty, the Certifications section hides itself.
      certifications: <CertificationItem>[],
      languages: <String>['Nepali (Native)', 'English (Intermediate)'],
    );
  }
}