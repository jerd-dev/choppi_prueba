import 'dart:async';

import 'package:choppi_prueba/blocs/rickandmorty_cubit/rickandmorty_cubit.dart';
import 'package:choppi_prueba/model/espisodes_response.dart';
import 'package:choppi_prueba/repository/episodes_repository.dart';
import 'package:choppi_prueba/repository/rickandmorty_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesScreen extends StatelessWidget {
  static const name = 'episodes-screen';

  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Episodes'),
      ),
      body: BlocProvider(
        create: (context) => RickandmortyCubit(
          RickAndMortyRepository(),
          EpisodesRepository()
        ),
        child: _EpisodesView(),
      ),
    );
  }
}

class _EpisodesView extends StatefulWidget {

  @override
  State<_EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<_EpisodesView> {
  final scrollController = ScrollController();
  bool reachedLastPage = false; // Agrega esta variable

  void setupScrollController(context) {

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<RickandmortyCubit>(context).loadEpisodes();
        }
      }
    });

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<RickandmortyCubit>();
      cubit.loadEpisodes();
    });
  }
  @override
  Widget build(BuildContext context) {
  setupScrollController(context);
    return  BlocBuilder<RickandmortyCubit, RickandmortyState>(builder: ((context, state) {

    if (state is LastPageReachedState) {
      reachedLastPage = true;
    }

    if (reachedLastPage) {
      return const Center();
    }

      if (state is LoadingEpisodeState && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
      } 

    List<Episode> episodes = [];
    bool isLoading = false;

     if ( state is LoadingEpisodeState) {
        episodes = state.oldEpisodes;
        isLoading = true;
      } else if (state is ResponseEpisodesRickandmortyState) {
        episodes = state.episodes;
      }

      return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
                if (index < episodes.length) {
                final episode = episodes[index];
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Ajusta los valores según tus necesidades
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(episode.name,
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
                                Text('Season: ${episode.episode.substring(1,3)}'),
                                Text('Episode: ${episode.episode.substring(4)}'),
                                Text('Air Date: ${episode.airDate}'),
                              ],
                            ),
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
            itemCount: episodes.length + (isLoading ? 1 : 0),
          );

    }));

  }
}
