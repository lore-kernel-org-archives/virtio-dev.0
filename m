Return-Path: <virtio-dev-return-14040-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E96C4332F
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 19:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AAEDA2A824
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 19:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87A2D986C4E
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Nov 2023 19:05:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C1F4986C46; Fri,  3 Nov 2023 19:05:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A7CF986C45;
	Fri,  3 Nov 2023 19:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Radu Ocica <rocica@blackberry.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>,
        "anton.yakovlev@opensynergy.com"
	<anton.yakovlev@opensynergy.com>
Thread-Topic: [virtio-dev] virtio-snd comments/questions
Thread-Index: AQHaAdgPGZsaTwL9FEiOAsMZLVwCl7BZBi2AgA/8Oms=
Date: Fri, 3 Nov 2023 19:05:30 +0000
Message-ID: <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>,<ZTeZ6YjyR0BJOylw@fedora>
In-Reply-To: <ZTeZ6YjyR0BJOylw@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.64.197.67]
Content-Type: multipart/alternative;
	boundary="_000_6df30c7945ca4ac2bb1c170b1c028719blackberrycom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
Subject: Re: [virtio-dev] virtio-snd comments/questions

--_000_6df30c7945ca4ac2bb1c170b1c028719blackberrycom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Matias,


I will answer to your comments:


> I agree that the STOP command could be better explain it. In our
implementation[1], we implemented as your last point defines it, i.e.,
stop host's pcm stream and keep messages in tx/rx. The STOP control
command is marked as completed immediately. The virtio spec does not
indicate that STOP requires to mark pending io messages as completed
thus we do not do that. A note about this in the spec would help.


In our implementation we made the assumption that STOP is meant to be imple=
mented as pause, thus if the host stream supports the pause operation we pa=
use it and keep io messages in tx/rx queue; the host stream is stopped (via=
 the drop operation) and io messages are marked in this case as completed a=
nd returned to the guest driver only when receiving the RELEASE control req=
uest.

However, if the host stream does not support pause the only option left is =
to perform a drop operation on the host stream and in this case all pending=
 messages in the tx/rx queue need to be returned to the guest as completed,=
 because at the next start possibly all messages will be needed to prime th=
e host stream (in the case of playback). A host stream prepare will also be=
 needed to be issued internally by the device if a START is issued by the g=
uest right after the STOP. And there is some uncertainty whether a guest dr=
iver will send new io messages before or after the START control request.

I think the difficulty of describing a clear behavior for STOP stems from a=
ttempting a minimal spec, with a minimal number of control requests. If ded=
icated STOP vs PAUSE requests were used, it would be more straightforward t=
o specify an unambiguous behavior for each.


> Checking the Linux kernel driver, the STOP cmd is issued when getting
SNDRV_PCM_TRIGGER_PAUSE_PUSH. Documentation does not indicate when this
msg is sent though. The RELEASE cmd is issued only during
virtsnd_pcm_sync_stop(). In this sense, I would guess that STOP behaves
like a PAUSE whereas RELEASE behaves like a STOP and dropping all
pending IO messages. The spec left for the implementation if device
would still playback those buffer or just drop them. I think you may
find interesting the discussion we started at this thread[2] regarding
the RELEASE control cmd semantics.


We have made the call to never have the device drain the host pcm stream. I=
f the host pcm stream supports pause, then STOP pauses it and RELEASE perfo=
rms a drop and returns immediately all io messages as completed to the gues=
t driver. If the host pcm stream does not support pause, then STOP results =
in a drop operation and return of all io messages as completed to the guest=
 driver, and the RELEASE is a no-op. A drain like behavior for playback can=
 be obtained if the guest driver stops writing new data and waits to underr=
un, time at which it sends STOP and RELEASE. This seems to work fine with t=
he existing reference linux/android guest driver for success path handling.=
 There are questions regarding failure path handling (failure of control or=
 io requests) and what variability can/should be expected in terms of guest=
 driver behavior.


> Right, we discussed about this issue at [3]. I've recently proposed the
following patch to fix that: '[PATCH v3] ALSA: virtio: use ack callback'


This looks promising. I found it already at https://github.com/torvalds/lin=
ux/blob/master/sound/virtio/ and will give it a try. Is there a repository =
for this driver code where both this fix and the audio control support is a=
vailable?


Thank you for your comments and the very valuable information on the ack ca=
llback patch.


Regards,

Radu

________________________________
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Sent: Tuesday, October 24, 2023 6:18:17 AM
To: Radu Ocica
Cc: virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org; a=
nton.yakovlev@opensynergy.com
Subject: Re: [virtio-dev] virtio-snd comments/questions

CAUTION - This email is from an external source. Please be cautious with li=
nks and attachments. (go/taginfo)

Hello Radu,

I CC Anton too. This email responds part of the questions.

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

