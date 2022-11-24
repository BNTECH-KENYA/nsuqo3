
import 'dart:ui';

import 'package:nsuqo/models/filters_params.dart';

class SubCategoriesModel{

  String sub_category_id;
  String sub_category_name;
  Filters_Params_Model filters_params_model;
  Color color;

  SubCategoriesModel(

      {required this.sub_category_name,
      required this.sub_category_id,
        required this.filters_params_model,
        required this.color
      }

      );

}