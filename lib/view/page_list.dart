part of 'page.dart';

class ListPage extends Page {

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  final ListBloc _bloc = ListBloc();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Keluarga'),
      ),
      body: FutureBuilder<void>(
        future: _bloc.getListKeluarga(),
        builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done) ? _bloc.listKeluarga.isNotEmpty ? ListView.builder(
            itemCount: _bloc.listKeluarga.length,
            itemBuilder: (context, indexKeluarga) {
              final Map<String, dynamic> keluarga = _bloc.listKeluarga[indexKeluarga];
              return Card(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  children: 
                  [
                    ListTile(
                      title: const Text('Nomor KK'),
                      subtitle: Text(keluarga.values.toList()[0] as String),
                    ),
                    ListTile(
                      title: const Text('Anggota'),
                      subtitle: Text((keluarga['Anggota'] as List).map((e) => e['Nama']).toList().join(', ')),
                    ),
                  ]
                ),
              );
            }
          ) : const Center(child: Text('Tidak Ada Data')) : const Center(child: CircularProgressIndicator())
      ),
    );
  }
}