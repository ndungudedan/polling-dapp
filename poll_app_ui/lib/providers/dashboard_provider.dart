import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import 'package:flutter_test_1/providers/wallet_connect_provider.dart';
import 'package:flutter_web3/ethers.dart';

final dashboardPollProvider = ChangeNotifierProvider<DashboardProvider>(
    (ref) => DashboardProvider(ref.watch(walletConnectProvider.notifier)));

final allPollsProvider = FutureProvider<List<PollModel>>((ref) async {
  return await ref.watch(dashboardPollProvider.notifier).getAllPolls();
});

final myPollsProvider = FutureProvider<List<PollModel>>((ref) async {
  return await ref.watch(dashboardPollProvider.notifier).listAddressPolls();
});

final pollCandidatesProvider =
    FutureProvider.family<List<PollCandidateModel>, int>((ref, index) async {
  return await ref
      .watch(dashboardPollProvider.notifier)
      .getPollCandidates(index);
});

class DashboardProvider extends ChangeNotifier {
  DashboardProvider(this.walletConnectProvider) : super() {
    walletConnectProvider.initWalletProvider();
    listenToContractEvents();
  }
  final WalletConnectProvider walletConnectProvider;

  List<PollModel> allPolls = [];
  List<PollCandidateModel> pollCandidates = [];
  List<MyVote> myVotes = [];
  List<PollModel> myPolls = [];

  Future<List<PollModel>> getAllPolls() async {
    try {
      await walletConnectProvider.initWalletProvider();
      List<dynamic> res =
          await walletConnectProvider.contract!.call('listPolls');
      print(res);
      if (res.isNotEmpty) {
        allPolls = [];
        for (int x = 0; x < res.length; x++) {
          var poll = res.elementAt(x);
          var banner = await getImageURl(poll[2]);
          allPolls.add(PollModel(
              title: poll[0],
              description: poll[1],
              banner: banner,
              expiresAt: int.parse(poll[3].toString())));
          getPollTotalVotes(x);
        }
      }
    } catch (e) {
      print('errror loading polls: ${e}');
    }
    listAddressVotes();
    return allPolls;
  }

  Future<List<PollCandidateModel>> getPollCandidates(int index) async {
    await listAddressVotes();
    try {
      pollCandidates = [];
      List<dynamic> res = await walletConnectProvider.contract!
          .call('listPollCandidates', [index]);
      print(res);
      if (res.isNotEmpty) {
        for (int x = 0; x < res.length; x++) {
          var candidate = res.elementAt(x);
          var banner = await getImageURl(candidate[2]);
          pollCandidates.add(PollCandidateModel(
            title: candidate[0],
            description: candidate[1],
            banner: banner,
          ));
          await getCandidateTotalVotes(index, x);
        }
      }
    } catch (e) {
      print('errror loading polls candidates: ${e}');
    }
    return pollCandidates;
  }

  Future<String> getImageURl(var ref) async {
    var res = await FirebaseStorage.instance.ref(ref).getDownloadURL();
    return res;
  }

  Future<void> voteForCandidate(int pollIndex, int candidateIndex) async {
    if (await walletConnectProvider.connectWallet()) {
      try {
        var res = await walletConnectProvider.contract!.send(
          'voteForCandidate',
          [pollIndex, candidateIndex],
        );
        getPollTotalVotes(pollIndex);
        getCandidateTotalVotes(pollIndex, candidateIndex);

        print(res);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> getPollTotalVotes(int index) async {
    await walletConnectProvider.connectWallet();
    try {
      var res = await walletConnectProvider.contract!
          .call('getPollTotalVotes', [index]);
      print(res);
      allPolls[index] = allPolls
          .elementAt(index)
          .copyWith(totalVotes: int.parse(res.toString()));
      if (myPolls.any((el) => allPolls[index].title == el.title)) {
        PollModel model = myPolls.singleWhere(
            (element) => allPolls[index].hashCode == element.hashCode);
        myPolls[myPolls.indexOf(model)] =
            model.copyWith(totalVotes: int.parse(res.toString()));
      }
    } catch (e) {
      print('errror loading getPollTotalVotes: ${e}');
    }
  }

  Future<void> getCandidateTotalVotes(int pollIndex, int index) async {
    await walletConnectProvider.connectWallet();
    try {
      var res = await walletConnectProvider.contract!
          .call('getCandidateTotalVotes', [pollIndex, index]);
      print(res);
      pollCandidates[index] = pollCandidates
          .elementAt(index)
          .copyWith(totalVotes: int.parse(res.toString()));
    } catch (e) {
      print('errror loading getCandidateTotalVotes: ${e}');
    }
  }

  Future<void> listAddressVotes() async {
    try {
      List<dynamic> res =
          await walletConnectProvider.contract!.call('listAddressVotes', []);
      print(res);
      if (res.isNotEmpty) {
        myVotes = [];
        for (int x = 0; x < res.length; x++) {
          var vote = res.elementAt(x);
          myVotes.add(MyVote(
            pollIndex: int.parse(vote[0].toString()),
            candidateIndex: int.parse(vote[1].toString()),
          ));
        }
      }
    } catch (e) {
      print('errror loading listAddressVotes: ${e}');
    }
  }

  Future<List<PollModel>> listAddressPolls() async {
    await walletConnectProvider.connectWallet();
    try {
      List<dynamic> res =
          await walletConnectProvider.contract!.call('listAddressPolls', []);
      print(res);
      if (res.isNotEmpty) {
        myPolls = [];
        for (int x = 0; x < res.length; x++) {
          var poll = res.elementAt(x);
          var banner = await getImageURl(poll[2]);
          myPolls.add(PollModel(
              title: poll[0],
              description: poll[1],
              banner: banner,
              expiresAt: int.parse(poll[3].toString())));
        }
      }
    } catch (e) {
      print('errror loading listAddressPolls: ${e}');
    }
    return myPolls;
  }

  //Listening to events

  Future<void> listenToContractEvents() async {
    await walletConnectProvider.initWalletProvider();

    walletConnectProvider.contract!.on('NewPollCreated',
        (pollIndex, poll, owner, event) async {
      print('NewPollCreated $pollIndex owner is $owner');
      Event.fromJS(event);
      await getAllPolls();
      if (owner == walletConnectProvider.walletAddress) {
        var banner = await getImageURl(poll[2]);
        myPolls.add(PollModel(
            title: poll[0],
            description: poll[1],
            banner: banner,
            expiresAt: int.parse(poll[3].toString())));
      }
      notifyListeners();
    });

    walletConnectProvider.contract!.on('NewVoteCast',
        (pollIndex, candidateIndex, voter, event) async {
      print('NewVoteCast for $pollIndex canidate $candidateIndex by $voter');
      Event.fromJS(event);

      await getPollTotalVotes(pollIndex);
      await getCandidateTotalVotes(pollIndex, candidateIndex);
      await listAddressVotes();
      notifyListeners();
    });
  }
  
}
