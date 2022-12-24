import 'package:flutter/material.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/utils/styles.dart';
import 'package:get/get.dart';


class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final String subTitle;
  const PaymentOptionButton({Key? key,
    required this.title,
    required this.index,
    required this.icon,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 5,
                    spreadRadius: 1
                )
              ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: Dimensions.iconSize24+16,
              color: _selected?AppColors.mainColor:Theme.of(context).disabledColor,
            ),
            title: Text(title,
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.font20,
                )),
            subtitle: Text(subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: Dimensions.font26,
              ),
            ),
            trailing: _selected?Icon(Icons.check_circle,
              color: Theme.of(context).primaryColor) : null,
          ),
        ),
      );
    });
  }
}
