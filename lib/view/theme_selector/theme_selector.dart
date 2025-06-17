import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentMode = themeProvider.themeMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Music App Theme')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Choose Theme Mode", style: TextStyle(fontSize: 18)),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: currentMode,
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: currentMode,
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: currentMode,
            onChanged: (value) {
              themeProvider.setTheme(value!);
            },
          ),
          const SizedBox(height: 24),
          const Text("Pick Primary Color", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.primaryColor,
              ),
              onPressed: () {
                _showColorPicker(context, themeProvider);
              },
              child: const Text("Choose Color"),
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context, ThemeProvider themeProvider) {
    Color pickerColor = themeProvider.primaryColor;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Select Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickerColor = color;
            },
            enableAlpha: false,
            labelTypes: const [ColorLabelType.rgb],
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              themeProvider.setPrimaryColor(pickerColor);
              Navigator.of(context).pop();
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }
}
