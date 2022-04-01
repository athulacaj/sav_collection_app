import 'package:flutter/material.dart';

class WidgetViewFullScreen extends StatelessWidget {
  final Widget child;
  const WidgetViewFullScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double childHight = 100;
    final GlobalKey _childKey = GlobalKey();

    Dialog fullScreenDialog = Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        child: Container(
            color: Colors.red,
            width: size.width,
            height: size.height,
            child: child));
    return GestureDetector(
      onTap: () {
        childHight = _childKey.currentContext?.size?.height ?? 100;
        //
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                MyZoomableWidget(child: child, childHeight: childHight)));
      },
      child: Container(key: _childKey, child: child),
    );
  }
}

class MyZoomableWidget extends StatelessWidget {
  final Widget child;
  final double childHeight;
  const MyZoomableWidget(
      {Key? key, required this.child, required this.childHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("childHeight ${childHeight}");
    TransformationController transformationController =
        TransformationController();

    Matrix4 n =
        Matrix4.fromList([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, .69]);
    transformationController.value = n..translate(-56.0, 0.0);
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.white.withOpacity(
      //     0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Colors.red, size: 30)),
          Expanded(
            child: ListView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                // TextButton(
                //     onPressed: () {
                //       Matrix4 n = Matrix4.fromList(
                //           [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, .69]);
                //       transformationController.value = n..translate(-56.0, 0.0); //
                //     },
                //     child: Text("click here")),

                InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 4.0,
                  panEnabled: false,
                  scaleEnabled: false,
                  // alignPanAxis: true,
                  // boundaryMargin: const EdgeInsets.all(1000),
                  // constrained: false,
                  transformationController: transformationController,
                  child: Container(
                      // 1/.69
                      constraints: BoxConstraints(
                          maxHeight: childHeight * (1 / .69) + 20),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * .16, vertical: 20),
                      child: child),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       vertical: size.width * .5, horizontal: 50),
                //   child: RotatedBox(
                //     child: child,
                //     quarterTurns: 1,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
