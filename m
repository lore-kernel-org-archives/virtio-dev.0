Return-Path: <virtio-dev-return-14039-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35165C4167D
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 18:17:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4E7E72A820
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 18:17:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 320E9986C50
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 18:17:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 160B1986C46; Fri,  3 Nov 2023 18:17:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F35AC986C45;
	Fri,  3 Nov 2023 18:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Radu Ocica <rocica@blackberry.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
        "anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Thread-Topic: [virtio-dev] virtio-snd comments/questions
Thread-Index: AQHaAdgPGZsaTwL9FEiOAsMZLVwCl7BZO+6AgA+1CEk=
Date: Fri, 3 Nov 2023 18:17:17 +0000
Message-ID: <134bb8dbb49643e6b3d6e9b65239b6a8@blackberry.com>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>,<ZTfHAQxns6j8gmEL@fedora>
In-Reply-To: <ZTfHAQxns6j8gmEL@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.64.197.67]
Content-Type: multipart/alternative;
	boundary="_000_134bb8dbb49643e6b3d6e9b65239b6a8blackberrycom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_17,2023-11-02_03,2023-05-22_02
Subject: Re: [virtio-dev] virtio-snd comments/questions

--_000_134bb8dbb49643e6b3d6e9b65239b6a8blackberrycom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I also think that the driver should not send a STOP command after a failed =
START command. There is no explicit description of any states in the virtio=
 sound device specification. We have both adopted an interpretation that th=
e state is determined by the last successful pcm control request and the tr=
ansitions specified for pcm control requests assume success of these contro=
l requests. I wish this was clarified explicitly in the spec, to not allow =
room for interpretation.


Regards,

Radu

________________________________
From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> on =
behalf of Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Sent: Tuesday, October 24, 2023 9:30:41 AM
To: Radu Ocica
Cc: virtio-dev@lists.oasis-open.org; virtio-comment@lists.oasis-open.org; a=
nton.yakovlev@opensynergy.com
Subject: Re: [virtio-dev] virtio-snd comments/questions

CAUTION - This email is from an external source. Please be cautious with li=
nks and attachments. (go/taginfo)

On Wed, Oct 18, 2023 at 03:32:21PM +0000, Radu Ocica wrote:
> Hi,
> I am working on implementing a virtio-snd vdev. During my work on differe=
nt aspects of the implementation I stumbled across the following issues wit=
h the virtio sound device specification (that is part of the virtio 1.3 dra=
ft). In some cases additional clarifications might be enough to address the=
 issue, in others additional features might be required. Below is a list of=
 the issues, with some suggestions on how the issues could be addressed.
> PCM playback and capture
> Unclear semantics of PCM_STOP/PCM_START operations
> The virtio-snd specification is not clear on the expectations on how the =
PCM_STOP control request is to be handled by the vdev, in terms of whether =
to:
>
>   *   drop the remaining buffered audio in the host pcm stream and return=
 pending io messages to the guest driver
>   *   drop the remaining buffered audio in the host pcm stream and keep p=
ending io messages in order to be able to prime the host pcm stream in case=
 PCM_STOP is followed by PCM_START; return pending io messages only when re=
ceiving PCM_RELEASE
>   *   drain the remaining buffered audio in the host pcm stream and send =
a PCM_STOP response upon drain completion, return pending io messages to th=
e guest driver as they are completed (before PCM_STOP response); drain capa=
bility might or might not be available for the host pcm stream
>   *   start draining the remaining buffered audio in the host pcm stream =
and send a PCM_STOP response immediately, return pending io messages to the=
 guest driver as they are completed (after PCM_STOP response); if receiving=
 PCM_RELEASE before drain completion hold off the response until all pendin=
