// use test
// db.data_example3.updateMany(
//     {
//       "MetadataLocal.CollectDate": {
//         $gte: new Date("2024-04-01T00:00:00.000Z"),
//         $lt: new Date("2024-05-01T00:00:00.000Z")
//       },
//       "MetadataLocal.ProductCode":"VM"
//     },
//     [{
//       $set: {
//         "Result.ResultExample1": "$Resource.field1",
//         "Result.ResultExample2": "$Resource.field2",
//         "Result.ResultExample3": "$Resource.field3",
//         "Result.ResultExample4": "$Resource.field4",
//         "Result.ResultExample5": "$Resource.field5",
//         "Result.ResultExample6": "$Resource.field6",
//         "Result.ResultExample7": "$Resource.field7",
//         "Result.ResultExample8": "$Resource.field8",
//         "Result.ResultExample9": {
//           $cond: {
//             if: { $isArray: "$Resource.Data.depthField5.depthField4" },
//             then: {
//               $reduce: {
//                 input: "$Resource.Data.depthField5.depthField4",
//                 initialValue: [],
//                 in: {
//                   $concatArrays: [
//                     "$$value",
//                     {
//                       $cond: {
//                         if: { $isArray: "$$this.depthField3.depthField2.depthField1" },
//                         then: "$$this.depthField3.depthField2.depthField1",
//                         else: ["$$this.depthField3.depthField2.depthField1"]
//                       }
//                     }
//                   ]
//                 }
//               }
//             },
//             else: {
//               $cond: {
//                 if: { $isArray: "$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1" },
//                 then: "$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1",
//                 else: ["$Resource.Data.depthField5.depthField4.depthField3.depthField2.depthField1"]
//               }
//             }
//           }
//         }
//       }
//     }]
//     );
