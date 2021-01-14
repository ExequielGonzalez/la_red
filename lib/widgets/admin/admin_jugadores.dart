import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';

class AdminJugadores extends StatelessWidget {
  String title = "Spheria";
  String author = "Cody Leet";
  String url = "http://www.codyleet.com/spheria";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    body:
    Form(
      key: _formKey,
      child: CardSettings(children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Favorite Book',
          ),
          children: <CardSettingsWidget>[
            CardSettingsText(
              label: 'Title',
              initialValue: title,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Title is required.';
              },
              onSaved: (value) => title = value,
            ),
            CardSettingsText(
              label: 'URL',
              initialValue: url,
              validator: (value) {
                if (!value.startsWith('http:'))
                  return 'Must be a valid website.';
              },
              onSaved: (value) => url = value,
            ),
          ],
        ),
      ]),
    );
  }
}
