import '../../domain/entities/catalog.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.order,
    required super.isSpecial,
    super.hasFireEmoji,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      order: json['order'] as int,
      isSpecial: json['isSpecial'] as bool,
      hasFireEmoji: json['hasFireEmoji'] as bool? ?? false,
    );
  }
}

class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.descriptionAr,
    required super.descriptionEn,
    required super.photo,
    required super.originalPrice,
    required super.sellingPrice,
    required super.discountPercent,
    required super.hasDiscount,
    required super.categoryId,
    required super.isAvailable,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      descriptionAr: json['descriptionAr'] as String,
      descriptionEn: json['descriptionEn'] as String,
      photo: json['photo'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      discountPercent: json['discountPercent'] as int,
      hasDiscount: json['hasDiscount'] as bool,
      categoryId: json['categoryId'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }
}

class OfferModel extends OfferEntity {
  const OfferModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.photo,
    required super.originalPrice,
    required super.discountedPrice,
    required super.discountPercent,
    required super.categoryId,
    required super.isAvailable,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      photo: json['photo'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      discountPercent: (json['discountPercent'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
    );
  }
}

class CatalogSectionModel extends CatalogSectionEntity {
  const CatalogSectionModel({
    required super.category,
    required super.items,
    required super.offers,
  });

  factory CatalogSectionModel.fromJson(Map<String, dynamic> json) {
    return CatalogSectionModel(
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      items: (json['items'] as List)
          .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CatalogModel extends CatalogEntity {
  const CatalogModel({required super.categories, required super.sections});

  factory CatalogModel.fromResponse(Map<String, dynamic> response) {
    final catalogJson =
        (response['dataResponse'] as Map<String, dynamic>)['catalog']
            as Map<String, dynamic>;
    return CatalogModel.fromJson(catalogJson);
  }

  factory CatalogModel.fromJson(Map<String, dynamic> json) {
    return CatalogModel(
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sections: (json['sections'] as List)
          .map((e) => CatalogSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
