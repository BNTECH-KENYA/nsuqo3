import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat_Dates extends StatefulWidget {
  const Chat_Dates({Key? key, required this.date_data}) : super(key: key);
  final String date_data;

  @override
  State<Chat_Dates> createState() => _Chat_DatesState();
}

class _Chat_DatesState extends State<Chat_Dates> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,

        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  4.0
                ),
                child: Text(widget.date_data,
                    style: TextStyle(
                        fontSize: 14,
                        color:Colors.grey[600]
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
