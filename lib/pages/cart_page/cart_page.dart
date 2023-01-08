import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class CartPageScreen extends StatelessWidget {
   CartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<CartController>(
      builder: (controller) {
        // img(controller.cartList);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 20,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //  image section
                    Container(
                        // margin: EdgeInsets.only(bottom: Dimentions.height10),
                        width: Dimentions.listViewImageSize,
                        height: Dimentions.listViewImageSize,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(lista[index])))),
                  ]);
            },
          ),
        );
      },
    );
  }

  List<String> lista = [];
  void img(List<CartModel> model) {
    model.forEach((element) {
      lista.add(element.img!);
    });
  }
}
