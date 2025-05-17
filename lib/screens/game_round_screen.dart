import 'package:flutter/material.dart';
import 'package:pokemon_game/screens/result_screen.dart' show ResultScreen;
import 'package:pokemon_game/theme/pokemon_theme.dart';
import '../models/pokemon.dart';
import 'dart:async';

class GameRoundScreen extends StatefulWidget {
  final Pokemon correctPokemon;
  final List<Pokemon> options;
  final int score;
  final int streak;

  const GameRoundScreen({
    super.key,
    required this.correctPokemon,
    required this.options,
    this.score = 0,
    this.streak = 0,
  });

  @override
  State<GameRoundScreen> createState() => _GameRoundScreenState();
}

class _GameRoundScreenState extends State<GameRoundScreen> {
  Timer? _timer;
  int _timeLeft = 10;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
        if (!_answered) {
          _goToResultScreen(null);
        }
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _goToResultScreen(Pokemon? selected) {
    _timer?.cancel();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => ResultScreen(
              correctPokemon: widget.correctPokemon,
              selectedPokemon:
                  selected ??
                  Pokemon(
                    id: -1,
                    name: 'No answer',
                    imageUrl: '',
                    types: [],
                    stats: [],
                  ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PokemonTheme.redColor,
        elevation: 6,
        shadowColor: PokemonTheme.blackColor,
        title: const Text(
          "Guess the Pokémon",
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              'Time left: $_timeLeft s',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: PokemonTheme.blackColor,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: PokemonTheme.grayColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: Center(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    PokemonTheme.shadowBlackColor,
                    BlendMode.srcATop,
                  ),
                  child: Image.network(
                    widget.correctPokemon.imageUrl,
                    fit: BoxFit.contain,
                    height: 280,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...widget.options.map((pokemon) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PokemonTheme.redColor,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                    shadowColor: PokemonTheme.blackColor,
                  ),
                  onPressed:
                      _answered
                          ? null
                          : () {
                            setState(() => _answered = true);
                            _goToResultScreen(pokemon);
                          },
                  child: Text(
                    pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: PokemonTheme.whiteColor,
                      letterSpacing: 1.05,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
