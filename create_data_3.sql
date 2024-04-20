use test

function randomString(length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

function randomDecimal() {
  return parseFloat(Math.random().toFixed(12));
}

function randomProjectId() {
  return String(Math.floor(Math.random() * 10000) + 1);  // 1에서 10000 사이의 숫자를 문자열로 반환
}

function createRandomStructure(depth) {
  if (depth === 0) {
    return randomString(10);  // 기본적으로 문자열을 반환
  } else {
    var obj = {};
    if (depth === 5) {
      obj['depthField5'] = createRandomStructure(depth - 1);
    } else if (depth === 4) {
      var fieldType = Math.random();  // 필드 타입을 결정할 난수
      if (fieldType < 0.5) {
        // 50% 확률로 배열 생성
        obj['depthField4'] = Array.from({ length: Math.floor(Math.random() * 3) + 1 }, () => createRandomStructure(depth - 1));
      } else {
        // 50% 확률로 객체 생성
        obj['depthField4'] = createRandomStructure(depth - 1);
      }
    } else {
      obj['depthField' + depth] = createRandomStructure(depth - 1);
    }
    return obj;
  }
}

db.data_example3.insertMany(
    Array.from({ length: 150000 }, () => ({
      "MetadataLocal": {
        "CollectDate": new Date("2024-04-05T01:00:00.000+00:00"),
        "ProductName": "VM",
        "ProductCode": "VM",
        "ProviderName": "AWS",
        "ProjectId": randomProjectId()
      },
      "Result": {
        "ResultExample1": randomString(10),
        "ResultExample2": randomString(10),
        "ResultExample3": randomString(10),
        "ResultExample4": randomString(10),
        "ResultExample5": randomString(10),
        "ResultExample6": randomString(10),
        "ResultExample7": randomString(10),
        "ResultExample8": randomString(10),
        "ResultExample9": randomString(10),
      },
      "Resource": {
        "data": {
          ...createRandomStructure(5)
        },
        "field1": randomString(10),
        "field2": randomString(10),
        "field3": randomString(10),
        "field4": randomString(10),
        "field5": randomString(10),
        "field6": randomString(10),
        "field7": randomString(10),
        "field8": randomDecimal(),  // 소수점 12자리 숫자
      }
    }))
    );
