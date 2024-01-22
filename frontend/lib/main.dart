import 'dart:developer';
import 'dart:io';

import 'package:demo/model/applicants.dart';
import 'package:demo/model/dropdown_dto.dart';
import 'package:demo/rest.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var rest = Rest();
  List<ApplicantDTO> applicantList = [];

  @override
  void initState() {
    super.initState();
    _loadApplicantList();
  }

  _loadApplicantList() async {
    var data = await rest.getApplicantList();
    applicantList.addAll(data ?? []);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: applicantList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ApplicantDetailsPage(dto: applicantList[index])),
                )
              },
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(applicantList[index].applicantName ?? ""),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Father: ${applicantList[index].fatherName}"),
                          Text(
                              "Freedom Fighter: ${applicantList[index].freedomFighterName}"),
                          Text("Village: ${applicantList[index].village}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ApplicantDetailsPage extends StatefulWidget {
  final ApplicantDTO dto;
  const ApplicantDetailsPage({super.key, required this.dto});

  @override
  State<ApplicantDetailsPage> createState() => _ApplicantDetailsPageState();
}

class _ApplicantDetailsPageState extends State<ApplicantDetailsPage> {
  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];
  List<WorkSteps> workStep = [];
  List<WorkSteps> billingStatus = [];
  String? workStepVal;
  String? billngStatusVal;
  String? details;
  var rest = Rest();

  void pickImage() async {}

  Future<Null> updated(StateSetter updateState) async {
    try {
      var img = await picker.pickMultiImage();
      updateState(() {
        images.addAll(img);
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future<Null> removeImage(StateSetter updateState, int index) async {
    try {
      updateState(() {
        images.removeAt(index);
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDropdowns();
  }

  _loadDropdowns() async {
    var response = await rest.fetchWorkingSteps();
    var response1 = await rest.fetchBillingStatus();
    workStep.addAll(response ?? []);
    billingStatus.addAll(response1 ?? []);
    setState(() {});
  }

  _submitValue(id) async {
    var response = await rest.post(
        id: id,
        workSteps: workStepVal,
        billingStatus: billngStatusVal,
        details: details,
        files: images);

    if (response) {
      images = [];
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Project Status"),
      ),
      body: Card(
        child: ListView(
          children: [
            ListTile(
              title: Text(widget.dto.applicantName ?? ""),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("পিতার নাম: ${widget.dto.fatherName}"),
                  Text(
                      "জাতীয় পরিচয় পত্র/মোবাইল: ${widget.dto.nidNo ?? widget.dto.mobileNo ?? ""}"),
                  Text(
                      "বীর মুক্তিযোদ্ধার নাম: ${widget.dto.freedomFighterName}"),
                  Row(
                    children: [
                      Expanded(child: Text("জেলা: ${widget.dto.village}")),
                      Expanded(child: Text("উপজেলা: ${widget.dto.village}")),
                      Expanded(child: Text("গ্রাম: ${widget.dto.village}")),
                    ],
                  ),
                  Text("লাল মুক্তিবার্তা: ${widget.dto.redLightRelease}"),
                  Text(
                      "সামরিক/বেসামরিক গেজেট নাম্বার: ${widget.dto.govtCivilGadgetNo}"),
                  Text("এম.আই.এস নম্বর: ${widget.dto.misNo}"),
                  const Divider(),
                  const Text("তফসিল: দাগ, খতিয়ান, মৌজা, জমির পরিমান"),
                  const Divider(),
                  Text("${widget.dto.landDetails}"),
                  const Divider(),
                  const Text("বসতবাড়ির অবস্থা"),
                  const Divider(),
                  Text(widget.dto.landLocation ?? "কোনো তথ্য পাওয়া যায়নি"),
                ],
              ),
            ),
            const ListTile(
              title: Column(
                children: [
                  Divider(),
                  Text(
                    "মাইলফলক: ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Divider()
                ],
              ),
            ),
            for (ProjectProgressDTOS item
                in widget.dto.projectProgressDTOS ?? []) ...{
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                            itemCount: (item.images ?? []).length,
                            pageSnapping: true,
                            itemBuilder: (context, pagePosition) {
                              return Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            (item.images ?? [])[pagePosition]),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Status"),
                          const SizedBox(
                            width: 10,
                          ),
                          Chip(
                            label: Text(item.workStep ?? ""),
                            side: const BorderSide(color: Colors.green),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Chip(
                            label: Text(item.billingStatus ?? ""),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 38, 6, 133)),
                          ),
                        ],
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.details ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "আবেদনের তারিখ: ${item.submittedDae}",
                            style: TextStyle(
                                color: Colors.pink[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            },

            const SizedBox(
              height: 100,
            )
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return ListView(
                    children: [
                      Container(
                        height: 200,
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: images.isEmpty
                            ? const Center(
                                child: Text("Select Images From Gallery"),
                              )
                            : PageView.builder(
                                itemCount: (images ?? []).length,
                                pageSnapping: true,
                                itemBuilder: (context, pagePosition) {
                                  return Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                images[pagePosition].path)),
                                            fit: BoxFit.cover)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () => {
                                                  removeImage(
                                                      setState, pagePosition)
                                                },
                                            icon: const Icon(Icons.close)),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 2),
                                          child: Chip(
                                            label: Text(((pagePosition) + 1)
                                                .toString()),
                                            color:
                                                const MaterialStatePropertyAll(
                                                    Color.fromARGB(
                                                        255, 255, 255, 255)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              label: const Text("Pick Images"),
                              onPressed: () async {
                                updated(setState);
                              },
                              icon: const Icon(Icons.camera_alt_outlined)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 2.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: workStepVal,
                              hint: const Text("Select Work Step"),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  workStepVal = value!;
                                });
                              },
                              items: workStep
                                  .map((e) => e.name ?? "")
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                            maxLines: 8,
                            onChanged: (value) {
                              setState(() => details = value);
                            },
                            decoration: const InputDecoration(
                                hintText: "Enter details",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 2.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: billngStatusVal,
                              hint: const Text("Select Billing Status"),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  billngStatusVal = value!;
                                });
                              },
                              items: billingStatus
                                  .map((e) => e.name ?? "")
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            label: const Text("Submit"),
                            onPressed: () => {_submitValue(widget.dto.id)},
                            icon: const Icon(Icons.save_as_rounded)),
                      ),
                    ],
                  );
                });
              })
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
