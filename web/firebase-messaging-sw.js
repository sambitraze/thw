importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

if (!firebase.apps.length) {
  try {
    firebase.initializeApp({
      apiKey: "AIzaSyBj6eaDLp044m1gRmT0c5IkxhfXJzFbZig",
      authDomain: "tandoor-hut.firebaseapp.com",
      databaseURL: "https://tandoor-hut.firebaseio.com",
      projectId: "tandoor-hut",
      storageBucket: "tandoor-hut.appspot.com",
      messagingSenderId: "975115877464",
      appId: "1:975115877464:web:5dc91cc72c73782922de2d",
      measurementId: "G-1SYQVEGPVS",
    });
    console.log("fb initialized");
  } catch (e) {
    console.log("sw error", e);
  }
}

const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = 'Background Message Title';
  const notificationOptions = {
    body: 'Background Message body.',
    icon: '/favicon.png'
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});
// messaging.setBackgroundMessageHandler(function (payload) {
//   const promiseChain = clients
//     .matchAll({
//       type: "window",
//       includeUncontrolled: true,
//     })
//     .then((windowClients) => {
//       for (let i = 0; i < windowClients.length; i++) {
//         const windowClient = windowClients[i];
//         windowClient.postMessage(payload);
//       }
//     })
//     .then(() => {
//       return registration.showNotification("New Message");
//     });
//   return promiseChain;
// });
// self.addEventListener("notificationclick", function (event) {
//   console.log("notification received: ", event);
// });
