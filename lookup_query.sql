db.LAYER1_HPC.aggregate([
    {
        $match: {
            "MetadataLocal.CollectDate": ISODate("2024-05-12T01:00:00Z")
        }
    },
    {
        $lookup: {
            from: "LAYER2_BASEFIELD",
            localField: "MetadataLocal.ProductCode",
            foreignField: "MetadataLocal.ProductCode",
            as: "product_info"
        }
    },
    {
        $match: {
            "product_info": { $ne: [] }
        }
    },
    {
        $unwind: "$product_info"
    },
    {
        $group: {
            _id: "$MetadataLocal.ProductName",
            firstServiceProvider: { $first: "$MetadataLocal.ServiceProvider" },
            count: { $sum: 1 }
        }
    },
    {
        $project: {
            _id: 0,
            ProductName: "$_id",
            ServiceProvider: "$firstServiceProvider",
            Count: "$count"
        }
    },
    {
        $unionWith: {
            coll: "LAYER2_BASEFIELD",
            pipeline: [
                {
                    $match: {
                        "MetadataLocal.ServiceProvider": "HPC"
                    }
                },
                {
                    $project: {
                        _id: 0,
                        ProductName: "$MetadataLocal.ProductName"
                    }
                },
                {
                    $lookup: {
                        from: "LAYER1_HPC",
                        let: { productName: "$ProductName" },
                        pipeline: [
                            {
                                $match: {
                                    "MetadataLocal.CollectDate": ISODate("2024-05-12T01:00:00Z")
                                }
                            },
                            {
                                $lookup: {
                                    from: "LAYER2_BASEFIELD",
                                    localField: "MetadataLocal.ProductCode",
                                    foreignField: "MetadataLocal.ProductCode",
                                    as: "product_info"
                                }
                            },
                            {
                                $match: {
                                    "product_info": { $ne: [] }
                                }
                            },
                            {
                                $unwind: "$product_info"
                            },
                            {
                                $group: {
                                    _id: "$MetadataLocal.ProductName",
                                    firstServiceProvider: { $first: "$MetadataLocal.ServiceProvider" },
                                    count: { $sum: 1 }
                                }
                            },
                            {
                                $match: {
                                    $expr: {
                                        $eq: ["$_id", "$$productName"]
                                    }
                                }
                            }
                        ],
                        as: "hpc_data"
                    }
                },
                {
                    $addFields: {
                        Count: {
                            $cond: { if: { $gt: [{ $size: "$hpc_data" }, 0] }, then: { $arrayElemAt: ["$hpc_data.Count", 0] }, else: 0 }
                        },
                        ServiceProvider: {
                            $cond: { if: { $gt: [{ $size: "$hpc_data" }, 0] }, then: { $arrayElemAt: ["$hpc_data.firstServiceProvider", 0] }, else: null }
                        }
                    }
                },
                {
                    $project: {
                        ProductName: 1,
                        ServiceProvider: 1,
                        Count: 1
                    }
                }
            ]
        }
    },
    {
        $group: {
            _id: "$ProductName",
            ServiceProvider: { $first: "$ServiceProvider" },
            Count: { $first: "$Count" }
        }
    },
    {
        $project: {
            _id: 0,
            ProductName: "$_id",
            ServiceProvider: 1,
            Count: 1
        }
    }
])