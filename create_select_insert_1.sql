use test
// example layer2 > layer3
db.data_example3.aggregate([
  {
    // stage 1: filter
    $match: {
      "MetadataLocal.CollectDate": {
        $gte: new Date("2024-04-01T00:00:00.000Z"),
        $lte: new Date("2024-04-30T23:59:59.999Z")
      }
    }
  },
  {
    // stage 2: group by day and calculate the avg
    $group: {
      _id: {date: "$MetadataLocal.CollectDate"
      },
      avgResultExample8: {
        $avg:
          "$Result.ResultExample8"
      }
    }
  },
  {
    // stage 3: project only the necessary data
    $project: {
      _id: 0,
      "MetadataLocal.CollectDate": "$_id",
      "Result.ResultExample8_avg": "$avgResultExample8"
    }
  },
  {
    // stage 4: merge the result into the data_example3_layer3
    $merge: {
      into: "data_example3_layer3",
      // on: "MetadataLocal.CollectDate",
      whenMatched: "replace",
      whenNotMatched: "insert"
    }
  }
]);
