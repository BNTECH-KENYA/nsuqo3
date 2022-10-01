
class Filters_Model{

  List<String> price;
  List<String> moq;
  List<String> warant;
  bool available;
  List<String> distributor;
  List<String> partno;
  List<String> location;

  Filters_Model(

      {
        required this.price,
        required this.moq,
        required this.warant,
        required this.available,
        required this.distributor,
        required this.partno,
        required this.location,
      }

      );
}