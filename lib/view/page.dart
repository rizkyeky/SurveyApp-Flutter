library page;

import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
// import '../model/model.dart';
import '../locator.dart';
import '../service/service.dart';
import 'component.dart';

part 'page_home.dart';
part 'page_question.dart';

abstract class Page extends StatefulWidget {

  const Page({
    Key key,
  }) : super(key: key);

  @override
  _PageState createState() => _PageState();

  @protected
  Widget build(BuildContext context);

  @protected
  void init();

  @protected
  void dispose();
}

class _PageState extends State<Page> {
  bool hasOffline = false;

  @override
  void initState() {
    super.initState();
    widget.init();
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ConnectionStatus>(
      valueListenable: locator.get<ConnectionService>().networkStatusNotifier,
      builder: (context, value, child) {
        if (value == ConnectionStatus.offline) {
          Future.delayed(const Duration(milliseconds: 500))
              .then((value) => showNetworkFlash(
                    context,
                    text: 'OFFLINE',
                    color: Colors.red,
                  ));
          hasOffline = true;
        } else if (hasOffline) {
          Future.delayed(const Duration(milliseconds: 500))
              .then((value) => showNetworkFlash(
                    context,
                    text: 'ONLINE',
                    color: Colors.green,
                  ));
        }
        return child;
      },
      child: widget.build(context),
    );
  }
}
