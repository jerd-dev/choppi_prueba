

import 'package:choppi_prueba/config/constants/enviroment.dart';
import 'package:choppi_prueba/model/espisodes_response.dart';
import 'package:dio/dio.dart';

class EpisodesRepository {

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.baseUrl
  ));

  Future<Info> getFinalPage() async {

    final response = await dio.get('/episode');

    if (response.statusCode == 200) {
      final episodesReponse = EpisodesResponse.fromJson(response.data);

      final result = episodesReponse.info;


      return Info(
        count: result.count, 
        pages: result.pages, 
        next: result.next
      );
    } else {

      throw "Something went wrong code ${response.statusCode}";

    }


  }


  Future<List<Episode>> getAllEpisodes(int page ) async {

    final response = await dio.get('/episode',
      queryParameters: {
        'page': page
      }
    );

    if (response.statusCode == 200) {
    final episodesReponse = EpisodesResponse.fromJson(response.data);

    final result = episodesReponse.results.map((episode) {
      return Episode(
        id: episode.id, 
        name: episode.name, 
        airDate: episode.airDate, 
        episode: episode.episode, 
        characters: episode.characters,
        url: episode.url, 
        created: episode.created
        );
    }).toList();
      return result;
    } else {

      throw "Something went wrong code ${response.statusCode}";

    }

  }


}