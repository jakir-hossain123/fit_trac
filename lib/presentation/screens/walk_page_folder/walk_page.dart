import 'package:flutter/material.dart';

class WalkScreen extends StatefulWidget {
  const WalkScreen({super.key});

  @override
  State<WalkScreen> createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  int selectedMinute = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1418),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1418),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "Let's Walk!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------------- START 10-MIN BUTTON ----------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1dbf73),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Start 10-min Walk",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Instant warm-up walk",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------------- TAB SWITCHER ----------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2B33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F7C66),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Time",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: const Text(
                              "Distance",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Walk Duration",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Scroll to choose minutes",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),

                  const SizedBox(height: 14),

                  // ---------------------- MINUTE SCROLLER ----------------------
                  SizedBox(
                    height: 80,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedMinute = index + 8;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final value = index + 8;
                          final isSelected = value == selectedMinute;

                          return Center(
                            child: Text(
                              value.toString(),
                              style: TextStyle(
                                fontSize: isSelected ? 28 : 20,
                                color:
                                isSelected ? Colors.white : Colors.white38,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        childCount: 6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "You'll get a notification when you're done.",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),

                  const SizedBox(height: 18),

                  // ---------------------- START TIMED WALK BUTTON ----------------------
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1dbf73),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Start Timed Walk",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------------- TODAY'S ACTIVITY ----------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text(
                        "Today's Activity",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.8,
                      minHeight: 10,
                      backgroundColor: Colors.white10,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("1.6 km", style: TextStyle(color: Colors.white70)),
                      Text("1389 steps",
                          style: TextStyle(color: Colors.white70)),
                      Text("5 min", style: TextStyle(color: Colors.white70)),
                      Text("120 kcal", style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------------- DID YOU KNOW ----------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF122027),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Did you know?",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Walking daily reduces stress hormones by up to 20%.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
