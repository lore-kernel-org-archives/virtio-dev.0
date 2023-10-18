Return-Path: <virtio-dev-return-14009-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903ACDB47E
	for <virtio-dev@archiver.kernel.org>; Wed, 18 Oct 2023 15:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5420A866A9
	for <virtio-dev@archiver.kernel.org>; Wed, 18 Oct 2023 15:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CCA59868B5
	for <virtio-dev@archiver.kernel.org>; Wed, 18 Oct 2023 15:32:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BF499868AA; Wed, 18 Oct 2023 15:32:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E08BE9868A9;
	Wed, 18 Oct 2023 15:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Radu Ocica <rocica@blackberry.com>
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: virtio-snd comments/questions
Thread-Index: AQHaAdgPGZsaTwL9FEiOAsMZLVwClw==
Date: Wed, 18 Oct 2023 15:32:21 +0000
Message-ID: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.64.197.67]
Content-Type: multipart/alternative;
	boundary="_000_02725a6508584ed2aa8b31c9e9f4264ablackberrycom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
Subject: [virtio-dev] virtio-snd comments/questions

--_000_02725a6508584ed2aa8b31c9e9f4264ablackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,
I am working on implementing a virtio-snd vdev. During my work on different=
 aspects of the implementation I stumbled across the following issues with =
the virtio sound device specification (that is part of the virtio 1.3 draft=
). In some cases additional clarifications might be enough to address the i=
ssue, in others additional features might be required. Below is a list of t=
he issues, with some suggestions on how the issues could be addressed.
PCM playback and capture
Unclear semantics of PCM_STOP/PCM_START operations
The virtio-snd specification is not clear on the expectations on how the PC=
M_STOP control request is to be handled by the vdev, in terms of whether to:

  *   drop the remaining buffered audio in the host pcm stream and return p=
ending io messages to the guest driver
  *   drop the remaining buffered audio in the host pcm stream and keep pen=
ding io messages in order to be able to prime the host pcm stream in case P=
CM_STOP is followed by PCM_START; return pending io messages only when rece=
iving PCM_RELEASE
  *   drain the remaining buffered audio in the host pcm stream and send a =
PCM_STOP response upon drain completion, return pending io messages to the =
guest driver as they are completed (before PCM_STOP response); drain capabi=
lity might or might not be available for the host pcm stream
  *   start draining the remaining buffered audio in the host pcm stream an=
d send a PCM_STOP response immediately, return pending io messages to the g=
uest driver as they are completed (after PCM_STOP response); if receiving P=
CM_RELEASE before drain completion hold off the response until all pending =
io messages are completed and returned to the guest driver; drain capabilit=
y might or might not be available for the host pcm stream
  *   pause the host pcm stream and maintain buffered audio / pending io me=
ssages as is; pause capability might or might not be available for the host=
 pcm stream

If the thinking is that the vdev on the host can decide on how to implement=
 PCM_STOP based on the host stream capabilities, the guest driver has no in=
formation about the choice made by the vdev. In our opinion the choice made=
 by the vdev in implementing PCM_STOP dictates what the possible transition=
s after PCM_STOP can be (if PCM_STOP is implemented as pause, PCM_START and=
 PCM_RELEASE are possible transitions, but if PCM_STOP is implemented as dr=
ain, the only valid transition is PCM_RELEASE and if PCM_STOP is implemente=
d as drop and all pending io messages have been returned to the guest drive=
r, again the only valid transition seems to be PCM_RELEASE), but the guest =
driver is the one issuing the next request and it might at the best be able=
 to make an educated guess how the vdev implemented PCM_STOP based on wheth=
er all the pending io messages are returned or not to the guest driver. To =
make such a guess possible, more clarifications would be required in the sp=
ec to identify which of the scenarios listed above are considered by the sp=
ec.
Note 1:  The reference virtio-snd linux/android guest driver explicitly doe=
sn't support the ALSA SNDRV_PCM_INFO_DRAIN_TRIGGER feature flag, which migh=
t indicate there was no intent to support drain semantics.
Note 2: The reference virtio-snd linux/android guest driver explicitly does=
 support the ALSA SNDRV_PCM_INFO_PAUSE feature flag, which seems to indicat=
e intent to support pause semantics, along with drop semantics.
Note 3: The Android Audio HAL and tinyalsa/tinyplay don't have any notion o=
f drain or pause. At the end of a playback session there is a wait for prev=
iously buffered data to complete playing using the tinyalsa pcm_wait() func=
tion, and then a PCM_STOP request is issued after the buffered audio has co=
mpleted playing. Drop semantics are assumed for PCM_STOP in this context.
Information on period alignment and max audio buffer size
No information about period alignment and min/max audio buffer/period size =
is currently available in struct virtio_snd_pcm_info. Ideally the period si=
ze used for io messages should match the period size used on the host. That=
 will guarantee consistency in timing, precise accounting of available room=
 to write more data or available data to read, across host and guest. A wor=
karound is possible, where the device will fail a PCM_SET_PARAMETERS reques=
t that specifies an unsupported period alignment or audio buffer/period siz=
e and the guest is forced to use a period and buffer size that is known to =
be supported by the host device (this can be done in an Android guest, by h=
ard coding the android audio HAL period size and the number of periods and =
thus effectively the audio buffer size that is used for the virtio sound de=
vices in the guest; in android and linux guests it can be done also by sett=
ing the virtio_snd module parameters, to the effect of locking down the per=
iod and buffer size).
General Issues

  *   There is no statement regarding the endianness of PCM data exchanged =
