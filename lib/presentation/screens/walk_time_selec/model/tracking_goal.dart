enum GoalType { time, distance, instant }

class TrackingGoal {
  final GoalType type;
  final int targetValue;

  TrackingGoal({
    required this.type,
    required this.targetValue,
  });

  factory TrackingGoal.instant() {
    return TrackingGoal(
      type: GoalType.instant,
      targetValue: 10,
    );
  }
}