import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import '../../providers/create_poll_provider.dart';
import '../../utils/text_styles.dart';
import '../../widgets/footer_buttons.dart';
import '../../widgets/textfield_border.dart';
import '../poll_widget.dart';

class CandidateScreen extends ConsumerStatefulWidget {
  final List<PollCandidateModel> candidates;
  final List<Uint8List?> banners;

  const CandidateScreen({required this.banners, required this.candidates});

  @override
  ConsumerState<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends ConsumerState<CandidateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  Uint8List? image;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pollProvider = ref.watch(createPollProvider);

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Poll Candidates Details',style: poppinsBold.copyWith(fontSize: 30,color: kPrimaryColor),),
            ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: size.height / 4,
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child: image == null
                        ? OutlinedButton(
                            onPressed: () async {
                              image = await pollProvider.pickImage();

                              setState(() {});
                            },
                            child: const Text('Upload Banner'))
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.memory(image!,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                              backgroundColor: kPrimaryLightColor
                            ),
                                    onPressed: () async {
                                      image = await pollProvider.pickImage();

                                      setState(() {});
                                    },
                                    child: const Text('Replace Banner')),
                              )
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BorderedTextField(
                    enabled: true,
                    controller: _titleController,
                    hintText: 'Candidate Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BorderedTextField(
                    enabled: true,
                    maxLines: 3,
                    controller: _descController,
                    hintText: 'Candidate Bio',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: kPrimaryColor
                      ),
                        onPressed: () {
                          if (formKey.currentState!.validate() && image!=null) {
                            pollProvider.addCandidate(
                                image!,
                                PollCandidateModel(
                                    description: _descController.text,
                                    title: _titleController.text));
                            _descController.clear();
                            _titleController.clear();
                            image = null;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:  Text('Add Candidate',
                          style: poppinsMedium.copyWith(color: Colors.white),),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Wrap(
            children: List.generate(pollProvider.candidates.length, (index) {
              return PollCandidateWidget(
                image: pollProvider.candidatesBanners.elementAt(index)!,
                candidate: pollProvider.candidates.elementAt(index),
              );
            }),
          ),
          FooterButtons(
            onBackPressed: () {},
            onForwardPressed: () {
              if (pollProvider.candidates.isNotEmpty) {
                pollProvider.finalizeSubmission();
              }
            },
          )
        ],
      ),
    );
  }
}
