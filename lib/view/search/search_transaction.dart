import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/search_controller.dart';
import 'package:money_management_app/view/search/widget/search_box.dart';
import 'package:money_management_app/view/transaction/widgets/transaction_field_widget.dart';
import 'package:money_management_app/view/widgets/empty_lottie.dart';

class SearchTransaction extends StatefulWidget {
  const SearchTransaction({super.key});

  @override
  State<SearchTransaction> createState() => _SearchTransactionState();
}

class _SearchTransactionState extends State<SearchTransaction> {
  @override
  void initState() {
    final searchController = Get.put(TransactionSearchController());
    searchController.initialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: CustomColors.kblack,
            )),
        centerTitle: true,
        title: Text(
          ' Transactions',
          style: CustomFuction.style(
              fontWeight: FontWeight.w600,
              size: 17,
              color: CustomColors.kblack),
        ),
        actions: [
          IconButton(
              onPressed: () async {},
              icon: Icon(Icons.filter_list_rounded, color: CustomColors.kblack))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SearchBox(),
          ),
          Expanded(child: GetBuilder<TransactionSearchController>(
              builder: (searchController) {
            if (searchController.searchList.isEmpty) {
              return emptyLottiePop(
                  messsage: 'No Transaction', screenSize: screenSize);
            }
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchController.searchList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final values = searchController.searchList[index];
                String date = DateFormat.MMMd().format(values.date);
                return TransactionFieldWidget(
                    screenSize: screenSize, values: values, date: date);
              },
            );
          }))
        ],
      ),
    );
  }
}
