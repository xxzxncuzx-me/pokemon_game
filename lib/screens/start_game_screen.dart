import 'package:flutter/material.dart';
import 'package:pokemon_game/screens/game_round_screen.dart'
    show GameRoundScreen;
import 'package:pokemon_game/theme/pokemon_theme.dart';
import '../../services/pokemon_service.dart';

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  Future<void> startRound(BuildContext context) async {
    final correctPokemon = await PokemonService.getRandomPokemon();

    final distractors = await PokemonService.getRandomPokemons(
      exclude: [correctPokemon.id],
      count: 3,
    );

    final allOptions = [...distractors, correctPokemon]..shuffle();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => GameRoundScreen(
              correctPokemon: correctPokemon,
              options: allOptions,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PokemonTheme.redColor,
        elevation: 6,
        shadowColor: PokemonTheme.blackColor,
        title: const Text(
          "Who's That Pokémon?",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: PokemonTheme.whiteColor,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 3,
                color: PokemonTheme.blackColor,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [PokemonTheme.peachColor, PokemonTheme.lemonColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () => startRound(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: PokemonTheme.redColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              shadowColor: PokemonTheme.blackColor,
            ),
            child: const Text(
              "Start Round",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: PokemonTheme.whiteColor,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
