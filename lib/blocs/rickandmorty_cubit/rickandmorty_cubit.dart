import 'package:choppi_prueba/model/characters_rickandmorty.dart';
import 'package:choppi_prueba/model/espisodes_response.dart';
import 'package:choppi_prueba/repository/episodes_repository.dart';
import 'package:choppi_prueba/repository/rickandmorty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rickandmorty_state.dart';

class RickandmortyCubit extends Cubit<RickandmortyState> {

  bool reachedLastPage = false;

  final RickAndMortyRepository _repository;

  final EpisodesRepository _repositoryEpisodes;

  
  RickandmortyCubit(this._repository, this._repositoryEpisodes) : super(InitialRickandmortyState());

  int page = 1;

  void loadCharacters() {

    if (state is LoadingRickandmortyState) return;

    final currentState = state;

    var oldCharacter = <CharacterRickAndMorty>[];

    if (currentState is ResponseRickandmortyState) {
      oldCharacter = currentState.characters;
    }

    emit(LoadingRickandmortyState(oldCharacter, isFirstFetch: page == 1));

    _repository.getAllCharacters(page).then((newCharacters) {

      page++;

      final characters = (state as LoadingRickandmortyState).oldCharacters;
      characters.addAll(newCharacters);

      emit(ResponseRickandmortyState(characters));

    });


  }

void loadCharacter(String characterId) async {

  try {
  print('sdfsdfsdfsdfsdf');

    final characterDetail = await _repository.getCharacter(characterId);

    emit(CharacterState(characterDetail));
  } catch (error) {
    emit(ErrorRickandmortyState("An error occurred while fetching character details."));
  }
}

  void loadEpisodes() async {
    if (state is LoadingEpisodeState) return;

    final currentState = state;
    var oldEpisodes = <Episode>[];

    if (currentState is ResponseEpisodesRickandmortyState) {
      oldEpisodes = currentState.episodes;
    }

    emit(LoadingEpisodeState(oldEpisodes, isFirstFetch: page == 1));

    try {
      final finalPageInfo = await _repositoryEpisodes.getFinalPage();

      if (page > finalPageInfo.pages) {
        emit(ResponseEpisodesRickandmortyState(oldEpisodes, true)); // Llegaste a la última página
        return;
      }

      final newEpisodes = await _repositoryEpisodes.getAllEpisodes(page);

      page++;

      final episodes = (state as LoadingEpisodeState).oldEpisodes;
      episodes.addAll(newEpisodes);

      emit(ResponseEpisodesRickandmortyState(episodes, false)); // No es la última página

    } catch (error) {
      emit(ErrorRickandmortyState("An error occurred while fetching episodes."));
    }
  }


}