via txq and rxq queues and the virtio sound PCM format definitions do not i=
nclude endianness.
  *   There is currently no requirement for the guest driver to enqueue an =
io message only after it has completed writing data to it (playback) or rea=
ding data from it (capture). The linux/android guest driver currently enque=
ues an io message for playback immediately after calling snd_pcm_period_ela=
psed(). snd_pcm_period_elapsed() makes it possible for the guest client app=
 to write new data, but upon the return of this function there is no guaran=
tee that the guest client app has already written new data. If the vdev deq=
ueues the io message immediately and copies the PCM data for that io reques=
t before the guest client app has actually written new data to it, it resul=
ts in out-of-sequence/stale data being played back.
  *   There is no statement how the guest driver should react to a control =
request failing.

     *   For PCM control requests the spec details what the "possible trans=
itions" are after each control request. It doesn't specify whether this app=
lies only to successful control requests, or irrespective of the success of=
 the control requests. For instance for PCM_START only PCM_STOP is listed a=
s a valid transition. What happens if PCM_START fails though? Is PCM_STOP s=
till a valid transition? Is a repeat of PCM_START valid, since the previous=
 PCM_START failed? Is a PCM_RELEASE required in order for the guest driver =
to recover the io request descriptors that were sent to the vdev before PCM=
_START? Is a PCM_STOP required in this case, in order to be able to send PC=
M_RELEASE (because of valid sequences considerations)? It was seen that the=
 reference linux/android guest driver ignores a PCM_START failure and still=
 sends io requests after the failed PCM_START.
     *   Should a failed control request be retried with a maximum retry co=
unt? Here the danger is that retrying forever without any wait in between r=
etries might result in a high CPU load. Should there be a dedicated status =
value that tells the guest not to retry a failed request (or to use a error=
 handling sequence involving RELEASE and PREPARE)?

  *   There is no statement how the guest driver should react to an io mess=
age failing

     *   Should it stop sending io messages and just send PCM_STOP? Or retr=
y sending io requests hoping that they will succeed? Should there be a maxi=
mum retry count? Here the danger is that retrying forever without any wait =
in between might result in a high CPU load.

  *   The spec seems to indicate that PCM_PREPARE after PCM_STOP or PCM_SET=
_PARAMS after PCM_STOP would be invalid, still the linux/android guest driv=
er are sending control  requests in these sequences (seen when playing back=
 from android UI and PCM_START handling is modified to fail for the sake of=
 testing the behavior). Is the spec out of date? Is the reference linux/gue=
st android driver not compliant to the spec? Are these sequences made possi=
ble by the fact that the PCM_START previous to PCM_STOP actually failed? If=
 these are valid sequences, the virtio spec should be updated to show them =
as valid.
  *   The virtio spec mentions that for playback, between PCM_PREPARE and P=
CM_START the guest driver should send io messages to prime the host playbac=
k stream. There is no statement what shall be done wrt io messages, in the =
following situations:

     *   between PCM_STOP and PCM_START: this goes back to the semantics of=
 PCM_STOP: if PCM_STOP had drop semantics, all outstanding io messages coul=
d be returned to the guest; if PCM_STOP had pause semantics, outstanding io=
 messages could be kept on the device side and returned to the guest only u=
pon the receipt of a PCM_RELEASE request from the guest; if PCM_STOP had dr=
ain semantics, the outstanding io messages could be returned to the guest a=
s they are completed
     *   after a failed PCM_START: since PCM_START failed, all io messages =
sent by the guest after PCM_PREPARE could be returned to the guest; or this=
 could be deferred to a PCM_STOP or PCM_RELEASE request

  *   There is no way for the vdev to notify the guest driver that there is=
 an error condition that requires a new PCM_PREPARE in order to clear. The =
vdev could send the VIRTIO_SND_EVT_PCM_XRUN, which requires PCM_PREPARE to =
clear, but this would be abusing the spec, as VIRTIO_SND_EVT_PCM_XRUN is me=
ant exclusively for XRUN errors.
  *   There is no way for the vdev to notify the guest driver that a stream=
 is disconnected (e.g. host audio device has been removed - think USB audio=
 device - or reinserted).


Recommendations:

  *   Add explicit statement about endianness of PCM data exchanged via txq=
 and rxq queues.
  *   Add explicit requirement for the guest driver to enqueue an io messag=
e only after it has completed writing data to it (playback) or reading data=
 from it (capture)
  *   Add explicit requirement for control and io message failures to be ha=
ndled on the guest driver side. It would be expected that if PCM_START fail=
s, for instance, the guest driver doesn't send any further io messages. For=
 io messages, at the minimum the guest driver should use a count of success=
ive failures and stop retrying. If the handling for a failed control reques=
t is retrying the same request, there should be a limited number of retries=
. Specific to PCM_START failure, it should be specified whether PCM_STOP an=
d maybe PCM_RELEASE and PCM_PREPARE is required before attempting any PCM_S=
TART retry. The behavior could be specified as dependent on whether the vde=
v has returned the pending io messages when handling PCM_STOP (if all pendi=
ng io messages returned at PCM_STOP, perform PCM_RELEASE and PCM_PREPARE be=
fore retrying).
  *   Add clarification for handling of oustanding io messages on the devic=
e side upon a failed PCM_START control request, or upon a PCM_STOP control =
request
  *   Update valid transitions for each PCM control request, if specificati=
