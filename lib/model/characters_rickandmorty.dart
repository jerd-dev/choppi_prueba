class CharacterRickAndMorty {
    final int id;
    final String name;
    final Status status;
    final Species? species;
    final String type;
    final Gender? gender;
    final Location origin;
    final Location location;
    final String image;
    final List<String> episode;
    final String url;
    final DateTime created;

    CharacterRickAndMorty({
        required this.id,
        required this.name,
        required this.status,
        this.species,
        required this.type,
        this.gender,
        required this.origin,
        required this.location,
        required this.image,
        required this.episode,
        required this.url,
        required this.created,
    });

    factory CharacterRickAndMorty.fromJson(Map<String, dynamic> json) => CharacterRickAndMorty(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: json["species"] != null ? speciesValues.map[json["species"]] : Species.unknown,        
        type: json["type"],
        gender: json["gender"] != null ? genderValues.map[json["gender"]] : Gender.unknown,
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}

enum Gender {
    female,
    male,
    genderless,
    unknown
}

final genderValues = EnumValues({
    "Female": Gender.female,
    "Male": Gender.male,
    "unknown": Gender.unknown,
    "Genderless": Gender.genderless
});

class Location {
    final String name;
    final String url;

    Location({
        required this.name,
        required this.url,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

enum Species {
  alien,
  human,
  mythologicalCreature,
  robot,
  humanoid,
  animal,
  unknown,
  cronenberg,
  poopyButthole,
  disease,
  
  
}

final speciesValues = EnumValues({
    "Alien": Species.alien,
    "Human": Species.human,
    "Mythological Creature": Species.mythologicalCreature,
    "Robot": Species.robot,
    "Humanoid": Species.humanoid,
    "Animal": Species.animal,
    "Cronenberg": Species.cronenberg,
    "unknown": Species.unknown,
    "Poopybutthole": Species.poopyButthole,
    "Disease": Species.disease,
});

enum Status {
    alive,
    dead,
    unknown
}

final statusValues = EnumValues({
    "Alive": Status.alive,
    "Dead": Status.dead,
    "unknown": Status.unknown
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
