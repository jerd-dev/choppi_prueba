

import 'package:choppi_prueba/config/constants/enviroment.dart';
import 'package:choppi_prueba/model/characters_rickandmorty.dart';
import 'package:choppi_prueba/model/rickandmorty_response.dart';
import 'package:dio/dio.dart';

class RickAndMortyRepository {

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.baseUrl
  ));


  Future<List<CharacterRickAndMorty>> getAllCharacters(int page ) async {

    final response = await dio.get('/character',
      queryParameters: {
        'page': page
      }
    );

    if (response.statusCode == 200) {
    final rickandmortyResponse = RickAndMortyResponse.fromJson(response.data);
      final result = rickandmortyResponse.results.map((character) {
        return CharacterRickAndMorty(
          id: character.id, 
          name: character.name, 
          status: character.status, 
          species: character.species, 
          type: character.type, 
          gender: character.gender, 
          origin: character.origin, 
          location: character.location, 
          image: character.image, 
          episode: character.episode, 
          url: character.url, 
          created: character.created
        );
      }).toList();
      return result;
    } else {

      throw "Something went wrong code ${response.statusCode}";

    }

  }

  Future<CharacterRickAndMorty> getCharacter( String id ) async {
    final response = await dio.get('/character/${id.replaceFirst(':', '')}/');

    if (response.statusCode == 200) {

    final rickandmortyResponse = CharacterRickAndMorty.fromJson(response.data);
    return rickandmortyResponse;

    } else {

      throw "Something went wrong code ${response.statusCode}";

    }

  }
}