on out of date (see above for control request sequences seen with the refer=
ence linux/android guest driver, that are currently not specified as valid =
in the virtio sound specification)
  *   Add explicit statement that the documented valid transitions for PCM =
control requests are for successful control requests and in the case of fai=
led requests, the valid transitions are same as before the failed control r=
equest (if this statement is correct, if not clarify what the expectation i=
s)
  *   It would be beneficial if the virtio-snd specification did not leave =
the interpretation of PCM_STOP semantics to the vdev (drop vs pause vs drai=
n), without a clear contract between vdev and guest driver
If the spec intends to allow the host to use both pause/resume and drop/go =
(and maybe even drain/go) semantics for the START/STOP operations, then for=
 clarity it should use a separate request (PCM_PAUSE) for pause and if drai=
n semantics are to be included as well, then a separate request (PCM_DRAIN)=
 for drain as well. PCM_START could be used to restart/resume in all cases.=
 Ideally there should be the following optional stream features:

     *   VIRTIO_SND_PCM_F_PAUSE - if offered by the vdev it indicates suppo=
rt for pause-resume both in the vdev and the host pcm stream; new request V=
IRTIO_SND_R_PCM_PAUSE with valid transitions START or RELEASE; START would =
have a valid transition to PAUSE;
     *   VIRTIO_SND_PCM_F_DRAIN - if offered by the vdev it indicates suppo=
rt for drain both in the vdev and the host pcm stream, new request VIRTIO_S=
ND_R_PCM_DRAIN with valid transitions RELEASE; START would have a valid tra=
nsition to DRAIN;
     *   VIRTIO_SND_R_PCM_STOP would retain drop semantics and have possibl=
e transitions RELEASE;
     *   A failed VIRTIO_SND_R_PCM_START would have the only possible trans=
ition RELEASE;
     *   Pending io messages would only need to be returned to the guest dr=
iver when handling VIRTIO_SND_R_PCM_RELEASE
     *   For priming the host pcm stream, io messages would only need to be=
 sent by the guest driver between VIRTIO_SND_R_PCM_PREPARE and VIRTIO_SND_R=
_PCM_START
     *   The above approach would highly simplify the spec in terms of docu=
menting possible transitions and when to send io messages to prime the host=
 pcm stream and when to return pending io messages to the guest driver, as =
opposed to overloading the use of PCM_STOP for drop/pause(/drain), when the=
 behavior wrt io messages would highly depend on the host interpretation of=
 PCM_STOP.

  *   It would be beneficial to add two new PCM notifications, via the foll=
owing stream features:

     *   VIRTIO_SND_PCM_F_EVT_ERR - indicates support for new notification =
VIRTIO_SND_EVT_PCM_ERROR, that signals to the guest driver that en error oc=
curred (other than structly underrun/overrun) while handling io messages, r=
equiring a sequence of PCM_RELEASE, PCM_PREPARE, PCM_START to recover
     *   VIRTIO_SND_PCM_F_EVT_CONN_STATE - indicates support for new notifi=
cations VIRTIO_SND_EVT_PCM_DISCONNECTED and VIRTIO_SND_EVT_PCM_CONNECTED, t=
o indicate to the guest driver pcm stream disconnected (e.g. USB device rem=
oved) and pcm stream connected (e.g. USB device re-inserted)

  *   It would be beneficial to include Information on period alignment and=
 max buffer size in struct virtio_snd_pcm_info, available via optional feat=
ure flag, e.g. VIRTIO_SND_PCM_F_PERIOD_INFO and the additional info would b=
e added at the end of struct struct virtio_snd_pcm_info, replacing the padd=
ing bytes and adding to the length of the struct - new le32 fields period_a=
lign_bytes, min_period_bytes, max_period_bytes, max_buffer_bytes, where min=
_period_bytes, max_period_bytes and max_buffer_bytes are all multiples of p=
eriod_align_bytes. With this addition, the guest driver would have the info=
rmation required to match the period/buffer size capabilities of the host p=
cm stream and advertise them to clients in the guest space, without the nee=
d to hard code these using the guest virtio_snd module parameters.
  *   Alternatively a new control request to query the refined PCM paramete=
rs could be added (e.g. PCM_GET_PARAMS, via PCM feature flag VIRTIO_SND_PCM=
_F_GET_PARAMS), to be used by the guest driver after it has successfully se=
nt PCM_SET_PARAMS, in order to query the PCM parameters effectively used by=
 the device.

Audio Controls
The original virtio-snd device specification as added to virtio 1.1 did not=
 include audio control support, however the virtio 1.3 draft includes this.
Audio Control Roles
The roles describe standard uses for controls, like volume, mute and gain. =
There is also an undefined role definition that according to the spec must =
not be used.

  *   VIRTIO_SND_CTL_ROLE_UNDEFINED
  *   VIRTIO_SND_CTL_ROLE_VOLUME
  *   VIRTIO_SND_CTL_ROLE_MUTE
  *   VIRTIO_SND_CTL_ROLE_GAIN

Problems identified with the role definitions:

  *   Not all audio controls can be described as volume, mute or gain. The =
undefined role must be allowed for any control that is not for volume, mute=
 or gain.
  *   What is the difference between VIRTIO_SND_CTL_ROLE_VOLUME and VIRTIO_=
SND_CTL_ROLE_GAIN, is the first supposed to be used for playback and the se=
cond for capture? Or is the first supposed to be used for digital volume an=
d the second for analog gain? Is a distinction between volume and gain nece=
ssary?
  *   If certain data types are assumed for controls with role VIRTIO_SND_C=
