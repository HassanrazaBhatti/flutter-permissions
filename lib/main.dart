import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:permissions/camera_screen.dart';
import 'package:permissions/phonelogs_screen.dart';
import 'package:oktoast/oktoast.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
          child: MaterialApp(
        title: 'Flutter Permissions',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Permissions'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  
  void _incrementCounter() {
    
    setState(() {
      _counter++;
    });
  }

openCamera(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );
  }

openPhonelogs(){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhonelogsScreen(),
      ),
    );
}

checkallpermission_opencamera() async{
  Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
      ].request();

    if(statuses[Permission.camera].isGranted){
      if(statuses[Permission.microphone].isGranted){
        openCamera();
      }else{
        showToast("Camera needs to access your microphone, please provide permission", position: ToastPosition.bottom);
      }
    }else{
      showToast("Provide Camera permission to use camera.", position: ToastPosition.bottom);
    }
}
  checkpermission_opencamera() async{
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;
    
    print(cameraStatus);
    print(microphoneStatus);
    //cameraStatus.isGranted == has access to application
    //cameraStatus.isDenied == does not have access to application, you can request again for the permission. 
    //cameraStatus.isPermanentlyDenied == does not have access to application, you cannot request again for the permission. 
    //cameraStatus.isRestricted == because of security/parental control you cannot use this permission. 
    //cameraStatus.isUndetermined == permission has not asked before. 
    
    if (!cameraStatus.isGranted)
      await Permission.camera.request();
      
    if (!microphoneStatus.isGranted)
      await Permission.microphone.request();
    
    if(await Permission.camera.isGranted){
      if(await Permission.microphone.isGranted){
        // PhonelogsScreen();
        openCamera();
      }else{
        showToast("Camera needs to access your microphone, please provide permission", position: ToastPosition.bottom);
      }
    }else{
      showToast("Provide Camera permission to use camera.", position: ToastPosition.bottom);
    } 
  }

  checkpermission_phone_logs() async{
    if(await Permission.phone.request().isGranted){
      openPhonelogs();
    }else {
      showToast("Provide Phone permission to make a call and view logs.", position: ToastPosition.bottom);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                          child: IconButton(onPressed: checkpermission_opencamera, icon: Icon(Icons.camera), iconSize: 42, 
              color: Colors.white,), color: Colors.amber, width: MediaQuery.of(context).size.width, height: (MediaQuery.of(context).size.height - 80) / 2,
            ),
            // Container(
            //               child: IconButton(onPressed: checkpermission_phone_logs, icon: Icon(Icons.phone), iconSize: 42,
            //   color: Colors.white), color: Colors.deepPurple, width: MediaQuery.of(context).size.width, height: (MediaQuery.of(context).size.height - 80) / 2,),
            
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
