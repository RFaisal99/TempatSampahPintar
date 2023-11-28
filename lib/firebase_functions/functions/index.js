const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendPush = functions.database
    .ref("/Notification")
    .onWrite(async (change, context) => {
      // Get the new value of the "condition" field
      const condition = change.after.val().condition;

      // Check if the condition is equal to "penuh"
      if (condition !== "penuh") {
        console.log("Condition is not 'penuh', skipping notification.");
        return null; // Exit the function if condition is not 'penuh'
      }
      // If the condition is 'penuh', proceed to send the notification
      const title = change.after.val().title;
      const topic = change.after.val().topic || "general_notification_topic";

      console.log("title: " + title);
      console.log("condition: " + condition);
      console.log("topic: " + topic);
      const payload = {
        data: {
          title: title,
          condition: condition,
        },
        topic: topic,
      };
      // Send notification
      try {
        await admin.messaging().send(payload);
        console.log("Notification sent successfully");
        await change.after.ref.child("condition").set("");
        await change.after.ref.child("title").set("");
      } catch (error) {
        console.error("Error sending notification:", error);
      }
    });

exports.performDataReset = functions.database.ref("/Notification")
    .onWrite(async (change, context) => {
      try {
        const selectedNode = change.after.val().performReset;

        if (!selectedNode) {
          console.log("Node not found");
          return null;
        }

        const db = admin.database();
        const nodeRef = db.ref(selectedNode);
        const docRef = admin.firestore().collection("database")
            .doc(selectedNode);

        // Tambahkan data tanggal ke subchild Reset sebagai "pembuangan"
        const currentDate = new Date();

        const resetTimeOptions = {
          timeZone: "Asia/Jakarta",
          hour: "2-digit",
          minute: "2-digit",
        };
        const resetTime = currentDate.
            toLocaleTimeString("id-ID", resetTimeOptions);

        const resetDateOptions = {
          timeZone: "Asia/Jakarta",
          day: "numeric",
          month: "long",
          year: "numeric",
        };
        const resetDate = currentDate.
            toLocaleDateString("id-ID", resetDateOptions);

        const resetDateTime = `${resetTime} - ${resetDate}`;

        const randomKey = db.ref().push().key;

        // Get existing Reset data
        const existingResetSnapshot =await nodeRef.child("Reset").once("value");
        const existingResetData = existingResetSnapshot.val() || {};

        existingResetData[randomKey] = {pembuangan: resetDateTime};

        await nodeRef.child("Reset").update(existingResetData);

        // Copy Reset data to Firestore
        await docRef.update({"Reset": existingResetData});

        const subNodesToMove = ["Plastik", "Gelas", "Kaleng"];

        for (const subNode of subNodesToMove) {
          const subNodeRef = nodeRef.child(subNode);
          const subNodeSnapshot = await subNodeRef.once("value");
          const subNodeData = subNodeSnapshot.val();

          if (subNodeData) {
            // Simpan data subchild langsung ke Firestore
            await docRef.update({[subNode]: subNodeData});
            await subNodeRef.remove();
          }
        }

        // Reset nilai Plastik, Gelas, dan Kaleng menjadi 0 dalam jumlah_botol
        const resetDataJumlahBotol = {
          "jumlah_botol": {
            "Plastik": 0,
            "Gelas": 0,
            "Kaleng": 0,
          },
        };

        // Update data jumlah botol pada node yang dipilih
        await nodeRef.update(resetDataJumlahBotol);

        // Reset nilai Plastik, Gelas, dan Kaleng menjadi 0 dalam jumlah_botol
        const resetKondisi = {
          "Kondisi": {
            "Plastik": "",
            "Gelas": "",
            "Kaleng": "",
          },
        };

        // Update data jumlah botol pada node yang dipilih
        await nodeRef.update(resetKondisi);

        console.log("Berhasil reset");
        await change.after.ref.child("performReset").set("");
        return null;
      } catch (error) {
        console.error("Gagal mereset data:", error.message);
        return null;
      }
    });
