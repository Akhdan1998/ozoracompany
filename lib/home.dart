part of 'pages.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final judul = TextEditingController();
  final deskripsi = TextEditingController();
  bool isLoading = false;
  final _formState = GlobalKey<FormState>();
  final LinearGradient _gradient = LinearGradient(
    colors: [
      '4599DB'.toColor(),
      '62CDCB'.toColor(),
    ],
    begin: Alignment.topRight,
    end: Alignment.centerLeft,
  );
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(
          'Daftar Tugas',
          style: GoogleFonts.poppins()
              .copyWith(fontSize: 13, color: Colors.white),
        ),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formState,
          child: Container(
            height: MediaQuery.of(context).size.height,
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
            padding: EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    var data = snapshot.data!.docs[0];
                    judul.text = data['judul'];
                    deskripsi.text = data['deskripsi'];
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: MediaQuery.of(context).size.height + 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: snapshot.data!.docs
                              .map(
                                (e) => Column(
                              children: [
                                SizedBox(height: 15),
                                Slidable(
                                  startActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(5),
                                        onPressed: ((context) {
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: const Text(
                                                  'Yakin ingin dihapus?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                    ),
                                                    child: const Text('Tidak'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                    ),
                                                    child: const Text('Ya'),
                                                    onPressed: () {
                                                      users.doc(e.id).delete();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.get('judul') ?? '',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Container(
                                                width:
                                                MediaQuery.of(context).size.width - 98,
                                                child: Text(e.get('deskripsi') ?? '')),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              useSafeArea: true,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(30),
                                                    topRight: Radius.circular(30)),
                                              ),
                                              backgroundColor: Colors.white,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SingleChildScrollView(
                                                  reverse: true,
                                                  scrollDirection: Axis.vertical,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      right: 20,
                                                      top: 20,
                                                      left: 20,
                                                      bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom +
                                                          20,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Edit Data',
                                                          style:
                                                          TextStyle(fontSize: 16),
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          keyboardType:
                                                          TextInputType.text,
                                                          controller: judul,
                                                          validator: (value) {
                                                            if (value == '') {
                                                              return 'Judul tidak boleh kosong!!';
                                                            }
                                                            return null;
                                                          },
                                                          textCapitalization:
                                                          TextCapitalization.sentences,
                                                          decoration:
                                                          InputDecoration(
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(9)),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.transparent,
                                                              ),
                                                            ),
                                                            fillColor: Colors.grey
                                                                .withOpacity(0.10),
                                                            filled: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(9)),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.transparent,
                                                              ),
                                                            ),
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10, top: 5, bottom: 5),
                                                            hintStyle: GoogleFonts.poppins()
                                                                .copyWith(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.grey,
                                                            ),
                                                            hintText: 'Judul',
                                                            border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(9),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        TextFormField(
                                                          keyboardType:
                                                          TextInputType.text,
                                                          controller: deskripsi,
                                                          validator: (value) {
                                                            if (value == '') {
                                                              return 'Deskripsi tidak boleh kosong!!';
                                                            }
                                                            return null;
                                                          },
                                                          textCapitalization:
                                                          TextCapitalization.sentences,
                                                          decoration:
                                                          InputDecoration(
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(9)),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.transparent,
                                                              ),
                                                            ),
                                                            fillColor: Colors.grey
                                                                .withOpacity(0.10),
                                                            filled: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(9)),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.transparent,
                                                              ),
                                                            ),
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10, top: 5, bottom: 5),
                                                            hintStyle: GoogleFonts.poppins()
                                                                .copyWith(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.grey,
                                                            ),
                                                            hintText: 'Deskripsi',
                                                            border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(9),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            if (_formState
                                                                .currentState!
                                                                .validate()) {
                                                              setState(() {
                                                                isLoading = true;
                                                              });
                                                              // Your update logic here
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                            height: 48,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(8),
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  '4599DB'.toColor(),
                                                                  '62CDCB'.toColor(),
                                                                ],
                                                                begin: Alignment.bottomRight,
                                                                end: Alignment.centerLeft,
                                                              ),
                                                            ),
                                                            child: (isLoading)
                                                                ? Text(
                                                              'Update',
                                                              style:
                                                              GoogleFonts.poppins()
                                                                  .copyWith(
                                                                fontSize: 15,
                                                                color:
                                                                'FFFFFF'.toColor(),
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            )
                                                                : Center(
                                                              child: SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child:
                                                                CircularProgressIndicator(
                                                                  strokeWidth: 2.5,
                                                                  color:
                                                                  'FFFFFF'.toColor(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 15),
                              ],
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: [
              '4599DB'.toColor(),
              '62CDCB'.toColor(),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.centerLeft,
          ),
        ),
        padding: EdgeInsets.all(2),
        child: IconButton(
          onPressed: () {
            Get.to(create());
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
