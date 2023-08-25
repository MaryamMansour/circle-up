import 'package:flutter/material.dart';

abstract class BaseConnector{
  void showLoading(String message);
  void showMessage(String message);
  void hideDialog();
}

class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier{
  CON? connector;

}

abstract class BaseView < VM extends BaseViewModel, T extends StatefulWidget>
    extends State<T> implements BaseConnector{

  late VM viewModel ;

  VM initViewModel();

  void initState(){
    super.initState();
    viewModel=initViewModel();
  }
  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading(String message) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Row(
        children: [
          Center(child: CircularProgressIndicator()),
          Text(message),
        ],
      ),
    ),);
  }

  @override
  void showMessage(String message) {
    hideDialog();
    showDialog(context: context, builder: (context) => AlertDialog(
      title:Text("Error"),
      content: Text(message),
    ),);
  }



}