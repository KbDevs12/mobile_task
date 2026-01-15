const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendLoginNotification = functions.auth.user().onCreate(async (user) => {
  const uid = user.uid;

  console.log("User login:", uid);

  const tokensSnapshot = await admin.firestore().collection("fcm_tokens").get();

  const tokens = tokensSnapshot.docs.map((doc) => doc.id);

  if (tokens.length === 0) {
    console.log("No FCM tokens found");
    return;
  }

  const payload = {
    notification: {
      title: "Login Berhasil",
      body: "Selamat datang kembali di Atlet Manager",
    },
    data: {
      type: "login",
    },
  };

  try {
    const response = await admin.messaging().sendToDevice(tokens, payload);
    console.log("FCM sent:", response.successCount);
  } catch (error) {
    console.error("FCM error:", error);
  }
});
