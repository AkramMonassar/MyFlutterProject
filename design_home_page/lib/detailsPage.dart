import 'dart:io';

import 'package:design_home_page/DataDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';



class PlaceDetailsPage extends StatelessWidget {
  var widt;

  PlaceDetailsPage(DataDetails filsmpile);
  DataDetails dataDetails = DataDetails();

  @override
  Widget build(BuildContext context) {
    widt = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _getImage(),
        _getEvalutePart(),
        _getFromPhon(),
        _getPragraph(),
        _getFromPhon2(),
        _getFromPhon3()

      ],
    );
  }

  _getImage() {
    return Container(
      height: 120,
      width: 500,
      color: Colors.red,
      child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            DataDetails.filsmpile().imageUrl,
          )),
    );
  }

  _getEvalutePart() {
    return Container(
      width: widt,
      // height: 200,
      // color: Colors.grey,
      padding: const EdgeInsets.all(28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DataDetails.filsmpile().mainText,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  DataDetails.filsmpile().city,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                )
              ],
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text(DataDetails.filsmpile().evalut_Number),
        ],
      ),
    );
  }

  _drawIcon_and_Text(IconData ic, String s) {
    return Column(
      children: [
        Icon(
          ic,
          color: Colors.blue,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            s,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  _getCall() {
    return InkWell(
      onTap: () {
        _makingPhoneCall();
      },
      child: _drawIcon_and_Text(Icons.call, DataDetails.filsmpile().phone),
    );
  }

  _getMessage() {
    return InkWell(
      onTap: () async {
        var url = Uri.parse("sms:+967775180222");
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: _drawIcon_and_Text(Icons.message, DataDetails.filsmpile().message),
    );
  }
  _getImageFromShareOnline() {
    return InkWell(
      onTap: () async {
        const urlImage = "https://unsplash.com/photos/iusJ25iYu1c";
        var url=Uri.parse(urlImage);
        var response=await http.get(url);
        var bytes=response.bodyBytes;

        Directory temp=await getTemporaryDirectory();
        String path='${temp.path}/image.jpg';
        File(path).writeAsBytesSync(bytes);

        await Share.shareFiles([path],text: 'This is Lion is cute');

      },
      child: _drawIcon_and_Text(Icons.ios_share_outlined, 'Online Share'),
    );
  }
  _getShare() {
    return InkWell(
      onTap: () async {
        // share Text
        var urlPreview='https://www.youtube.com/watch?v=MSv38j04EJK';
       await Share.share('This is Lion is cute \n\n $urlPreview');
      },
      child: _drawIcon_and_Text(Icons.share, DataDetails.filsmpile().share),
    );
  }

  _getFromPhon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getCall(),
        _getMessage(),
        _getShare(),
      ],
    );
  }
  _getFromPhon2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getEmail(),
        _getImageFromShareOnline(),
        _getShareImageFromPhone(),
      ],
    );
  }

  _getShareImageFromPhone() {
    return InkWell(
      onTap: () async {
        // share from gallery
        final image=await ImagePicker().pickImage(source: ImageSource.camera);
        if(image==null) return;
        await Share.shareFiles([image.path],text: 'This is lion to cute ');

      },
      child: _drawIcon_and_Text(Icons.mobile_screen_share, 'Share Image'),
    );
  }
  _getEmail() {
    return InkWell(
      onTap: () {
        _makingEmailSend();
      },
      child: _drawIcon_and_Text(Icons.email, 'EMAIL'),
    );
  }

  _getPragraph() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(DataDetails.filsmpile().descrip),
    );
  }

_makingPhoneCall() async {
  var url = Uri.parse("tel:+967775180222");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

  _makingEmailSend() async {
    var url=Uri.parse('mailto:alasbahi12345@gmail.com?subject=News News &body=New%20plugin pluhin');
    if(await canLaunchUrl(url))
    {
      await launchUrl(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  _getFromPhon3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _getEmail(),
        _getFile(),
        _getShareImageFromPhone(),
      ],
    );
  }
  // void _pickFile() async {
  //
  //   // opens storage to pick files and the picked file or files
  //   // are assigned into result and if no file is chosen result is null.
  //   // you can also toggle "allowMultiple" true or false depending on your need
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //
  //   // if no file is picked
  //   if (result == null) return;
  //
  //   // we get the file from result object
  //   final file = result.files.first;
  //
  //   _openFile(file);
  // }

  // void _openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
  _getFile() {
    return InkWell(
      onTap: ()  {
        // _pickFile();
      },
      child: _drawIcon_and_Text(Icons.file_upload, 'Get File'),
    );
  }



}
