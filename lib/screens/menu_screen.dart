


import 'package:flutter/material.dart';
import 'package:minecraft2d_game/screens/world_select_screen.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/launcher/minecraft_button.dart';
import 'package:panorama/panorama.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = GameMethods.instance.getScreenSize();
    return Scaffold(
      body: Stack(
        children: [
          Panorama(
            interactive: false,
            animSpeed: 1,
            child: Image.asset("assets/images/launcher/panorama.png"),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.05),
                    child: Container(
                      //color: Colors.red,
                      height: screenSize.height * 0.4,
                      width: screenSize.width * 0.4,
                      decoration: const BoxDecoration(
                        //color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage("assets/images/launcher/logo.png"),
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  MinecraftButtonWidget(
                    text: "Singleplayer",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorldSelectScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MinecraftButtonWidget(text: "Multiplayer (Soon)", onPressed: () {}),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "This game is an replica of the original Minecraft Game, Project made for Educational purposes. Pleas Check out the actual game - Minecraft",
                      style: TextStyle(
                          color: Colors.yellow.withOpacity(0.75),
                          fontSize: 10,
                          fontFamily: "MinecraftFont"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}