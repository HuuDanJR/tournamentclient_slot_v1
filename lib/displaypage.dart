import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/service/service_api.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/utils/showsnackbar.dart';
import 'package:tournament_client/widget/text.dart';

class DisplayPage extends StatefulWidget {
  SocketManager? mySocket;
  DisplayPage({Key? key, required this.mySocket}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  void initState() {
    debugPrint('INIT DISPLAYPAGE');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final service_api = ServiceAPIs();
  final TextEditingController controllerLimit =
      TextEditingController(text: MyString.DEFAULT_COLUMN);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:  textcustom(text:'Display Page',size: MyString.padding16),
        actions: const [],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: MyColor.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.display_settings_outlined),
                    label: textcustom(text: "Show View"),
                    onPressed: () {
                      print('show view');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: textcustom(text: "SHOW VIEW"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textcustom(text: "show view top ranking displaying on screen if you click confirm")
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
                              onPressed: () async {
                                print('press confirm show');
                                service_api
                                    .listDisplayTopRankingStatus()
                                    .then((value) {
                                  service_api
                                      .updateDisplayTopRankingStatus(id: value['data'][0]['_id'], enable: true)
                                      .then((val) {
                                    if (val['status'] == true) {
                                      widget.mySocket!.emitToggleClient();
                                      showSnackBar(context:context,message:val['message']);
                                    }
                                  });
                                }).whenComplete(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('CONFIRM'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.hide_source_sharp),
                    label: textcustom(text: 'Hide View'),
                    onPressed: () {
                      print('hide view');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: textcustom(text: "HIDE VIEW"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textcustom(
                                  text:
                                      "Hide view top ranking displaying on screen if you click confirm")
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
                              onPressed: () async {
                                print('press confirm hide');
                                service_api
                                    .listDisplayTopRankingStatus()
                                    .then((value) {
                                  service_api
                                      .updateDisplayTopRankingStatus(id: value['data'][0]['_id'], enable: false)
                                      .then((val) {
                                    if (val['status'] == true) {
                                      widget.mySocket!.emitToggleClient();
                                      showSnackBar(context:context,message:val['message']);
                                    }
                                  });
                                }).whenComplete(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('CONFIRM'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: MyString.padding16,),
              //display image view
              ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: textcustom(text: 'Images/Videos'),
                    onPressed: () {
                      print('image/video');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: textcustom(text: "Images/Videos"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textcustom(text:"Choose images/Video displaying on screen ")
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
                              onPressed: () async {
                                
                              },
                              child: const Text('CONFIRM'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            SizedBox(height: MyString.padding16,),
            Divider(),
            SizedBox(height: MyString.padding16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.fullscreen),
                  onPressed: (){}, label: Text('Show RealTime Only')),
                const SizedBox(width: MyString.padding16,),
                ElevatedButton.icon(
                  icon: Icon(Icons.fullscreen),
                  onPressed: (){}, label: Text('Show Both')),
              ],
            )

            ],
          )),
    );
  }
}
