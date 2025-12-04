import 'package:flutter/material.dart';

class RunDistanceSelector extends StatefulWidget {
  final int selectedDistance;
  final ValueChanged<int> onDistanceChanged;

  const RunDistanceSelector({
    super.key,
    required this.selectedDistance,
    required this.onDistanceChanged,
  });

  @override
  State<RunDistanceSelector> createState() => _RunDistanceSelectorState();
}

class _RunDistanceSelectorState extends State<RunDistanceSelector> {
  late FixedExtentScrollController _scrollController;

  final int minDistance = 200;
  final int maxDistance = 10000;
  final int step = 100;

  late final int totalItems = (maxDistance - minDistance) ~/ step + 1;

  @override
  void initState() {
    super.initState();
    final initialIndex = (widget.selectedDistance - minDistance) ~/ step;

    _scrollController = FixedExtentScrollController(
      initialItem: initialIndex.clamp(0, totalItems - 1),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getDisplayValue(int value) {
    if (value >= 1000 && value % 100 == 0) {
      double km = value / 1000;
      return '${km.toStringAsFixed(km % 1 == 0 ? 0 : 1)} Km';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        controller: _scrollController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          final selectedValue = minDistance + index * step;
          widget.onDistanceChanged(selectedValue);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final value = minDistance + index * step;
            final isSelected = value == widget.selectedDistance;

            return Center(
              child: Text(
                _getDisplayValue(value),
                style: TextStyle(
                  fontSize: isSelected ? 28 : 20,
                  color: isSelected ? Colors.white : Colors.white38,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          childCount: totalItems,
        ),
      ),
    );
  }
}
