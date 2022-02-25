const functions = require("firebase-functions");
const fetch = require("node-fetch");



exports.helloWorld = functions.firestore
  .document("test/{id}")
  .onCreate(async (snapshot, context) => {
    const { name } = snapshot.data();
    return snapshot.ref.update({ helloMsg: `hello ${name}` });
  });
