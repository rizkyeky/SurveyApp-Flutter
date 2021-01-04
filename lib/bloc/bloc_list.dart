part of 'bloc.dart';

class ListBloc implements Bloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  final FirebaseService _firebaseService = locator.get<FirebaseService>();

  List<Map<String, dynamic>> listKeluarga = [];

  Future<void> getListKeluarga() async {
    await _firebaseService.readKoleksi().then((result) {
      listKeluarga = result.value;
    });
  }

}