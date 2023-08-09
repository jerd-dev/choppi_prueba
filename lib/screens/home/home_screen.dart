import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

    String generateRandomImageUrl() {
    final random = Random();
    final randomId = random.nextInt(825) + 1;
    return 'https://rickandmortyapi.com/api/character/avatar/$randomId.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty App'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => context.push('/characters'),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text('Characters List', style: TextStyle(fontWeight: FontWeight.bold),)
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => context.push('/episodes'),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text('Episodes List', style: TextStyle(fontWeight: FontWeight.bold),)
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                generateRandomImageUrl(),
                              ),
                              radius: 35, // Radio de la imagen circular, la mitad del tamaño deseado (70/2)
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}