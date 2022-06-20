import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';

final walletConnectProvider =
    StateNotifierProvider<WalletConnectProvider, int>((ref) {
  return WalletConnectProvider();
});

class WalletConnectProvider extends StateNotifier<int> {
  WalletConnectProvider() : super(80001);

  int currentChainId = -1;

  //4=Rinkkeby network
  //80001=mumbai
  final int chainId = 80001;
  String walletAddress = '';

  Web3Provider? web3Client;
  Contract? contract;

  String mapIdToChain(int id) {
    String name = '';
    switch (id) {
      case 4:
        name = 'Rinkeby Network';
        break;
      case 80001:
        name = 'Mumbai Network';
        break;
      default:
        name = 'Unknown';
    }

    return name;
  }

  Future<bool> connectWallet() async {
    if (currentChainId == chainId) {
      return true;
    }
    if (ethereum != null) {
      try {
        // Prompt user to connect to the provider, i.e. confirm the connection modal
        final accs = await ethereum!
            .requestAccount(); // Get all accounts in node disposal
        currentChainId = await ethereum!.getChainId();

        walletAddress = accs.first;
        ethereum!.onAccountsChanged((accs) {
          walletAddress = accs.first;
        });

        ethereum!.onChainChanged((chain) {
          currentChainId = chain;
          state = chain;
        });
        web3Client = Web3Provider(ethereum!);
        await loadContract(web3Client?.getSigner());
        if (currentChainId == chainId) {
          return true;
        }
      } on EthereumUserRejected {
        print('User rejected the modal');
      } catch (e) {
        print('Wallet connect error: ${e}');
      }
    }
    return false;
  }

  Future<void> initWalletProvider() async {
    web3Client = Web3Provider(ethereum!);
    await loadContract(web3Client);
  }

  Future<void> loadContract(dynamic providerOrSigner) async {
    //loads the ABI json file from assets and converts it into a String
    String abi = await rootBundle.loadString('assets/poll_abi.json');
    //Get the contract address and paste it here
    String contractAddress = '0x0eDa5880E19A9AAF7E6681302859bb10e78D9f24';
    //Pass in the json String and the abi of the smart contract.
    contract = Contract(contractAddress, abi, providerOrSigner);
  }
}
