// db.aaa.find().count()
// db.aaa.find()

// function randomString(length) {
//   var result = '';
//   var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
//   var charactersLength = characters.length;
//   for (var i = 0; i < length; i++) {
//     result += characters.charAt(Math.floor(Math.random() * charactersLength));
//   }
//   return result;
// }
//
// db.aaa.insertMany(
//     Array.from({ length: 500000 }, () => ({
//       "mmm": { "ccc": "vm" },
//       "rrr": {
//         "ddd": randomString(10),  // 랜덤 문자열 10자
//         "eee": randomString(10)   // 랜덤 문자열 10자
//       },
//       "field1": randomString(10),
//       "field2": randomString(10),
//       "field3": randomString(10),
//       "field4": randomString(10),
//       "field5": randomString(10),
//       "field6": randomString(10),
//       "field7": randomString(10),
//       "field8": randomString(10),
//       "field9": randomString(10),
//       "field10": randomString(10)
//     }))
//     );

function randomString(length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

function createRandomStructure(depth) {
  if (depth === 0) {
    return randomString(10);  // 재귀의 끝, 랜덤 문자열을 반환
  } else {
    var obj = {};
    var fieldCount = Math.floor(Math.random() * 3) + 1;  // 1~3개의 필드 생성
    for (var i = 0; i < fieldCount; i++) {
      var newDepth = Math.floor(Math.random() * depth);  // 더 낮은 깊이로 재귀
      obj[randomString(5)] = createRandomStructure(newDepth);
    }
    return obj;
  }
}

db.bbb.insertMany(
    Array.from({ length: 20000 }, () => ({
      "mmm": { "ccc": "vm" },
      "rrr": {
        "ddd": randomString(10),  // 랜덤 문자열 10자
        "eee": randomString(10)   // 랜덤 문자열 10자
      },
      ...createRandomStructure(4)  // 최대 4단계의 랜덤 구조 생성
    }))
    );
