import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161B1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child:  Image.asset(
                        "assets/images/user.png",
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                      SizedBox(width:10 ,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Good Morning!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            "John Doe",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(width: 124,),

                      Icon(Icons.notifications_none,size: 30,color: Colors.teal.shade800,)
                    ],
                  ),

                ],
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2429),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      children: const [
                        Text(
                          "Daily Goal",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),const SizedBox(width: 11,),
                        Text(
                          "30 min workout",
                          style: TextStyle(color: Colors.teal, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: LinearProgressIndicator(
                          value: 0.8,
                          backgroundColor: Colors.white10,
                          color: Colors.blue.shade700,
                          minHeight: 35,
                        ),
                      ),

                        Center(child: Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text("80%",style: TextStyle(fontWeight: FontWeight.bold),),
                        )),
        ]
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: const Text("Quick Start",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2429),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Calories",
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "+6%",
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          const Text(
                            "843 Kcal",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2429),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Time",
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "-8%",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          const Text(
                            "3h 29min",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 25),

              const Text(
                "Start Exercise",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 14,
                runSpacing: 17,
                children: [

                  _buildExerciseButton("Freehand", "assets/icons/Freehand.svg"),
                  _buildExerciseButton("Walk", "assets/icons/Freehand.svg"),

                  _buildExerciseButton("Run", "assets/icons/step.svg"),

                  _buildExerciseButton("Swim", "assets/icons/Swim.svg"),

                  _buildExerciseButton("Cycling", "assets/icons/Cycling.svg"),

                  _buildExerciseButton("Yoga", "assets/icons/Yoga.svg"),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Weekly Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2429),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset("assets/images/chart.png"),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E2429),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String change, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2429),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(change, style: TextStyle(color: color, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseButton(String label, String iconPath) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 18, color: Colors.tealAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
