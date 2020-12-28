part of 'page.dart';

class HomePage extends Page {

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  final HomeBloc _bloc = locator.get<HomeBloc>();

  final List<String> _nameDetail = [
    'NIK:',
    'Alamat:',
    'Jenis Kelamin:',
    'Tempat Lahir:',
    'Tanggal Lahir:',
    'Agama:',
    'Lulusan:',
  ];
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Survey'),
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
          SizedBox(
            height: 300,
            child: ValueListenableBuilder<List<Map<String, String>>>(
              valueListenable: _bloc.anggotaNotif, 
              builder: (context, value, child) => ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: value.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(value[index]['nama']),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(value.length, (index) => Text(
                            '${_nameDetail[index]} ${value[index]['nik']}'
                          ))
                        ),
                      )
                    )
                  ),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Anggota'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            _bloc.deleteAnggota(index);
                            Navigator.pop(context);
                          }, 
                          child: const Text('OKE')
                        ),
                        FlatButton(
                          color: Colors.teal,
                          onPressed: () => Navigator.pop(context), 
                          child: const Text('CANCEL')
                        ),
                      ],
                    )
                  ),
                  title: Text(value[index]['nama'],),
                )
              )
            ),
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
                keyboardType: TextInputType.number,
                title: 'Nama',
                onChanged: (val) => bloc.tempNik = val,
              ),
              TextFieldWithTitle(
                keyboardType: TextInputType.number,
                title: 'NIK',
                onChanged: (val) => bloc.tempNik = val,
              ),
              TextFieldWithTitle(
                title: 'Alamat (RT & RW)',
                maxLines: 3,
                onChanged: (val) => bloc.tempAlamat = val,
              ),
              StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    RadioListTile<String>(
                      groupValue: bloc.tempJenisKel,
                      title: const Text('Laki-laki'),
                      value: 'Laki-laki',
                      onChanged: (value) =>
                          setState(() => bloc.tempJenisKel = value),
                    ),
                    RadioListTile<String>(
                      groupValue: bloc.tempJenisKel,
                      title: const Text('Perempuan'),
                      value: 'Perempuan',
                      onChanged: (value) =>
                        setState(() => bloc.tempJenisKel = value),
                    ),
                  ],
                )),
              TextFieldWithTitle(
                padding: const EdgeInsets.symmetric(vertical: 12),
                title: 'Tempat Lahir',
                onChanged: (val) => bloc.tempTempatLahir = val,
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
                    if (pickedDate != null &&
                        pickedDate != bloc.tempTglLahir) {
                      setState(() => bloc.tempTglLahir = pickedDate);
                    }
                  },
                  child: Text(
                    pickedDate != null
                      ? bloc.tempTglLahir
                        .toLocal()
                        .toString()
                        .split(' ')[0]
                      : 'Pilih Tanggal Lahir',
                    style: const TextStyle(color: Colors.white)),
                ),
              ),
              TextFieldWithTitle(
                padding: const EdgeInsets.symmetric(vertical: 12),
                title: 'Agama',
                onChanged: (val) => bloc.tempAgama = val,
              ),
              TextFieldWithTitle(
                title: 'Lulusan',
                onChanged: (val) => bloc.tempLulusan = val,
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
          FlatButton(
            color: Colors.teal,
            onPressed: () {
              bloc.addAnggota();
              Navigator.of(context).pop();
            },
            child: const Text('OKE'),
          ),
        ]
      );
  }
}
