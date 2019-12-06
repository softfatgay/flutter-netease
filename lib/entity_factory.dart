

import 'package:flutter_app/ui/brand/brand_detail_entity.dart';
import 'package:flutter_app/ui/brand/brand_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BrandDetailEntity") {
      return BrandDetailEntity.fromJson(json) as T;
    } else if (T.toString() == "BrandListEntity") {
      return BrandListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}