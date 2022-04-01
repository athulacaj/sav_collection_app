import 'package:cloud_firestore/cloud_firestore.dart';

savePlayerOrReset() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore
      .collection("records")
      .doc('players')
      .set({'players': players});
}

List players = [
  {
    "name": "AKHIL JOSE",
    "current team": "Green Star kollada",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "PRASHOB KUMAR",
    "current team": "YOUNG STAR KOROM",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AKSHAY RAMESH",
    "current team": "TYCC CHERUPUZHA",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ARUN EB",
    "current team": "AMIGOS PRAPOYIL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "NITHIN",
    "current team": "PERUMBADAVE",
    "role": "ALL-ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "AJO E",
    "current team": "THIRUMENI",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ASWIN KS",
    "current team": "CHERUPUZHA",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHANAVAS",
    "current team": "MATOOL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHINTO",
    "current team": "PERUMBADV",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "JAYRAJ",
    "current team": "PERUMBADV",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHARAFUDHEEN",
    "current team": "SREEKANDAPURAM",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "MUJEEB K P",
    "current team": "SREEKANDAPURAM",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AKHIL MANOJ",
    "current team": "PALAVAYAL",
    "role": "ALL - ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "ARUN BALAN",
    "current team": "PRAPOYIL",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SUDHEESH K",
    "current team": "CHITTRIKAL",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABHIJITH P",
    "current team": "PRAPOYIL",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SREEJITH SUSHEELA",
    "current team": "VANGAD",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ASWANTH",
    "current team": "PRAPOYIL",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "FAISAL",
    "current team": "MATOOL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SANDEEP",
    "current team": "PRAPOYIL",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "JISHNU",
    "current team": "ALAKODE",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RINEESH",
    "current team": "PAYYANUR",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "GOKUL BALAN",
    "current team": "ALAKODE",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "VIPIN CV",
    "current team": "ALAKODE",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABDU",
    "current team": "CHERUPUZHA",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "MOHAMED JABIR",
    "current team": "PAZHAYANGADI",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "GAUTHAM",
    "current team": "CHERUPUZHA",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABHAYAN",
    "current team": "PALLIMUKKU",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "JOMON",
    "current team": "PALLIMUKKU",
    "role": "ALL-ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "JITHU",
    "current team": "ALAKODE",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "EBIN VARGHESE",
    "current team": "NARKILAKAD",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANAS",
    "current team": "NADUVIL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RENJITH P B",
    "current team": "NADUVIL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AJESH MON",
    "current team": "ALAKODE",
    "role": "ALL-ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "M SALAH",
    "current team": "AMIGOS PRAPOYIL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHANTU",
    "current team": "PHOENIX PERUMBADAVU",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ROSHIT",
    "current team": "VYC CHATTIVAIL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SUBEESH",
    "current team": "CHERUPUZHA",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AKHIL",
    "current team": "AMIGOS PRAPOYIL",
    "role": "BATTER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "SUBIN C P",
    "current team": "FRIENDS 56",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "HAMSA",
    "current team": "MOONI XPLOD",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "FAWAS",
    "current team": "FCB MASAFI",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABHJITH",
    "current team": "AMIGOS PRAPOYIL",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SREELAL",
    "current team": "PERUMBADAVU",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SABIR TV",
    "current team": "MASAFI",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RAJESH T",
    "current team": "YOUNG VOICE",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RENJI",
    "current team": "PHONENIX PERUMBADAVU",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RASHID",
    "current team": "FCB MATTOOL",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ALI",
    "current team": "FCB MATTOOL",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHANIL",
    "current team": "PHOENIX PERUMBADAVU",
    "role": "BATTER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "UNNI",
    "current team": "ARJUNA N",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ASHARAF",
    "current team": "FCB MATTOOL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "MUFEED",
    "current team": "BYC",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ARSHID",
    "current team": "BYC",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANAND T",
    "current team": "PHOENIX PERUMBADAVU",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SANI",
    "current team": "PARU-CHUNKS",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "MAHAROOF",
    "current team": "PLAY BOYS",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANOOP",
    "current team": "AMBRO 11",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SUJITH",
    "current team": "MASTERS PERINGOME",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABJITH",
    "current team": "MASTERS PERINGOME",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANFEER",
    "current team": "FCC",
    "role": "ALL-ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "JERIN ABHRAHAM",
    "current team": "TOWN TEAM CHITTARIKAL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "JUSTINE",
    "current team": "MCA THERTHALLI",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SUJITH CK",
    "current team": "CRICKET TEAM CHERUKUNNU",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SANEESH P",
    "current team": "PHOENIX PERUMBADAVE",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SARIN KUMAR",
    "current team": "TYCC",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "PRAJEESH",
    "current team": "AMIGOS",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANOOP",
    "current team": "AMIGOS",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "NIVILASH",
    "current team": "SRIKANDAPURAM",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AKHIL PAROTHUMNEER",
    "current team": "AMIGOS",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SAJITH K",
    "current team": "KDR",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "AFSAL",
    "current team": "GS PEDENA",
    "role": "ALL - ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SARATH",
    "current team": "MASTERS PERINGOME",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ADIL TP",
    "current team": "GREEN STAR NHEKLY",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ABDU",
    "current team": "MASTERS PERINGOME",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RAJUL",
    "current team": "S H PAYYAVOOR",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "VIPIN NARAYAN",
    "current team": "S H PAYYAVOOR",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RAHUL",
    "current team": "FCC",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SUMESH",
    "current team": "AMIGOS",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "NOUFAL",
    "current team": "EMIRATES PERINGOME",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "MURSHID",
    "current team": "TOWN TEAM PUTHIYANGADI",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ARUN THAMBAN",
    "current team": "TOWN TEAM CHERUPUZHA",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "ANEESH S",
    "current team": "PERINGOME",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RAZI MALAY",
    "current team": "VIVA BOYS PUTHIYANGADI",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SHIHAB",
    "current team": "GREEN STAR KOLLADA",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "JOYAL MATHEW",
    "current team": "FCC KANNIKALAM",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SABITH",
    "current team": "AMIGOS",
    "role": "BATTER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SONU",
    "current team": "CHITTARIKAL",
    "role": "ALL-ROUNDER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "SANEESH",
    "current team": "CHITTARIKAL",
    "role": "ALL-ROUNDER",
    "hand": "LEFT-HAND"
  },
  {
    "name": "ADISH",
    "current team": "CHITTARIKAL",
    "role": "BOWLER",
    "hand": "RIGHT-HAND"
  },
  {
    "name": "RAJESH THAMBAN",
    "current team": "CHITTARIKAL",
    "role": "BOWLER",
    "hand": "LEFT-HAND"
  }
];