TL_ROLE_VOLUME, VIRTIO_SND_CTL_ROLE_MUTE or VIRTIO_SND_CTL_ROLE_GAIN, this =
should be explicitly specified (e.g. BOOLEAN for VIRTIO_SND_CTL_ROLE_MUTE, =
INTEGER for VIRTIO_SND_CTL_ROLE_VOLUME and VIRTIO_SND_CTL_ROLE_GAIN?).

Mute control value meaning
The virtio spec is not clear whether a value of 1 for an audio control with=
 role VIRTIO_SND_CTL_ROLE_MUTE means muted, or rather switched on (unmuted)=
. Testing end-to-end with the reference virtio-snd linux/android guest driv=
er it was inferred that 1 means switched on, i.e. unmuted. In our opinion t=
his should be clarified within the spec.
TLV support
The TLV struct and possible type values are considered well known from ALSA.
There are only a few common/standard TLV type definitions (for specific met=
a data types, like db scale, db min/max plus a handful more or the containe=
r TLV type that allows packing multiple TLVs into one containing TLV); they=
 should be defined in virtio-snd.h for the completeness of the specificatio=
n. Otherwise a non ALSA based host that supports reporting metadata would n=
eed to redefine these to match the ALSA definitions
The audio controls extension proposal draft includes the definition of stru=
ct virtio_snd_ctl_tlv. It is removed however in the virtio_snd.h header fil=
e of the linux/android virtio-snd guest driver implementation for this exte=
nsion - the guest driver just performs memcpy to/from the equivalent ALSA s=
truct. For the completeness of the specification all data structures used f=
or data exchanges within the virtio spec should be part of the public heade=
r file. This is particularly important when the host or guest don't use ALS=
A and don't have access to the ALSA TLV struct definition.
Other than for metadata of controls for volume/gain, in ALSA audio controls=
 can use TLVs for representing the actual control data (such controls use t=
ype VIRTIO_SND_CTL_TYPE_BYTES and access VIRTIO_SND_CTL_ACCESS_TLV_READ, VI=
RTIO_SND_CTL_ACCESS_TLV_WRITE or a combination of VIRTIO_SND_CTL_ACCESS_TLV=
_READ and VIRTIO_SND_CTL_ACCESS_TLV_WRITE). Since this use seems to be supp=
orted by the reference linux/android virtio-snd guest driver, it should be =
documented in the spec.
virtio_snd_ctl_info struct alignment
Field "name" of the virtio_snd_ctl_info struct has a length of 44 bytes. Wi=
th this field length, the alignment of the following value union field with=
 __le64 data members depends on packing and/or alignment compiler directive=
s that can differ between host and guest and thus result in a different ali=
gnment of "value". Klocwork detects this issue as a PORTING.STORAGE.STRUCT =
guideline violation for this struct, which can be fixed by modifying the le=
ngth of field "name" to 48, or by adding a padding field of length 4 bytes =
between the "name" and "value" fields (e.g. __u8 padding[4]).
Looking forward to clarifications and/or responses.
Radu Ocica

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_02725a6508584ed2aa8b31c9e9f4264ablackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><font face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color Emoji,S=
egoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSymbols" si=
ze=3D"3" color=3D"black"><span style=3D"font-size:12pt;" id=3D"divtagdefaul=
twrapper"></p>
<div>
<div id=3D"divtagdefaultwrapper">
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Hi,</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">I am working on implementing a v=
irtio-snd vdev.</span></font><font size=3D"3" color=3D"black">
</font><font size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Dur=
ing my work on different aspects of the implementation I stumbled across th=
e following issues with the virtio sound device specification (that is part=
 of the virtio 1.3 draft). In some cases
 additional clarifications might be enough to address the issue, in others =
additional features might be required. Below is a list of the issues, with =
some suggestions on how the issues could be addressed.
</span></font><font size=3D"3" color=3D"black"><span style=3D"font-size:12p=
t;"><br>
</span></font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"6" color=3D"black"><span style=3D"font-size:24pt;"><b>PCM play=
back and capture</b></span></font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>Unclear =
semantics of PCM_STOP/PCM_START operations</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The virtio-snd specification is =
not clear on the expectations on how the PCM_STOP control request is to be =
handled by the vdev, in terms of whether to:</span></font></div>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">drop the remainin=
g buffered audio in the host pcm stream and return pending io messages to t=
he guest driver</span></font></li><li style=3D"margin:0;"><font face=3D"Cal=
ibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"=
font-size:12pt;">drop the remaining buffered audio in the host pcm stream a=
nd keep pending io messages in order to be able to prime the host pcm stream
 in case PCM_STOP is followed by PCM_START; return pending io messages only=
 when receiving PCM_RELEASE</span></font></li><li style=3D"margin:0;"><font=
 face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><sp=
an style=3D"font-size:12pt;">drain the remaining buffered audio in the host=
 pcm stream and send a PCM_STOP response upon drain completion, return pend=
ing io messages
 to the guest driver as they are completed (before PCM_STOP response); drai=
n capability might or might not be available for the host pcm stream</span>=
</font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,=
EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">start=
 draining the remaining buffered audio in the host pcm stream and send a PC=
M_STOP response immediately, return pending io messages
 to the guest driver as they are completed (after PCM_STOP response); if re=
