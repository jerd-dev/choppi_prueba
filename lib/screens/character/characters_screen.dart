import 'dart:async';

import 'package:choppi_prueba/blocs/rickandmorty_cubit/rickandmorty_cubit.dart';
import 'package:choppi_prueba/config/theme/app_theme.dart';
import 'package:choppi_prueba/model/characters_rickandmorty.dart';
import 'package:choppi_prueba/repository/episodes_repository.dart';
import 'package:choppi_prueba/repository/rickandmorty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends StatelessWidget {
  static const name = 'characters-screen';


  const CharactersScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RickandmortyCubit(
        RickAndMortyRepository(),
        EpisodesRepository()
      ),
      child: const _CharacterView(),
    );
  }
}

class _CharacterView extends StatefulWidget {
  const _CharacterView();

  @override
  State<_CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<_CharacterView> {
  final scrollController = ScrollController();
  
  void setupScrollController(context) {

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<RickandmortyCubit>(context).loadCharacters();
        }
      }
    });

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<RickandmortyCubit>();
      cubit.loadCharacters();
    });
  }


  @override
  Widget build(BuildContext context) {
  setupScrollController(context);
    final appTheme = AppTheme();  // Crea una instancia de AppTheme para acceder a los estilos

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters List'),
      ),
      body: BlocBuilder<RickandmortyCubit, RickandmortyState>(builder: ((context, state) {

        if (state is LoadingRickandmortyState && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } 
        
        // else if( state is ResponseRickandmortyState) {

          List<CharacterRickAndMorty> characters = [];
          bool isLoading = false;


        if ( state is LoadingRickandmortyState) {
            characters = state.oldCharacters;
            isLoading = true;
        } else if (state is ResponseRickandmortyState) {
          characters = state.characters;
        }

          // final characters = state.characters;
          return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
                if (index < characters.length) {
                final character = characters[index];
                    return Column(
                    children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Ajusta el radio de la esquina según tus necesidades
                            ),
                            tileColor: Colors.white,
                            // isThreeLine: true,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                character.image,
                              ),
                              radius: 30,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Ajusta los valores según tus necesidades

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(character.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),  
                              ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gender: ${character.gender!.name.toLowerCase()}', style: appTheme.subtitleTextStyle()),
                                Text('Specie: ${character.species!.name.toLowerCase()}'),
                                Text('Status: ${character.status.name.toLowerCase()}'),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () => context.push('/character/:${character.id.toString()}'),
                              icon: const Icon(Icons.arrow_forward)), // Un ícono que se mostrará a la derecha del título
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ) , 
                    ],
                  );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent
                    );
                  });
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    )
                  );
                }

            },
            itemCount: characters.length + (isLoading ? 1 : 0),
          );    
      }
      
      
      ), ),
    );
  }
}
