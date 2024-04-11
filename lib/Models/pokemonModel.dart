class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<String> type;
  String height;
  String weight;
  String candy;
  int candyCount;
  String egg;
  double spawnChance;
  double avgSpawns;
  String spawnTime;
  List<double> multipliers;
  List<String> weaknesses;
  List<Evolution> nextEvolution;
  List<Evolution> prevEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: List<String>.from(json['type']),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candy_count'] ?? 0,
      egg: json['egg'],
      spawnChance: json['spawn_chance'].toDouble(),
      avgSpawns: json['avg_spawns'].toDouble(),
      spawnTime: json['spawn_time'],
      multipliers: json['multipliers'] != null ? List<double>.from(json['multipliers']) : [],
      weaknesses: List<String>.from(json['weaknesses']),
      nextEvolution: json['next_evolution'] != null
          ? List<Evolution>.from(
          json['next_evolution'].map((e) => Evolution.fromJson(e)))
          : [],
      prevEvolution: json['prev_evolution'] != null
          ? List<Evolution>.from(
          json['prev_evolution'].map((e) => Evolution.fromJson(e)))
          : [],
    );

  }
}

class Evolution {
  String num;
  String name;

  Evolution({
    required this.num,
    required this.name,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      num: json['num'],
      name: json['name'],
    );
  }
}
