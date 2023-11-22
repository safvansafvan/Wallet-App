import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';

class SelectDateButton extends StatelessWidget {
  const SelectDateButton({
    super.key,
    required this.screenSize,
    required this.controller,
    required this.color,
  });

  final Size screenSize;
  final GlobelController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '  Select Date',
        style: CustomFuction.style(
            fontWeight: FontWeight.w600, size: 15, color: color),
      ),
      Card(
        elevation: 5,
        child: SizedBox(
          height: screenSize.height * 0.074,
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () async {
              final selectedTempDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now());
              if (selectedTempDate == null) {
                return;
              } else {
                controller.updateDate(selectedTempDate);
              }
            },
            icon: Icon(Icons.calendar_today, color: color),
            label: GetBuilder<GlobelController>(builder: (ctrl) {
              final formattedDate = DateFormat.MMMEd()
                  .format(ctrl.selectedDate ?? DateTime.now());
              return Text(
                ctrl.selectedDate == null ? 'Select Date' : formattedDate,
                style: TextStyle(color: color),
              );
            }),
          ),
        ),
      )
    ]);
  }
}
