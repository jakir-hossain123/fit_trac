import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes.dart';

class FreeHandExcerciseScreen extends StatefulWidget {
  const FreeHandExcerciseScreen({super.key});

  @override
  State<FreeHandExcerciseScreen> createState() => _FreeHandExcerciseScreenState();
}

class _FreeHandExcerciseScreenState extends State<FreeHandExcerciseScreen> {
  bool _allOfWorkoutOgTheDay =true;
  bool _bodyAndCardio = true;
  bool _lowerBody =true;
  bool _uperBody = true;
  bool _coreAndAbdomen = true;
  bool _isWorkoutStart = false;
  TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        _searchFocusNode.unfocus();
      },
      child: Scaffold( //color - //161B1F //343D45
        backgroundColor: Color(0xFF161B1F),
          appBar: AppBar(
            backgroundColor:Color(0xFF20262B),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(onPressed:() {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            actions: [IconButton(onPressed: (){
              Navigator.pushNamed(context, AppRoutes.pushUp);
            }, icon: Icon(Icons.navigate_next,size: 39,))],
            title: Text("Freehand  Exercises",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            centerTitle: true,
            scrolledUnderElevation: 0,
            elevation: 0,

          ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                TextField(
                  focusNode: _searchFocusNode,
                  controller: searchController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Search for an exercise...",
                    hintStyle: const TextStyle(color: Colors.white24),
                    suffixIcon: const Icon(Icons.search, color: Colors.white24,size: 28,),
                    prefixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.white24),
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                    )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),


                    enabledBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white24, width: 1.0),
                    ),


                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white24, width: 1.0),
                    ),


                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Workout of the day',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Complete workout plan for the whole body',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _allOfWorkoutOgTheDay = !_allOfWorkoutOgTheDay;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        _allOfWorkoutOgTheDay ? 'All' : 'Hide',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 20),

                if (_allOfWorkoutOgTheDay)Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/exercise.png',
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Body Blitz',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Strength & Cardio Mix  •  20 min',
                            style: TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, color: Colors.blue, size: 20),
                              SizedBox(width: 4),
                              const Text(
                                '3 sets of 10-12 reps',
                                style: TextStyle(color: Colors.white54, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.local_fire_department_outlined, color: Colors.blue, size: 20),
                              SizedBox(width: 4),
                             const Text(
                                'target: Chest, triceps, shoulder',
                                style: TextStyle(color: Colors.white54, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (!_isWorkoutStart)Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                child: SizedBox(
                                  height: 22,
                                  width: double.infinity,
                                  child: LinearProgressIndicator(
                                    borderRadius: BorderRadius.circular(10),
                                    value: 0.8,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                    backgroundColor: Colors.white30,
                                  ),
                                ),
                              ),
                              const Text(
                                '80% complete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _isWorkoutStart = !_isWorkoutStart;
                                });
                              },
                              icon: Icon(Icons.play_arrow_outlined),
                              label: Text(
                                _isWorkoutStart ? "Start Workout" : "Continue Workout",

                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1E6E6D),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Body and Cardio',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                           'Develop powerful arms,chest & back',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _bodyAndCardio = !_bodyAndCardio;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child:  Text(
                        _bodyAndCardio ? 'All' : 'Hide',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],
                ),

                const SizedBox(height: 15),

                if (_bodyAndCardio)Column(children: [
                  buildExerciseTile("Burpee", "The ultimate full-body exercise", "25 min"),
                  buildExerciseTile("Mountain Climbers", "Moving plank for core, legs & cardio", "15 min"),
                  buildExerciseTile("Jumping Jacks", "Classic total-body cardio", "15 min"),

                ],
                ),

                const SizedBox(height:  32,),




                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lower Body',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Develop powerful arms,chest & back',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _lowerBody = ! _lowerBody;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child:  Text(
                        _lowerBody ? 'All' : 'Hide',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                if(_lowerBody)Column(children: [
                  buildExerciseTile("Wall sit", "squat", "10 min"),
                  buildExerciseTile("Box squat", "squat", "10 min"),
                  buildExerciseTile("Supported Lunge", "Lung", "10 min"),



                ],
                ),
                 SizedBox(height:  32,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upper Body',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Develop powerful arms,chest & back',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _uperBody = !_uperBody;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child:  Text(
                        _uperBody ? 'All' : 'Hide',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],
                ),

                const SizedBox(height: 15,),


               if(_uperBody)Column(
                 children: [
                 buildExerciseTile("Wall Push-up", "Horizontal Push", "10 min"),
                 buildExerciseTile("Incline Push-up", "Horizontal Push", "10 min"),
                 buildExerciseTile("Bear Plank Shoulder Taps", "Vertical Push", "10 min"),


               ],
               ),

                const SizedBox(height:  32,),




                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Core & Abdomen',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Develop powerful arms,chest & back',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _coreAndAbdomen = !_coreAndAbdomen;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child:  Text(
                        _coreAndAbdomen ? 'All' : 'Hide',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],
                ),

                const SizedBox(height: 15,),
            if(_coreAndAbdomen)Column(children: [
              buildExerciseTile("Knee plank", "Anti-Extension", "10 min"),
              buildExerciseTile("Sead Bug", "Anti-Extension", "10 min"),
              buildExerciseTile("Crunch", "Flexion", "10 min"),

            ],
            ),
                const SizedBox(height: 15,),
                SvgPicture.asset('assets/icons/card2.svg'),
                const SizedBox(height: 37,)

              ]

            ),
          ),
        ),


          ),
    );
  }
}





Widget buildExerciseTile(String title, String subtitle, String time) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF20262B),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/TopHeader.png',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
        ),
        // ডান পাশের প্লে বাটন
        Icon(Icons.play_circle_outline_rounded, color: Colors.teal.shade400, size: 30),
      ],
    ),
  );
}
