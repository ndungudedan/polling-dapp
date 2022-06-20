import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/providers/wallet_connect_provider.dart';

import '../models/poll_model.dart';

final createPollProvider = ChangeNotifierProvider<CreatePollProvider>(
    (ref) => CreatePollProvider(ref.watch(walletConnectProvider.notifier)));

class CreatePollProvider extends ChangeNotifier {
  CreatePollProvider(this.walletConnectProvider);
  final WalletConnectProvider walletConnectProvider;

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

  Future<bool> submitPollToChain() async {
    if (await walletConnectProvider.connectWallet()) {
      List<String> candidateTitles = [];
      List<String> candidatedDescriptions = [];
      List<String> candidateBanners = [];
      try {
        var banner = await uploadPhotosToFirebase(pollBanner!);
        for (var cand in candidates) {
          int index = candidates.indexOf(cand);
          var image = await uploadPhotosToFirebase(candidatesBanners[index]!);
          candidateTitles.add(cand.title);
          candidatedDescriptions.add(cand.description);
          candidateBanners.add(image);
        }
        var args = [
          pollModel!.title,
          pollModel!.description,
          banner,
          pollModel!.expiresAt,
          candidateTitles,
          candidatedDescriptions,
          candidateBanners
        ];
        print(args);
        var res =
            await walletConnectProvider.contract!.send('createNewPoll', args);
        print(res);
        submit = false;
        pollBanner = null;
        pollModel = null;
        candidates = [];
        candidatesBanners = [];
        return true;
      } catch (e) {
        print('submitPollToChain Error: ${e}');
      }
    }
    return false;
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

  Future<String> uploadPhotosToFirebase(Uint8List image) async {
    String fileName = DateTime.now().toString() + '.png';
    // Upload file
    var upload =
        await FirebaseStorage.instance.ref('uploads/$fileName').putData(image);

    return upload.ref.fullPath;
  }
}
