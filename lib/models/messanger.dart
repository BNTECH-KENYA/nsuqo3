
class MessangerModel{

  int unreadmsg;
  String ltsmessage;
  String timstamp;
  String sender_name;
  String wholesaler_id_mm;
  String retailer_id_mm;
  String sender_email;
  String reciever_email;
  String opponent_name;
  String auth_email;

  MessangerModel(

      {required this.unreadmsg,
        required this.ltsmessage,
        required this.timstamp,
        required this.sender_name,
        required this.wholesaler_id_mm,
        required this.retailer_id_mm,
        required this.sender_email,
        required this.reciever_email,
        required this.opponent_name,
        required this.auth_email,
      });
}