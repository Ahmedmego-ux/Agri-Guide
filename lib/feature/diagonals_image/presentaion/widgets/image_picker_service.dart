import 'dart:convert';
import 'dart:io';

import 'package:agri_guide_app/feature/diagonals_image/presentaion/view/ai_result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  ImagePickerService(this.context);

  final BuildContext context;
  final ImagePicker _picker = ImagePicker();

  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) openAppSettings();
    return false;
  }

  Future<bool> _requestGalleryPermission() async {
    final status = await Permission.photos.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) openAppSettings();
    return false;
  }


  Future<void> pickFromCamera() async {
  final ok = await _requestCameraPermission();
  if (!ok) return;

  final image = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 70,
  );

  if (image != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AIResultScreen(imagePath: image.path),
      ),
    );
  }
}

  Future<void> pickFromGallery() async {
  final ok = await _requestGalleryPermission();
  if (!ok) return;

  final image = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (image != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AIResultScreen(imagePath: image.path),
      ),
    );
  }
}

  void showPickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

 

 
}