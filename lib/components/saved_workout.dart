class SavedWorkout {
  final String id;
  final String name;
  final String difficulty;
  final String equipment;
  final String image;
  final String instructions;
  final int date;
  final double sets;
  final int repetitions;
  final String bodyPart;
  final String target;

  SavedWorkout({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.equipment,
    required this.image,
    required this.instructions,
    required this.date,
    required this.sets,
    required this.repetitions,
    required this.bodyPart,
    required this.target
  });

  static SavedWorkout fromJson(Map<String, dynamic> json) => SavedWorkout(
    id: json['id'],
    name: json['Name'],
    difficulty: json['Difficulty'],
    equipment: json['Equipment'],
    image: json['Image'],
    instructions: json['Instructions'],
    date: json['Date'],
    sets: json['Sets'],
    repetitions: json['Repetitions'],
    bodyPart: json['Body Part'],
    target: json['Target']
  );
}