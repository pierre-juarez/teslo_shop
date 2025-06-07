import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  ProductsRepositoryImpl(this.productsDataSource);

  final ProductsDataSource productsDataSource;

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return productsDataSource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return productsDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return productsDataSource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    return productsDataSource.getProductsByTerm(term);
  }
}
