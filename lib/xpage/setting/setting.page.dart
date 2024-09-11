import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tournament_client/service/format.date.factory.dart';
import 'package:tournament_client/service/format.factory.dart';
import 'package:tournament_client/service/service_api.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/utils/showsnackbar.dart';
import 'package:tournament_client/widget/textfield.dart';
import 'package:tournament_client/xpage/setting/bloc_setting/settting_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_client/xpage/setting/dialog.confirm.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {
  final TextEditingController controllerMinBet = TextEditingController();
    final TextEditingController controllerMaxBet = TextEditingController();
    final TextEditingController controllerBuyIn = TextEditingController();
    final TextEditingController controllerTotalRoud = TextEditingController();
    final TextEditingController controllerCurrentRound =  TextEditingController();
    final TextEditingController controllerLastUpdate = TextEditingController();
    final TextEditingController controllerBuyInNote = TextEditingController();
    final TextEditingController controllerGame = TextEditingController();
    final formatNumber = DateFormatter();
  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    controllerMinBet.dispose();
    controllerMaxBet.dispose();
    controllerBuyIn.dispose();
    controllerTotalRoud.dispose();
    controllerCurrentRound.dispose();
    controllerLastUpdate.dispose();
    controllerBuyInNote.dispose();
    controllerGame.dispose();
    super.dispose();
  }

  void _setControllerValues(SettingState state) {
    controllerMinBet.text = '${state.posts.first.minbet}';
    controllerMaxBet.text = '${state.posts.first.maxbet}';
    controllerTotalRoud.text = '${state.posts.first.remaingame}';
    controllerCurrentRound.text = '${state.posts.first.run}';
    controllerBuyIn.text = '${state.posts.first.buyin}';
    controllerLastUpdate.text = formatNumber.formatDateAndTime(state.posts.first.lastupdate);
    controllerGame.text = '${state.posts.first.gamenumber} - ${state.posts.first.gametext}';
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceAPIs = ServiceAPIs();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    


    return Container(
      padding: const EdgeInsets.all(MyString.padding16),
      child: BlocProvider(
          // lazy: false,
          create: (_) => SetttingBloc(httpClient: http.Client())..add(SettingFetched()),
          child: BlocListener<SetttingBloc,SettingState>(
            listener: (context, state) {
            if (state.status == SettingStatus.success && state.posts.isNotEmpty) {
              _setControllerValues(state);
            }
            
          },
            child: BlocBuilder<SetttingBloc, SettingState>(
              builder: (context, state) {
                switch (state.status) {
                  case SettingStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case SettingStatus.failure:
                    return const Center( child: Text('An error orcur when fetch settings'));
                  case SettingStatus.success:
                    if (state.posts.isEmpty) {
                      return const Center(child: Text('No settings found'));
                    }
                    
                  
            
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Setting Game"),
                          const Divider(color: MyColor.grey),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.attach_money_outlined),
                                    label: "Min Bet",
                                    text: controllerMinBet.text,
                                    controller: controllerMinBet,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding16,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.attach_money_outlined),
                                    label: "Max Bet",
                                    text: controllerMaxBet.text,
                                    controller: controllerMaxBet,
                                    enable: true,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.airplay),
                                    label: "Remain Round",
                                    text: controllerTotalRoud.text,
                                    controller: controllerTotalRoud,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding16,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.airplay),
                                    label: "Current Round",
                                    text:controllerCurrentRound.text,
                                    controller: controllerCurrentRound,
                                    enable: true,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.attach_money_outlined),
                                    label: "Buy In",
                                    text:controllerBuyIn.text,
                                    controller: controllerBuyIn,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding16,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.lock_clock_rounded),
                                    label: "Last Update",
                                    text: controllerLastUpdate.text,
                                    controller: controllerLastUpdate,
                                    enable: false,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.note_alt),
                                    label: "Buy In Note",
                                    text: "\$100 = 500 Credit, \$500 Max (My Setting)",
                                    controller: controllerBuyInNote,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding16,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 3,
                                    icon: const Icon(Icons.info_rounded),
                                    label: "Game Info",
                                    text: '${state.posts.first.gamenumber} - ${state.posts.first.gametext}',
                                    controller: controllerGame,
                                    enable: false,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: MyString.padding08,
                          ),
                          TextButton.icon(
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                showConfirmationDialog(
                                  context,
                                  "Update Setting",
                                  () {
                                    // Action when confirmed
                                    // debugPrint("Confirmed action executed");
                                    // debugPrint("min: ${controllerMinBet.text}");
                                    // debugPrint("max: ${controllerMaxBet.text}");
                                    // debugPrint("current: ${controllerCurrentRound.text}");
                                    // debugPrint("total: ${controllerTotalRoud.text}");
                                    // debugPrint("buy in: ${controllerBuyIn.text}");
                                    // debugPrint("buy in note: ${controllerBuyInNote.text}");
            
                                    serviceAPIs.updateSetting(remaintime: '${state.posts.first.remaintime}', 
                                    remaingame:  state.posts.first.remaingame!, minbet: int.parse(controllerMinBet.text),
                                    maxbet: int.parse(controllerMaxBet.text), 
                                    run: int.parse(controllerCurrentRound.text),
                                    lastupdate: "${DateTime.now().toIso8601String()}",
                                    gamenumber: state.posts.first.gamenumber!, 
                                    roundtext: state.posts.first.roundtext!, 
                                    gametext: state.posts.first.gametext!,
                                    buyin: int.parse(controllerBuyIn.text)).then((v){
                                      if(v['status'] == 1){
                                        showSnackBar(context:context,message:"${v['message']}");
                                      }else{
                                        showSnackBar(context:context,message:"Can not update setting ");
                                      }
                                    }).whenComplete((){
                                      debugPrint('complete update APIs');
                                    });
                                  },
                                );
                              },
                              label: const Text("Update Setting")),
                        ],
                      ),
                    );
                }
              },
            ),
          )),
    );
  }
}
