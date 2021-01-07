part of 'page.dart';

class HomePage extends Page {

  HomePage();

  @override
  void dispose() {
    bloc.dispose();
  }

  @override
  void init() {
    bloc.init();
  }

  final HomeBloc bloc = locator.get<HomeBloc>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Data Anggota Keluarga'),
      actions: [
        IconButton(
          icon: const Icon(Icons.article_outlined), 
          onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => ListPage())
          )
        )
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithTitle(
            title: 'Nomor KK',
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: bloc.nomorKK),
            onChanged: (val) {
              bloc.nomorKK = val;
              bloc.validFormNotif.value = bloc.checkValid();
            },
          ),
          const SizedBox(height: 12,),
          RaisedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => InputPage()));
            },
            icon: const Icon(Icons.add),
            label: const Text('Tambah Anggota'),
          ),
          const SizedBox(height: 12,),
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: bloc.anggotaNotif, 
            builder: (context, value, child) => Column(
              children: List.generate(value.length, (indexAnggota) => Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      ...List.generate(2, 
                        (indexLs) {
                          final String key = bloc.anggota[indexAnggota].keys
                            .toList()[indexLs];
                          final List<String> menu = ['Delete'];
                          return ListTile(
                            contentPadding: (indexLs == 0) ? const EdgeInsets.symmetric(vertical: 6, horizontal: 12) : const EdgeInsets.all(0),
                            title: Text(bloc.anggota[indexAnggota][key] as String, style: TextStyle(
                              fontSize: (indexLs == 0) ? 18 : 16,
                              fontWeight: (indexLs == 0) ? FontWeight.bold : FontWeight.normal
                            ),),
                            subtitle: (indexLs != 0) ? Text(key) : null,
                            dense: indexLs != 0,
                            trailing: (indexLs == 0) ? PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'Delete') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Anggota'),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            bloc.deleteAnggota(indexAnggota);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('DELETE')
                                        ),
                                        FlatButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('CANCEL')
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }, 
                              itemBuilder: (context) => List.generate(menu.length,
                                (index) => PopupMenuItem<String>(
                                  value: menu[index], 
                                  child: Text(menu[index]), 
                                )
                              ),
                            ) : null,
                            onTap: (indexLs == 0) ? () {} : null,
                          );
                        }
                      ),
                    ]
                  ),
                )
              ),)
            )
          ),
        ],
      ),
    ),
    floatingActionButton: ValueListenableBuilder<bool>(
      valueListenable: bloc.validFormNotif,
      builder: (context, value, _) => FloatingActionButton(
        backgroundColor: value ? Colors.teal : Colors.grey,
        onPressed: value ? () async {
          await bloc.checkNoKK(bloc.nomorKK).then((value) {
            if (!value) {
              bloc.saveDataKeluarga();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => QuestionPage(bloc.dataKeluarga)));
            } else {
              showNetworkFlash(
                context,
                text: 'Nomor KK sudah terdaftar',
                color: Colors.yellow,
                textColor: Colors.black
              );
            }
          });
        } : null,
        child: const Icon(Icons.arrow_forward),
      ),
    ),
  );
  }
}

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final double titleSize;
  final String hit;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

  const TextFieldWithTitle({
    this.title, 
    this.keyboardType, 
    this.onChanged, 
    this.padding, 
    this.hit, 
    this.maxLines, 
    this.titleSize,
    this.textCapitalization,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: titleSize ?? 16.0),),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: controller,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            onChanged: onChanged ?? (value) {},
            keyboardType: keyboardType ?? TextInputType.name,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: hit ,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ],
      ),
    );
  }
}