ceiving PCM_RELEASE before drain completion hold off the response until all=
 pending io messages are completed and returned to the guest driver; drain&=
nbsp;capability might or might not be
 available for the host pcm stream</span></font></li><li style=3D"margin:0;=
"><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"bla=
ck"><span style=3D"font-size:12pt;">pause the host pcm stream and maintain =
buffered audio / pending io messages as is; pause capability might or might=
 not be available for
 the host pcm stream</span></font></li></ul>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">If the thinking is that the vdev=
 on the host can decide on how to implement PCM_STOP based on the host stre=
am capabilities, the guest driver has no information
 about the choice made by the vdev. In our opinion the choice made by the v=
dev in implementing PCM_STOP dictates what the possible transitions after P=
CM_STOP can be (if PCM_STOP is implemented as pause, PCM_START and PCM_RELE=
ASE are possible transitions, but
 if PCM_STOP is implemented as drain, the only valid transition is PCM_RELE=
ASE and if PCM_STOP is implemented as drop and all pending io messages have=
 been returned to the guest driver, again the only valid transition seems t=
o be PCM_RELEASE), but the guest
 driver is the one issuing the next request and it might at the best be abl=
e to make an educated guess how the vdev implemented PCM_STOP based on whet=
her all the pending io messages are returned or not to the guest driver. To=
 make such a guess possible, more
 clarifications would be required in the spec to identify which of the scen=
arios listed above are considered by the spec.</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Note 1:&nbsp; The reference virt=
io-snd linux/android guest driver explicitly doesn't support the ALSA SNDRV=
_PCM_INFO_DRAIN_TRIGGER feature flag, which might
 indicate there was no intent to support drain semantics.</span></font></di=
v>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Note 2: The reference virtio-snd=
 linux/android guest driver explicitly does support the ALSA SNDRV_PCM_INFO=
_PAUSE feature flag, which seems to indicate
 intent to support pause semantics, along with drop semantics.</span></font=
></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Note 3: The Android Audio HAL an=
d tinyalsa/tinyplay don't have any notion of drain or pause. At the end of =
a playback session there is a wait for previously
 buffered data to complete playing using the tinyalsa pcm_wait() function, =
and then a PCM_STOP request is issued after the buffered audio has complete=
d playing. Drop semantics are assumed for PCM_STOP in this context.</span><=
/font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>Informat=
ion on period alignment and max audio buffer size</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">No information about period alig=
nment and min/max audio buffer/period size is currently available in struct=
 virtio_snd_pcm_info. Ideally the period size
 used for io messages should match the period size used on the host. That w=
ill guarantee consistency in timing, precise accounting of available room t=
o write more data or available data to read, across host and guest. A worka=
round is possible, where the device
 will fail a PCM_SET_PARAMETERS request that specifies an unsupported perio=
d alignment or audio buffer/period size and the guest is forced to use a pe=
riod and buffer size that is known to be supported by the host device (this=
 can be done in an Android guest,
 by hard coding the android audio HAL period size and the number of periods=
 and thus effectively the audio buffer size that is used for the virtio sou=
nd devices in the guest; in android and linux guests it can be done also by=
 setting the virtio_snd module parameters,
 to the effect of locking down the period and buffer size).</span></font></=
div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>General =
Issues</b></span></font></div>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">There is no state=
ment regarding the endianness of PCM data exchanged via txq and rxq queues =
and the virtio sound PCM format definitions
 do not include endianness.</span></font></li><li style=3D"margin:0;"><font=
 face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><sp=
an style=3D"font-size:12pt;">There is currently no requirement for the gues=
t driver to enqueue an io message only after it has completed writing data =
to it (playback)
 or reading data from it (capture). The linux/android guest driver currentl=
y enqueues an io message for playback immediately after calling snd_pcm_per=
iod_elapsed(). snd_pcm_period_elapsed() makes it possible for the guest cli=
ent app to write new data, but upon
 the return of this function there is no guarantee that the guest client ap=
p has already written new data. If the vdev dequeues the io message immedia=
tely and copies the PCM data for that io request before the guest client ap=
p has actually written new data
 to it, it results in out-of-sequence/stale data being played back.</span><=
/font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,E=
mojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">There =
is no statement how the guest driver should react to a control request fail=
ing.
</span></font></li></ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<ul style=3D"margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">For PCM control r=
equests the spec details what the &quot;possible transitions&quot; are afte=
r each control request. It doesn't specify whether this
 applies only to successful control requests, or irrespective of the succes=
s of the control requests. For instance for PCM_START only PCM_STOP is list=
ed as a valid transition. What happens if PCM_START fails though? Is PCM_ST=
OP still a valid transition? Is
 a repeat of PCM_START valid, since the previous PCM_START failed? Is a PCM=
_RELEASE required in order for the guest driver to recover the io request d=
escriptors that were sent to the vdev before PCM_START? Is a PCM_STOP requi=
red in this case, in order to be
 able to send PCM_RELEASE (because of valid sequences considerations)? It w=
as seen that the reference linux/android guest driver ignores a PCM_START f=
ailure and still sends io requests after the failed PCM_START.</span></font=
></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Should a fa=
iled control request be retried with a maximum retry count? Here the danger=
 is that retrying forever without any wait in between
 retries might result in a high CPU load. Should there be a dedicated statu=
