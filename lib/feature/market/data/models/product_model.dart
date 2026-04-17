import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';

class ProductModel  extends ProductEntity{
  ProductModel({
    required super.id,
     required super.title,
      required super.handle, 
      required super.description, 
      required super.image,
       required super.price,
        required super.productType,
        required super.images
        });

factory ProductModel.fromJson(Map<String,dynamic>json){
 return  ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      handle: json['handle'] ?? '',
      description: json['body_html'] ?? '',
      image: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['src']
          : '',
      price: double.tryParse(
            json['variants'][0]['price'].toString(),
          ) ??
          0.0,
           productType: json['product_type']??'',
            images: (json['images'] as List<dynamic>?)
        ?.map((e) => e['src'] as String)
        .toList() ?? [],
    );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'title': title,
    'image': image,
    'price': price,
    'productType': productType,
    'handle':handle,
    'body_html':description,
    'images':image


    
  };
}
  
}