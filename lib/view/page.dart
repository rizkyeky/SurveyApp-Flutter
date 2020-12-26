library page;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/bloc.dart';
// import '../model/model.dart';
import '../service/service.dart';
import 'component.dart';

part 'page_home.dart';

abstract class Page<T extends Bloc> extends StatefulWidget {
  Page({
    Key key,
  }) : super(key: key);

  @override
  _PageState<T> createState() => _PageState<T>();

  @protected
  Widget build(BuildContext context, T bloc);

  @protected
  void init();

  @protected
  void dispose();
}

class _PageState<T extends Bloc> extends State<Page<T>> {
  bool hasOffline = false;

  @override
  void initState() {
    super.initState();
    if (widget.init != null) {
      widget.init();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.dispose != null) {
      widget.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    T bloc = Provider.of<T>(context);

    return ValueListenableBuilder<ConnectionStatus>(
      valueListenable: Provider.of<ConnectionService>(context).networkStatusNotifier,
      builder: (context, value, child) {
        if (value == ConnectionStatus.offline) {
          Future.delayed(const Duration(seconds: 1))
            .then((value) => showNetworkFlash(
              context,
              text: 'OFFLINE',
              color: Colors.red,
            ));
          hasOffline = true;
        } else if (hasOffline) {
          Future.delayed(const Duration(seconds: 1))
            .then((value) => showNetworkFlash(
              context,
              text: 'ONLINE',
              duration: const Duration(seconds: 2),
              color: Colors.green,
            ));
        }
        return child;
      },
      child: widget.build(context, bloc),
    );
  }
}