s value that tells the guest not to retry a failed request (or to use a err=
or handling sequence involving RELEASE and PREPARE)?</span></font></li></ul>
</ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">There is no state=
ment how the guest driver should react to an io message failing
</span></font></li></ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<ul style=3D"margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Should it stop se=
nding io messages and just send PCM_STOP? Or retry sending io requests hopi=
ng that they will succeed? Should there be
 a maximum retry count? Here the danger is that retrying forever without an=
y wait in between might result in a high CPU load.</span></font></li></ul>
</ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">The spec seems to=
 indicate that PCM_PREPARE after PCM_STOP or PCM_SET_PARAMS after PCM_STOP =
would be invalid, still the linux/android
 guest driver are sending control&nbsp; requests in these sequences (seen w=
hen playing back from android UI and PCM_START handling is modified to fail=
 for the sake of testing the behavior). Is the spec out of date? Is the ref=
erence linux/guest android driver not
 compliant to the spec? Are these sequences made possible by the fact that =
the PCM_START previous to PCM_STOP actually failed? If these are valid sequ=
ences, the virtio spec should be updated to show them as valid.</span></fon=
t></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,Emoji=
Font" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">The virtio=
 spec mentions that for playback, between PCM_PREPARE and PCM_START the gue=
st driver should send io messages to prime the host
 playback stream. There is no statement what shall be done wrt io messages,=
 in the following situations:
</span></font></li></ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<ul style=3D"margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">between PCM_STOP =
and PCM_START: this goes back to the semantics of PCM_STOP: if PCM_STOP had=
 drop semantics, all outstanding io messages
 could be returned to the guest; if PCM_STOP had pause semantics, outstandi=
ng io messages could be kept on the device side and returned to the guest o=
nly upon the receipt of a PCM_RELEASE request from the guest; if PCM_STOP h=
ad drain semantics, the outstanding
 io messages could be returned to the guest as they are completed</span></f=
ont></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,Emo=
jiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">after a =
failed PCM_START: since PCM_START failed, all io messages sent by the guest=
 after PCM_PREPARE could be returned to the guest;
 or this could be deferred to a PCM_STOP or PCM_RELEASE request</span></fon=
t></li></ul>
</ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">There is no way f=
or the vdev to notify the guest driver that there is an error condition tha=
t requires a new PCM_PREPARE in order to clear.
 The vdev could send the VIRTIO_SND_EVT_PCM_XRUN, which requires PCM_PREPAR=
E to clear, but this would be abusing the spec, as VIRTIO_SND_EVT_PCM_XRUN =
is meant exclusively for XRUN errors.</span></font></li><li style=3D"margin=
:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"=
black"><span style=3D"font-size:12pt;">There is no way for the vdev to noti=
fy the guest driver that a stream is disconnected (e.g. host audio device h=
as been removed - think
 USB audio device - or reinserted).</span></font></li></ul>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">&nbsp;</span></font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>Recommen=
dations:</b></span></font></div>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Add explicit stat=
ement about endianness of PCM data exchanged via txq and rxq queues.</span>=
</font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,=
EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Add e=
xplicit requirement for the guest driver to enqueue an io message only afte=
r it has completed writing data to it (playback) or reading
 data from it (capture)</span></font></li><li style=3D"margin:0;"><font fac=
e=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span s=
tyle=3D"font-size:12pt;">Add explicit requirement for control and io messag=
e failures to be handled on the guest driver side. It would be expected tha=
t if PCM_START
 fails, for instance, the guest driver doesn't send any further io messages=
. For io messages, at the minimum the guest driver should use a count of su=
ccessive failures and stop retrying. If the handling for a failed control r=
equest is retrying the same request,
 there should be a limited number of retries. Specific to PCM_START failure=
, it should be specified whether PCM_STOP and maybe PCM_RELEASE and PCM_PRE=
PARE is required before attempting any PCM_START retry. The behavior could =
be specified as dependent on whether
 the vdev has returned the pending io messages when handling PCM_STOP (if a=
ll pending io messages returned at PCM_STOP, perform PCM_RELEASE and PCM_PR=
EPARE before retrying).</span></font></li><li style=3D"margin:0;"><font fac=
e=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span s=
tyle=3D"font-size:12pt;">Add clarification for handling of oustanding io me=
ssages on the device side upon a failed PCM_START control request, or upon =
a PCM_STOP
 control request</span></font></li><li style=3D"margin:0;"><font face=3D"Ca=
libri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D=
"font-size:12pt;">Update valid transitions for each PCM control request, if=
 specification out of date (see above for control request sequences seen wi=
th
 the reference linux/android guest driver, that are currently not specified=
 as valid in the virtio sound specification)</span></font></li><li style=3D=
"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" co=
lor=3D"black"><span style=3D"font-size:12pt;">Add explicit statement that t=
he documented valid transitions for PCM control requests are for successful=
 control requests and in the case
 of failed requests, the valid transitions are same as before the failed co=
ntrol request (if this statement is correct, if not clarify what the expect=
ation is)</span></font></li><li style=3D"margin:0;"><font face=3D"Calibri,s=
ans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-s=
ize:12pt;">It would be beneficial if the virtio-snd specification did not l=
eave the interpretation of PCM_STOP semantics to the vdev (drop vs pause
 vs drain), without a clear contract between vdev and guest driver</span></=
font><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"=
black"><span style=3D"font-size:12pt;"><br>
If the spec intends to allow the host to use both pause/resume and drop/go =
(and maybe even drain/go) semantics for the START/STOP operations, then for=
 clarity it should use a separate request (PCM_PAUSE) for pause and if drai=
