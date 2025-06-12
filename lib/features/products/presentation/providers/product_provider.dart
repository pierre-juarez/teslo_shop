import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/product_repository_provider.dart';

class ProductState {
  ProductState({required this.id, this.product, this.isLoading = true, this.isSaving = false});

  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState copyWith({String? id, Product? product, bool? isLoading, bool? isSaving}) {
    return ProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier({required this.productsRepository, required String productId}) : super(ProductState(id: productId)) {
    loadProduct();
  }

  final ProductsRepository productsRepository;

  Product _newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(isLoading: false, product: _newEmptyProduct());
        return;
      }

      final product = await productsRepository.getProductById(state.id);
      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }
}

final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductNotifier(productsRepository: productsRepository, productId: productId);
});
