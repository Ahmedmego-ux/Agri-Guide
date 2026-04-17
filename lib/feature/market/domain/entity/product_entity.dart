class ProductEntity {
   final int id;
  final String title;
  final String handle;
  final String description;
  final String image;
  final double price;
  final String productType;
  final List<String> images;

  ProductEntity({
    required this.id, 
    required this.title,
     required this.handle,
      required this.description,
       required this.image,
        required this.price,
         required this.productType,
         required this.images
         });

}