
class MesssageModel{

  String message;
  String timestamp;
  String time_ui;
  String name;

  String product_id;
  String product_name;
  String product_photo;
  String product_description;
  String product_price;

  MesssageModel(

      {required this.message,
        required this.timestamp,
        required this.time_ui,
        required this.name,
        required this.product_id,
        required this.product_name,
        required this.product_photo,
        required this.product_description,
        required this.product_price,
      }

      );
}