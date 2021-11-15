import 'package:flutter/material.dart';
import 'package:parkinglot/widget/navigationBar.dart';
import '../models/HistoryList.dart';
import '../util/colors.dart';


class CheckReservation extends StatefulWidget {
  const CheckReservation({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CheckReservation> createState() => _CheckReservationState();
}

class _CheckReservationState extends State<CheckReservation> {


  List<HistoryList> historyList = [
    HistoryList('park.png','대한극장주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
    HistoryList('park.png','장충공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
    HistoryList('park.png','필동공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: <Widget> [
                Tab(
                  child: Text('과거 예약 내역', style: TextStyle(color: Colors.black54)),
                ),
                Tab(
                  child: Text('현재 예약 내역', style: TextStyle(color: Colors.black54)),
                ),              ],
            ),
            title: const Text('예약 내역 확인', style: TextStyle(color: Colors.black54),),
            backgroundColor: Colors.white,

          ),
            body: ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index){
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        subtitle: Column(
                            children:[
                              Row(
                                children : [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children : [
                                        Text(historyList[index].name,
                                            style: TextStyle(fontSize: 23, color: Colors.black54, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Text(historyList[index].address),
                                        Text(historyList[index].number),
                                        Text(historyList[index].date),
                                        Text(historyList[index].hours),
                                        Text(historyList[index].paidFee),
                                      ]
                                  ),
                                  SizedBox(width: 80),
                                  Image.asset('lib/images/park.png',width: 100, height: 100),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:[
                                    /*TextButton(
                                      onPressed: () =>
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  content: const Text(favoriteConvert, style: TextStyle(fontSize: 15),),
                                                  //children: Image.asset('lib/images/ga.PNG'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context, '취소'),
                                                      child: const Text('취소'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (context) => Favorites()));
                                                      },
                                                      child: const Text('확인'),
                                                    ),
                                                  ],
                                                ),
                                          ),
                                      style: TextButton.styleFrom(backgroundColor: lightGrey, minimumSize: Size(165,20)),
                                      child: const Text('즐겨찾기 추가', style: TextStyle(color: Colors.black)),
                                    ),*/
                                    SizedBox(width: 0),
                                    TextButton(
                                      onPressed: () {  },
                                      style: TextButton.styleFrom(backgroundColor: blue, minimumSize: Size(330,20)),
                                      child: const Text('수정하기', style: TextStyle(color: Colors.white)),
                                    ),
                                    SizedBox(height: 5),
                                  ]
                              )
                            ]
                        ),
                        // --- 이미지 넣기 ---
                      ),
                    )
                );
              },
            )
        ),
      ),
    );
  }
}