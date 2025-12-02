import 'package:flutter/material.dart';

class WalkDurationSelector extends StatefulWidget {
  final int selectedMinute;
  final ValueChanged<int> onMinuteChanged;

  const WalkDurationSelector({
    super.key,
    required this.selectedMinute,
    required this.onMinuteChanged,
  });

  @override
  State<WalkDurationSelector> createState() => _WalkDurationSelectorState();
}

class _WalkDurationSelectorState extends State<WalkDurationSelector> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.selectedMinute - 1;
    _scrollController = FixedExtentScrollController(
        initialItem: initialIndex.clamp(0, 15)
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
          widget.onMinuteChanged(index + 1);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final value = index + 1;
            final isSelected = value == widget.selectedMinute;

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
          childCount: 16,
        ),
      ),
    );
  }
}