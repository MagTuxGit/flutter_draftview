import 'package:draft_view/draft_view.dart';
import 'package:flutter/material.dart';

import '../draft_data.dart';
import '../post_settings_data.dart';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Theme(
        data: ThemeData(
          textTheme: TextTheme(
            displayLarge: TextStyle(fontSize: 30, color: Colors.black),
            displayMedium: TextStyle(fontSize: 25, color: Colors.black),
            displaySmall: TextStyle(fontSize: 20, color: Colors.black),
            bodyLarge: TextStyle(height: 2, fontSize: 17),
          ),
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DraftView(
                rawDraftData: data,
                plugins: [
                  TextPlugin(),
                  BlockQuotePlugin(),
                  HeaderPlugin(),
                  ImagePlugin(),
                  PostSettingsPlugin(rawSettings: settings),
                  ListPlugin(),
                  AudioPlugin(),
                  LinkPlugin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
