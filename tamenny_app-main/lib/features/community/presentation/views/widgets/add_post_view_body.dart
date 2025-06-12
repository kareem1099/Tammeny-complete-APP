import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/add_post_button_bloc_consumer.dart';
import 'package:tamenny_app/generated/l10n.dart';

class AddPostViewBody extends StatefulWidget {
  const AddPostViewBody({super.key});

  @override
  State<AddPostViewBody> createState() => _AddPostViewBodyState();
}

class _AddPostViewBodyState extends State<AddPostViewBody> {
  TextEditingController postController = TextEditingController();

  File? selectedImage;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
      child: Column(
        children: [
          TextField(
            controller: postController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.of(context).addPostHintText,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),
          if (selectedImage != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(selectedImage!,
                      height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => selectedImage = null),
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue),
                      onPressed: pickImage),
                ],
              ),
              AddPostButtonBlocConsumer(
                postTextController: postController,
                selectedImage: selectedImage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
