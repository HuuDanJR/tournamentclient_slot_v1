import 'package:flutter/material.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/textfield.dart';
import 'package:tournament_client/utils/showsnackbar.dart';
import 'package:tournament_client/service/service_api.dart';
import 'package:tournament_client/lib/models/stationmodel.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';

class SetupPage extends StatefulWidget {
  SocketManager? mySocket;

  SetupPage({Key? key, this.mySocket}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final TextEditingController controllerMember = TextEditingController();
  final TextEditingController controllerMC = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final TextEditingController controllerLimit =
      TextEditingController(text: MyString.DEFAULT_COLUMN);
  final TextEditingController controllerPoint = TextEditingController();
  final service_api = ServiceAPIs();

  @override
  void initState() {
    debugPrint('initState SetupPage');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void emitEvent() {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint('add');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: textcustom(text: "Create New MC Display"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        mytextfield(controller: controllerMember, hint: "Member"),
                        mytextfield(controller: controllerMC, hint: "MC"),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: textcustom(text: "CANCEL")),
                      TextButton(
                          onPressed: () {
                            debugPrint(
                                'value: ${controllerMember.text} ${controllerMC.text}');
                            try {
                              service_api.createStation(
                                member: controllerMember.text,
                                machine: controllerMC.text,
                              ).then((value) {
                                setState(() {
                                  controllerMC.text = '';
                                  controllerMember.text = '';
                                });
                              }).whenComplete(
                                      () => Navigator.of(context).pop());
                            } catch (e) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: textcustom(text: "SUBMIT"))
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add, color: MyColor.white)),
        appBar: AppBar(
          centerTitle: false,
          title:  textcustom(text:'Set Up Real Time Display',size:MyString.padding16),
          actions: [


            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: textcustom(text: "Setting Limit Ranking Display"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: controllerLimit,
                            decoration: const InputDecoration(
                              hintText: 'FROM 1 -> 20',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint("onPressed: emitEventChangeLimitRealTimeRanking");
                            if (int.parse(controllerLimit.text) > 20) {
                              showSnackBar(
                                  context: context,
                                  message:
                                      'Input invalid, Please input from 1-20');
                            } else {
                              debugPrint("onPressed: access emitEventChangeLimitRealTimeRanking");
                              widget.mySocket!.emitEventChangeLimitRealTimeRanking(
                                      int.parse(controllerLimit.text));
                              showSnackBar(
                                  context: context,
                                  message: 'Setting Finished');
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('SUBMIT'),
                        ),
                      ],
                    ),
                  );
                },
                child: textcustom(text: "Setting Limit",size: MyString.padding12)),

              // ElevatedButton(
              // onPressed: () {
              //   print('rebuild realtime');
              //   showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //       title: textcustom(text: "Re-Build Realtime Ranking"),
              //       content: textcustom(
              //           text:
              //               "Re-Build realtime ranking will be take action if you click confirm"),
              //       actions: [
              //         TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: textcustom(text: "CANCEL")),
              //         TextButton(
              //             onPressed: () {
              //               widget.mySocket!.emitEventFromClientForce();
              //               Navigator.of(context).pop();
              //             },
              //             child: textcustom(text: "CONFIRM")),
              //       ],
              //     ),
              //   );
              // },
              // child: textcustom(text: "REFRESH VIEW"))
          ],
        ),
        body: FutureBuilder(
          future: service_api.listStationData(),
          builder: (BuildContext context,
              AsyncSnapshot<ListStationModel?> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'an error orcur or can not connection to db!',
                textAlign: TextAlign.center,
              ));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final ListStationModel? model = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(0.0),
              height: height,
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          itemList(
                            width: width,
                            child:textcustom(text: '#', size: 16.0, isBold: true),
                          ),
                          itemList(
                            width: width,
                            child: textcustom(text: 'MEMBER', size: 16.0, isBold: true),
                          ),
                          itemList(
                            width: width,
                            child: textcustom(
                                text: 'MACHINE', size: 16.0, isBold: true),
                          ),
                          itemList(
                            width: width,
                            child: textcustom(
                                text: 'IP', size: 16.0, isBold: true),
                          ),
                          itemList(
                            width: width,
                            child: textcustom(
                                text: 'CREDIT', size: 16.0, isBold: true),
                          ),
                          itemList(
                              width: width,
                              child: textcustom(
                                  text: 'STATUS', size: 16.0, isBold: true)),
                          Expanded(
                              child: itemList(
                                  width: width,
                                  child: textcustom(
                                      text: 'ACTION',
                                      size: 16.0,
                                      isBold: true))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  itemList(
                                    width: width,
                                    child: textcustom(text: '${index + 1}'),
                                  ),
                                  itemList(
                                    width: width,
                                    child: textcustom(
                                        text: model!.list[index].member),
                                  ),
                                  itemList(
                                    width: width,
                                    child: textcustom(
                                        text: model.list[index].machine),
                                  ),
                                  itemList(
                                    width: width,
                                    child: textcustom(
                                        text: '${model.list[index].ip}'),
                                  ),
                                  itemList(
                                    width: width,
                                    child: textcustom(
                                        text:'${model.list[index].credit / 100}\$'),
                                  ),
                                  itemList(
                                      width: width,
                                      child: textcustomColor(
                                        text: model.list[index].connect == 1
                                            ? 'Connected'
                                            : 'Disconnected',
                                        color: model.list[index].connect == 1
                                            ? Colors.green
                                            : Colors.red,
                                      )),
                                  Expanded(
                                    child: itemList(
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              tooltip: 'update member',
                                              onPressed: () {
                                                debugPrint(
                                                    'update ${model.list[index].member}');
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              icon: const Icon(Icons.edit),
                                                              title: textcustom(text:'Confirm Update RT'),
                                                              content: Column(
                                                                mainAxisSize:MainAxisSize.min,
                                                                children: [
                                                                  textcustom(text:  "Are you sure to update this member?"),
                                                                  const Divider(color: MyColor.grey_tab),
                                                                  mytextFieldTitle(
                                                                    hint:'Current Member',
                                                                    enable:false,
                                                                    text: model.list[index].member,
                                                                    textinputType:TextInputType.text,
                                                                    label: 'Current Member',
                                                                    controller:  controllerMemberCurrent,
                                                                  ),
                                                                  mytextFieldTitle(
                                                                      hint: 'New Member',
                                                                      enable:  true,
                                                                      text:
                                                                          null,
                                                                      controller:
                                                                          controllerMemberNew,
                                                                      textinputType:
                                                                          TextInputType
                                                                              .number,
                                                                      label:
                                                                          'New Member'),
                                                                ],
                                                              ),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          try {
                                                                            debugPrint('ip & member: ${model.list[index].ip} ${model.list[index].member}');
                                                                            if (controllerMemberNew.text == '' ||
                                                                                controllerMemberNew.text == model.list[index].member) {
                                                                                showSnackBar(context: context, message: "Invalid input. Please use a new member number ");
                                                                            } else {
                                                                              service_api.updateMemberStation(
                                                                                ip: model.list[index].ip,
                                                                                member: controllerMemberNew.text,
                                                                              ).then((value) {
                                                                                showSnackBar(context: context, message: value['message']);
                                                                                controllerMemberNew.clear();
                                                                              }).whenComplete(() {
                                                                                Navigator.of(context).pop();
                                                                                controllerMemberNew.clear();
                                                                              });
                                                                            }
                                                                          } catch (e) {
                                                                            debugPrint('$e');
                                                                            Navigator.of(context).pop();
                                                                          }
                                                                        },
                                                                        child: const Text(
                                                                            "SUBMIT",
                                                                            style:
                                                                                TextStyle(color: Colors.green))),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "CANCEL"))
                                                                  ],
                                                                )
                                                              ],
                                                            ));
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              tooltip: 'disable/enable',
                                              onPressed: () {
                                                //show dialog
                                                showDialogEdit(
                                                    functionFinishDisplay: () {
                                                      print('complete display');
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    functionFinishUnDisplay:
                                                        () {
                                                      print(
                                                          'complete  un-display');
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    context: context,
                                                    service_api: service_api,
                                                    ip: model.list[index].ip,
                                                    status: model
                                                        .list[index].display);
                                              },
                                              icon: Icon(model.list[index]
                                                          .display ==
                                                      0
                                                  ? Icons.close_outlined
                                                  : Icons
                                                      .remove_red_eye_rounded)),
                                          // IconButton(
                                          //     onPressed: () {
                                          //       debugPrint('update point');
                                          //       showDialog(
                                          //           context: context,
                                          //           builder:
                                          //               (context) =>
                                          //                   AlertDialog(
                                          //                     icon: const Icon( Icons.edit),
                                          //                     title: textcustom(text:'Confirm Update Point'),
                                          //                     content: Column(
                                          //                       mainAxisSize: MainAxisSize.min,
                                          //                       children: [
                                          //                         textcustom(text:"Are you sure to update this member's point?"),
                                          //                         const Divider( color: MyColor.grey_tab),
                                          //                         mytextFieldTitle(
                                          //                           hint:'Current Point',
                                          //                           enable:false,
                                          //                           text: model.list[index].member,
                                          //                           textinputType:TextInputType.text,
                                          //                           label:'Current Point',
                                          //                           controller:
                                          //                               controllerMemberCurrent,
                                          //                         ),
                                          //                         mytextFieldTitle(
                                          //                             hint:'New Point',
                                          //                             enable: true,
                                          //                             text: null,
                                          //                             controller:controllerMemberNew,
                                          //                             textinputType: TextInputType.number,
                                          //                             label:'New Point'),
                                          //                       ],
                                          //                     ),
                                          //                     actions: [
                                          //                       Row(
                                          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //                         children: [
                                          //                           TextButton(
                                          //                               onPressed:() {
                                          //                                 try {
                                          //                                   debugPrint('ip & member: ${model.list[index].ip} ${model.list[index].member}');
                                          //                                   if (controllerPoint.text == '' ||
                                          //                                       int.parse(controllerPoint.text) == model.list[index].credit) {
                                          //                                     showSnackBar(context: context, message: "Invalid input. Please use a new point");
                                          //                                   } else {
                                          //                                     service_api.updateMemberStation(
                                          //                                       ip: model.list[index].ip,
                                          //                                       member: controllerPoint.text,
                                          //                                     ).then((value) {
                                          //                                       showSnackBar(context: context, message: value['message']);
                                          //                                       setState(() {
                                          //                                         controllerPoint.text = '';
                                          //                                       });
                                          //                                     }).whenComplete(() {
                                          //                                       Navigator.of(context).pop();
                                          //                                     });
                                          //                                   }
                                          //                                 } catch (e) {
                                          //                                   debugPrint('$e');
                                          //                                   Navigator.of(context).pop();
                                          //                                 }
                                          //                               },
                                          //                               child: const Text("SUBMIT", style: TextStyle(color: Colors.green))),
                                          //                           TextButton(
                                          //                               onPressed: () {
                                          //                                 Navigator.of(context).pop();
                                          //                               },
                                          //                               child: const Text("CANCEL"))
                                          //                         ],
                                          //                       )
                                          //                     ],
                                          //                   ));
                                          //     },
                                          //     icon: const Icon(Icons.credit_score)),
                                          IconButton(
                                              onPressed: () {
                                                debugPrint('delete');
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              title: textcustom(text:'Confirm delete'),
                                                              content: textcustom(text:"Are you sure to delete this item?"),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () {
                                                                      try {
                                                                        service_api
                                                                            .deleteStation(
                                                                              machine: model.list[index].machine,
                                                                              member: model.list[index].member,
                                                                            )
                                                                            .then((value) =>
                                                                                {
                                                                                  setState(() {})
                                                                                })
                                                                            .whenComplete(() =>
                                                                                Navigator.of(context).pop());
                                                                      } catch (e) {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    },
                                                                    child: textcustom(
                                                                        text:
                                                                            "SUBMIT")),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: textcustom(
                                                                        text:
                                                                            "CANCEL")),
                                                              ],
                                                            ));
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(color: MyColor.grey_tab),
                          ],
                        );
                      },
                      itemCount: model!.list.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

Widget itemList({width, child}) {
  return Container(
    alignment: Alignment.centerLeft,
    width: width / 8,
    child: Center(child: child),
  );
}

showDialogEdit(
    {context,
    status,
    ServiceAPIs? service_api,
    ip,
    functionFinishDisplay,
    functionFinishUnDisplay}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Status'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  status == 0 ? "DISPLAY" : "UN-DISPLAY",
                  style: TextStyle(
                      color: status == 0 ? Colors.green : Colors.pink),
                ),
                onPressed: () {
                  if (status == 0) {
                    print('display');
                    service_api!
                        .updateDisplayStatus(ip: ip, display: 1)
                        .then((value) => null)
                        .whenComplete(() {
                      functionFinishDisplay();
                    });
                  } else {
                    print('un-display');
                    service_api!
                        .updateDisplayStatus(ip: ip, display: 0)
                        .then((value) => null)
                        .whenComplete(() {
                      functionFinishUnDisplay();
                    });
                  }
                },
              ),
              TextButton(
                child: const Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
        content: const Text("Status will be apply for mobile and web"),
      );
    },
  );
}
