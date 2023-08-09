import 'package:choppi_prueba/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [  
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: '/characters',
      name: CharactersScreen.name,
      builder: (context, state) => const CharactersScreen(),
    ),
    GoRoute(
      path: '/episodes',
      name: EpisodesScreen.name,
      builder: (context, state) => const EpisodesScreen()
    ),
    GoRoute(
      path: '/character/:id',
      name: CharacterDetailScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';

        return CharacterDetailScreen(movieId: movieId);
      }
    ),
  ]
);