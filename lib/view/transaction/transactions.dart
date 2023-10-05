import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/transaction/widgets/custom_cliper_shape.dart';
import 'package:money_management_app/view/transaction/widgets/money_status_bar.dart';
import 'package:money_management_app/view/widgets/common_header.dart';

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
        Container(
          margin: const EdgeInsets.only(top: 25, left: 25),
          child: commonHeader('Last Transations'),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: CustomColors.containerColor,
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: CustomColors.kblue.withAlpha(100)),
                      boxShadow: [BoxShadow(color: CustomColors.kblue)]),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: CustomColors.containerColor,
                        radius: 30,
                        child: Text(
                          '12,sep',
                          style: TextStyle(color: CustomColors.kblack),
                        ),
                      ),
                      title: Text(
                        '\$1000',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w600, size: 18),
                      ),
                      subtitle: Text(
                        'Birthday party',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w500, size: 15),
                      ),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_vert)),
                    ),
                  )),
            );
          },
          itemCount: 10,
        )
      ],
    );
  }
}
