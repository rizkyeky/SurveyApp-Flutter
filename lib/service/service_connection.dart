part of 'service.dart';

class ConnectionService implements Service {
  final Connectivity _connectivity = Connectivity();

  final ValueNotifier<ConnectionStatus> networkStatusNotifier =
      ValueNotifier<ConnectionStatus>(ConnectionStatus.offline);

  ConnectionService() {
    _connectivity.onConnectivityChanged.listen((value) {
      final ConnectionStatus status = _getNetworkStatus(value);
      print(status);
      if (networkStatusNotifier.value != status) {
        networkStatusNotifier.value = status;
      }
    });
  }

  @override
  Future<void> init() async {
    await _connectivity.checkConnectivity().then((value) {
      final ConnectionStatus status = _getNetworkStatus(value);
      print(status);
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

  @override
  void dispose() {
  }
}
