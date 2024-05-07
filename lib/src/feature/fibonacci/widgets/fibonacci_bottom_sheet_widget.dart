import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seven_solutions/src/feature/fibonacci/controllers/fibonacci_controller.dart';
import 'package:seven_solutions/src/feature/fibonacci/models/fibonacci_model.dart';

class FibonacciBottomSheetWidget extends StatelessWidget {
  FibonacciBottomSheetWidget({super.key, required this.fibonacciItem});
  final FibonacciModel fibonacciItem;
  final _ctrl = Get.find<FibonacciController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollablePositionedList.separated(
              shrinkWrap: true,
              itemScrollController: _ctrl.scrollController_2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: _ctrl.fibonaccis.length,
              itemBuilder: (context, index) {
                FibonacciModel item = _ctrl.fibonaccis[index];
                bool showItem = _ctrl.addedFibonaccis
                    .where((element) =>
                        element.id == item.id &&
                        element.type == fibonacciItem.type)
                    .isNotEmpty;
                return showItem
                    ? GestureDetector(
                        onTap: () => _ctrl.onRemoveFibonacci(item),
                        child: Container(
                          height: 50,
                          color: _ctrl.checkItemIsFocus(item)
                              ? Colors.green
                              : Colors.white,
                          child: Row(
                            children: [
                              Text(
                                "index = $index :       ${item.fibonacci}           ${item.type}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Icon(_ctrl.getIconByType(item))
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
              separatorBuilder: (context, index) {
                FibonacciModel item = _ctrl.fibonaccis[index];
                bool showItem = _ctrl.addedFibonaccis
                    .where((element) =>
                        element.id == item.id &&
                        element.type == item.type)
                    .isNotEmpty;
                return showItem
                    ? const Divider(
                        height: 1,
                      )
                    : const SizedBox();
              }),
        ),
      ],
    );
  }
}
