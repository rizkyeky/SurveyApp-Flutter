part of 'service.dart';

class ConnectionService {
  final Connectivity _connectivity = Connectivity();

  final ValueNotifier<ConnectionStatus> networkStatusNotifier =
      ValueNotifier<ConnectionStatus>(ConnectionStatus.offline);

  ConnectionService() {
    _connectivity.onConnectivityChanged.listen((value) {
      final ConnectionStatus status = _getNetworkStatus(value);
      // print(status);
      if (networkStatusNotifier.value != status) {
        networkStatusNotifier.value = status;
      }
    });
  }

  Future<void> init() async {
    await _connectivity.checkConnectivity().then((value) {
      final ConnectionStatus status = _getNetworkStatus(value);
      // print(status);
      if (networkStatusNotifier.value != status) {
        networkStatusNotifier.value = status;
      }
    });
  }

  ConnectionStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? ConnectionStatus.online
        : ConnectionStatus.offline;
  }

  // Future<bool> checkConnection() async {
  //   final bool previousConnection = hasConnection;

  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       hasConnection = true;
  //     } else {
  //       hasConnection = false;
  //     }
  //   } on SocketException catch(_) {
  //     hasConnection = false;
  //   }

  //   if (previousConnection != hasConnection) {
  //     networkStatusNotifier.value = _getNetworkStatus(value);
  //   }

  //   return hasConnection;
  // }
}
