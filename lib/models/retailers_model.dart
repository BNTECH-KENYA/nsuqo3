
import 'dart:ui';

class Retailers_Model {

  final String retailer_email;
  final String retailer_name;
  final String company_name;
  final String retailer_phonenumber;
  late final bool can_view;

  Retailers_Model({
    required this.retailer_email,
    required this.company_name,
    required this.retailer_phonenumber,
    required this.retailer_name,
    required this.can_view,
  });
}
