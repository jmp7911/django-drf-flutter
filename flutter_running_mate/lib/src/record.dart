import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:flutter_running_mate/src/geolocator.dart';
part 'record.g.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySwipePage(),
    );
  }
}

class MySwipePage extends StatefulWidget {
  @override
  _MySwipePageState createState() => _MySwipePageState();
}

class _MySwipePageState extends State<MySwipePage> {
  final PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  
  final List<RecordPage> screenContents = [
    RecordPage(name: '목표설정', options: ['시간','거리']),
    RecordPage(name: '목표설정', options: List.generate(4, (index) => ((index+1)*15).toString()+'분|'+(index+1).toString()+'km')),
    RecordPage(name: '페이스(m/km)', options: ['8분','7분45초','7분30초','7분15초','7분','6분45초','6분30초','6분15초','6분']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dot Indicator & Swipe'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier.value = index;
                  
                });
              },
              itemCount: screenContents.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(screenContents[index].name),
                      DropdownButton<String>(
                        value: screenContents[index].selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            screenContents[index].selectedValue = newValue!;
                          });
                        },
                        items: screenContents[index].options.toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () {
                          // "Next" 버튼이 눌렸을 때의 동작 추가
                          
                          // 여기에 다음 화면으로 이동하는 코드를 추가할 수 있습니다.
                          if (screenContents.length > index + 1) {
                            _pageController.animateToPage(index+1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyGeolocator()));
                          }
                          
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CirclePageIndicator(
              itemCount: screenContents.length,
              currentPageNotifier: _currentPageNotifier,
              onPageSelected: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
            ),
          ),
        ],
      ),
    );
  }
}



class RecordPage {
  final String name;
  final List<String> options;
  String? selectedValue;

  RecordPage({required this.name, required this.options, this.selectedValue});

}