class AppAsset {
  static final bg = 'assets/images/bg.png';
  static final bgLogo = 'assets/images/bglogo.png';
  static final productBg = 'assets/images/product_bg.png';
  static final cateBaby = 'assets/images/baby.png';
  static final cateBeauty = 'assets/images/beauty.png';
  static final cateCosmetic = 'assets/images/cosmetic.png';
  static final cateHeart = 'assets/images/heart.png';
  static final cateMask = 'assets/images/mask.png';
  static final cateMen = 'assets/images/men.png';
  static final catePerfume = 'assets/images/perfume.png';
  static final cateSlim = 'assets/images/slim.png';
  static final titleBg = 'assets/images/title_bg.png';
  static final setting = 'assets/images/image_setting.png';
  static final creditCard = 'assets/images/credit_card.png';

  static final AppAsset _instance = AppAsset._internal();

  factory AppAsset() {
    return _instance;
  }

  AppAsset._internal();
}
