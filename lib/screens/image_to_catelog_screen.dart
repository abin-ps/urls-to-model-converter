import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_to_catelog_converter/common_widgets/padded.dart';

import '../common_widgets/reusable_text_button.dart';
import '../models/catelog.dart';

class ImageToCatelogScreen extends StatefulWidget {
  const ImageToCatelogScreen({super.key});

  @override
  State<ImageToCatelogScreen> createState() => _ImageToCatelogScreenState();
}

class _ImageToCatelogScreenState extends State<ImageToCatelogScreen> {
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
          'Image To Catelog Converter',
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
                              'Urls must be seperated with ,\nFor Example:\nhttps://peakpx.com/image1.jpg,\nhttps://peakpx.com/image2',
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: imageUrlsController.text));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text('Copied to Clipboard!')));
                                  },
                                  icon: const Icon(Icons.copy)),
                            ),
                          ),
                        )
                ],
              ),
            ),
            ReusableTextButton(
              onTap: () {
                setState(() {
                  isConverting = true;
                });
                List<String> imageUrls = getUrls(imageUrlsController.text);

                List<Catelog> catelogs = generateCatelogs(imageUrls: imageUrls);

                String output = catelogsAsString(catelogs: catelogs);
                imageUrlsController.clear();
                imageUrlsController.text = output;

                setState(() {
                  isConverting = false;
                  conversionCompleted = true;
                });
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

  catelogsAsString({required List<Catelog> catelogs}) {
    String output = '';
    output += '[\n';
    // print('[');
    for (Catelog c in catelogs) {
      output += '\tCatelog(\n';
      output += '\t\tid: ${c.id},\n';
      output += '\t\tcatelogId: ${c.categoryId},\n';
      output += '\t\tname: ${c.name},\n';
      output += '\t\tdescription: ${c.description},\n';
      output += '\t\timageUrl: ${c.imageUrl},\n';
      output += '\t),\n';
    }
    output += ']';

    return output;
  }

  List<Catelog> generateCatelogs({required List<String> imageUrls}) {
    List<Catelog> catelogs = imageUrls.asMap().entries.map((entry) {
      int index = entry.key;
      String imageUrl = entry.value;
      List<String> parts = imageUrl.split('/');
      String lastPart = parts.last;
      String name = lastPart.split('-').skip(2).join(' ').split('.').first;
      String description = lastPart.split('.').first.replaceAll('-', ' ');
      return Catelog(
        id: '${index + 1}',
        categoryId: '1',
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
