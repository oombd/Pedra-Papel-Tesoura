import 'dart:math';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  List maos = [['pedra', '✊'], ['papel', '🖐'], ['tesoura','✌'], ['nada', ' ']];

  String escolhaDoApp = '';
  String ganhador = '';

  void sorteio(List mao) {

    List resultado = [];

    setState(() {
      resultado.add( mao );
      resultado.add(maos[Random().nextInt( 3 )]);

      if (
          ( resultado[0][0] == 'pedra' && resultado[1][0] == 'papel' )   ||
          ( resultado[0][0] == 'tesoura' && resultado[1][0] == 'pedra' ) ||
          ( resultado[0][0] == 'papel' && resultado[1][0] == 'tesoura' )
      ){
        resultado.add( false );
      } else if (
          ( resultado[0][0] == 'papel' && resultado[1][0] == 'pedra' )   ||
          ( resultado[0][0] == 'pedra' && resultado[1][0] == 'tesoura' ) ||
          ( resultado[0][0] == 'tesoura' && resultado[1][0] == 'papel' )
      ){
        resultado.add( true );
      } else {
        resultado.add( "Empate" );
      }
    });

    escolhaDoApp = resultado[1][1];

    if (resultado[2] == true) {
      ganhador = "Parabéns, você ganhou!";
    } else if (resultado[2] == false) {
      ganhador = "Você perdeu!";
    } else {
      ganhador = "Empate!";
    }
  }

   Widget botao(int indexMaos)
   {
     return ElevatedButton(
       onPressed: () {
         sorteio(maos[indexMaos]);
       },
       child: RichText(
         text: TextSpan(
           text: maos[indexMaos][1],
           style: const TextStyle(
             fontFamily: 'EmojiOne',
             fontSize: 45,
           ),
         ),
       ),
       style: ElevatedButton.styleFrom(
         shape: CircleBorder(),
         padding: EdgeInsets.all(15),
         primary: Colors.blue, // <-- Button color
         onPrimary: Colors.red, // <-- Splash color
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const SelectableText(
          "Pedra, papel e tesoura",
          toolbarOptions: ToolbarOptions(copy: true),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Padding(
              padding: EdgeInsets.all(21),
              child: SelectableText(
                '$ganhador',
                toolbarOptions: ToolbarOptions(copy: true),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            ClipOval(
              child: Container(
                color: Colors.deepPurpleAccent,
                height: 210,
                width: 210,
                child: Padding(
                  padding: EdgeInsets.only(left: 14, top: 17, right: 10, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                      text: '$escolhaDoApp',
                      style: const TextStyle(
                        fontFamily: 'EmojiOne',
                        fontSize: 150,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                botao(0),
                botao(1),
                botao(2),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          child: const Padding(
            padding: EdgeInsets.all(3.142857),
            child: SelectableText(
              "Escolha uma opção",
              textAlign: TextAlign.center,
              toolbarOptions: ToolbarOptions(copy: true),
              showCursor: true,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
              ),
            ),
          ),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    );
  }
}