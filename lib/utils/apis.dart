class Api {
  static var baseUrl = "http://mealmentor.codeswithbipin.com/api";
  static var baseUrlLive = "http://mealmentor.codeswithbipin.com/api";
  // If Using Laravel Valet
  static var baseUrlLocal = "http://mealmentor.test/api";
  // Other wise use ip address

  static String login = "$baseUrl/login";
  static String item = "$baseUrl/item-categories";
  static String itemByCategory = "$baseUrl/items?item_category_id";
  static String pastOrders = "$baseUrl/pos-orders";
  static String tables = "$baseUrl/tables";
  static String postOrder = "$baseUrl/pos-orders";
}
