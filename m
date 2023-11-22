Return-Path: <virtio-dev-return-14063-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3341C61D97
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Nov 2023 18:59:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03E6722370
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Nov 2023 18:59:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF3A39868A8
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Nov 2023 18:59:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C76B298689C; Wed, 22 Nov 2023 18:59:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5D4798689F
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Nov 2023 18:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Radu Ocica <rocica@blackberry.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Thread-Topic: [virtio-dev] virtio-snd comments/questions
Thread-Index: AQHaAdgPGZsaTwL9FEiOAsMZLVwCl7BZBi2AgA/8OmuABNQTgIAEeavRgAZFtwCADkTzCg==
Date: Wed, 22 Nov 2023 18:59:15 +0000
Message-ID: <dd0ecb29d8de4fc5a775469ea51af461@blackberry.com>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora> <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>
 <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
 <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>,<ZVIFlIcOjW5+jgaH@fedora>
In-Reply-To: <ZVIFlIcOjW5+jgaH@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.64.197.67]
Content-Type: multipart/alternative;
	boundary="_000_dd0ecb29d8de4fc5a775469ea51af461blackberrycom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
Subject: Re: [virtio-dev] virtio-snd comments/questions

--_000_dd0ecb29d8de4fc5a775469ea51af461blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Matias,


> >
> > > Could you elaborate on this? Which audio backend would not support
> > > PAUSE? I am not very familiar with audio engines.
> >
> > For instance in linux, alsa-lib has a flag that specifies pause support=
 by a PCM stream:
> > #define SNDRV_PCM_INFO_PAUSE                       (1UL<<19)  /* pause =
ioctl is supported */
> > The snd_pcm_pause API can only be used successfully if the PCM stream h=
as this bit set in its PCM info.
> > A similar concept exists in QNX sound.
> >

> Oh, I see. I was unaware of this flag. Not supporting PAUSE in the host
> sound card may not be a problem. In our case, the pw backend in the host
> stops playing when a guest sends STOP immediately. As soon as START is
> sent again, pw begins consuming from the tx queue. Tx buffers are only
> signaled as complete after START is reissued. In the meantime, the msgs
> are in the available ring of the tx queue.

> > However, if the host stream does not support pause the only option
> > left is to perform a drop operation on the host stream and in this
> > case all pending messages in the tx/rx queue need to be returned to
> > the guest as completed, because at the next start possibly all
> > messages will be needed to prime the host stream (in the case of
> > playback).

> If STOP is sent and there is still msgs in the TX queue, can't the
> device just stop playing until START is issued again? Why does the
> device require to drop the msgs in this case?
Invoking the pcm drop API on the host has been the modality chosen by us to=
 stop playing, with immediate effect. Whatever io messages were buffered at=
 the time by the host pcm device need then to be returned to the guest driv=
er as completed. Messages in the TX queue at the time of the STOP request c=
an be left untouched. Depending on the relationship between number of perio=
ds used by the guest device vs number of periods used by the host device, t=
he TX queue might be normally empty though (for instance if host and guest =
device use the same number of periods, all pcm data received from the guest=
 driver would end up immediately in the backend buffer).
The way you describe STOP it sounds like you just stop writing new data to =
the host pcm device, without invoking any API to explicitly stop it (if pau=
se API not available for the host pcm device). This allows for currently ba=
ckend buffered data to continue playing and correspondingly io messages nee=
d to be returned to the guest driver as they are consumed. If no START is r=
eceived before the backend buffered data completes playing, the host device=
 then underruns. At this point it either continues running by injecting sil=
ence or stops, depending on setup options. The effective stop of sound play=
back occurs when the backend buffered data completes playing, which might b=
e after a considerable delay, depending on backend buffer size. Keeping the=
 host device running and injecting silence sounds like the easiest way to a=
void the need to re-prepare the host pcm device when restarting. Have I cap=
tured your approach accurately?

Cheers,
Radu

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_dd0ecb29d8de4fc5a775469ea51af461blackberrycom_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p>Hi Matias,</p>
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);"><font size=3D"2"><span style=3D"font-si=
ze:10pt;">
<div class=3D"PlainText">&gt; &gt; <br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; &g=
t; Could you elaborate on this? Which audio backend would not support<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; &g=
t; PAUSE? I am not very familiar with audio engines.<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; <b=
r>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; Fo=
r instance in linux, alsa-lib has a flag that specifies pause support by a =
PCM stream:<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; #d=
efine SNDRV_PCM_INFO_PAUSE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; (1UL&lt;&lt;19)&nbsp; /* pause ioctl is supported */<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; Th=
e snd_pcm_pause API can only be used successfully if the PCM stream has thi=
s bit set in its PCM info.<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; A =
similar concept exists in QNX sound.<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; <b=
r>
<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>Oh, I s=
ee. I was unaware of this flag. Not supporting PAUSE in the host<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>sound c=
ard may not be a problem. In our case, the pw backend in the host<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>stops p=
laying when a guest sends STOP immediately. As soon as START is<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>sent ag=
ain, pw begins consuming from the tx queue. Tx buffers are only<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>signale=
d as complete after START is reissued. In the meantime, the msgs<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>are in =
the available ring of the tx queue.<br>
<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; Ho=
wever, if the host stream does not support pause the only option<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; le=
ft is to perform a drop operation on the host stream and in this<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; ca=
se all pending messages in the tx/rx queue need to be returned to<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; th=
e guest as completed, because at the next start possibly all<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; me=
ssages will be needed to prime the host stream (in the case of<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>&gt; pl=
ayback).<br>
<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>If STOP=
 is sent and there is still msgs in the TX queue, can't the<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>device =
just stop playing until START is issued again? Why does the<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt; </span></font>device =
require to drop the msgs in this case?<br>
</div>
<div class=3D"PlainText">Invoking the pcm drop API on the host has been the=
 modality chosen by us to stop playing, with immediate effect. Whatever io =
messages were buffered at the time by the host pcm device need then to be&n=
bsp;returned to the guest driver as completed.
 Messages in the TX queue at the time of the STOP request can be left untou=
ched. Depending on the relationship between number of periods used by the g=
uest device vs number of periods used by the host device, the TX queue migh=
t be normally empty though (for
 instance if host and guest device use the same number of periods, all pcm =
data received from the guest driver would end up immediately in the backend=
 buffer).</div>
<div class=3D"PlainText">The way you describe STOP it sounds like you just =
stop writing new data to the host pcm device, without invoking any API to e=
xplicitly stop it (if pause API not available for the host pcm device). Thi=
s allows for currently backend buffered
 data to continue playing and correspondingly io messages need to be return=
ed to the guest driver as they are consumed. If no START is received before=
 the backend buffered data completes playing, the host device then underrun=
s. At this point it either continues
 running by injecting silence or stops, depending on setup options. The eff=
ective stop of sound playback occurs when the backend buffered data complet=
es playing, which might be after a considerable delay, depending on backend=
 buffer size. Keeping the host device
 running and injecting silence sounds like the easiest way to avoid the nee=
d to re-prepare the host pcm device when restarting. Have I captured your a=
pproach accurately?</div>
<div class=3D"PlainText"><br>
Cheers,</div>
<div class=3D"PlainText">Radu<br>
<br>
</div>
</span></font></div>
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

--_000_dd0ecb29d8de4fc5a775469ea51af461blackberrycom_--
