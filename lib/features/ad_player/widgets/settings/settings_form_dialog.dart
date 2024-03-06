import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ad_player_bloc.dart';
import '../../models/models.dart';

class SettingsFormDialog extends StatefulWidget {
  const SettingsFormDialog({super.key});

  @override
  State<SettingsFormDialog> createState() => _SettingsFormDialogState();
}

class _SettingsFormDialogState extends State<SettingsFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();
  final _shopIdController = TextEditingController();
  final _timeUpdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentSettings = context.read<AdPlayerBloc>().state.settings;

    _apiKeyController.text = currentSettings?.apiKey ?? '';
    _shopIdController.text = currentSettings?.shopId ?? '';
    _timeUpdateController.text = currentSettings?.timeUpdate ?? '';
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final settings = SettingsModel(
      apiKey: _apiKeyController.text,
      shopId: _shopIdController.text,
      timeUpdate: _timeUpdateController.text,
    );

    context
        .read<AdPlayerBloc>()
        .add(AdPlayerSetSettingsEvent(settings: settings));

    Navigator.of(context).pop();
  }

  String? _validate(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Обязательно';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _apiKeyController,
              textInputAction: TextInputAction.next,
              validator: _validate,
              decoration: const InputDecoration(
                labelText: 'apiKey',
              ),
            ),
            TextFormField(
              controller: _shopIdController,
              textInputAction: TextInputAction.next,
              validator: _validate,
              decoration: const InputDecoration(
                labelText: 'shopId',
              ),
            ),
            TextFormField(
              controller: _timeUpdateController,
              textInputAction: TextInputAction.done,
              validator: _validate,
              decoration: const InputDecoration(
                labelText: 'timeUpdate',
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _onSubmit,
          child: const Text('Сохранить'),
        ),
      ],
      scrollable: true,
    );
  }
}
