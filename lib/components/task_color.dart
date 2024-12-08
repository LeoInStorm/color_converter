import 'package:color_converter/data/task_color_dao.dart';
import 'package:flutter/material.dart';

class TaskColor extends StatefulWidget {
  final Color? selectedColor;
  final String hexValue;
  final String rgbValue;
  final String hsvValue;
  final String hslValue;
  final VoidCallback? onDelete;
  const TaskColor({
    this.selectedColor,
    required this.hexValue,
    required this.rgbValue,
    required this.hsvValue,
    required this.hslValue,
    this.onDelete,
    super.key,
  });

  @override
  State<TaskColor> createState() => _TaskColorState();
}

class _TaskColorState extends State<TaskColor> {
  Color hexToColor(String hexValue) {
    hexValue = hexValue.replaceAll('HEX: #', '');
    if (hexValue.length == 6) {
      hexValue = 'FF$hexValue';
    }
    return Color(int.parse(hexValue, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(249, 255, 255, 255),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2),
                ),
                height: 150,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 290.0),
                      child: SizedBox(
                        height: 30,
                        child: IconButton(
                          onPressed: () async {
                            await TaskColorDao().delete(widget.hexValue);
                            widget.onDelete!();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: hexToColor(widget.hexValue),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(width: 2),
                          ),
                          width: 90,
                          height: 90,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.hexValue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.rgbValue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.hsvValue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.hslValue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
