import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/category_widget.dart';

class Single_Category extends StatefulWidget {
  const Single_Category({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  State<Single_Category> createState() => _Single_CategoryState();

}

class _Single_CategoryState extends State<Single_Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          leading: Icon(Icons.arrow_back, color:Colors.white),
          title:Text(
            '${widget.category}',
            style: TextStyle(
                color:Colors.white
            ),
          )
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    childAspectRatio: 0.7,
    ),

    children: [

      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),
      Category_Widget(),

    ]),
        ),
      ),
    );
  }
}
