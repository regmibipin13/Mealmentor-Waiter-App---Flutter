List<PastOrder> pastOrderFromJson(List<dynamic> pastOrderJson) =>
    List<PastOrder>.from(pastOrderJson
        .map((pastOrderJson) => PastOrder.fromJson(pastOrderJson)));

class PastOrder {
  int? id;
  String? tableId;
  String? orderDate;
  String? orderStatus;
  String? isOrderEnded;
  String? totalAmount;
  String? grandTotal;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;
  PastOrderTable? table;
  List<PastOrderOrderableItems>? orderableItems;

  PastOrder(
      {this.id,
      this.tableId,
      this.orderDate,
      this.orderStatus,
      this.isOrderEnded,
      this.totalAmount,
      this.grandTotal,
      this.restaurantId,
      this.createdAt,
      this.updatedAt,
      this.table,
      this.orderableItems});

  PastOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableId = json['table_id'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    isOrderEnded = json['is_order_ended'];
    totalAmount = json['total_amount'];
    grandTotal = json['grand_total'].toString();
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    table =
        json['table'] != null ? PastOrderTable.fromJson(json['table']) : null;
    if (json['orderable_items'] != null) {
      orderableItems = <PastOrderOrderableItems>[];
      json['orderable_items'].forEach((v) {
        orderableItems!.add(PastOrderOrderableItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_id'] = tableId;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['is_order_ended'] = isOrderEnded;
    data['total_amount'] = totalAmount;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (table != null) {
      data['table'] = table!.toJson();
    }
    if (orderableItems != null) {
      data['orderable_items'] = orderableItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PastOrderTable {
  int? id;
  String? name;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;

  PastOrderTable(
      {this.id, this.name, this.restaurantId, this.createdAt, this.updatedAt});

  PastOrderTable.fromJson(Map<String, dynamic> json) {
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

class PastOrderOrderableItems {
  int? id;
  String? orderableId;
  String? orderableType;
  String? itemId;
  String? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  PastOrderItemName? itemName;

  PastOrderOrderableItems(
      {this.id,
      this.orderableId,
      this.orderableType,
      this.itemId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.itemName});

  PastOrderOrderableItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderableId = json['orderable_id'];
    orderableType = json['orderable_type'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemName = json['item_name'] != null
        ? PastOrderItemName.fromJson(json['item_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderable_id'] = orderableId;
    data['orderable_type'] = orderableType;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (itemName != null) {
      data['item_name'] = itemName!.toJson();
    }
    return data;
  }
}

class PastOrderItemName {
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

  PastOrderItemName(
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
      this.updatedAt});

  PastOrderItemName.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
