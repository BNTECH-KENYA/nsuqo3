

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/messagemodel.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.messageModel}) : super(key: key);
  final MesssageModel messageModel;
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,

          ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          color: Colors.deepOrange,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 5,
                  bottom: 20
                ),
                child: Text(messageModel.message,
                style: TextStyle(
                  fontSize: 16,
                  color:Colors.white
                )),
              ),
              Positioned(
                bottom: 4,
                right: 10,

                child: Row(
                  children: [
                    Text(messageModel.time_ui, style: TextStyle(
                      fontSize: 13,
                      color:Colors.white,
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
