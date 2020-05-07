const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
var db = admin.database();


exports.firstNotficationCheck = functions.pubsub.schedule('0 8 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 8:00 AM PST!');
    // birthdayNotificationCheck("morning"); (America/Los_Angeles)
    await sendHeadlineNotification();
    return null;
  });

exports.secondNotficationCheck = functions.pubsub.schedule('0 9 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 9:00 AM PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.thirdNotficationCheck = functions.pubsub.schedule('0 10 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 10:00 AM PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.forthNotficationCheck = functions.pubsub.schedule('0 11 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 11:00 AM PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.fifthNotficationCheck = functions.pubsub.schedule('0 12 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 12:00 AM PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.sixthNotficationCheck = functions.pubsub.schedule('0 13 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {

    console.log('This will be run every day at 13:00 AM PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.seventhNotficationCheck = functions.pubsub.schedule('0 14 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {

    console.log('This will be run every day at 14:00  PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.eighthNotficationCheck = functions.pubsub.schedule('0 15 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 15:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.ninethNotficationCheck = functions.pubsub.schedule('0 16 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 16:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

exports.tenthNotficationCheck = functions.pubsub.schedule('0 17 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 17:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

  exports.eleventhNotficationCheck = functions.pubsub.schedule('0 18 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 18:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

  exports.twelvethNotficationCheck = functions.pubsub.schedule('0 19 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 19:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

  exports.thirteenNotficationCheck = functions.pubsub.schedule('0 20 * * *')
  .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
  .onRun(async context => {
    console.log('This will be run every day at 20:00 PST!');
    // birthdayNotificationCheck("morning");
    await sendHeadlineNotification();
    return null;
  });

// exports.testNotificationCheck = functions.pubsub.schedule('every 2 minutes')
//   .timeZone('America/Los_Angeles') // Users can choose timezone - default is America/Los_Angeles
//   .onRun((context) => {

//     console.log('This will be run every 1 minute');
//     // birthdayNotificationCheck("morning");
//     sendHeadlineNotification();
//     return null;
// });

async function sendHeadlineNotification() {

  var booksRef = db.ref("/AllBooks1/Relationships")

  return await booksRef.once("value", async function (snapshot) {

    var books = snapshot.val();

    //console.log("books ", books);

    for (var bookId in books) {

      var book = books[bookId];

      if (book['isSent'] == 'true') {
        continue;
      }

      var headerline = book["Headline1"];

      if (headerline !== null && headerline !== '') {
        await sendToDevices(headerline)
      }

      booksRef.child(bookId).update({
        isSent: 'true',
      });
      break;
    }

  });

}

async function sendToDevices(headerline) {
  var pushTokensRef = db.ref("/pushTokens");
  return await pushTokensRef.once("value", async function (snapshot) {
    var pushTokens = snapshot.val();
    //console.log("Push Token ", pushTokens);
    const pushTokenList = [];
    for (var token in pushTokens) {
      //console.log("headline ", headerline);
      //console.log("push token ", pushTokens[token]);
      var token = pushTokens[token]
      pushTokenList.push(token);
      if(pushTokenList.length > 0 && pushTokenList.length >= 10){
        await sendPushNotification(pushTokenList, '', headerline, 0);
        setTimeout(() => {
          pushTokenList.splice(0,pushTokenList.length)
        }, 500)
      }
    }
    // console.log("Push Token ", pushTokenList.length);
    // if (pushTokenList.length > 0) {
    //   sendPushNotification(pushTokenList, ' ', headerline, 0);
    // }
  });
}

async function sendPushNotification(token, title, text, badge) {

  // console.log("from ID ", fromUserID, " fromUsername ", fromUsername);

  let payload = {
    notification: {
      title: title,
      body: text,
      sound: 'default',
      badge: badge.toString(),
      ios_badgeType: 'Increase',
      ios_badgeCount: '1',
      click_action: 'ACTIONABLE'
    },
    data: {
      text: text
    }
  };

  console.log('TOKEN', token);
  console.log('push notification sent ', payload);

  await admin.messaging().sendToDevice(token, payload)
    .then((response) => {
      console.log('Successfully sent message:', response);
      // console.log('error message ', response['results']);
    }).catch((error) => {
      console.log('Error sending message:', error);
    });

  // return admin.messaging().sendToDevice(token, payload);
}


