import 'package:nsuqo/models/filters_params.dart';

class Item_Model {

  final String wholesalerid;
  final String itemId;
  final String itemname;
  final String category;
  final String itemprice;
  final String itemdescription;
  List<dynamic> photosLinks;
  final String availability;
  final String warrant_period;
  final String no_of_clicks;
  final String moq;
  final String partno;
  final String searchalgopartnoname;
  final String company_name;
  final String location;
  final String ram;
  final String processor;
  final String screen;
  final String brand;
  final String resolution;
  final String storage;
  final String screensize;
  final String partner;
  final String package;
  final String exchange_rate;
   String ? subcategory;
   String ? subsubcategory;
  final Filters_Params_Model filters_params;

  Item_Model({required
  this.wholesalerid,
    required this.itemId,
    required this.itemname,
    required this.category,
    required this.itemprice,
    required this.photosLinks,
    required this.availability,
    required this.itemdescription,
    required this.no_of_clicks,
    required this.warrant_period,
    required this.moq,
    required this.partno,
    required this.searchalgopartnoname,
    required this.company_name,
    required this.location,
    required this.ram,
    required this.processor,
    required this.screen,
    required this.brand,
    required this.resolution,
    required this.storage,
    required this.screensize,
    required this.partner,
    required this.package,
    required this.filters_params,
    required this.exchange_rate,
    this.subcategory,
    this.subsubcategory,

  });
}