g io messages are completed and returned to the guest driver; drain capabil=
ity might or might not be available for the host pcm stream
>   *   pause the host pcm stream and maintain buffered audio / pending io =
messages as is; pause capability might or might not be available for the ho=
st pcm stream
>
> If the thinking is that the vdev on the host can decide on how to impleme=
nt PCM_STOP based on the host stream capabilities, the guest driver has no =
information about the choice made by the vdev. In our opinion the choice ma=
de by the vdev in implementing PCM_STOP dictates what the possible transiti=
ons after PCM_STOP can be (if PCM_STOP is implemented as pause, PCM_START a=
nd PCM_RELEASE are possible transitions, but if PCM_STOP is implemented as =
drain, the only valid transition is PCM_RELEASE and if PCM_STOP is implemen=
ted as drop and all pending io messages have been returned to the guest dri=
ver, again the only valid transition seems to be PCM_RELEASE), but the gues=
t driver is the one issuing the next request and it might at the best be ab=
le to make an educated guess how the vdev implemented PCM_STOP based on whe=
ther all the pending io messages are returned or not to the guest driver. T=
o make such a guess possible, more clarifications would be required in the =
spec to identify which of the scenarios listed above are considered by the =
spec.
> Note 1:  The reference virtio-snd linux/android guest driver explicitly d=
oesn't support the ALSA SNDRV_PCM_INFO_DRAIN_TRIGGER feature flag, which mi=
ght indicate there was no intent to support drain semantics.
> Note 2: The reference virtio-snd linux/android guest driver explicitly do=
es support the ALSA SNDRV_PCM_INFO_PAUSE feature flag, which seems to indic=
ate intent to support pause semantics, along with drop semantics.
> Note 3: The Android Audio HAL and tinyalsa/tinyplay don't have any notion=
 of drain or pause. At the end of a playback session there is a wait for pr=
eviously buffered data to complete playing using the tinyalsa pcm_wait() fu=
nction, and then a PCM_STOP request is issued after the buffered audio has =
completed playing. Drop semantics are assumed for PCM_STOP in this context.
> Information on period alignment and max audio buffer size
> No information about period alignment and min/max audio buffer/period siz=
e is currently available in struct virtio_snd_pcm_info. Ideally the period =
size used for io messages should match the period size used on the host. Th=
at will guarantee consistency in timing, precise accounting of available ro=
om to write more data or available data to read, across host and guest. A w=
orkaround is possible, where the device will fail a PCM_SET_PARAMETERS requ=
est that specifies an unsupported period alignment or audio buffer/period s=
ize and the guest is forced to use a period and buffer size that is known t=
o be supported by the host device (this can be done in an Android guest, by=
 hard coding the android audio HAL period size and the number of periods an=
d thus effectively the audio buffer size that is used for the virtio sound =
devices in the guest; in android and linux guests it can be done also by se=
tting the virtio_snd module parameters, to the effect of locking down the p=
eriod and buffer size).
> General Issues
>
>   *   There is no statement regarding the endianness of PCM data exchange=
d via txq and rxq queues and the virtio sound PCM format definitions do not=
 include endianness.
>   *   There is currently no requirement for the guest driver to enqueue a=
n io message only after it has completed writing data to it (playback) or r=
eading data from it (capture). The linux/android guest driver currently enq=
ueues an io message for playback immediately after calling snd_pcm_period_e=
lapsed(). snd_pcm_period_elapsed() makes it possible for the guest client a=
pp to write new data, but upon the return of this function there is no guar=
antee that the guest client app has already written new data. If the vdev d=
equeues the io message immediately and copies the PCM data for that io requ=
est before the guest client app has actually written new data to it, it res=
ults in out-of-sequence/stale data being played back.
>   *   There is no statement how the guest driver should react to a contro=
l request failing.
>
>      *   For PCM control requests the spec details what the "possible tra=
nsitions" are after each control request. It doesn't specify whether this a=
pplies only to successful control requests, or irrespective of the success =
of the control requests. For instance for PCM_START only PCM_STOP is listed=
 as a valid transition. What happens if PCM_START fails though? Is PCM_STOP=
 still a valid transition? Is a repeat of PCM_START valid, since the previo=
us PCM_START failed? Is a PCM_RELEASE required in order for the guest drive=
r to recover the io request descriptors that were sent to the vdev before P=
CM_START? Is a PCM_STOP required in this case, in order to be able to send =
PCM_RELEASE (because of valid sequences considerations)? It was seen that t=
he reference linux/android guest driver ignores a PCM_START failure and sti=
ll sends io requests after the failed PCM_START.