n semantics are to be included as
 well, then a separate request (PCM_DRAIN) for drain as well. PCM_START cou=
ld be used to restart/resume in all cases. Ideally there should be the foll=
owing optional stream features:</span></font></li></ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<ul style=3D"margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">VIRTIO_SND_PCM_F_=
PAUSE - if offered by the vdev it indicates support for pause-resume both i=
n the vdev and the host pcm stream; new request
 VIRTIO_SND_R_PCM_PAUSE with valid transitions START or RELEASE; START woul=
d have a valid transition to PAUSE;</span></font></li><li style=3D"margin:0=
;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"bl=
ack"><span style=3D"font-size:12pt;">VIRTIO_SND_PCM_F_DRAIN - if offered by=
 the vdev it indicates support for drain both in the vdev and the host pcm =
stream, new request VIRTIO_SND_R_PCM_DRAIN
 with valid transitions RELEASE; START would have a valid transition to DRA=
IN;</span></font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-se=
rif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12=
pt;">VIRTIO_SND_R_PCM_STOP would retain drop semantics and have possible tr=
ansitions RELEASE;</span></font></li><li style=3D"margin:0;"><font face=3D"=
Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=
=3D"font-size:12pt;">A failed VIRTIO_SND_R_PCM_START would have the only po=
ssible transition RELEASE;</span></font></li><li style=3D"margin:0;"><font =
face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><spa=
n style=3D"font-size:12pt;">Pending io messages would only need to be retur=
ned to the guest driver when handling VIRTIO_SND_R_PCM_RELEASE</span></font=
></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">For priming=
 the host pcm stream, io messages would only need to be sent by the guest d=
river between VIRTIO_SND_R_PCM_PREPARE and VIRTIO_SND_R_PCM_START</span></f=
ont></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,Emo=
jiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">The abov=
e approach would highly simplify the spec in terms of documenting possible =
transitions and when to send io messages to prime the
 host pcm stream and when to return pending io messages to the guest driver=
, as opposed to overloading the use of PCM_STOP for drop/pause(/drain), whe=
n the behavior wrt io messages would highly depend on the host interpretati=
on of PCM_STOP.</span></font></li></ul>
</ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">It would be benef=
icial to add two new PCM notifications, via the following stream features:
</span></font></li></ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<ul style=3D"margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">VIRTIO_SND_PCM_F_=
EVT_ERR - indicates support for new notification VIRTIO_SND_EVT_PCM_ERROR, =
that signals to the guest driver that en error
 occurred (other than structly underrun/overrun) while handling io messages=
, requiring a sequence of PCM_RELEASE, PCM_PREPARE, PCM_START to recover</s=
pan></font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,se=
rif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">V=
IRTIO_SND_PCM_F_EVT_CONN_STATE - indicates support for new notifications VI=
RTIO_SND_EVT_PCM_DISCONNECTED and VIRTIO_SND_EVT_PCM_CONNECTED,
 to indicate to the guest driver pcm stream disconnected (e.g. USB device r=
emoved) and pcm stream connected (e.g. USB device re-inserted)</span></font=
></li></ul>
</ul>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">It would be benef=
icial to include Information on period alignment and max buffer size in str=
uct virtio_snd_pcm_info, available via optional
 feature flag, e.g. VIRTIO_SND_PCM_F_PERIOD_INFO and the additional info wo=
uld be added at the end of struct struct virtio_snd_pcm_info, replacing the=
 padding bytes and adding to the length of the struct - new le32 fields per=
iod_align_bytes, min_period_bytes,
 max_period_bytes, max_buffer_bytes, where min_period_bytes, max_period_byt=
es and max_buffer_bytes are all multiples of period_align_bytes. With this =
addition, the guest driver would have the information required to match the=
 period/buffer size capabilities
 of the host pcm stream and advertise them to clients in the guest space, w=
ithout the need to hard code these using the guest virtio_snd module parame=
ters.</span></font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-=
serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:=
12pt;">Alternatively a new control request to query the refined PCM paramet=
ers could be added (e.g. PCM_GET_PARAMS, via PCM feature flag VIRTIO_SND_PC=
M_F_GET_PARAMS),
 to be used by the guest driver after it has successfully sent PCM_SET_PARA=
MS, in order to query the PCM parameters effectively used by the device.</s=
pan></font></li></ul>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"6" color=3D"black"><span style=3D"font-size:24pt;"><b>Audio Co=
ntrols</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The original virtio-snd device s=
pecification as added to virtio 1.1 did not include audio control support, =
however the virtio 1.3 draft includes this.</span></font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>Audio Co=
ntrol Roles</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The roles describe standard uses=
 for controls, like volume, mute and gain. There is also an undefined role =
definition that according to the spec must
 not be used.</span></font></div>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">VIRTIO_SND_CTL_RO=
LE_UNDEFINED</span></font></li><li style=3D"margin:0;"><font face=3D"Calibr=
i,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"fon=
t-size:12pt;">VIRTIO_SND_CTL_ROLE_VOLUME</span></font></li><li style=3D"mar=
gin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">VIRTIO_SND_CTL_ROLE_MUTE</span><=
/font></li><li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,E=
mojiFont" size=3D"3" color=3D"black"><span style=3D"font-size:12pt;">VIRTIO=
_SND_CTL_ROLE_GAIN</span></font></li></ul>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Problems identified with the rol=
e definitions:</span></font></div>
<ul style=3D"margin-top:14pt;margin-bottom:0;">
<li style=3D"margin:0;"><font face=3D"Calibri,sans-serif,serif,EmojiFont" s=
ize=3D"3" color=3D"black"><span style=3D"font-size:12pt;">Not all audio con=
trols can be described as volume, mute or gain. The undefined role must be =
allowed for any control that is not for volume,
 mute or gain.</span></font></li><li style=3D"margin:0;"><font face=3D"Cali=
