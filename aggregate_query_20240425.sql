// aaa 컬렉션의 ProjectId 업데이트
db.aaa.aggregate([
    {
        $lookup: {
            from: "mapping",
            localField: "project_id",
            foreignField: "project_originId",
            as: "mapping_info"
        }
    },
    {
        $set: {
            "MetadataLocal.ProjectId": { $arrayElemAt: ["$mapping_info.tag.project_fix_id", 0] }
        }
    },
    {
        $merge: { into: "aaa", on: "_id", whenMatched: "replace" }
    }
]);

// cup 컬렉션과 매칭 및 ProjectInfo 업데이트
db.aaa.aggregate([
    {
        $lookup: {
            from: "cup",
            let: {
                project_id: "$MetadataLocal.ProjectId",
                collect_date: "$MetadataLocal.CollectDate"
            },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $and: [
                                { $eq: ["$space_id", "$$project_id"] },
                                { $eq: ["$MetadataLocal.CollectDate", "$$collect_date"] }
                            ]
                        }
                    }
                }
            ],
            as: "cup_info"
        }
    },
    {
        $set: {
            "ProjectInfo": "$cup_info"
        }
    },
    {
        $unset: "ProjectInfo"
    },
    {
        $merge: { into: "aaa", on: "_id", whenMatched: "replace" }
    }
]);