import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:matcher/matcher.dart';

class Messagetile extends StatefulWidget {
  final String message;
  final String sender;
  final bool meSend;
  const Messagetile(
      {Key? key,
      required this.message,
      required this.sender,
      required this.meSend})
      : super(key: key);

  @override
  State<Messagetile> createState() => _MessagetileState();
}

class _MessagetileState extends State<Messagetile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.meSend ? 0 : 24,
          right: widget.meSend ? 24 : 0),
      alignment: widget.meSend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.meSend
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: widget.meSend
              ? const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
          color:
              widget.meSend ? Theme.of(context).primaryColor : Colors.grey[700],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: widget.meSend
                ? const TextStyle(fontSize: 16)
                : const TextStyle(fontSize: 16, color: Colors.white),
          )
        ]),
      ),
    );
  }
}
