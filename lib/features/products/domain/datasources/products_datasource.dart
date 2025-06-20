import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);

  // TODO: Implement methods
  Future<List<Product>> getProductsByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
