import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/models/category/category_model.dart';

const CATEGORY_DB_NAME = "category database";

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCAtegories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCAtegoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> ExpenseCAtegoryListLIstner =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categorydb.put(value.id, value);
    refressUI();
  }

  @override
  Future<List<CategoryModel>> getCAtegories() async {
    final _categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categorydb.values.toList();
  }

  Future<void> refressUI() async {
    final _allcategories = await getCAtegories();
    incomeCAtegoryListListner.value.clear();
    ExpenseCAtegoryListLIstner.value.clear();
    await Future.forEach(
      _allcategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCAtegoryListListner.value.add(category);
        } else {
          ExpenseCAtegoryListLIstner.value.add(category);
        }
      },
    );
    incomeCAtegoryListListner.notifyListeners();
    ExpenseCAtegoryListLIstner.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    // TODO: implement deleteCategory

    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDb.delete(categoryId);
    refressUI();
  }
}
