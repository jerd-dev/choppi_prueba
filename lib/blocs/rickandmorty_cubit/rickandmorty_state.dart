part of 'rickandmorty_cubit.dart';

abstract class RickandmortyState {}

class InitialRickandmortyState extends RickandmortyState {}


class ErrorRickandmortyState extends RickandmortyState {
  final String message;
  ErrorRickandmortyState(this.message);
}

class ResponseRickandmortyState extends RickandmortyState {

  final List<CharacterRickAndMorty> characters;
  ResponseRickandmortyState(this.characters);

}

class CharacterState extends RickandmortyState {

  final CharacterRickAndMorty characterDetail;
  CharacterState(this.characterDetail);

}

class LastPageReachedState extends RickandmortyState {}


class ResponseEpisodesRickandmortyState extends RickandmortyState {

  final List<Episode> episodes;
  final bool isLastPageReached; // Agrega esta propiedad

  ResponseEpisodesRickandmortyState(this.episodes, this.isLastPageReached);

}

class LoadingEpisodeState extends RickandmortyState {
  
  final List<Episode> oldEpisodes;
  final bool isFirstFetch;

  LoadingEpisodeState(this.oldEpisodes, {this.isFirstFetch = false});

}


class LoadingRickandmortyState extends RickandmortyState {
  
  final List<CharacterRickAndMorty> oldCharacters;
  final bool isFirstFetch;

  LoadingRickandmortyState(this.oldCharacters, {this.isFirstFetch = false});

}
