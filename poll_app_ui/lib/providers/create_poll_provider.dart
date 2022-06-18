import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/poll_model.dart';

final createPollProvider =
    ChangeNotifierProvider<CreatePollProvider>((ref) => CreatePollProvider());

class CreatePollProvider extends ChangeNotifier {
  bool submit = false;
  PollModel? pollModel;
  List<PollCandidateModel> candidates = [];

  Uint8List? pollBanner;
  //index to map to candidates index on their list
  List<Uint8List?> candidatesBanners = [];

  void createPollModel(String title, String description, DateTime dateTime) {
    pollModel = PollModel(
        title: title,
        description: description,
        expiresAt: dateTime.millisecondsSinceEpoch);
    notifyListeners();
  }

  void deletePollCandidate(PollCandidateModel candidate) {
    int index = candidates.indexOf(candidate);
    candidates.remove(candidate);
    candidatesBanners.removeAt(index);
    notifyListeners();
  }

  Future<void> pickPollBanner() async {
    pollBanner = await pickImage();
    notifyListeners();
  }

  Future<void> addCandidate(
      Uint8List image, PollCandidateModel candidate) async {
    candidates.add(candidate);
    candidatesBanners.insert(candidates.indexOf(candidate), image);
    notifyListeners();
  }

  void finalizeSubmission() {
    submit = true;
    notifyListeners();
  }

  Future<Uint8List?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      return result.files.first.bytes;
    }
    return null;
  }
}
