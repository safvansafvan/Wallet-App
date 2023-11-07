import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/widgets/drawer/widget/drawer_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: CustomColors.commonClr,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Scaffold.of(context).closeDrawer(),
                      icon: Icon(
                        Icons.close,
                        color: CustomColors.kwhite,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 38,
                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                  ),
                  CustomHeights.heightFive(context),
                  Text(
                    'Unknown',
                    style: CustomFuction.style(
                        fontWeight: FontWeight.w700,
                        size: 16,
                        color: CustomColors.kwhite),
                  ),
                  CustomHeights.heightFive(context),
                  Text(
                    'Unknown',
                    style: CustomFuction.style(
                        fontWeight: FontWeight.w500,
                        size: 16,
                        color: CustomColors.kwhite),
                  )
                ],
              ),
            ),
          ),
          CustomHeights.commonheight(context),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const DrawerTileWidget(icon: Icons.share, text: 'Share'),
                CustomHeights.heightFive(context),
                const DrawerTileWidget(
                    icon: Icons.feedback_outlined, text: 'Feedback'),
                CustomHeights.heightFive(context),
                const DrawerTileWidget(icon: Icons.settings, text: 'Settings'),
                CustomHeights.heightFive(context),
                const DrawerTileWidget(icon: Icons.clear, text: 'Clear Datas')
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'Version',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w500,
                    size: 16,
                    color: CustomColors.kblack),
              ),
              Text(
                '1.0',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w500,
                    size: 15,
                    color: CustomColors.kblack),
              ),
              CustomHeights.heightFive(context)
            ],
          )
        ],
      ),
    );
  }
}
