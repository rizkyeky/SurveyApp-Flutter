part of 'page.dart';

class HomePage extends Page {

  @override
  void dispose() {
    _bloc.dispose();
  }

  @override
  void init() {
    _bloc.init();
  }

  final HomeBloc _bloc = locator.get<HomeBloc>();
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Data Anggota Keluarga'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithTitle(
            title: 'Nomor KK',
            keyboardType: TextInputType.number,
            onChanged: (val) => _bloc.nomorKK = val,
          ),
          RaisedButton.icon(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AnggotaFormDialog(bloc: _bloc),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Anggota Keluarga'),
          ),
          const SizedBox(height: 12,),
          ValueListenableBuilder<List<Map<String, String>>>(
            valueListenable: _bloc.anggotaNotif, 
            builder: (context, value, child) => Column(
              children: List.generate(value.length, (index) => Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Anggota Keluarga'),
                      actions: [
                        FlatButton(
                          color: Colors.teal,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
                        FlatButton(
                          onPressed: () {
                            _bloc.deleteAnggota(index);
                            Navigator.pop(context);
                          },
                          child: const Text('DELETE'),
                        ),
                      ]
                    ),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(_bloc.anggota[index].keys.length, 
                        (indexLs) {
                          final String key = _bloc.anggota[index].keys
                            .toList()[indexLs];
                          return ListTile(
                          title: Text(_bloc.anggota[index][key], style: TextStyle(
                            fontSize: (indexLs == 0) ? 20 : 16,
                            fontWeight: (indexLs == 0) ? FontWeight.bold : FontWeight.normal
                          ),),
                          subtitle: (indexLs != 0) ? Text(key) : null,
                          dense: indexLs != 0,
                          
                        );
                        }
                      )
                    ]
                  ),
                )
              ),)
            )
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => QuestionPage())),
      child: const Icon(Icons.arrow_forward),
    ),
  );
}

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final double titleSize;
  final String hit;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final EdgeInsetsGeometry padding;
  final int maxLines;

  const TextFieldWithTitle({
    this.title, 
    this.keyboardType, 
    this.onChanged, 
    this.padding, 
    this.hit, 
    this.maxLines, 
    this.titleSize
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
            onChanged: onChanged ?? (value) {},
            keyboardType: keyboardType ?? TextInputType.name,
            maxLines: maxLines ?? 1,
            decoration: const InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ],
      ),
    );
  }
}

class AnggotaFormDialog extends StatelessWidget {
  final HomeBloc bloc;

  const AnggotaFormDialog({this.bloc});

  @override
  Widget build(BuildContext context) {
    DateTime pickedDate;

    return AlertDialog(
      title: const Text('Tambah Anggota Keluarga'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(
              title: 'Nama',
              onChanged: (val) {
                bloc.tempNama = val;
                bloc.checkValidFormAnggota();
              },
            ),
            TextFieldWithTitle(
              keyboardType: TextInputType.number,
              title: 'NIK',
              onChanged: (val) {
                bloc.checkValidFormAnggota();
                bloc.tempNik = val;
              },
            ),
            StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  RadioListTile<String>(
                    groupValue: bloc.tempJenisKel,
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    onChanged: (value) {
                      setState(() => bloc.tempJenisKel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                  RadioListTile<String>(
                    groupValue: bloc.tempJenisKel,
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    onChanged: (value) {
                      setState(() => bloc.tempJenisKel = value);
                      bloc.checkValidFormAnggota();
                    },
                  ),
                ],
              )),
            TextFieldWithTitle(
              padding: const EdgeInsets.symmetric(vertical: 12),
              title: 'Tempat Lahir',
              onChanged: (val) {
                bloc.tempTempatLahir = val;
                bloc.checkValidFormAnggota();
              },
            ),
            StatefulBuilder(
              builder: (context, setState) => FlatButton(
                color: Colors.teal,
                onPressed: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2021),
                  );
                  if (pickedDate != null && pickedDate != bloc.tempTglLahir) {
                    setState(() => bloc.tempTglLahir = pickedDate);
                    bloc.checkValidFormAnggota();
                  }
                },
                child: Text(
                  pickedDate != null
                    ? formatDate(bloc.tempTglLahir)
                    : 'Pilih Tanggal Lahir',
                  style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: bloc.validFormNotif,
          builder: (context, value, _) => FlatButton(
            color: Colors.teal,
            onPressed: value ? () {
              bloc.addAnggota();
              Navigator.of(context).pop();
            } : null,
            child: const Text('OKE'),
          ),
        ),
      ]
    );
  }
}
