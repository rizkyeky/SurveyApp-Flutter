part of 'service.dart';

class FirebaseService implements Service {

  CollectionReference _dataCollection;
  
  @override
  Future<void> init() async {
    await Firebase.initializeApp();
    _dataCollection = FirebaseFirestore.instance.collection('keluarga');
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  Future<ServiceResult> addKeluarga(Map<String, dynamic> keluarga) async {
    try {
      await _dataCollection.doc(keluarga['Nomor KK'] as String).set(keluarga);
      return ServiceResult(isSucess: true, massage: 'complete');

    } catch (e) {
      return ServiceResult(isSucess: false, massage: '');
    }
  }

  Future<ServiceResult<List<Map<String, dynamic>>>> readKoleksi() async {
    try {
      final QuerySnapshot query = await _dataCollection.get();
      final List<Map<String, dynamic>> data = query.docs.map((e) => e.data()).toList();
      return ServiceResult(value: data, isSucess: true, massage: 'Sucessed');
    } catch (e) {
      return ServiceResult(isSucess: false, massage: 'Failed');
    }
  }

  Future<ServiceResult<List<String>>> checkKoleksi() async {
    try {
      final QuerySnapshot query = await _dataCollection.get();
      final List<String> data = query.docs.map((e) => e.id).toList();
      return ServiceResult(value: data, isSucess: true, massage: 'Sucessed');
    } catch (e) {
      return ServiceResult(isSucess: false, massage: 'Failed');
    }
  }

  Future<String> uploadFile(String noKK,File _image) async {
    final Reference storageReference = FirebaseStorage.instance.ref().child(
      '$noKK/${basename(_image.path)}'
    );
    final UploadTask uploadTask = storageReference.putFile(_image);
    final TaskSnapshot snapshot = uploadTask.snapshot;
    return snapshot.ref.getDownloadURL();
  }
}