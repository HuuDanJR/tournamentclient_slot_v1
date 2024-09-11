import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_client/lib/models/stationmodel.dart';
import 'package:tournament_client/service/service_api.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/loader.bottom.custom.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/xpage/setting/bloc_machine/machine_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_client/xpage/setting/setting.machine.title.dart';
import 'package:tournament_client/xpage/setup/list.item.dart';

class SettingMachinePage extends StatelessWidget {
  const SettingMachinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) =>
          ListMachineBloc(httpClient: http.Client())..add(ListMachineFetched()),
      child: const SettingMachineBodyPage(),
    );
  }
}

class SettingMachineBodyPage extends StatefulWidget {
  const SettingMachineBodyPage({Key? key}) : super(key: key);

  @override
  State<SettingMachineBodyPage> createState() => _SettingMachineBodyPageState();
}

class _SettingMachineBodyPageState extends State<SettingMachineBodyPage> {
  final _scrollController = ScrollController();
  final service_api = ServiceAPIs();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    // debugPrint('reach bottom setting.machine.page');
    if (_isBottom) context.read<ListMachineBloc>().add(ListMachineFetched());
  }

  void _onRefresh() {
    context.read<ListMachineBloc>().add(ListMachineFetched());
    // ignore: invalid_use_of_visible_for_testing_member
    context.read<ListMachineBloc>().emit(const ListMachineState());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Flexible(
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: MyString.padding16),
      width: width,
      height: height / 2,
      child: BlocBuilder<ListMachineBloc, ListMachineState>(
        builder: (context, state) {
          switch (state.status) {
            case ListMachineStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case ListMachineStatus.failure:
              return Center(
                child: TextButton.icon(
                icon:Icon(Icons.refresh),
                onPressed: () {
                  context.read<ListMachineBloc>().add(ListMachineFetched());
                  // ignore: invalid_use_of_visible_for_testing_member
                  context
                      .read<ListMachineBloc>()
                      .emit(const ListMachineState());
                },
                label: const Text('No ranking founds, press to retry'),
              ));
            case ListMachineStatus.success:
              if (state.posts.isEmpty) {
                return const Center(child: Text('no rankings'));
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Setting Machine"),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // TextButton.icon(
                          //     icon: const Icon(Icons.refresh),
                          //     onPressed: () {
                          //       debugPrint('refresh view');
                          //     },
                          //     label: const Text("Refresh")),
                          // const SizedBox(
                          //   width: MyString.padding08,
                          // ),
                          TextButton.icon(
                              icon: const Icon(Icons.disabled_by_default_sharp),
                              onPressed: () {
                                debugPrint('disable all');
                              },
                              label: const Text("Disable All")),
                        ],
                      ),
                    ],
                  ),
                  SettingMachineTitle(width: width),
                  Expanded(
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          physics: const BouncingScrollPhysics(),
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.trackpad
                          },
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _onRefresh();
                          },
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return index >= state.posts.length
                                  ? BottomLoaderCustom(
                                      function: () => _onRefresh(),
                                    )
                                  : itemList(
                                      width: width,
                                      context: context,
                                      model: state.posts,
                                      index: index);
                            },
                            itemCount: state.hasReachedMax
                                ? state.posts.length
                                : state.posts.length + 1,
                            controller: _scrollController,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: MyString.padding16,
                  )
                ],
              );
          }
        },
      ),
    ));
  }
}

Widget itemList(
    {required double width,
    required BuildContext context,
    required int index,
    required List<StationModel?> model}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0.0),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        itemListRT(
          width: width,
          child: textcustom(size: MyString.padding14, text: '${index + 1}'),
        ),
        itemListRT(
          width: width,
          child:
              textcustom(size: MyString.padding14, text: model[index]!.member),
        ),
        itemListRT(
          width: width,
          child:
              textcustom(size: MyString.padding14, text: model[index]!.machine),
        ),
        itemListRT(
          width: width,
          child:
              textcustom(size: MyString.padding14, text: '${model[index]!.ip}'),
        ),
        itemListRT(
          width: width,
          child: textcustom(
              size: MyString.padding14,
              text: '${model[index]!.credit / 100}\$'),
        ),
        itemListRT(
          width: width,
          child: textcustom(
              size: MyString.padding14, text: '${model[index]!.aft}'),
        ),
        itemListRT(
            width: width,
            child: textcustomColor(
              size: MyString.padding14,
              text: model[index]!.connect == 1 ? 'connected' : 'disconnected',
              color: model[index]!.connect == 1 ? Colors.green : Colors.red,
            )),
        Expanded(
          child: itemListRT(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    tooltip: 'enable/disable',
                    onPressed: () {
                      debugPrint('enable/disable ${model[index]!.member}');
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