I agree that the STOP command could be better explain it. In our
implementation[1], we implemented as your last point defines it, i.e.,
stop host's pcm stream and keep messages in tx/rx. The STOP control
command is marked as completed immediately. The virtio spec does not
indicate that STOP requires to mark pending io messages as completed
thus we do not do that. A note about this in the spec would help.

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

Checking the Linux kernel driver, the STOP cmd is issued when getting
SNDRV_PCM_TRIGGER_PAUSE_PUSH. Documentation does not indicate when this
msg is sent though. The RELEASE cmd is issued only during
virtsnd_pcm_sync_stop(). In this sense, I would guess that STOP behaves
like a PAUSE whereas RELEASE behaves like a STOP and dropping all
pending IO messages. The spec left for the implementation if device
would still playback those buffer or just drop them. I think you may
find interesting the discussion we started at this thread[2] regarding
the RELEASE control cmd semantics.

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

Right, we discussed about this issue at [3]. I've recently proposed the
following patch to fix that: '[PATCH v3] ALSA: virtio: use ack callback'

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

We've also spotted that the spec does not specify what to do with
invalid transitions. I think in those cases the transition cannot be
taken and thus spec only refers to successful transitions. IIUC, in
Crosvm, for example, if a cmd is executed in a invalid state, the device
returns error to the guest but the transition does not happen.

I will send a second email to address the remainder points.

Thanks, Matias.

[1] https://urldefense.com/v3/__https://github.com/rust-vmm/vhost-device/tr=
ee/main/staging/vhost-device-sound__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKqKlnT9s=
d2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdvUzFVHM$
[2] https://urldefense.com/v3/__https://lore.kernel.org/all/1a54feab-5de9-4=
b39-a4ce-7ff22e23cf52@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKq=
KlnT9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdg5pM9y4$
[3] https://urldefense.com/v3/__https://lore.kernel.org/all/f28d4604-b169-4=
583-b9ab-d53e6d08ce63@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKq=
KlnT9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdHbWqCWs$ .

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_6df30c7945ca4ac2bb1c170b1c028719blackberrycom_
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
<p>Hi Matias,</p>
<p><br>
</p>
<p>I will answer to your comments:</p>
<p><br>
</p>
<p>&gt; <font size=3D"2"><span style=3D"font-size:10pt">I agree that the ST=
OP command could be better explain it. In our<br>
implementation[1], we implemented as your last point defines it, i.e.,<br>
stop host's pcm stream and keep messages in tx/rx. The STOP control<br>
command is marked as completed immediately. The virtio spec does not<br>
indicate that STOP requires to mark pending io messages as completed<br>
thus we do not do that. A note about this in the spec would help.</span></f=
ont></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">In our implementation we=
 made the assumption that STOP is meant to be implemented as pause, thus if=
 the host stream supports the pause operation we pause it and keep io messa=
ges in tx/rx queue; the host stream
 is stopped (via the drop operation) and io messages are marked in this cas=
e as completed and returned to the guest driver only when receiving the REL=
EASE control request.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">However, if the host str=
eam does not support pause the only option left is to perform a drop operat=
ion on the host stream and in this case all pending messages in the tx/rx q=
ueue need to be returned to the guest
 as completed, because at the next start possibly all messages will be need=
ed to prime the host stream (in the case of playback). A host stream prepar=
e will also be needed to be issued internally by the device if a START is i=
ssued by the guest right after the
 STOP. And there is some uncertainty whether a guest driver will send new i=
o messages before or after the START control request.
<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">I think the difficulty o=
f describing a clear behavior for STOP stems from attempting a minimal spec=
, with a minimal number of control requests. If dedicated STOP vs PAUSE req=
uests were used, it would be more straightforward
 to specify an unambiguous behavior for each.&nbsp; <br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt; <font size=3D"2"><s=
pan style=3D"font-size:10pt">Checking the Linux kernel driver, the STOP cmd=
 is issued when getting<br>
SNDRV_PCM_TRIGGER_PAUSE_PUSH. Documentation does not indicate when this<br>
msg is sent though. The RELEASE cmd is issued only during<br>
virtsnd_pcm_sync_stop(). In this sense, I would guess that STOP behaves<br>
like a PAUSE whereas RELEASE behaves like a STOP and dropping all<br>
pending IO messages. The spec left for the implementation if device<br>
would still playback those buffer or just drop them. I think you may<br>
find interesting the discussion we started at this thread[2] regarding<br>
the RELEASE control cmd semantics.</span></font><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">We have made the call to=
 never have the device drain the host pcm stream. If the host pcm stream su=
pports pause, then STOP pauses it and RELEASE performs a drop and returns i=
mmediately all io messages as completed
 to the guest driver. If the host pcm stream does not support pause, then S=
TOP results in a drop operation and return of
<font size=3D"2"><span style=3D"font-size:10pt">all io messages as complete=
d to the guest driver</span></font>, and the RELEASE is a no-op. A drain li=
ke behavior for playback can be obtained if the guest driver stops writing =
new data and waits to underrun, time
 at which it sends STOP and RELEASE. This seems to work fine with the exist=
