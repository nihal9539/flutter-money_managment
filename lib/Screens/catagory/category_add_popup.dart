import 'package:flutter/material.dart';
import 'package:money_managment/db/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';

ValueNotifier<CategoryType> SelectedCAtegoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCAtrgoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: Text("Add category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Category Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = SelectedCAtegoryNotifier.value;
                final _category = CategoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type,
                );
                CategoryDb().insertCategory(_category);
                Navigator.of(ctx).pop();
                print('5');
              },
              child: const Text('Add'),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: SelectedCAtegoryNotifier,
          builder: (BuildContext context, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: SelectedCAtegoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                SelectedCAtegoryNotifier.value = value;
                SelectedCAtegoryNotifier.notifyListeners();
              },
            );
          }),
      Text(title)
    ]);
  }
}
