import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video/pages/call.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelcontroller = TextEditingController();
  bool _validateError = false;

  @override
  void dispose() {
    _channelcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SehatYaab"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _startCall(ClientRoleType.clientRoleBroadcaster, "Doctor");
                },
                child: const Text("Doctor"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _startCall(ClientRoleType.clientRoleAudience, "Patient");
                },
                child: const Text("Patient"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startCall(ClientRoleType role, String userType) async {
    _channelcontroller.text = "video"; // Set a default channel
    await _handleCammeraAndMic(Permission.camera);
    await _handleCammeraAndMic(Permission.microphone);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyWidget(
          channelName: _channelcontroller.text,
          role: role,
        ),
      ),
    );
    log("$userType joined as ${role == ClientRoleType.clientRoleBroadcaster ? 'Broadcaster' : 'Audience'}");
  }

  Future<void> _handleCammeraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
