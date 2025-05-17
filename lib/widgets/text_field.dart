import 'package:flutter/material.dart';
import 'package:pokemon_game/theme/pokemon_theme.dart';

class PokemonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;

  const PokemonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: PokemonTheme.redColor,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: PokemonTheme.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: PokemonTheme.redColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: PokemonTheme.redColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: PokemonTheme.deepOrangeColor, width: 3),
        ),
        prefixIcon: Icon(icon, color: PokemonTheme.redColor),
      ),
    );
  }
}
