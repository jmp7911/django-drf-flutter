part of 'record.dart';

class MyRecordPage extends StatefulWidget {
  @override
  _MyRecordPageState createState() => _MyRecordPageState();
}

class _MyRecordPageState extends State<MyRecordPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dot Indicator & Record'),
      ),
      body: Text('record')
    );
  }
}