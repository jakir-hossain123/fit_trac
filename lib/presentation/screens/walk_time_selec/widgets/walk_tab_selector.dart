import 'package:flutter/material.dart';

class WalkTabSelector extends StatelessWidget {
  final bool isTimeSelected;
  final ValueChanged<bool> onTabSelected;

  const WalkTabSelector({
    super.key,
    required this.isTimeSelected,
    required this.onTabSelected,
  });


  Widget _buildTabItem(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // Use transparent color if not selected
            color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem(
            "Time",
            isTimeSelected,
                () => onTabSelected(true),
          ),
          _buildTabItem(
            "Distance",
            !isTimeSelected,
                () => onTabSelected(false),
          ),
        ],
      ),
    );
  }
}