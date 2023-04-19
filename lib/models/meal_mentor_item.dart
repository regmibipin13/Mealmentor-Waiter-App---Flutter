List<MealMentorItem> categoryFromJson(List<dynamic> categoryJson) =>
    List<MealMentorItem>.from(categoryJson
        .map((categoryJson) => MealMentorItem.fromJson(categoryJson)));

class MealMentorItem {
  int? id;
  String? itemCategoryId;
  String? unitId;
  String? name;
  String? price;
  String? unitValueOfPrice;
  String? specialDiscount;
  String? enabled;
  String? outOfStock;
  String? description;
  String? photo;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;
  ItemCategory? itemCategory;
  ItemCategory? unit;
  int itemCount = 1;

  MealMentorItem(
      {this.id,
      this.itemCategoryId,
      this.unitId,
      this.name,
      this.price,
      this.unitValueOfPrice,
      this.specialDiscount,
      this.enabled,
      this.outOfStock,
      this.description,
      this.photo,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.itemCategory,
      this.itemCount = 1,
      this.unit});

  MealMentorItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCategoryId = json['item_category_id'];
    unitId = json['unit_id'];
    name = json['name'];
    price = json['price'];
    unitValueOfPrice = json['unit_value_of_price'];
    specialDiscount = json['special_discount'];
    enabled = json['enabled'];
    outOfStock = json['out_of_stock'];
    description = json['description'];
    photo = json['photo'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemCategory = json['item_category'] != null
        ? ItemCategory.fromJson(json['item_category'])
        : null;
    unit = json['unit'] != null ? ItemCategory.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_category_id'] = itemCategoryId;
    data['unit_id'] = unitId;
    data['name'] = name;
    data['price'] = price;
    data['unit_value_of_price'] = unitValueOfPrice;
    data['special_discount'] = specialDiscount;
    data['enabled'] = enabled;
    data['out_of_stock'] = outOfStock;
    data['description'] = description;
    data['photo'] = photo;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (itemCategory != null) {
      data['item_category'] = itemCategory!.toJson();
    }
    if (unit != null) {
      data['unit'] = unit!.toJson();
    }
    return data;
  }
}

class ItemCategory {
  int? id;
  String? name;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;

  ItemCategory(
      {this.id, this.name, this.restaurantId, this.createdAt, this.updatedAt});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
