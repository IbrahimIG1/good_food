import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/data/reposetory/recommended_product_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Products.fromJson(response.body).products);
      // print(_recommendedProductList.length);
      _isLoading = true;
      update();
    }
  }
}
