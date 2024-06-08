import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/presentation/controllers/search_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<TransactionSearchController>();

    return TextField(
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
          focusedBorder: AppTheme.borderStyle,
          enabledBorder: AppTheme.borderStyle),
    );
  }
}
