import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/pages/food/popular_food_details.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details/recommended_food_details.dart';
import 'package:food_delivery_app/pages/home/dots_indicator/dots_indicator.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text__row.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  var scaleFactor = 0.8;
  double _height = Dimentions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // App Bar
          Container(
            margin: EdgeInsets.only(
                top: Dimentions.height45, bottom: Dimentions.height10),
            padding: EdgeInsets.only(
                right: Dimentions.width20, left: Dimentions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Bangiladish',
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(text: 'Narshingdi', color: Colors.black54),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: Container(
                    width: Dimentions.width45,
                    height: Dimentions.height45,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimentions.radius15))),
                    child: Icon(
                      Icons.search,
                      size: Dimentions.iconSize24,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          GetBuilder<PopularProductController>(builder: (popularProduct) {
            return popularProduct.isLoading
                ?
                // Slide Food Images
                SingleChildScrollView(
                    child: Container(
                        // color: Colors.red,
                        height: Dimentions.pageView,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: popularProduct.popularProductList.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PopularFoodDetails(
                                    index: index,
                                  );
                                }));
                              },
                              child: _buildPageItem(index,
                                  popularProduct.popularProductList[index]),
                            );
                          },
                        )),
                  )
                :
                //  Circle Progress Indicator
                Container(
                    height: Dimentions.pageView,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  );
          }),
          //  Dots
          GetBuilder<PopularProductController>(builder: (popularProduct) {
            return MyDotsIndicator(
                currPageValue: _currPageValue,
                dotsCount: popularProduct.popularProductList.isEmpty
                    ? 1
                    : popularProduct.popularProductList.length);
          }),
          //  Recommended text
          Container(
            margin: EdgeInsets.only(left: Dimentions.width20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: 'Recommended'),
                SizedBox(width: Dimentions.width10),
                Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: BigText(
                      text: '.',
                      color: Colors.black26,
                    )),
                SizedBox(width: Dimentions.width10),
                Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: SmallText(text: 'Food pairing'))
              ],
            ),
          ),
          // List of food and image
          GetBuilder<RecommendedProductController>(
              builder: (recommendedProduct) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return recommendedProduct.isLoading
                    ? Container(
                        margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20,
                            bottom: Dimentions.height10),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return RecommendedFoodDetails(
                                    index: index,
                                  );
                                },
                              ));
                            },
                            child: recommendedFood(recommendedProduct
                                .recommendedProductList[index])),
                      )
                    : Container();
              },
            );
          })
        ],
      ),
    );
  }

  //  Matrix , Slide Item
  Widget _buildPageItem(int index, ProductModel productModel) {
    Matrix4 matrix = Matrix4.identity();
    //  this For The Current page now
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor); // = 1
      var currTranse =
          _height * (1 - currScale) / 2; // = 220  => the current height
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranse, 0);
      //  this For The Next page
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = scaleFactor +
          (_currPageValue - index + 1) * (1 - scaleFactor); // = 1.8
      var currTranse = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranse, 0);
      //   this For The Previous page
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTranse = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranse, 0);
      // This For The third page in the dirst scroll
    } else {
      var currScale = .8;
      var currTranse = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTranse, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: Dimentions.width5, right: Dimentions.width5),
            height: Dimentions.pageViewContainer,
            decoration: BoxDecoration(
              color: index.isEven ? Colors.amber : Colors.indigo,
              borderRadius: BorderRadius.circular(Dimentions.radius30),
              image: DecorationImage(
                  image:
                      NetworkImage(AppConstants.IMAGE_URL + productModel.img!),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimentions.width30,
                  right: Dimentions.width30,
                  bottom: Dimentions.height30),
              height: Dimentions.pageTextContainer,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        color: Color(0xFFe8e8e8)),
                    BoxShadow(
                        offset: Offset(
                            -5, 0), // to stop the black shadow from Right side
                        color: Colors.white),
                    BoxShadow(
                        offset: Offset(
                            5, 0), // to stop the black shadow from Left side
                        color: Colors.white),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimentions.height20,
                    left: Dimentions.width15,
                    right: Dimentions.width15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: productModel.name!),
                      SizedBox(height: Dimentions.height10),
                      Row(
                        children: [
                          star(productModel.stars!),
                          SizedBox(width: Dimentions.width5),
                          SmallText(text: productModel.stars!.toString()),
                          SizedBox(width: Dimentions.width10),
                          SmallText(text: productModel.location!),
                        ],
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      rowIconAndText(true)
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recommendedFood(ProductModel productModel) =>
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //  image section
        Container(
            // margin: EdgeInsets.only(bottom: Dimentions.height10),
            width: Dimentions.listViewImageSize,
            height: Dimentions.listViewImageSize,
            decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(Dimentions.radius15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.IMAGE_URL + productModel.img!)))),
        Expanded(
          child: Container(
            height: Dimentions.listViewTxtContainerSize,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimentions.radius20),
                    bottomRight: Radius.circular(Dimentions.radius20))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: productModel.name!),
                  SizedBox(height: Dimentions.height10),
                  SmallText(text: productModel.description!, maxLines: 1),
                  SizedBox(height: Dimentions.height10),
                  rowIconAndText(false),
                ],
              ),
            ),
          ),
        )
      ]);
}

Row rowIconAndText(bool spaceBetween) {
  return Row(
    mainAxisAlignment:
        spaceBetween ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
    children: [
      IconAndTextRow(
          text: 'Normal', iconColor: AppColors.iconColor1, icon: Icons.circle),
      IconAndTextRow(
          text: '1.7km', iconColor: Colors.blue[200]!, icon: Icons.location_on),
      IconAndTextRow(
          text: '32min',
          iconColor: Colors.red[200]!,
          icon: Icons.watch_later_outlined),
    ],
  );
}

star(int starCount) => Wrap(
    children: List.generate(
        starCount,
        (index) => Icon(
              Icons.star,
              size: Dimentions.width15,
              color: AppColors.mainColor,
            )));
