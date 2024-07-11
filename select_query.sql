db.collection.find({
  $expr: {
    $function: {
      body: function(obj) {
        function search(value, data) {
          if (typeof data === 'object' && data !== null) {
            if (Array.isArray(data)) {
              for (let item of data) {
                if (search(value, item)) return true;
              }
            } else {
              for (let key in data) {
                if (data.hasOwnProperty(key)) {
                  if (data[key] === value) {
                    return true;
                  } else if (typeof data[key] === 'object' && data[key] !== null) {
                    if (search(value, data[key])) return true;
                  }
                }
              }
            }
          }
          return false;
        }
        return search(90, obj);
      },
      args: ["$$ROOT"],
      lang: "js"
    }
  }
});

// 배열 존재 유무 확인
db.collection.find({
	"data.policies.0": {$exists: true}
})