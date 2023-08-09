
import 'package:choppi_prueba/model/characters_rickandmorty.dart';

class RickAndMortyResponse {
    final Info info;
    final List<CharacterRickAndMorty
    > results;

    RickAndMortyResponse({
        required this.info,
        required this.results,
    });

    factory RickAndMortyResponse.fromJson(Map<String, dynamic> json) => RickAndMortyResponse(
        info: Info.fromJson(json["info"]),
        results: List<CharacterRickAndMorty>.from(json["results"].map((x) => CharacterRickAndMorty.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Info {
    final int count;
    final int pages;
    final String next;
    final dynamic prev;

    Info({
        required this.count,
        required this.pages,
        required this.next,
        this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

