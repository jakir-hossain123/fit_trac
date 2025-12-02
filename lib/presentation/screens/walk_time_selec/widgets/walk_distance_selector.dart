import 'package:flutter/material.dart';

class WalkDistanceSelector extends StatefulWidget {
  final int selectedDistance;
  final ValueChanged<int> onDistanceChanged;

  const WalkDistanceSelector({
    super.key,
    required this.selectedDistance,
    required this.onDistanceChanged,
  });

  @override
  State<WalkDistanceSelector> createState() => _WalkDistanceSelectorState();
}

class _WalkDistanceSelectorState extends State<WalkDistanceSelector> {
  late FixedExtentScrollController _scrollController;
  // Options in meters, increasing in steps
  final List<int> _distanceOptions = [
    500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 2000, 3000, 5000, 10000
  ];

  @override
  void initState() {
    super.initState();
    final initialIndex = _distanceOptions.indexOf(widget.selectedDistance);
    _scrollController = FixedExtentScrollController(
        initialItem: initialIndex.clamp(0, _distanceOptions.length - 1)
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          widget.onDistanceChanged(_distanceOptions[index]);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final value = _distanceOptions[index];
            final isSelected = value == widget.selectedDistance;

            return Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: isSelected ? 28 : 20,
                  color: isSelected ? Colors.white : Colors.white38,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          childCount: _distanceOptions.length,
        ),
      ),
    );
  }
}