import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  late String title;
  late int idade;
  late String feedback;
  CardInfo(
      {super.key,
      required this.title,
      required this.idade,
      required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Row(
                // Cabeçalho do card
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'RobotoCondensed',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Image.asset(
                      'assets/images/idade.png',
                    ),
                  )
                ],
              ),
            ),

            // Corpo do Card
            Row(
              children: [
                Text(
                  '$idade',
                  style: const TextStyle(
                    height: 0.8,
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'KanitBold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'anos',
                  style: TextStyle(
                    fontSize: 15,
                    height: 2.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35)),
                  child: Center(
                    child: Text(
                      feedback,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