I tested this and I observed that when START fails, the guest still
sends the STOP cmd. This cmd is only valid if the stream has transited
to the START state, i.e., the spec only allows STOP in the START state.
I did not obser that the RELEASE cmd is issued. I think the driver shall
not send the STOP msg in that situation. What do you think?

Regards, Matias.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_134bb8dbb49643e6b3d6e9b65239b6a8blackberrycom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>I also think that the driver should not send a STOP command after a fail=
ed START command. There is no explicit description of any states in the vir=
tio sound device specification. We have both adopted an interpretation that=
 the state is determined by the
 last successful pcm control request and the transitions specified for pcm =
control requests assume success of these control requests. I wish this was =
clarified explicitly in the spec, to not allow room for interpretation.</p>
<p><br>
</p>
<p>Regards,</p>
<p>Radu<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> virtio-dev@lists.oa=
sis-open.org &lt;virtio-dev@lists.oasis-open.org&gt; on behalf of Matias Ez=
equiel Vara Larsen &lt;mvaralar@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, October 24, 2023 9:30:41 AM<br>
<b>To:</b> Radu Ocica<br>
<b>Cc:</b> virtio-dev@lists.oasis-open.org; virtio-comment@lists.oasis-open=
.org; anton.yakovlev@opensynergy.com<br>
<b>Subject:</b> Re: [virtio-dev] virtio-snd comments/questions</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">CAUTION - This email is from an external source. P=
lease be cautious with links and attachments. (go/taginfo)<br>
<br>
On Wed, Oct 18, 2023 at 03:32:21PM &#43;0000, Radu Ocica wrote:<br>
&gt; Hi,<br>
&gt; I am working on implementing a virtio-snd vdev. During my work on diff=
erent aspects of the implementation I stumbled across the following issues =
with the virtio sound device specification (that is part of the virtio 1.3 =
draft). In some cases additional clarifications
 might be enough to address the issue, in others additional features might =
be required. Below is a list of the issues, with some suggestions on how th=
e issues could be addressed.<br>
&gt; PCM playback and capture<br>
&gt; Unclear semantics of PCM_STOP/PCM_START operations<br>
&gt; The virtio-snd specification is not clear on the expectations on how t=
he PCM_STOP control request is to be handled by the vdev, in terms of wheth=
er to:<br>
&gt; <br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; drop the remaining buffered audio in the hos=
t pcm stream and return pending io messages to the guest driver<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; drop the remaining buffered audio in the hos=
t pcm stream and keep pending io messages in order to be able to prime the =
host pcm stream in case PCM_STOP is followed by PCM_START; return pending i=
o messages only when receiving PCM_RELEASE<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; drain the remaining buffered audio in the ho=
st pcm stream and send a PCM_STOP response upon drain completion, return pe=
nding io messages to the guest driver as they are completed (before PCM_STO=
P response); drain capability might or might not be available
 for the host pcm stream<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; start draining the remaining buffered audio =
in the host pcm stream and send a PCM_STOP response immediately, return pen=
ding io messages to the guest driver as they are completed (after PCM_STOP =
response); if receiving PCM_RELEASE before drain completion
 hold off the response until all pending io messages are completed and retu=
rned to the guest driver; drain capability might or might not be available =
for the host pcm stream<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; pause the host pcm stream and maintain buffe=
red audio / pending io messages as is; pause capability might or might not =
be available for the host pcm stream<br>
&gt; <br>
&gt; If the thinking is that the vdev on the host can decide on how to impl=
ement PCM_STOP based on the host stream capabilities, the guest driver has =
no information about the choice made by the vdev. In our opinion the choice=
 made by the vdev in implementing PCM_STOP
 dictates what the possible transitions after PCM_STOP can be (if PCM_STOP =
is implemented as pause, PCM_START and PCM_RELEASE are possible transitions=
, but if PCM_STOP is implemented as drain, the only valid transition is PCM=
_RELEASE and if PCM_STOP is implemented
 as drop and all pending io messages have been returned to the guest driver=
, again the only valid transition seems to be PCM_RELEASE), but the guest d=
river is the one issuing the next request and it might at the best be able =
to make an educated guess how the
 vdev implemented PCM_STOP based on whether all the pending io messages are=
 returned or not to the guest driver. To make such a guess possible, more c=
