
List<MealMentorCategory> itemCategoryFromJson(List<dynamic> itemCategoryJson) =>
    List<MealMentorCategory>.from(itemCategoryJson.map(
        (itemCategoryJson) => MealMentorCategory.fromJson(itemCategoryJson)));

class MealMentorCategory {
  int? id;
  String? name;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;

  MealMentorCategory(
      {this.id, this.name, this.restaurantId, this.createdAt, this.updatedAt});

  MealMentorCategory.fromJson(Map<String, dynamic> json) {
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
