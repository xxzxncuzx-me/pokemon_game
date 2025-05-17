import 'package:flutter/material.dart';
import 'package:pokemon_game/screens/start_game_screen.dart'
    show StartGameScreen;
import 'package:pokemon_game/theme/pokemon_theme.dart';
import '../models/pokemon.dart';

class ResultScreen extends StatelessWidget {
  final Pokemon correctPokemon;
  final Pokemon selectedPokemon;

  const ResultScreen({
    super.key,
    required this.correctPokemon,
    required this.selectedPokemon,
  });

  bool get isCorrect => correctPokemon.id == selectedPokemon.id;

  @override
  Widget build(BuildContext context) {
    final isCorrect = correctPokemon.id == selectedPokemon.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PokemonTheme.redColor,
        elevation: 6,
        shadowColor: PokemonTheme.blackColor,
        title: const Text(
          'Result',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 400),
            child: Container(
              decoration: BoxDecoration(
                color: PokemonTheme.lightYellowColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: PokemonTheme.blackColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    isCorrect
                        ? '🎉 You caught it!'
                        : '❌ Oops! It was ${correctPokemon.name[0].toUpperCase()}${correctPokemon.name.substring(1)}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color:
                          isCorrect
                              ? PokemonTheme.greenColor
                              : PokemonTheme.brightRedColor,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: PokemonTheme.blackColor,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      correctPokemon.imageUrl,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${correctPokemon.name[0].toUpperCase()}${correctPokemon.name.substring(1)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Type(s): ${correctPokemon.types.join(', ')}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        correctPokemon.stats.map((stat) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              '${stat['name'].toString().toUpperCase()}: ${stat['value']}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartGameScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PokemonTheme.redColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: PokemonTheme.blackColor,
                    ),
                    child: const Text(
                      'Next Round',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PokemonTheme.whiteColor,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