larifications would be required in the spec to identify which of the scenar=
ios listed above are considered
 by the spec.<br>
&gt; Note 1:&nbsp; The reference virtio-snd linux/android guest driver expl=
icitly doesn't support the ALSA SNDRV_PCM_INFO_DRAIN_TRIGGER feature flag, =
which might indicate there was no intent to support drain semantics.<br>
&gt; Note 2: The reference virtio-snd linux/android guest driver explicitly=
 does support the ALSA SNDRV_PCM_INFO_PAUSE feature flag, which seems to in=
dicate intent to support pause semantics, along with drop semantics.<br>
&gt; Note 3: The Android Audio HAL and tinyalsa/tinyplay don't have any not=
ion of drain or pause. At the end of a playback session there is a wait for=
 previously buffered data to complete playing using the tinyalsa pcm_wait()=
 function, and then a PCM_STOP request
 is issued after the buffered audio has completed playing. Drop semantics a=
re assumed for PCM_STOP in this context.<br>
&gt; Information on period alignment and max audio buffer size<br>
&gt; No information about period alignment and min/max audio buffer/period =
size is currently available in struct virtio_snd_pcm_info. Ideally the peri=
od size used for io messages should match the period size used on the host.=
 That will guarantee consistency in
 timing, precise accounting of available room to write more data or availab=
le data to read, across host and guest. A workaround is possible, where the=
 device will fail a PCM_SET_PARAMETERS request that specifies an unsupporte=
d period alignment or audio buffer/period
 size and the guest is forced to use a period and buffer size that is known=
 to be supported by the host device (this can be done in an Android guest, =
by hard coding the android audio HAL period size and the number of periods =
and thus effectively the audio buffer
 size that is used for the virtio sound devices in the guest; in android an=
d linux guests it can be done also by setting the virtio_snd module paramet=
ers, to the effect of locking down the period and buffer size).<br>
&gt; General Issues<br>
&gt; <br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; There is no statement regarding the endianne=
ss of PCM data exchanged via txq and rxq queues and the virtio sound PCM fo=
rmat definitions do not include endianness.<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; There is currently no requirement for the gu=
est driver to enqueue an io message only after it has completed writing dat=
a to it (playback) or reading data from it (capture). The linux/android gue=
st driver currently enqueues an io message for playback
 immediately after calling snd_pcm_period_elapsed(). snd_pcm_period_elapsed=
() makes it possible for the guest client app to write new data, but upon t=
he return of this function there is no guarantee that the guest client app =
has already written new data. If
 the vdev dequeues the io message immediately and copies the PCM data for t=
hat io request before the guest client app has actually written new data to=
 it, it results in out-of-sequence/stale data being played back.<br>
&gt;&nbsp;&nbsp; *&nbsp;&nbsp; There is no statement how the guest driver s=
hould react to a control request failing.<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; For PCM control requests t=
he spec details what the &quot;possible transitions&quot; are after each co=
ntrol request. It doesn't specify whether this applies only to successful c=
ontrol requests, or irrespective of the success of the control requests. Fo=
r instance
 for PCM_START only PCM_STOP is listed as a valid transition. What happens =
if PCM_START fails though? Is PCM_STOP still a valid transition? Is a repea=
t of PCM_START valid, since the previous PCM_START failed? Is a PCM_RELEASE=
 required in order for the guest
 driver to recover the io request descriptors that were sent to the vdev be=
fore PCM_START? Is a PCM_STOP required in this case, in order to be able to=
 send PCM_RELEASE (because of valid sequences considerations)? It was seen =
that the reference linux/android
 guest driver ignores a PCM_START failure and still sends io requests after=
 the failed PCM_START.<br>
<br>
I tested this and I observed that when START fails, the guest still<br>
sends the STOP cmd. This cmd is only valid if the stream has transited<br>
to the START state, i.e., the spec only allows STOP in the START state.<br>
I did not obser that the RELEASE cmd is issued. I think the driver shall<br>
not send the STOP msg in that situation. What do you think?<br>
<br>
Regards, Matias.<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org<br>
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org<br>
<br>
</div>
</span></font>

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

--_000_134bb8dbb49643e6b3d6e9b65239b6a8blackberrycom_--
