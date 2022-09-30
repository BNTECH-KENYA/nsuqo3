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
  });
}
