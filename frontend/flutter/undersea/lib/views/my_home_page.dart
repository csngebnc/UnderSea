import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undersea/controllers/my_home_page_controller.dart';
import './about_page.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final MyHomePageController controller = Get.put(MyHomePageController());

  MyHomePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                '${controller.count.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(AboutPage());
                },
                child: Text('About GetX'))
            //  Get.off(AboutPage()) ha nem akarjuk, hogy visszamenjen  a back-el
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
