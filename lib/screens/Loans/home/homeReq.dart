import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../connect/connect.dart';


class Homerequest extends StatefulWidget {
   Homerequest({Key? key,required this.uid,required this.type}) : super(key: key);
  var uid,type;
  @override
  State<Homerequest> createState() => _HomerequestState();
}

class _HomerequestState extends State<Homerequest> {
  // List loanTypes=['Home','Education','Gold','Personal','EMI'];

  var acNo=TextEditingController();
  var amt=TextEditingController();
  var mobile=TextEditingController();
  var email=TextEditingController();
  // var _selectedType;
  Future<void> sendData() async {
    var data={
      "acNo":acNo.text,
      "amt":amt.text,
      "mobile":mobile.text,
      "email":email.text,
      "type":widget.type,
      "uid":widget.uid,
    };

    var response=await post(Uri.parse('${Con.url}loanRequest.php'),body: data);
    print(response.body);
    print(response.statusCode);
    if(jsonDecode(response.body)['result']=='success'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Loan Request Send successfully  ...")));
      Navigator.pop(context);
    }else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Send Request  ...")));
        Navigator.pop(context);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home Loan Request"),
          backgroundColor: Colors.indigo.shade900,
          centerTitle: true,
          actions: [
            Icon(Icons.home),
          ]
      ),
      body:Center(
        child: Column(
          children: [

        //     Container(
        //       decoration: BoxDecoration(
        //
        //           borderRadius: BorderRadius.circular(0),
        //
        //
        //       ),
        //       child: DropdownButtonHideUnderline(
        //         child: DropdownButton(
        // isExpanded:true,
        //             hint: Text('  --Select type of relationship--'),
        //             value: _selectedType,
        //             items: loanTypes.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
        //             onChanged: (val){
        //               setState(() {
        //                 _selectedType=val as String?;
        //               });
        //             }
        //         ),
        //       ),
        //     ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0),
            //       ),
            //       labelText: "Type of relationship",
            //       hintText: "Select type of relationship",
            //
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: acNo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  labelText: "Account number",
                  hintText: "Account number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: mobile,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  labelText: "Enter your mobile number with ISD code",
                  hintText: "Mobile",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  labelText: "Email ID",
                  hintText: "Enter your email id",
                ),
              ),
            ),


            ElevatedButton(onPressed: (){

              if(acNo.text.isNotEmpty && mobile.text.isNotEmpty && email.text.isNotEmpty){
                sendData();
                setState(() {

                });
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Fields Required ...")));

              }
            },style: ElevatedButton.styleFrom(
              primary: Colors.indigo.shade900,
            ),
                child: Text("Submit")),
          ],
        ),
      ),

    );
  }
}
