import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import 'package:flutter_test_1/widgets/textfield_border.dart';

import '../../providers/create_poll_provider.dart';
import '../../widgets/footer_buttons.dart';

class PollModelScreen extends ConsumerStatefulWidget {
  final PollModel? pollModel;
  final Uint8List? banner;

  PollModelScreen({required this.pollModel, required this.banner});

  @override
  ConsumerState<PollModelScreen> createState() => _PollModelScreenState();
}

class _PollModelScreenState extends ConsumerState<PollModelScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateTimeContoller = TextEditingController();
  DateTime? dateTime;
  TextEditingController _descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pollProvider = ref.watch(createPollProvider);

    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              child: pollProvider.pollBanner == null
                  ? OutlinedButton(
                      onPressed: () {
                        pollProvider.pickPollBanner();
                      },
                      child: Text('Upload Banner'))
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          pollProvider.pollBanner!,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: OutlinedButton(
                              onPressed: () {
                                pollProvider.pickPollBanner();
                              },
                              child: Text('Replace Banner')),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: 40,
            ),
            BorderedTextField(
              enabled: true,
              controller: _titleController,
              hintText: 'Poll Title',
            ),
            SizedBox(
              height: 40,
            ),
            BorderedTextField(
              enabled: true,
              controller: _descController,
              hintText: 'Poll Description',
            ),
            BorderedTextField(
              onTap: () async {
                final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101));

                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (date != null && time != null) {
                  dateTime=DateTime(date.year, date.month,
                          date.day, time.hour, time.minute);
                  _dateTimeContoller.text = dateTime.toString();
                }
              },
              enabled: true,
              controller: _dateTimeContoller,
              hintText: 'Closing Time',
            ),
            FooterButtons(
              onBackPressed: () {},
              onForwardPressed: () {
                if (formKey.currentState!.validate()) {
                  pollProvider.createPollModel(
                      _titleController.text, _descController.text, dateTime!);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
