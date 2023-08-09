import 'package:choppi_prueba/blocs/rickandmorty_cubit/rickandmorty_cubit.dart';
import 'package:choppi_prueba/model/characters_rickandmorty.dart';
import 'package:choppi_prueba/repository/episodes_repository.dart';
import 'package:choppi_prueba/repository/rickandmorty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const name = 'characters-detail-screen';
  final String movieId;
  const CharacterDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RickandmortyCubit(RickAndMortyRepository(), EpisodesRepository()),
      child: _DetailMovieView(
          movieId: movieId,
      ),
    );
  }
}

class _DetailMovieView extends StatefulWidget {
  final String movieId;

  const _DetailMovieView({required this.movieId});

  @override
  State<_DetailMovieView> createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<_DetailMovieView> {
  late String movieId; // Declara la propiedad movieId en el estado

  @override
  void initState() {
    super.initState();
    movieId = widget.movieId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<RickandmortyCubit>();
      cubit.loadCharacter(movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<RickandmortyCubit, RickandmortyState>(
      builder: (context, state) {

      CharacterRickAndMorty character;

        if (state is CharacterState) {
          character = state.characterDetail;
        } else {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(character.name),
          ),
          body: SingleChildScrollView(
            // Permite hacer scroll si el contenido es grande
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    character.image,
                    height: size.width * 0.9,
                    width: size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20), // Espacio entre la imagen y el texto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Character Name: ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      Text(character.name, style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Character Type: ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      Text(character.gender.toString().split('.').last, style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Character Name: ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      Text(character.species.toString().split('.').last, style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
