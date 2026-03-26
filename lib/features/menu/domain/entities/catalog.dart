class CategoryEntity {
  final String id;
  final String nameAr;
  final String nameEn;
  final int order;
  final bool isSpecial;
  final bool hasFireEmoji;

  const CategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.order,
    required this.isSpecial,
    this.hasFireEmoji = false,
  });
}

class MenuItemEntity {
  final String id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String photo;
  final double originalPrice;
  final double sellingPrice;
  final int discountPercent;
  final bool hasDiscount;
  final String categoryId;
  final bool isAvailable;

  const MenuItemEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.photo,
    required this.originalPrice,
    required this.sellingPrice,
    required this.discountPercent,
    required this.hasDiscount,
    required this.categoryId,
    required this.isAvailable,
  });
}

class OfferEntity {
  final String id;
  final String nameAr;
  final String nameEn;
  final String photo;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final String categoryId;
  final bool isAvailable;
  final bool isMostSelling;

  const OfferEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.photo,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.categoryId,
    required this.isAvailable,
    this.isMostSelling = false,
  });
}

class CatalogSectionEntity {
  final CategoryEntity category;
  final List<MenuItemEntity> items;
  final List<OfferEntity> offers;

  const CatalogSectionEntity({
    required this.category,
    required this.items,
    required this.offers,
  });
}

class CatalogEntity {
  final List<CategoryEntity> categories;
  final List<CatalogSectionEntity> sections;

  const CatalogEntity({required this.categories, required this.sections});
}