bri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=3D"f=
ont-size:12pt;">What is the difference between VIRTIO_SND_CTL_ROLE_VOLUME a=
nd VIRTIO_SND_CTL_ROLE_GAIN, is the first supposed to be used for playback
 and the second for capture? Or is the first supposed to be used for digita=
l volume and the second for analog gain? Is a distinction between volume an=
d gain necessary?</span></font></li><li style=3D"margin:0;"><font face=3D"C=
alibri,sans-serif,serif,EmojiFont" size=3D"3" color=3D"black"><span style=
=3D"font-size:12pt;">If certain data types are assumed for controls with ro=
le VIRTIO_SND_CTL_ROLE_VOLUME, VIRTIO_SND_CTL_ROLE_MUTE or VIRTIO_SND_CTL_R=
OLE_GAIN,
 this should be explicitly specified (e.g. BOOLEAN for VIRTIO_SND_CTL_ROLE_=
MUTE, INTEGER for VIRTIO_SND_CTL_ROLE_VOLUME and VIRTIO_SND_CTL_ROLE_GAIN?)=
.</span></font></li></ul>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>Mute con=
trol value meaning</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The virtio spec is not clear whe=
ther a value of 1 for an audio control with role VIRTIO_SND_CTL_ROLE_MUTE m=
eans muted, or rather switched on (unmuted).
 Testing end-to-end with the reference virtio-snd linux/android guest drive=
r it was inferred that 1 means switched on, i.e. unmuted. In our opinion th=
is should be clarified within the spec.</span></font></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>TLV supp=
ort</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The TLV struct and possible type=
 values are considered well known from ALSA.</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">There are only a few common/stan=
dard TLV type definitions (for specific meta data types, like db scale, db =
min/max plus a handful more or the container
 TLV type that allows packing multiple TLVs into one containing TLV); they =
should be defined in virtio-snd.h for the completeness of the specification=
. Otherwise a non ALSA based host that supports reporting metadata would ne=
ed to redefine these to match the
 ALSA definitions</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">The audio controls extension pro=
posal draft includes the definition of struct virtio_snd_ctl_tlv. It is rem=
oved however in the virtio_snd.h header file
 of the linux/android virtio-snd guest driver implementation for this exten=
sion - the guest driver just performs memcpy to/from the equivalent ALSA st=
ruct. For the completeness of the specification all data structures used fo=
r data exchanges within the virtio
 spec should be part of the public header file. This is particularly import=
ant when the host or guest don't use ALSA and don't have access to the ALSA=
 TLV struct definition.</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Other than for metadata of contr=
ols for volume/gain, in ALSA audio controls can use TLVs for representing t=
he actual control data (such controls use
 type VIRTIO_SND_CTL_TYPE_BYTES and access VIRTIO_SND_CTL_ACCESS_TLV_READ, =
VIRTIO_SND_CTL_ACCESS_TLV_WRITE or a combination of VIRTIO_SND_CTL_ACCESS_T=
LV_READ and VIRTIO_SND_CTL_ACCESS_TLV_WRITE). Since this use seems to be su=
pported by the reference linux/android
 virtio-snd guest driver, it should be documented in the spec.</span></font=
></div>
<div style=3D"margin:14pt 0;"><font face=3D"Calibri,sans-serif,serif,EmojiF=
ont" size=3D"5" color=3D"black"><span style=3D"font-size:18pt;"><b>virtio_s=
nd_ctl_info struct alignment</b></span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Field &quot;name&quot; of the vi=
rtio_snd_ctl_info struct has a length of 44 bytes. With this field length, =
the alignment of the following value union field with
 __le64 data members depends on packing and/or alignment compiler directive=
s that can differ between host and guest and thus result in a different ali=
gnment of &quot;value&quot;. Klocwork detects this issue as a PORTING.STORA=
GE.STRUCT guideline violation for this struct,
 which can be fixed by modifying the length of field &quot;name&quot; to 48=
, or by adding a padding field of length 4 bytes between the &quot;name&quo=
t; and &quot;value&quot; fields (e.g. __u8 padding[4]).</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Looking forward to clarification=
s and/or responses.
</span></font><font size=3D"3" color=3D"black"><span style=3D"font-size:12p=
t;"><br>
</span></font></div>
<div style=3D"margin-top:14pt;margin-bottom:14pt;"><font size=3D"3" color=
=3D"black"><span style=3D"font-size:12pt;">Radu Ocica</span></font></div>
</div>
</div>
</span></font><br>
<p></p>
</div>

<HR>This transmission (including any attachments) may contain confidential =
information, privileged material (including material protected by the solic=
itor-client or other applicable privileges), or constitute non-public infor=
mation. Any use of this information by anyone other than the intended recip=
ient is prohibited. If you have received this transmission in error, please=
 immediately reply to the sender and delete this information from your syst=
em. Use, dissemination, distribution, or reproduction of this transmission =
by unintended recipients is not authorized and may be unlawful.<BR>
</body>
</html>

--_000_02725a6508584ed2aa8b31c9e9f4264ablackberrycom_--
