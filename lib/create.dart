part of 'pages.dart';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final judul = TextEditingController();
  final deskripsi = TextEditingController();
  final _formState = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
    extendBodyBehindAppBar: true,
    extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Buat Data'),
        centerTitle: true,
      ),
      body: Form(
        key: _formState,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                '1F4247'.toColor(),
                '0D1D23'.toColor(),
                '09141A'.toColor(),
              ],
              begin: Alignment.centerRight,
              end: Alignment.bottomLeft,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: 'FFFFFF'.toColor(),
                ),
                cursorColor: 'FFFFFF'.toColor(),
                controller: judul,
                validator: (value) {
                  if (value == '') {
                    return 'Judul tidak boleh kosong!!';
                  }
                  return null;
                },
                textCapitalization:
                TextCapitalization.sentences,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  fillColor: Colors.grey.withOpacity(0.10),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  contentPadding:
                  EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  hintStyle: GoogleFonts.poppins().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                  hintText: 'Judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: 'FFFFFF'.toColor(),
                ),
                cursorColor: 'FFFFFF'.toColor(),
                controller: deskripsi,
                validator: (value) {
                  if (value == '') {
                    return 'Deskripsi tidak boleh kosong!!';
                  }
                  return null;
                },
                textCapitalization:
                TextCapitalization.sentences,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  fillColor: Colors.grey.withOpacity(0.10),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  contentPadding:
                  EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  hintStyle: GoogleFonts.poppins().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                  hintText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () async {
            if (_formState.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              users.add({
                'judul': judul.text,
                'deskripsi': deskripsi.text,
              });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('users', users.id);
              Get.to(MyHomePage());
            } else {}
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  '4599DB'.toColor(),
                  '62CDCB'.toColor(),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: (isLoading = true)
                ? Text(
              'Simpan',
              style: GoogleFonts.poppins().copyWith(
                fontSize: 15,
                color: 'FFFFFF'.toColor(),
                fontWeight: FontWeight.bold,
              ),
            )
                : Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: 'FFFFFF'.toColor(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
