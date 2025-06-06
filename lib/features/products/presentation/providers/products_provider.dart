// State Notifier Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/domain/repositories/products_repository.dart';
import 'product_repository_provider.dart';

class ProductState {
  ProductState({this.isLastPage = false, this.limit = 10, this.offset = 0, this.isLoading = false, this.products = const []});

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductState copyWith({bool? isLastPage, int? limit, int? offset, bool? isLoading, List<Product>? products}) {
    return ProductState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductState> {
  ProductsNotifier({required this.productsRepository}) : super(ProductState()) {
    loadNextPage();
  }

  final ProductsRepository productsRepository;

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      products: [...state.products, ...products],
    );
  }
}

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(productsRepository: productsRepository);
});
