//each time a new chat is received a new row is added to the chatWindow with a sender icon, message object, and associated emoji
function receiveChat() {
    chatWindow = document.getElementById("chatLog");

    console.log("message received");

    row = chatWindow.insertRow(-1);
    cell1 = row.insertCell(0);
    cell2 = row.insertCell(1);
    cell3 = row.insertCell(2);

    cell1.innerHTML += "<td style=\"width: 5%\">\n" +
        "                <img src=\"https://media.giphy.com/media/3oJtgd37mxeDib8go0/giphy.gif\" style=\"width:55px; height:55px; border-radius: 50%\">\n" +
        "               </td>";
    cell2.innerHTML += "<td class = \"recvdMess\" style=\"width: 45%\"> <div id='VChatMsg'>\" +\n" +
        "                               \"<audio controls><source src= ></audio></div> \" +" +
        "</td>";
    cell3.innerHTML += "<td style=\"width: 5%\">\n" +
        "                <img src=\"https://media.giphy.com/media/hXcEHA7zYRr4dUNQP8/giphy.gif\" style=\"width:55px; height:55px; border-radius: 50%\">\n" +
        "               </td>";

}

//each time a new chat is sent a new row is added to the chatWindow with associated emoji, message and sender icon
function sendChat() {

    chatWindow = document.getElementById("chatLog");

    console.log("message sent");

    var voiceMsg = document.getElementById("recordingsList").lastChild;


    var vchat = voiceMsg.cloneNode(true);
    voiceMsg.removeChild(voiceMsg.childNodes[0]);
    voiceMsg.removeChild(voiceMsg.childNodes[0]);



    row = chatWindow.insertRow(-1);
    cell1 = row.insertCell(0);
    cell2 = row.insertCell(1);
    cell3 = row.insertCell(2);

    cell1.innerHTML += "<td style=\"width: 5%\">\n" +
        "                <img src=\"https://media.giphy.com/media/hXcEHA7zYRr4dUNQP8/giphy.gif\" style=\"width:55px; height:55px; border-radius: 50%\">\n" +
        "               </td>";
    cell2.innerHTML += "<td class = \"sentMess\" style=\"width: 45%\"> <div id='VChatMsg'>" +
        vchat +
        "</td>";
    cell3.innerHTML += "<td style=\"width: 5%\">\n" +
        "                <img src=\"https://media.giphy.com/media/3oJtgd37mxeDib8go0/giphy.gif\" style=\"width:55px; height:55px; border-radius: 50%\">\n" +
        "               </td>";


}

//recorder.js, based on https://github.com/addpipe/media-recorder-api-audio-demo/blob/master/js/app.js & https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
URL = window.URL || window.webkitURL;

var gumStream;
var recorder;
var chunks = [];
var extension;


var recordButton = document.getElementById("recordBtn");
var stopButton = document.getElementById("stopBtn");

//event listeners
recordButton.addEventListener("click", startRecording);
stopButton.addEventListener("click", stopRecording);

//true on chrome, false on firefox
console.log("audio/webm:"+MediaRecorder.isTypeSupported('audio/webm/codecs=opus'));
//false on chrome, true on firefox
console.log("audio/ogg:"+MediaRecorder.isTypeSupported('audio/ogg;codecs=opus'));

if(MediaRecorder.isTypeSupported('audio/webm;codecs=opus')){
    extension = "webm";
} else {
    extension = "ogg"
}

function startRecording(){
    console.log("recording in progress");

    var constraints = {audio:true};

    recordButton.disabled = true;
    stopButton.disabled = false;

    navigator.mediaDevices.getUserMedia(constraints).then(function(stream){
        console.log("getUserMedia() success, stream created, initializing MediaRecorder");

        gumStream = stream;

        var options = {
            audioBitsPerSecond :  256000,
            videoBitsPerSecond : 2500000,
            bitsPerSecond:       2628000,
            mimeType : 'audio/'+extension+';codecs=opus'
        }

        recorder = new MediaRecorder(stream, options);

        recorder.ondataavailable = function(e){
            console.log("recorder.ondataavailable:"+e.data);

            console.log ("recorder.audioBitsPerSecond:"+recorder.audioBitsPerSecond)
            console.log ("recorder.videoBitsPerSecond:"+recorder.videoBitsPerSecond)
            console.log ("recorder.bitsPerSecond:"+recorder.bitsPerSecond)
            // add stream data to chunks
            chunks.push(e.data);
            // if recorder is 'inactive' then recording has finished
            if (recorder.state == 'inactive') {
                // convert stream data chunks to a 'webm' audio format as a blob
                const blob = new Blob(chunks, { type: 'audio/'+extension, bitsPerSecond:128000});
                createDownloadLink(blob)
            }
        };

        recorder.onerror = function(e){
            console.log(e.error);
        }

        //start recording using 1 second chunks
        //Chrome and Firefox will record one long chunk if you do not specify the chunk length
        recorder.start(1000);

    }).catch(function(err) {
        recordButton.disabled = false;
        stopButton.disabled = true;
    });
}

function stopRecording() {
    console.log("stopButton clicked");

    //disable the stop button, enable the record to allow for new recordings
    stopButton.disabled = true;
    recordButton.disabled = false;

    //tell the recorder to stop the recording
    recorder.stop();

    //stop microphone access
    gumStream.getAudioTracks()[0].stop();

}

function createDownloadLink(blob){

    var url = URL.createObjectURL(blob);
    var audio = document.createElement('audio');
    var li = document.createElement('li');
    var link = document.createElement('a');

    audio.controls = true;
    audio.src = url;

    link.href = url;
    link.download = new Date().toISOString() + '.' + extension;
    link.innerHTML = link.download;

    li.appendChild(audio);
    li.appendChild(link);

    recordingsList.appendChild(li);

}