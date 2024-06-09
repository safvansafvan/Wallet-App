import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/presentation/controllers/search_controller.dart';
import 'package:money_management_app/presentation/views/search/widget/search_box.dart';
import 'package:money_management_app/presentation/views/transaction/widgets/transaction_field_widget.dart';
import 'package:money_management_app/presentation/widgets/empty_lottie.dart';

class SearchTransaction extends StatefulWidget {
  const SearchTransaction({super.key});

  @override
  State<SearchTransaction> createState() => _SearchTransactionState();
}

class _SearchTransactionState extends State<SearchTransaction> {
  @override
  void initState() {
    final searchController = Get.find<TransactionSearchController>();
    searchController.initialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Transactions'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SearchBox(),
          ),
          Expanded(
            child: GetBuilder<TransactionSearchController>(
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
              },
            ),
          )
        ],
      ),
    );
  }
}
