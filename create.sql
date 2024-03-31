//create user
db.createUser({
    user: "readAccountExample",
    pwd: "1234",
    roles: [{
        role: "read", db:"test"
    }]
})

db.createUser({
    user: "readWriteAccountExample",
    pwd: "1234",
    roles: [{
        role: "readWrite", db:"test"
    }]
})

db.createUser({
    user: "superAdmin",
    pwd: "1234",
    roles: [
        {role: "readWriteAnyDatabase", db:"admin"},
        {role: "userAdminAnyDatabase", db:"admin"},
        {role: "dbAdminAnyDatabase", db:"admin"},
        {role: "clusterAdmin", db:"admin"},
        {role: "restore", db:"admin"},
        {role: "backup", db:"admin"},
    ]
})

db.books.aggregate([
    {
      $project: {
          _id: 0,
          ccc: 1
      }
    },
    {
        $out: "books_temp"
    }
])

db.books.aggregate([
    {
        $replaceRoot: {
            newRoot: "$ccc"
        }
    },
    {
        $out: "books_temp1"
    }
])

db.books.aggregate([
    {
        $replaceRoot: {
            newRoot: "$ccc"
        }
    },
    {
        $merge: {
            into: "books_temp1",
            whenMatched: "merge",
            whenNotMatched: "insert"
        }
    }
])

db.books.updateMany(
    {
        "title":"나의 이야기3"
    },
    {
        $set: {
            "ccc.ddd": "$dd2",
            "ccc.eee": "$ee2"
        }
    }
    )

db.books_temp1.find()
