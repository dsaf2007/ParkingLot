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
    HistoryList('park.png','필동공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
    HistoryList('park.png','필동공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
    HistoryList('park.png','필동공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),
    HistoryList('park.png','필동공영주차장1', '서울 중구 필동 2가','02-1234-5678', '날짜', '시간', '결제금액'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('예약 내역 확인',
            style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: '과거 예약 내역'),
                  Tab(text: '현재 예약 내역'),
                ],
              )
            ),
            Container(
              height: 505,
              decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
            ),
            child: TabBarView(children: <Widget>[
              Container(
                child: Center(
                  child: ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index){
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
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
                                                  style: TextStyle(fontSize: 23, color: blue, fontWeight: FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text(historyList[index].address),
                                              Text(historyList[index].number),
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
                                          TextButton(
                                            onPressed: () => (){},
                                            style: TextButton.styleFrom(backgroundColor: lightGrey, minimumSize: Size(165,20)),
                                            child: const Text('즐겨찾기 추가', style: TextStyle(color: Colors.black)),
                                          ),
                                          SizedBox(width: 10),
                                          TextButton(
                                            onPressed: () {  },
                                            style: TextButton.styleFrom(backgroundColor: blue, minimumSize: Size(165,20)),
                                            child: const Text('예약하기', style: TextStyle(color: Colors.white)),
                                          ),
                                          SizedBox(height: 5),
                                        ])
                                  ]),
                              // --- 이미지 넣기 ---
                            ),
                          ));
                    },
                  )
                ),),
              Container(
                child: Center(
                  child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),),
            ],
          ),
        ),

          ]
        )
      ),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),

    );
  }
}