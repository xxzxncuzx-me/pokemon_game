import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_game/screens/start_game_screen.dart';
import 'package:pokemon_game/screens/sign_up_screen.dart' show SignUpScreen;
import 'package:pokemon_game/theme/pokemon_theme.dart';
import 'package:pokemon_game/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokemonTheme.sandColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PokemonTextField(
              controller: emailController,
              label: "Enter Email",
              icon: Icons.email,
            ),
            SizedBox(height: 25),
            PokemonTextField(
              controller: passController,
              label: "Enter Password",
              icon: Icons.lock,
              obscureText: true,
            ),

            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {
                String mail = emailController.text.trim();
                String pass = passController.text.trim();

                if (mail.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter All The Fields")),
                  );
                } else {
                  try {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(email: mail, password: pass)
                        .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartGameScreen(),
                            ),
                          );
                        });
                  } catch (err) {
                    print(err);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: PokemonTheme.redColor,
                elevation: 8,
                shadowColor: PokemonTheme.redColor,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PokemonTheme.whiteColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                "New User? Click Here",
                style: TextStyle(
                  color: PokemonTheme.deepOrangeColor,
                  fontWeight: FontWeight.w600,

                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
