import 'package:cachat/main.dart';
import 'package:flutter/material.dart';

void main()=> runApp(const mapp());

class mapp extends StatelessWidget {
  const mapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        
        body: Center(
          child: Column(
            children: [
Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  'Hello , Im mostu ,Im software engineer',
                  style: TextStyle(
                      fontSize: 15,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'Akaya'),
                ),
              ),
             
              
 ) ],
          ),
        ),
      ),
      
    );
  }
}