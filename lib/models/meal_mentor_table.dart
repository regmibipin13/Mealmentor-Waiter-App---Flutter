List<MealMentorTable> tableFromJson(List<dynamic> tableJson) =>
    List<MealMentorTable>.from(
        tableJson.map((tableJson) => MealMentorTable.fromJson(tableJson)));

class MealMentorTable {
  int? id;
  String? name;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;

  MealMentorTable(
      {this.id, this.name, this.restaurantId, this.createdAt, this.updatedAt});

  MealMentorTable.fromJson(Map<String, dynamic> json) {
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
