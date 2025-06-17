import 'package:flutter/material.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  final List<Color> colorOptions = const [
    Color(0xFF6750A4),
    Color(0xFF386641),
    Color(0xFFEF476F),
    Color(0xFFFFB703),
    Color(0xFF219EBC),
    Color(0xFF6A994E),
    Color(0xFF264653),
    Color(0xFF8E24AA),
    Color(0xFF1D3557),
    Color(0xFFD62828),
    Color(0xFFBBDEFB), // Light Blue
    Color(0xFFFFCDD2), // Light Red/Pink
    Color(0xFFC8E6C9), // Light Green
    Color(0xFFFFF9C4), // Light Yellow
    Color(0xFFFFE0B2), // Light Orange
    Color(0xFFD1C4E9), // Lavender
    Color(0xFFB2EBF2), // Cyan
    Color(0xFFF8BBD0), // Rose
    Color(0xFFE1BEE7), // Soft Purple
    Color(0xFFFFF3E0), // Cream
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final selectedColor = themeProvider.primaryColor;
    final selectedMode = themeProvider.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Theme Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Theme Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Custom Segmented Button UI
            Row(
              children: ThemeMode.values.map((mode) {
                final isSelected = mode == selectedMode;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => themeProvider.setTheme(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          mode.name[0].toUpperCase() + mode.name.substring(1),
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            const Text(
              'Pick a Primary Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Custom Color Bubbles
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: colorOptions.map((color) {
                final isSelected = color.value == selectedColor.value;
                return GestureDetector(
                  onTap: () => themeProvider.setPrimaryColor(color),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 3,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            const Spacer(),
            Center(
              child: Text(
                'Changes apply instantly',
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