ing reference linux/android guest driver for success path handling. There a=
re questions regarding failure path handling (failure of control or io requ=
ests) and what variability can/should
 be expected in terms of guest driver behavior.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt; <font size=3D"2"><s=
pan style=3D"font-size:10pt">Right, we discussed about this issue at [3]. I=
've recently proposed the<br>
following patch to fix that: '[PATCH v3] ALSA: virtio: use ack callback'</s=
pan></font><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">This looks promising. I =
found it already at
<a href=3D"https://github.com/torvalds/linux/blob/master/sound/virtio/" cla=
ss=3D"x_OWAAutoLink">
https://github.com/torvalds/linux/blob/master/sound/virtio/</a> and will gi=
ve it a try. Is there a repository for this driver code where both this fix=
 and the audio control support is available?<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Thank you for your comme=
nts and the very valuable information on the ack callback patch.</span></fo=
nt></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Regards,</span></font></=
p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Radu<br>
</span></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Matias Ezequiel Var=
a Larsen &lt;mvaralar@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, October 24, 2023 6:18:17 AM<br>
<b>To:</b> Radu Ocica<br>
<b>Cc:</b> virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open=
.org; anton.yakovlev@opensynergy.com<br>
<b>Subject:</b> Re: [virtio-dev] virtio-snd comments/questions</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">CAUTION - This email is from an external source. P=
lease be cautious with links and attachments. (go/taginfo)<br>
<br>
Hello Radu, <br>
<br>
I CC Anton too. This email responds part of the questions.<br>
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
<br>
I agree that the STOP command could be better explain it. In our<br>
implementation[1], we implemented as your last point defines it, i.e.,<br>
stop host's pcm stream and keep messages in tx/rx. The STOP control<br>
command is marked as completed immediately. The virtio spec does not<br>
indicate that STOP requires to mark pending io messages as completed<br>
thus we do not do that. A note about this in the spec would help.<br>
<br>
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
<br>
Checking the Linux kernel driver, the STOP cmd is issued when getting<br>
SNDRV_PCM_TRIGGER_PAUSE_PUSH. Documentation does not indicate when this<br>
msg is sent though. The RELEASE cmd is issued only during<br>
virtsnd_pcm_sync_stop(). In this sense, I would guess that STOP behaves<br>
like a PAUSE whereas RELEASE behaves like a STOP and dropping all<br>
pending IO messages. The spec left for the implementation if device<br>
would still playback those buffer or just drop them. I think you may<br>
find interesting the discussion we started at this thread[2] regarding<br>
the RELEASE control cmd semantics.<br>
<br>
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
<br>
Right, we discussed about this issue at [3]. I've recently proposed the<br>
following patch to fix that: '[PATCH v3] ALSA: virtio: use ack callback'<br>
<br>
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
We've also spotted that the spec does not specify what to do with<br>
invalid transitions. I think in those cases the transition cannot be<br>
taken and thus spec only refers to successful transitions. IIUC, in<br>
Crosvm, for example, if a cmd is executed in a invalid state, the device<br>
returns error to the guest but the transition does not happen. <br>
<br>
I will send a second email to address the remainder points.<br>
<br>
Thanks, Matias.<br>
<br>
[1] <a href=3D"https://urldefense.com/v3/__https://github.com/rust-vmm/vhos=
t-device/tree/main/staging/vhost-device-sound__;!!JoeW-IhCUkS0Jg!bYrKkBHywr=
zvbKqKlnT9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdvUzFVHM$">
https://urldefense.com/v3/__https://github.com/rust-vmm/vhost-device/tree/m=
ain/staging/vhost-device-sound__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKqKlnT9sd2r8=
yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdvUzFVHM$</a>
<br>
[2] <a href=3D"https://urldefense.com/v3/__https://lore.kernel.org/all/1a54=
feab-5de9-4b39-a4ce-7ff22e23cf52@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrK=
kBHywrzvbKqKlnT9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdg5p=
M9y4$">
https://urldefense.com/v3/__https://lore.kernel.org/all/1a54feab-5de9-4b39-=
a4ce-7ff22e23cf52@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKqKlnT=
9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdg5pM9y4$</a>
<br>
[3] <a href=3D"https://urldefense.com/v3/__https://lore.kernel.org/all/f28d=
4604-b169-4583-b9ab-d53e6d08ce63@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrK=
kBHywrzvbKqKlnT9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdHbW=
qCWs$">
https://urldefense.com/v3/__https://lore.kernel.org/all/f28d4604-b169-4583-=
b9ab-d53e6d08ce63@opensynergy.com/T/__;!!JoeW-IhCUkS0Jg!bYrKkBHywrzvbKqKlnT=
9sd2r8yt3hdxcPMpipjtExqsI3lIusGdbwOM5n1sT_BE1-GB4xdvBalxdHbWqCWs$</a> .<br>
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

--_000_6df30c7945ca4ac2bb1c170b1c028719blackberrycom_--
