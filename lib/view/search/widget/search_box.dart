import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/search_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(TransactionSearchController());

    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CustomColors.kblack)),
      child: TextField(
        controller: searchController.searchController,
        onChanged: (value) {
          searchController.searchTransaction(value);
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search...',
            suffixIcon: IconButton(
                onPressed: () {
                  searchController.clearFieldText();
                },
                icon: const Icon(Icons.close)),
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}
