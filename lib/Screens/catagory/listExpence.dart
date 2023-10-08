import 'package:flutter/material.dart';
import 'package:money_managment/db/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';

class ListExpenseCategory extends StatelessWidget {
  const ListExpenseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().ExpenseCAtegoryListLIstner,
        builder:
            (BuildContext context, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final category = newlist[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(category.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}
