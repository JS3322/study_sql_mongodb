use test
db.data_example3.aggregate([
  {
    $match: {
      "MetadataLocal.CollectDate": {
        $gte: new Date("2024-04-02T00:00:00.000Z"),
        $lt: new Date("2024-04-03T00:00:00.000Z")
      },
      "MetadataLocal.ProductCode": "VM"
    }
  },
  {
    $set: {
      "Result.ResultExample1": "$Resource.field1",
      "Result.ResultExample2": "$Resource.field2",
      "Result.ResultExample3": "$Resource.field3",
      "Result.ResultExample4": "$Resource.field4",
      "Result.ResultExample5": "$Resource.field5",
      "Result.ResultExample6": "$Resource.field6",
      "Result.ResultExample7": "$Resource.field7",
      "Result.ResultExample8": "$Resource.field8",
      "Result.ResultExample9": {
        $cond: {
          if: { $isArray: "$Resource.Data.depthField5.depthField4" },
          then: {
            $reduce: {
              input: "$Resource.Data.depthField5.depthField4",
              initialValue: [],
              in: {
                $concatArrays: [
                  "$$value",
                  {
                    $map: {
                      input: "$$this.depthField3.depthField2",
                      as: "d3d2",
                      in: {
                        $reduce: {
                          input: "$$d3d2.depthField1",
                          initialValue: [],
                          in: {
                            $concatArrays: [
                              "$$value",
                              ["$$this"]
                            ]
                          }
                        }
                      }
                    }
                  }
                ]
              }
            }
          },
          else: {
            $cond: {
              if: { $isArray: "$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1" },
              then: "$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1",
              else: ["$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1"]
            }
          }
        }
      }
    }
  },
  {
    $lookup: {
      from: "data_projectInfo",
      localField: "MetadataLocal.ProjectId",
      foreignField: "spaceId",
      as: "projectInfoTemp"
    }
  },
  {
    $set: {
      "projectInfo": { $arrayElemAt: ["$projectInfoTemp", 0] }
    }
  },
  {
    $unset: "projectInfoTemp"  // 임시로 생성된 projectInfoTemp 필드를 제거
  },
  {
    $merge: {
      into: "data_example3", // 결과를 다시 같은 컬렉션에 병합
      on: "_id", // 기존 도큐먼트와 매칭할 필드
      whenMatched: "replace" // 일치할 때는 새 데이터로 대체
    }
  }
]);
