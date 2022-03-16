import 'package:flutter/material.dart';
import 'package:WordWord/models/word_model.dart';

class WordInfo extends StatelessWidget {
  final Item item;

  const WordInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.word ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (item.supNo == '0')
                  const SizedBox(width: 1)
                else
                  Text(
                    item.supNo ?? '',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.pos ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.sense?.definition ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Column(
    //   children: [
    //     Container(
    //       alignment: Alignment.topLeft,
    //       padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             item.word ?? '',
    //             style: const TextStyle(
    //               fontSize: 30,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           if (item.supNo == '0')
    //             const SizedBox(width: 1)
    //           else
    //             Text(
    //               item.supNo ?? '',
    //               style: const TextStyle(
    //                 fontSize: 10,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       alignment: Alignment.topLeft,
    //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //       child: Text(
    //         '${item.pos}',
    //         style: const TextStyle(
    //           color: Colors.lightBlueAccent,
    //           fontSize: 13,
    //         ),
    //       ),
    //     ),
    //     Container(
    //       alignment: Alignment.topLeft,
    //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //       child: Text(
    //         item.sense?.definition ?? '',
    //         style: const TextStyle(
    //           fontSize: 15,
    //           //fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //     const Divider(
    //       thickness: 1,
    //       indent: 20,
    //       endIndent: 20,
    //     ),
    //   ],
    // );
  }
}
