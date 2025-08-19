import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:my_audio_app/resources/constant.dart';

class AIResponseWidget extends StatelessWidget {
  final String aiResponse;

  const AIResponseWidget({super.key, required this.aiResponse});

  @override
  Widget build(BuildContext context) {
    // Extract JSON code block (chart data)
    final jsonRegex = RegExp(r'```json([\s\S]*?)```', multiLine: true);
    final match = jsonRegex.firstMatch(aiResponse);
    Map<String, dynamic>? chartData;

    String markdownText = aiResponse;

    if (match != null) {
      final jsonString = match.group(1)!.trim();
      try {
        chartData = jsonDecode(jsonString);
      } catch (_) {
        chartData = null;
      }
      markdownText = aiResponse.replaceFirst(jsonRegex, '');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "User Prompt Example",
              style: TextStyle(
                color: MyColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        // Markdown rendering
        buildMarkdown(context),
        const SizedBox(height: 20),
        // Chart rendering
        if (chartData != null) buildChart(chartData),
      ],
    );
  }

  Widget buildMarkdown(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Choose config based on theme
    final baseConfig = isDark
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;

    return MarkdownWidget(
      data: aiResponse,
      shrinkWrap: true,

      config: baseConfig.copy(
        configs: [
          (isDark ? PreConfig.darkConfig : PreConfig()).copy(
            wrapper: codeWrapper,
          ),
        ],
      ),
    );
  }

  Widget codeWrapper(Widget child, String text, String language) {
    return CodeWrapperWidget(child, text, language);
  }

  Widget buildChart(Map<String, dynamic> chartData) {
    final labels = List<String>.from(chartData['labels']);
    final keys = chartData.keys.where((k) => k != 'labels').toList();

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.grey.withOpacity(0.15), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < labels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        labels[value.toInt()],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          barGroups: List.generate(labels.length, (i) {
            return BarChartGroupData(
              x: i,
              barsSpace: 4,
              barRods: List.generate(keys.length, (j) {
                final dataset = List<num>.from(chartData[keys[j]]);
                return BarChartRodData(
                  toY: dataset[i].toDouble(),
                  color: j == 0
                      ? Colors.blueAccent.withOpacity(0.7)
                      : Colors.orangeAccent.withOpacity(0.7),

                  width: 2,
                );
              }),
            );
          }),
          groupsSpace: 12,
        ),
      ),
    );
  }
}

class TestMarkdown extends StatefulWidget {
  const TestMarkdown({super.key});

  @override
  State<TestMarkdown> createState() => _TestMarkdownState();
}

class _TestMarkdownState extends State<TestMarkdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat Dynamic UI"),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AIResponseWidget(aiResponse: aiResponse),
          AIResponseWidget(aiResponse: weatherReport),
          AIResponseWidget(aiResponse: fitnessReport),
          AIResponseWidget(aiResponse: financeReport),
          AIResponseWidget(aiResponse: bitcoinVsEtherium),
          AIResponseWidget(aiResponse: bitcoinDetails),
          AIResponseWidget(aiResponse: mathSolution),
        ],
      ),
    );
  }
}

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;
  final String language;

  const CodeWrapperWidget(this.child, this.text, this.language, {super.key});

  @override
  State<CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<CodeWrapperWidget> {
  late Widget _switchWidget;
  bool hasCopied = false;

  @override
  void initState() {
    super.initState();
    _switchWidget = Icon(Icons.copy_rounded, key: UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.language.isNotEmpty)
                  SelectionContainer.disabled(
                    child: Container(
                      margin: EdgeInsets.only(right: 2),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 0.5,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      child: Text(widget.language),
                    ),
                  ),
                InkWell(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: _switchWidget,
                  ),
                  onTap: () async {
                    if (hasCopied) return;
                    await Clipboard.setData(ClipboardData(text: widget.text));
                    _switchWidget = Icon(Icons.check, key: UniqueKey());
                    refresh();
                    Future.delayed(Duration(seconds: 2), () {
                      hasCopied = false;
                      _switchWidget = Icon(
                        Icons.copy_rounded,
                        key: UniqueKey(),
                      );
                      refresh();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}
