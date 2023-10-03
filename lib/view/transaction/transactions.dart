import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/transaction/widgets/custom_cliper_shape.dart';

class TrasactionsScreen extends StatelessWidget {
  const TrasactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipperShape(),
                child: Container(
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        CustomColors.commonClr,
                        CustomColors.gradientSecond
                      ])),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "WALLET APP",
                          style: CustomFuction.style(
                              fontWeight: FontWeight.w600,
                              size: 17,
                              color: CustomColors.kwhite),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: CustomColors.kwhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 30,
                right: 30,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          spreadRadius: -4.0,
                          blurRadius: 10.0,
                        )
                      ]),
                  child: Column(
                    children: [
                      Text(
                        'Your Balance',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold,
                            size: 14,
                            color: CustomColors.commonClr),
                      ),
                      Text(
                        ' \$500.00',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold, size: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(color: Colors.grey.withAlpha(50)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Text(
                                  'Income',
                                  style: CustomFuction.style(
                                      fontWeight: FontWeight.bold, size: 14),
                                ),
                                Text(
                                  '\$50.00',
                                  style: CustomFuction.style(
                                      fontWeight: FontWeight.bold,
                                      size: 18,
                                      color: CustomColors.kgreen),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Text(
                                  'Expences',
                                  style: CustomFuction.style(
                                      fontWeight: FontWeight.bold, size: 14),
                                ),
                                Text(
                                  '\$45.00',
                                  style: CustomFuction.style(
                                      fontWeight: FontWeight.bold,
                                      size: 18,
                                      color: CustomColors.kred),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
