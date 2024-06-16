use test
// application level에서 조회해야 데이터 출력
// query에서는 objectId 출력

db.TB_CHAILD_DATA.insertMany([
  {
    "name": "Document 15"
  },
  {
    "name": "Document 16"
  },
  {
    "name": "Document 17"
  }
])

db.TB_PARENT_DATA.insertOne({
  "name": "Reference Document2",
  "data.referencesList": [
    ObjectId("60f8c0a4f1a3c123456789aa"),
    ObjectId("60f8c0a4f1a3c123456789ab"),
    ObjectId("60f8c0a4f1a3c123456789ac"),
    ObjectId("666e39ae69fc1e2aac3757fc"),
    ObjectId("666e39ae69fc1e2aac3757fd"),
    ObjectId("666e39ae69fc1e2aac3757fe"),
  ]
})