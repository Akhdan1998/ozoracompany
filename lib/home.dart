part of 'pages.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final judul = TextEditingController();
  final deskripsi = TextEditingController();
  final _formState = GlobalKey<FormState>();
  late AnimationController _controller;
  final List<Map<String, dynamic>> _items = List.generate(
      1,
          (index) => {
        // "id": index,
        // "title": "Contact",
        // "content":
        // "This is the main content of item $index. It is very long and you have to expand the tile to see it."
      });
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
        IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                '4599DB'.toColor(),
                '62CDCB'.toColor(),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Daftar Tugas',
            style: GoogleFonts
            .poppins()
            .copyWith(),
        ),
        automaticallyImplyLeading: true,
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
            // padding: EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    // var data = snapshot.data!.docs[0];
                    // judul.text = data['judul'];
                    // deskripsi.text = data['deskripsi'];
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(20),
                              //   topRight: Radius.circular(20),
                              // ),
                              gradient: LinearGradient(
                                colors: [
                                  '4599DB'.toColor(),
                                  '62CDCB'.toColor(),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.centerLeft,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    '1F4247'.toColor(),
                                    '1F4247'.toColor(),
                                  ],
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            height: MediaQuery.of(context).size.height + 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: snapshot.data!.docs
                                  .map(
                                    (e) => Column(
                                  children: [
                                    Slidable(
                                      startActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            spacing: 10,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            onPressed: ((context) {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                      'Yakin ingin dihapus?',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                        ),
                                                        child:
                                                        const Text('Tidak'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .labelLarge,
                                                        ),
                                                        child: const Text('Ya'),
                                                        onPressed: () {
                                                          users
                                                              .doc(e.id)
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }),
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete,
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.get('judul') ?? '',
                                                  style: GoogleFonts.poppins()
                                                      .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Container(
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                      98,
                                                  child: Text(
                                                    e.get(
                                                      'deskripsi',
                                                    ) ??
                                                        '',
                                                    style: GoogleFonts
                                                        .poppins()
                                                        .copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  useSafeArea: true,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topLeft: Radius
                                                            .circular(30),
                                                        topRight:
                                                        Radius.circular(
                                                            30)),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SingleChildScrollView(
                                                      reverse: true,
                                                      scrollDirection:
                                                      Axis.vertical,
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                          right: 20,
                                                          top: 20,
                                                          left: 20,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .viewInsets
                                                              .bottom +
                                                              20,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              'Edit Data',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            TextFormField(
                                                              keyboardType:
                                                              TextInputType
                                                                  .text,
                                                              controller: judul,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    '') {
                                                                  return 'Judul tidak boleh kosong!!';
                                                                }
                                                                return null;
                                                              },
                                                              textCapitalization:
                                                              TextCapitalization
                                                                  .sentences,
                                                              decoration:
                                                              InputDecoration(
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          9)),
                                                                  borderSide:
                                                                  BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                fillColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                    0.10),
                                                                filled: true,
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          9)),
                                                                  borderSide:
                                                                  BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                contentPadding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                    10,
                                                                    top: 5,
                                                                    bottom:
                                                                    5),
                                                                hintStyle: GoogleFonts
                                                                    .poppins()
                                                                    .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                hintText:
                                                                'Judul',
                                                                border:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      9),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            TextFormField(
                                                              keyboardType:
                                                              TextInputType
                                                                  .text,
                                                              controller:
                                                              deskripsi,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    '') {
                                                                  return 'Deskripsi tidak boleh kosong!!';
                                                                }
                                                                return null;
                                                              },
                                                              textCapitalization:
                                                              TextCapitalization
                                                                  .sentences,
                                                              decoration:
                                                              InputDecoration(
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          9)),
                                                                  borderSide:
                                                                  BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                fillColor: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                    0.10),
                                                                filled: true,
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          9)),
                                                                  borderSide:
                                                                  BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                ),
                                                                contentPadding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                    10,
                                                                    top: 5,
                                                                    bottom:
                                                                    5),
                                                                hintStyle: GoogleFonts
                                                                    .poppins()
                                                                    .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                hintText:
                                                                'Deskripsi',
                                                                border:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      9),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 10),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (_formState
                                                                    .currentState!
                                                                    .validate()) {
                                                                  users.doc(e.id)
                                                                      .update({
                                                                        'judul': judul
                                                                            .text,
                                                                        'deskripsi':
                                                                            deskripsi
                                                                                .text,
                                                                      });
                                                                  // snapshot
                                                                  //     .data!
                                                                  //     .docs[0]
                                                                  //     .reference
                                                                  //     .update({
                                                                  //   'judul': judul
                                                                  //       .text,
                                                                  //   'deskripsi':
                                                                  //   deskripsi
                                                                  //       .text,
                                                                  // });
                                                                  Navigator.pop(context);
                                                                }
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                height: 48,
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                  gradient:
                                                                  LinearGradient(
                                                                    colors: [
                                                                      '4599DB'
                                                                          .toColor(),
                                                                      '62CDCB'
                                                                          .toColor(),
                                                                    ],
                                                                    begin: Alignment
                                                                        .bottomRight,
                                                                    end: Alignment
                                                                        .centerLeft,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  'Update',
                                                                  style: GoogleFonts
                                                                      .poppins()
                                                                      .copyWith(
                                                                    fontSize:
                                                                    15,
                                                                    color: 'FFFFFF'
                                                                        .toColor(),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                    SizedBox(height: 15),
                                  ],
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        ],
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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 15,
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // '4599DB'.toColor(),
                        '62CDCB'.toColor(),
                        // '4DA934'.toColor(),
                        Colors.white,
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/akhdan.jpeg'),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Akhdan Habibie',
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: '323232'.toColor(),
                            ),
                          ),
                          Text(
                            'Junior Proggramer',
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: '323232'.toColor(),
                            ),
                          ),
                          Text(
                            'Flutter Developer',
                            style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: '323232'.toColor(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 90,
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width - 45,
                  child: Text(
                    'Flutter Developer dengan pengalaman pengembangan aplikasi/web, membantu proses desain dan pemeliharaan aplikasi dengan fokus pada peningkatan fitur yang efisien, dan mencari bug pada aplikasi/web perusahaan.',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 11.5,
                      color: '323232'.toColor(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 180,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    color: '323232'.toColor(),
                  ),
                ),
              ),
              Positioned(
                top: 188,
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height,
                  color:  Colors.white,
                  child: ListView.builder(
                    // reverse: true,
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      itemCount: _items.length,
                      itemBuilder: (_, index) {
                        // final item = _items[index];
                        return Container(
                          height: MediaQuery.of(context).size.height + 2150,
                          child: Column(
                            children: [
                              //contact
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Kontak',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.call,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '081290763984',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.email,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'akhdanhabibie192@gmail.com',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                height: 24,
                                                width: 24,
                                                // padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'in',
                                                  style: GoogleFonts.aBeeZee()
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'akhdanhabibie',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.home,
                                                  size: 17,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Depok, Jawa Barat',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  // color: '4DA934'.toColor(),
                                                ),
                                                child: Image.asset(
                                                  'assets/github.png',
                                                  scale: 22,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'https://github.com/Akhdan1998',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 3, right: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(6),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  'assets/ig.png',
                                                  scale: 52,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'akhddan',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 3, right: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(6),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  'assets/ig.png',
                                                  scale: 52,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'pendekargendut',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //biodata
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Biodata',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.male,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Male',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.pregnant_woman,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Jakarta, 24 March 1998 (25 Years)',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.monitor_weight,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '75 Kg',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.height,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '165 Cm',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                ),
                                                child: Image.asset(
                                                  'assets/ring.png',
                                                  scale: 40,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Not married yet',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //pendidikan
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Pendidikan',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.school,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Smk Al-Hidayah 1 Jakarta',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Computer Network Engineering',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.school,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Institut Sains & Teknologi Nasional',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sarjanan  Komputer',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'IPK 3,32 / 4,0',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //pengalaman kerja
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Pengalaman kerja',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                colors: [
                                                  '4599DB'.toColor(),
                                                  '62CDCB'.toColor(),
                                                ],
                                                begin: Alignment.bottomRight,
                                                end: Alignment.centerLeft,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.work,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'PT. Arkana Dwi Mutiara',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'Junior Programmer (Flutter Developer)',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'February 2022 – sekarang',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'Deskripsi pekerjaan :',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '- ',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        203,
                                                    child: Text(
                                                      'Memantau proses aplikasi dan mengatasi bug atau error pada aplikasi.',
                                                      style: GoogleFonts.poppins()
                                                          .copyWith(
                                                        fontSize: 10.5,
                                                        color: '323232'.toColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '- ',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        203,
                                                    child: Text(
                                                      'Menguji program dan berdiskusi dengan kelompok untuk meningkatkan efektivitas aplikasi.',
                                                      style: GoogleFonts.poppins()
                                                          .copyWith(
                                                        fontSize: 10.5,
                                                        color: '323232'.toColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '- ',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        203,
                                                    child: Text(
                                                      'Fokus pada perancangan, pengujian, dan pembuatan aplikasi.',
                                                      style: GoogleFonts.poppins()
                                                          .copyWith(
                                                        fontSize: 10.5,
                                                        color: '323232'.toColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //pengalaman magang
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Pengalaman magang',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                colors: [
                                                  '4599DB'.toColor(),
                                                  '62CDCB'.toColor(),
                                                ],
                                                begin: Alignment.bottomRight,
                                                end: Alignment.centerLeft,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.work,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'SMA Mawaddah',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'Computer Lab Operator',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'November 2020 – Desember 2020',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Text(
                                                'Job description :',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 10.5,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '- ',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        203,
                                                    child: Text(
                                                      'Membuat aplikasi pembelajaran di rumah berbasis Android dengan Adobe Animate (Flash).',
                                                      style: GoogleFonts.poppins()
                                                          .copyWith(
                                                        fontSize: 10.5,
                                                        color: '323232'.toColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //pelatihan
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Pelatihan',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.home_work,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Junior Office Operator',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'KOMINFO',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Agustus 2020',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Deskripsi pelatihan :',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Peralatan Peripheral.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Perangkat lunak pengolah kata tingkat dasar.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Perangkat lunak presentasi tingkat dasar.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 12.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Perangkat lunak pengakses surat elektronik.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Aplikasi berbasis Internet.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Memastikan validitas data.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      '4599DB'.toColor(),
                                                      '62CDCB'.toColor(),
                                                    ],
                                                    begin: Alignment.bottomRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.home_work,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Junior Office Operator',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'KOMINFO',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Juli 2021',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Deskripsi pelatihan :',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Konfigurasi routing pada perangkat 1 jaringan antar autonomous system.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Mengumpulkan kebutuhan teknis pengguna yang menggunakan jaringan.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Merancang pengalamatan jaringan.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Memasang kabel jaringan.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Merancang topologi jaringan.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Menentukan spesifikasi perangkat jaringan.',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //skills
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Keahlian & Kompetensi',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Android Studio',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Visual Studio Code',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Flutter',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Figma',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Firebase',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Github',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Jira',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'PHP myAdmin/SQL',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: '323232'.toColor(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                              //organinasi
                              ExpansionTile(
                                  iconColor: '323232'.toColor(),
                                  collapsedIconColor: '323232'.toColor(),
                                  // childrenPadding: const EdgeInsets.all(20),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  title: Text(
                                    'Pengalaman organisasi',
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 17, right: 17, bottom: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.groups,
                                                size: 20,
                                                color: Colors.cyan,
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                        114,
                                                    child: Text(
                                                      'Perguruan Pencak Silat Tradisional Betawi',
                                                      style: GoogleFonts.poppins()
                                                          .copyWith(
                                                        fontSize: 12,
                                                        color: '323232'.toColor(),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'BEKSI',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Juli 2014 – sekarang',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 10.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Deskripsi latihan :',
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12.5,
                                                      color: '323232'.toColor(),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Pembukaan doa',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Memimpin latihan',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Mengkoodinir sistem pelatihan',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Mempraktekan fungsi yang dilatih',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 12.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Melatih mental',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 12.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Evaluasi',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 12.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '- ',
                                                        style:
                                                        GoogleFonts.poppins()
                                                            .copyWith(
                                                          fontSize: 10.5,
                                                          color:
                                                          '323232'.toColor(),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                            203,
                                                        child: Text(
                                                          'Penutupan doa',
                                                          style: GoogleFonts
                                                              .poppins()
                                                              .copyWith(
                                                            fontSize: 10.5,
                                                            color: '323232'
                                                                .toColor(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  // thickness: 1,
                                  height: 0,
                                  color: '323232'.toColor(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
