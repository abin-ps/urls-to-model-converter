import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_to_catelog_converter/common_widgets/padded.dart';

import '../app_utils.dart';
import '../common_widgets/reusable_text_button.dart';
import '../models/model.dart';

class UrlsToModelScreen extends StatefulWidget {
  const UrlsToModelScreen({super.key});

  @override
  State<UrlsToModelScreen> createState() => _UrlsToModelScreenState();
}

class _UrlsToModelScreenState extends State<UrlsToModelScreen> {
  final TextEditingController imageUrlsController = TextEditingController();
  bool isConverting = false;
  bool conversionCompleted = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle warningTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.redAccent.shade200,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Urls To Model Converter',
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padded(
              child: Stack(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 700),
                    child: TextFormField(
                      onChanged: (v) {
                        if (conversionCompleted == true) {
                          setState(() {
                            conversionCompleted = false;
                          });
                        }
                      },
                      maxLines: null,
                      controller: imageUrlsController,
                      readOnly: isConverting,
                      decoration: InputDecoration(
                          hintText:
                              'Paste Urls like:\nhttps://peakpx.com/sample-image1, https://peakpx.com/sample-image2',
                          hintMaxLines: 3,
                          // hintText:
                          //     'Urls must be seperated with ,\nFor Example:\nhttps://peakpx.com/image1.jpg,\nhttps://peakpx.com/image2',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  !conversionCompleted
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 36,
                            width: 36,
                            padding: const EdgeInsets.only(right: 12, top: 12),
                            child: IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: imageUrlsController.text));
                                AppUtils.showSnackBar(context, message: 'Copied to Clipboard!');
                              },
                              icon: const Icon(Icons.copy),
                              iconSize: 24,
                              padding: const EdgeInsets.all(0),
                            ),
                          ),
                        )
                ],
              ),
            ),
            ReusableTextButton(
              onTap: () {
                if (imageUrlsController.text.isEmpty) {
                  AppUtils.showSnackBar(context, message: 'No urls found!');
                } else {
                  setState(() {
                    isConverting = true;
                  });
                  List<String> imageUrls = getUrls(imageUrlsController.text);

                  List<Model> catelogs = generateCatelogs(imageUrls: imageUrls);

                  String output = catelogsAsString(catelogs: catelogs);
                  imageUrlsController.clear();
                  imageUrlsController.text = output;

                  setState(() {
                    isConverting = false;
                    conversionCompleted = true;
                  });
                }
              },
              isLoading: isConverting,
              buttonText: 'Convert',
            ),
            Padded(
                child: Text(
              '* note: Currently its only supports \'peakpx.com\'',
              style: warningTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            )),
          ],
        ),
      )),
    );
  }

  catelogsAsString({required List<Model> catelogs}) {
    String output = '';
    output += '[\n';
    // print('[');
    for (Model c in catelogs) {
      output += '\nModel(\n';
      output += '\t\tid: \'${c.id}\',\n';
      output += '\t\tname: \'${c.name}\',\n';
      output += '\t\tdescription: \'${c.description}\',\n';
      output += '\t\timageUrl: \'${c.imageUrl}\',\n';
      output += '\t),\n';
    }
    output += ']';

    return output;
  }

  List<Model> generateCatelogs({required List<String> imageUrls}) {
    List<Model> catelogs = imageUrls.asMap().entries.map((entry) {
      int index = entry.key;
      String imageUrl = entry.value;
      List<String> parts = imageUrl.split('/');
      String lastPart = parts.last;
      String name = lastPart.split('-').skip(2).join(' ').split('.').first.trim();
      String description = lastPart.split('.').first.replaceAll('-', ' ').replaceAll('thumbnail', '').trim();
      return Model(
        id: '${index + 1}',
        name: name,
        description: description,
        imageUrl: imageUrl,
      );
    }).toList();

    return catelogs;
  }

  List<String> getUrls(String urls) {
    return urls.split(',').map((url) => url.trim().replaceAll("'", "")).toList();
  }
}
