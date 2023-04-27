import 'package:flutter/material.dart';

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
          top: 8,
          bottom: 8,
          left: widget.meSend ? 0 : 24,
          right: widget.meSend ? 24 : 0),
      alignment: widget.meSend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
          color: widget.meSend
              ? Theme.of(context).primaryColor.withOpacity(0.8)
              : Colors.grey[700],
        ),
        child: Text(
          widget.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: widget.meSend ? Colors.white : Colors.white,
          ),
        ),
      ),
    );
  }
}
