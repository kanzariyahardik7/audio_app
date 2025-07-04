import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final selectedColor = themeProvider.primaryColor;
    final selectedMode = themeProvider.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Theme Settings'),
        centerTitle: true,
        scrolledUnderElevation: 0,
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MyColors.colorOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Adjust for your layout
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 80 / 50, // Match your original size
              ),
              itemBuilder: (context, index) {
                final color = MyColors.colorOptions[index];
                final isSelected = color.value == selectedColor.value;

                return GestureDetector(
                  onTap: () => themeProvider.setPrimaryColor(color),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: MyColors.white,
                            size: 35,
                          )
                        : null,
                  ),
                );
              },
            ),

            const Spacer(),
            Center(
              child: Text(
                'Changes apply instantly',
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
