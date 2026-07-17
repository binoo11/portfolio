/// Single source of truth for asset locations. No magic strings in widgets.
class AssetPaths {
  const AssetPaths._();

  static const String _img = 'assets/img';
  static const String _icons = 'assets/icons';

  // TODO: drop a real square profile image here (>=512px).
  static const String profile = '$_img/fav_icon.png';
  static const String ovalProfile = '$_img/oval_profile.png';

  // TODO: optional hero background texture/gradient PNG.
  static const String heroBackground = '$_img/hero_bg.png';

  static const String githubIcon = '$_icons/github.svg';
  static const String linkedinIcon = '$_icons/linkedin.svg';
  static const String whatsappIcon = '$_icons/whatsapp.svg';
}