import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_e03_todoapp/app_keys.dart';
import '../bloc/products/products_bloc.dart';
import '../repositories/repositories.dart';
import '../model/product.dart';
import '../model/models.dart';
import 'button_default.dart';

part 'bottom_sheet_todo_more.dart';

part 'dialog_add_product.dart';

part 'dialog_edit_product.dart';

part 'dropdown_dialog.dart';

part 'text_field_dialog.dart';

typedef onSaveTap = Function(
  String name,
  Category category,
  int price,
  String desc,
);
typedef onTextFieldSave<T> = Function(T value);
typedef onSelectCategory = Function(Category value);
