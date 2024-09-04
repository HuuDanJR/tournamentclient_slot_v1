import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tournament_client/home_test.dart';
import 'package:tournament_client/admin_verify.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/home_mongo_test.dart';
import 'package:tournament_client/authentication/viewpage.dart';

class ContainerPage extends StatefulWidget {
  String url;
  int selectedIndex;

  ContainerPage({Key? key, required this.url, required this.selectedIndex})
      : super(key: key);
  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  
  // late final Future<LottieComposition> _composition;
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    print('ContainerPage: initstate');
    // print('index: ${widget.selectedIndex}');
    //lottie using here
    // _composition = AssetLottie(lottiePath).load();
    _controller = VideoPlayerController.asset('asset/bg_video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and set it to loop.
        setState(() {
          _controller!.setLooping(true);
          _controller!.play();
        });
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ContainerPage:did change dependency');
  }

  @override
  void dispose() {
    super.dispose();
    print('ContainerPage: disposed');
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // final ContainerPage args = ModalRoute.of(context)!.settings.arguments as ContainerPage;

    // String url_parent = args.url;
    // int selectedIndex_parent = args.selectedIndex;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   child: Icon(Icons.arrow_back, color: MyColor.white),
      // ),
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          print('Back button pressed! Navigating to another screen...');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AdminVerify(),
          ));
          // Navigator.of(context).pop();
          return false;
        },
        child: Stack(
          children: [
            Container(width: width, height: height, color: MyColor.black_text),
            //LOADING BACKGROUND
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.size.width ?? width,
                  height: _controller!.value.size.height ?? height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
            // loadingbackground(composition: _composition,height:height,width:width),
            // Lottie.asset(lottiePath,width: width,height:height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  // color:const Color.fromRGBO(223, 204, 188, 1),
                  width: width / 2,
                  height: height,
                  child: 
                  // kIsWeb 
                  // ? 
                  ViewPage(
                          url: widget.url,
                          child: 
                          HomeMongoTest(
                          title: 'TNM V3',
                          url: widget.url,
                          selectedIndex: MyString.DEFAULTNUMBER),
                        )
                  // : 
                  // HomeMongoTest(
                  //         title: 'Tournament Client',
                  //         url: widget.url,
                  //         selectedIndex: MyString.DEFAULTNUMBER),
                ),
                SizedBox(
                  width: width / 2,
                  height: height,
                  child: HomeTest(
                    url: widget.url,
                    selectedIndex: widget.selectedIndex,
                    title: 'Tournament Client',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
