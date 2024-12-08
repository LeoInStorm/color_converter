import 'package:color_converter/components/task_color.dart';
import 'package:color_converter/data/task_color_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;

class ConverterScreen extends StatefulWidget {
  final BuildContext colorContent;
  const ConverterScreen({
    required this.colorContent,
    super.key,
  });

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<ConverterScreen> {
  Color selectedColor =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  String hexValue = '';
  String rgbValue = '';
  String hsvValue = '';
  String hslValue = '';

  TextEditingController hexController = TextEditingController();
  TextEditingController rgbController = TextEditingController();
  TextEditingController hsvController = TextEditingController();
  TextEditingController hslController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateColorValues(selectedColor);
  }

  void updateFromHex(String hex) {
    try {
      hex = hex.replaceAll("HEX: #", "").trim();
      Color color = Color(int.parse(hex, radix: 16) + 0xFF000000);
      updateColorValues(color); 
    } catch (e) {
      print("Formato inválido: $e");
    }
  }

  void updateFromRgb(String rgb) {
    try {
      rgb = rgb.replaceAll("RGB: (", "").replaceAll(")", "").trim();
      List<String> values = rgb.split(", ");
      int r = int.parse(values[0]);
      int g = int.parse(values[1]);
      int b = int.parse(values[2]);
      Color color = Color.fromRGBO(r, g, b, 1.0);
      updateColorValues(color);
    } catch (e) {
      print("Formato inválido: $e");
    }
  }

  void updateFromHsv(String hsv) {
    try {
      hsv = hsv.replaceAll("HSV: (", "").replaceAll("%)", "").trim();
      List<String> values = hsv.split(", ");
      double h = double.parse(values[0].replaceAll("°", ""));
      double s = double.parse(values[1]) / 100.0;
      double v = double.parse(values[2]) / 100.0;
      HSVColor hsvColor = HSVColor.fromAHSV(1.0, h, s, v);
      updateColorValues(hsvColor.toColor());
    } catch (e) {
      print("Formato inválido: $e");
    }
  }

  void updateFromHsl(String hsl) {
    try {
      hsl = hsl.replaceAll("HSL: (", "").replaceAll("%)", "").trim();
      List<String> values = hsl.split(", ");
      double h = double.parse(values[0].replaceAll("°", ""));
      double s = double.parse(values[1]) / 100.0;
      double l = double.parse(values[2]) / 100.0;
      HSLColor hslColor = HSLColor.fromAHSL(1.0, h, s, l);
      updateColorValues(hslColor.toColor());
    } catch (e) {
      print("Formato inválido: $e");
    }
  }

  void updateColorValues(Color color) {
    setState(() {
      selectedColor = color;
      final hsv = HSVColor.fromColor(color);
      final hsl = HSLColor.fromColor(color);

      hexValue =
          "HEX: #${color.value.toRadixString(16).substring(2).toUpperCase()}";

      rgbValue = "RGB: (${color.red}, ${color.green}, ${color.blue})";

      hsvValue = "HSV: (${hsv.hue.toStringAsFixed(0)}°, "
          "${(hsv.saturation * 100).toStringAsFixed(0)}%, "
          "${(hsv.value * 100).toStringAsFixed(0)}%)";

      hslValue = "HSL: (${hsl.hue.toStringAsFixed(0)}°, "
          "${(hsl.saturation * 100).toStringAsFixed(0)}%, "
          "${(hsl.lightness * 100).toStringAsFixed(0)}%)";

      hexController.text = hexValue;
      rgbController.text = rgbValue;
      hsvController.text = hsvValue;
      hslController.text = hslValue;
    });
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escolha uma cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                updateColorValues(color);
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversor"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 650,
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    onTap: showColorPicker,
                    child: Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: hexController,
                        onChanged: updateFromHex,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: rgbController,
                        onChanged: updateFromRgb,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: hsvController,
                        onChanged: updateFromHsv,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: hslController,
                        onChanged: updateFromHsl,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (hexValue.isNotEmpty) {
                      TaskColorDao().save(TaskColor(
                        selectedColor: selectedColor,
                        hexValue: hexValue,
                        rgbValue: rgbValue,
                        hsvValue: hsvValue,
                        hslValue: hslValue,
                      ));
                    }
                    Future.delayed(const Duration(milliseconds: 50), () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      });
                    });
                  },
                  child: const Text("Adicionar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
