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
  late TimeOfDay _selectedDate;

  @override
  void initState() {
    super.initState();
    final currentSettings = context.read<AdPlayerBloc>().state.settings;

    // TODO
    _apiKeyController.text =
        currentSettings?.apiKey ?? '4a81161c-64c1-46fa-899c-fe77482f7ed3';
    _shopIdController.text = currentSettings?.shopId ?? '';
    _timeUpdateController.text = currentSettings?.timeUpdate == null
        ? ''
        : '${currentSettings?.timeUpdate.hour}:${currentSettings?.timeUpdate.minute}';
    _selectedDate = TimeOfDay(
      hour: currentSettings?.timeUpdate.hour ?? 0,
      minute: currentSettings?.timeUpdate.minute ?? 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _apiKeyController.dispose();
    _shopIdController.dispose();
    _timeUpdateController.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final settings = SettingsModel(
      apiKey: _apiKeyController.text,
      shopId: _shopIdController.text,
      timeUpdate: DateTime(
        0,
        0,
        0,
        _selectedDate.hour,
        _selectedDate.minute,
      ),
    );

    context.read<AdPlayerBloc>().add(AdPlayerFetchAdEvent(settings: settings));

    Navigator.of(context).pop();
  }

  String? _validate(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Обязательно';
    }
    return null;
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timeOfDay != null) {
      _selectedDate = timeOfDay;
      _timeUpdateController.text = '${timeOfDay.hour}:${timeOfDay.minute}';
    }
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
              obscureText: true,
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
              readOnly: true,
              onTap: () => _selectTime(),
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
