import 'package:flutter/material.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Expanded(
                        child: FittedBox(
                          child: Text("data${index}"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Expanded(
                        child: FittedBox(
                          child: Text("data${index}"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Text.rich(
TextSpan(children: [
WidgetSpan(
child: FittedBox(
child: Row(
children: [
Text("data data data data data"),
Text("data data data data data"),
Text("data data data data data"),
Text("data data data data data"),
],
),
),
),
WidgetSpan(
child: FittedBox(
fit: BoxFit.fitWidth,
child: Row(
children: [
Text("data data data data data"),
Text("data data data data data"),
],
),
)),
*/
/* TextSpan(children: [
                TextSpan(text: "data data data data data"),
                TextSpan(text: "data data data data data"),
              ])*/ /*

]),
textAlign: TextAlign.justify,
)*/
