part of 'service.dart';

class FirebaseService implements Service {

  CollectionReference _dataCollection;
  
  @override
  Future<void> init() async {
    await Firebase.initializeApp();
    _dataCollection = FirebaseFirestore.instance.collection('graph');
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}