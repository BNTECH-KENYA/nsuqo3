import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category_Widget extends StatelessWidget {
  const Category_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height:110,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0, right:8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15), ),
                    image: DecorationImage(
                      image: AssetImage("assets/IMG-20220714-WA0001.jpg"),
                      fit:BoxFit.cover,

                    )
                ),

              ),
            ),
            Positioned(
              top: 80,
              child: SizedBox(
                width: 110,
                child: Text("Mens Shirt with flowers like coates",textAlign: TextAlign.center, style:TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12
                )),
              ),
            ),

          ],
        ),
      );
  }
}
