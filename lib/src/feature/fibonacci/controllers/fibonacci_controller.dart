import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_rx/get_rx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seven_solutions/src/core/base/base_controller.dart';
import 'package:seven_solutions/src/feature/fibonacci/models/fibonacci_model.dart';
import 'package:seven_solutions/src/feature/fibonacci/widgets/fibonacci_bottom_sheet_widget.dart';

class FibonacciController extends BaseController {
  final ItemScrollController _scrollController = ItemScrollController();
  ItemScrollController get scrollController => _scrollController;
  final ItemScrollController _scrollController_2 = ItemScrollController();
  ItemScrollController get scrollController_2 => _scrollController_2;

  final _fibonaccis = <FibonacciModel>[].obs;
  List<FibonacciModel> get fibonaccis => _fibonaccis;

  final _addedFibonaccis = <FibonacciModel>[].obs;
  List<FibonacciModel> get addedFibonaccis => _addedFibonaccis;

  final _itemIsFocus = Rxn<FibonacciModel>();
  FibonacciModel? get itemIsFocus => _itemIsFocus.value;

  onAddFibonacci(FibonacciModel item) {
    _addedFibonaccis.add(item);
    _itemIsFocus.value = item;
    _onRefresh();
    g.Get.bottomSheet(
        FibonacciBottomSheetWidget(
          fibonacciItem: item,
        ),
        backgroundColor: Colors.white);

    int getIndex = _fibonaccis
        .indexWhere((element) => element.id == item.id);
    _scrollController_2.scrollTo(
        index: getIndex,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }

  onRemoveFibonacci(FibonacciModel item) {
    _addedFibonaccis.removeWhere(
      (element) => element.id == item.id,
    );
    _itemIsFocus.value = item;
    _onRefresh();
    g.Get.back();
    int getIndex = _fibonaccis
        .indexWhere((element) => element.id == item.id);
    _scrollController.scrollTo(
        index: getIndex,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }

  bool checkItemIsFocus(FibonacciModel item) {
    if (itemIsFocus == null) return false;
    if (itemIsFocus!.id == item.id) return true;
    return false;
  }

  IconData getIconByType(FibonacciModel item) {
    switch (item.type) {
      case "C":
        return Icons.circle;
      case "S":
        return Icons.square_outlined;
      case "X":
        return Icons.close;
      default:
        return Icons.numbers;
    }
  }

  _onRefresh() {
    _fibonaccis.refresh();
    _addedFibonaccis.refresh();
  }

  _generateFibonacci() {
    for (int i = 0; i < 40; i++) {
      // log(fibonacci(i));
      FibonacciModel item = FibonacciModel(
          id: i + 1, type: getRandomString(1), fibonacci: _fibonacci(i));
      _fibonaccis.add(item);
    }
  }

  int _fibonacci(int n) {
    if (n == 0 || n == 1) {
      return n;
    }
    return _fibonacci(n - 1) + _fibonacci(n - 2);
  }

  final String _chars = 'CSX';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void onInit() {
    _generateFibonacci();
    super.onInit();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    // _scrollController_2.dispose();
    super.dispose();
  }
}


// 0 : 0 ==> C
// 1 : 1 ==> S
// 2 : 1 ==> S
// 3 : 2 ==> X
// 4 : 3 ==> C
// 5 : 5 ==> X
// 6 : 8 ==> X
// 7 : 13 ==> S
// 8 : 21 ==> C
// 9 : 34 ==> S
// 10 : 55 ==> S
// 11 : 89 ==> X
// 12 : 144 ==> C
// 13 : 233 ==> X


// ================== F/B ================== ~0.618
// 0 : 0 ==> C
// 4 : 3 ==> C
// 8 : 21 ==> C
// 12 : 144 ==> C

// ================== B/F ================== ~1.618
// 1 : 1 ==> S
// 2 : 1 ==> S
// 7 : 13 ==> S
// 9 : 34 ==> S
// 10 : 55 ==> S

// ================== 2F/B ================== ~0.382
// 3 : 2 ==> X
// 5 : 5 ==> X
// 6 : 8 ==> X
// 11 : 89 ==> X
// 13 : 233 ==> X