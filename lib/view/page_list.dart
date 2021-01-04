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
        builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done) ? ListView.builder(
            itemCount: 3,
            itemBuilder: (context, indexKeluarga) {
              final Map<String, dynamic> keluarga = _bloc.listKeluarga[indexKeluarga];
              return Card(
              child: Column(
                children: 
                [
                  ListTile(
                    title: Text(keluarga.keys.toList()[0]),
                    subtitle: Text(keluarga.values.toList()[0] as String),
                  ),
                  ...List.generate(3, (index) => ListTile(
                    title: Text(keluarga.values.toList()[index] as String),
                    subtitle: Text(keluarga.keys.toList()[index]),
                  ))
                ]
              ),
            );
            }
          ) : const Center(child: CircularProgressIndicator())
      ),
    );
  }
}