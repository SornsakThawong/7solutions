import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seven_solutions/src/feature/fibonacci/controllers/fibonacci_controller.dart';
import 'package:seven_solutions/src/feature/fibonacci/models/fibonacci_model.dart';

class FibonacciScreen extends StatelessWidget {
  FibonacciScreen({super.key});
  final _ctrl = Get.put(FibonacciController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Fibonacci"),
        ),
        body: Obx(
          () => ScrollablePositionedList.separated(
              itemScrollController: _ctrl.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: _ctrl.fibonaccis.length,
              itemBuilder: (context, index) {
                FibonacciModel item = _ctrl.fibonaccis[index];
                bool notShowItem = _ctrl.addedFibonaccis
                    .where((element) => element.id == item.id)
                    .isNotEmpty;

                return notShowItem
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => _ctrl.onAddFibonacci(item),
                        child: Container(
                          height: 50,
                          color: _ctrl.checkItemIsFocus(item)
                              ? Colors.red
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
                      );
              },
              separatorBuilder: (context, index) {
                FibonacciModel item = _ctrl.fibonaccis[index];
                bool notShowItem = _ctrl.addedFibonaccis
                    .where((element) => element.id == item.id)
                    .isNotEmpty;
                return notShowItem
                    ? const SizedBox()
                    : const Divider(
                        height: 1,
                      );
              }),
        ));
  }
}
