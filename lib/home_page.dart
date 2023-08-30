
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  WebViewController? _controller;

  bool openMenuStatus = false;
  bool openDetailPage = false;
  bool showGuitar3D = false;

  String js = '''
            (() => {
              const modelViewer = document.querySelector('#guitar_id');
              setInterval(() => {
                modelViewer.cameraOrbit = '-95deg 85deg 15m';
              });
            })();
            ''';

  String js2 = '''
            (() => {
              const modelViewer = document.querySelector('#guitar_id');
              setInterval(() => {
                modelViewer.cameraOrbit = '0deg 85deg 7m';            
              });
            })();
            ''';

  String js3 = '''
            (() => {
              const modelViewer = document.querySelector('#guitar_id');
              setInterval(() => {
                modelViewer.cameraOrbit = '0deg 180deg 15m';
              });
            })();
            ''';


  void openMenu(){
    openMenuStatus = !openMenuStatus;
    if(openMenuStatus) {
      _controller?.runJavaScript(js);
    }else{
      _controller?.runJavaScript(js2);
    }
    setState(() {});
  }

  void openDetail(bool open){
    if(open){
      openDetailPage = true;
      _controller?.runJavaScript(js3);
    }else{
      openDetailPage = false;
      _controller?.runJavaScript(js2);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);

    return Scaffold(

      body: GestureDetector(
        onVerticalDragUpdate: (value){
          if(value.delta.dy < 0){
            openDetail(true);
          }else{
            openDetail(false);
          }
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          height: size.height,
          width: size.width,
          color: openMenuStatus || openDetailPage
              ? const Color(0xffa1a18a)
              : const Color(0xffd7c9a5),
          child:  Stack(
            alignment: Alignment.center,
            children: [


              ///GUITAR 3D
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: openDetailPage ? -140 : 170,
                child: SizedBox(
                  height: size.height * .65,
                  width: size.width,
                  child: ModelViewer(
                    cameraControls: false,
                    src: 'assets/guitar.glb',
                    ar: false,
                    javascriptChannels: const {},
                    id: "guitar_id",
                    interpolationDecay: 180,
                    onWebViewCreated: (WebViewController controller){
                      _controller = controller;
                    },

                  ),
                ),
              ),


              ///MENU
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                top: 50,
                left: openMenuStatus ? size.width - 60 : 10,
                child: SizedBox(
                  width: size.width,
                  height: 70,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: openMenu,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xffd7c9a5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.menu,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: size.width - 90,
                        height: 70,
                        child: const Text("Product Detail",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),


              ///FENDER TXT
              Positioned(
                top: 160,
                left: 0,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: openDetailPage ? 0 : 1,
                    child: const Text("FENDER",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: Colors.black12

                    ),),
                  ),
                ),
              ),


              ///Fender American Elite TXT
              Positioned(
                bottom: 50,
                left: 30,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: openMenuStatus ? 400 : 1200),
                  opacity: openMenuStatus ? 0 : 1,
                  child: const Text("Fender\nAmerican\nElite",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1.2
                    ),
                  ),
                ),
              ),


              ///3d icon
              Positioned(
                bottom: 60,
                right: 30,
                child: GestureDetector(
                  onTap: (){
                      setState(() {
                        showGuitar3D = true;
                      });
                  },
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: openMenuStatus ? 400 : 1200),
                    opacity: openMenuStatus ? 0 : 1,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.view_in_ar, size: 40,),
                        SizedBox(height: 5,),
                        Text("3D\nView",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1

                        ),)

                      ],
                    ),
                  ),
                ),
              ),


              ///Menu
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                left: openMenuStatus ? 0: -size.width * .4,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.all(20),
                  height: size.height,
                  width: size.width * .4,
                  color: openMenuStatus
                      ? const Color(0xffd7c9a5)
                      : const Color(0xffa1a18a),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 150,),
                      Container(
                        margin: const EdgeInsets.only(left: 15,bottom: 5),
                        height: 60,
                        width: 60,
                        child: Image.asset("assets/guitar_img.png"),
                      ),
                      const Text("STRINGS",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                        ),
                      ),

                      const SizedBox(height: 120,),
                      const Text("GUITARS",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff962d2d),
                            height: 2
                        ),
                      ),
                      const Text("BASSES",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            height: 2
                        ),
                      ), const Text("GUITARS",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            height: 2
                        ),
                      ), const Text("AMPS",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            height: 2
                        ),
                      ), const Text("PEDALS",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            height: 2
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      const Text("ABOUT",
                        style: TextStyle(
                         fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("SUPPORT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 2
                        ),
                      ),
                      const Text("TERMS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 2
                        ),
                      ),
                      const Text("FAQ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),



              ///Details
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                bottom: openDetailPage ? 0 : - size.height * .65,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  height: size.height * .65,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffd7c9a5),
                    border: Border(
                      top: BorderSide(
                        color: Color(0xffe0d5c9),
                        width: 8
                      )
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      const Text("Fender\nAmerican\nElite",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            height: 1.2
                        ),
                      ),

                      const SizedBox(height: 10,),

                      const Text("A Fender Stratocaster é um modelo de guitarra elétrica desenhada por Leo Fender, George Fullerton e Freddie Tavares em 1954, é fabricada continuamente até os dias de hoje, sendo uma das guitarras mais famosas da história",
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10,),

                      Expanded(
                          child: Image.network("https://www.guitarshop.com.br/media/amasty/blog/cache/1/5/740/368/15-fatos-stratocaster.jpg",
                            fit: BoxFit.cover,
                          )
                      ),
                    ],
                  ),
                ),
              ),



              if(showGuitar3D)
              Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const ModelViewer(
                      src: 'assets/guitar.glb',
                      ar: false,
                    ),

                    Positioned(
                      top: 60,
                        right: 20,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              showGuitar3D = false;
                            });
                          },
                          child: const Row(
                            children: [
                              Text("Close", style: TextStyle(fontSize: 18),),
                              Icon(Icons.close_rounded)
                            ],
                          ),
                        )
                    )
                  ],
                ),
              )





            ],
          ),
        ),
      ),


    );
  }
}
