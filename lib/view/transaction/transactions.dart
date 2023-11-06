import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/view/transaction/widgets/custom_cliper_shape.dart';
import 'package:money_management_app/view/transaction/widgets/money_status_bar.dart';
import 'package:money_management_app/view/widgets/common_header.dart';
import 'package:money_management_app/view/widgets/empty_lottie.dart';

class TrasactionsScreen extends StatelessWidget {
  const TrasactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
                          ]),
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(Icons.menu_rounded,
                                color: CustomColors.kwhite),
                          ),
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
                const Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: MoneyStatusBar(),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 25, left: 25),
              child: commonHeader('Last Transations'),
            ),
          ),
          GetBuilder<TransactionDbController>(builder: (controller) {
            if (controller.transaction.isEmpty) {
              return emptyLottiePop(
                  messsage: 'No Transaction', screenSize: screenSize);
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final values = controller.transaction[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: CustomColors.containerColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: CustomColors.kblue.withAlpha(100)),
                          boxShadow: [BoxShadow(color: CustomColors.kblue)]),
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: CustomColors.containerColor,
                            radius: 30,
                            child: Text(
                              values.date.toString(),
                              style: TextStyle(color: CustomColors.kblack),
                            ),
                          ),
                          title: Text(
                            '\$ ${values.amount}',
                            style: CustomFuction.style(
                                fontWeight: FontWeight.w600, size: 18),
                          ),
                          subtitle: Text(
                            values.purpose,
                            style: CustomFuction.style(
                                fontWeight: FontWeight.w500, size: 15),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert)),
                        ),
                      )),
                );
              },
              itemCount: controller.transaction.length,
              separatorBuilder: (context, index) => const Divider(),
            );
          })
        ],
      ),
    );
  }
}
