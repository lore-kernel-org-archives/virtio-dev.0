Return-Path: <virtio-dev-return-14051-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB39C4332F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 16:46:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA3922237D
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 16:46:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B92EC986CE7
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 16:46:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8ABB6986CDB; Thu,  9 Nov 2023 16:46:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30E58986CDC
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Nov 2023 16:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Radu Ocica <rocica@blackberry.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "anton.yakovlev@opensynergy.com" <anton.yakovlev@opensynergy.com>
Thread-Topic: [virtio-dev] virtio-snd comments/questions
Thread-Index: AQHaAdgPGZsaTwL9FEiOAsMZLVwCl7BZBi2AgA/8OmuABNQTgIAEeavR
Date: Thu, 9 Nov 2023 16:46:45 +0000
Message-ID: <37eaf0dc2bdb4a7b936618b48dd00ac2@blackberry.com>
References: <02725a6508584ed2aa8b31c9e9f4264a@blackberry.com>
 <ZTeZ6YjyR0BJOylw@fedora>
 <6df30c7945ca4ac2bb1c170b1c028719@blackberry.com>,<CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
In-Reply-To: <CAHYGQ0yXPY2NU25N3jh=MH7=PUjkWy5R-SmtaMOVP-VCPPuq3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [100.64.197.67]
Content-Type: multipart/alternative;
	boundary="_000_37eaf0dc2bdb4a7b936618b48dd00ac2blackberrycom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
Subject: Re: [virtio-dev] virtio-snd comments/questions

--_000_37eaf0dc2bdb4a7b936618b48dd00ac2blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


> Could you elaborate on this? Which audio backend would not support
> PAUSE? I am not very familiar with audio engines.

For instance in linux, alsa-lib has a flag that specifies pause support by =
a PCM stream:
#define SNDRV_PCM_INFO_PAUSE                       (1UL<<19)  /* pause ioct=
l is supported */
The snd_pcm_pause API can only be used successfully if the PCM stream has t=
his bit set in its PCM info.
A similar concept exists in QNX sound.



>> This looks promising. I found it already at https://urldefense.com/v3/__=
https://github.com/torvalds/linux/blob/master/sound/virtio/__;!!JoeW-IhCUkS=
0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fKT3Utk=
-cpGw6FiWxDY$  and will give it a try. Is there a repository for this drive=
r code where both this fix and the audio control support is available?
>>
>>

> What do you mean with audio control support? Are you talking about the
> device? The device implementation is at
https://urldefense.com/v3/__https://github.com/rust-vmm/vhost-device/tree/m=
ain/staging__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsY=
yEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw1sNq6IY$ .

I meant the support for feature VIRTIO_SND_F_CTLS in the virtio_snd guest d=
river. A patch to add this support is available here: https://lists.oasis-o=
pen.org/archives/virtio-comment/202104/msg00013.html. However this patch is=
 not present in the virtio_snd guest driver version here: https://urldefens=
e.com/v3/__https://github.com/torvalds/linux/blob/master/sound/virtio/__;!!=
JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsYyEr9pXjSEu7n5ibc=
5BL4fKT3Utk-cpGw6FiWxDY$ . I was wondering whether there is a repository wh=
ere the virtio_snd driver has both the VIRTIO_SND_F_CTLS support and the ac=
k callback patch.

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_37eaf0dc2bdb4a7b936618b48dd00ac2blackberrycom_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p><span style=3D"font-size:10pt;"></p>
<div class=3D"PlainText"><br>
&gt; Could you elaborate on this? Which audio backend would not support<br>
&gt; PAUSE? I am not very familiar with audio engines.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">For instance in linux, alsa-lib has a flag that sp=
ecifies pause support by a PCM stream:</div>
<div class=3D"PlainText"><span>#define SNDRV_PCM_INFO_PAUSE&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1UL&lt;&lt;19)&nbsp; /* pause io=
ctl is supported */</span><br>
</div>
<div class=3D"PlainText">The snd_pcm_pause API can only be used successfull=
y if the PCM stream has this bit set in its PCM info.</div>
<div class=3D"PlainText">A similar concept exists in QNX sound.&nbsp;</div>
</span>
<p></p>
<p><br>
</p>
<p><br>
</p>
<font size=3D"2"><span style=3D"font-size:10pt;">&gt;&gt; This looks promis=
ing. I found it already at
<a href=3D"https://urldefense.com/v3/__https://github.com/torvalds/linux/bl=
ob/master/sound/virtio/__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40=
V1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw6FiWxDY$">
https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/s=
ound/virtio/__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0ts=
YyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw6FiWxDY$</a>&nbsp; and will give it a try.=
 Is there a repository for this driver
 code where both this fix and the audio control support is available?<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
&gt; What do you mean with audio control support? Are you talking about the=
<br>
&gt; device? The device implementation is at<br>
<a href=3D"https://urldefense.com/v3/__https://github.com/rust-vmm/vhost-de=
vice/tree/main/staging__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V=
1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw1sNq6IY$">https://urldefense.com=
/v3/__https://github.com/rust-vmm/vhost-device/tree/main/staging__;!!JoeW-I=
hCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fK=
T3Utk-cpGw1sNq6IY$</a>
 .</span></font></div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, H=
elvetica, sans-serif, &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
</div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, H=
elvetica, sans-serif, &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
I meant the support for feature <span>VIRTIO_SND_F_CTLS in the virtio_snd g=
uest driver. A patch to add this support is available here:
<a href=3D"https://lists.oasis-open.org/archives/virtio-comment/202104/msg0=
0013.html" class=3D"OWAAutoLink">
https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html</=
a>. However this patch is not present in the virtio_snd guest driver versio=
n here:
<a href=3D"https://urldefense.com/v3/__https://github.com/torvalds/linux/bl=
ob/master/sound/virtio/__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40=
V1ctr_OU0tsYyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw6FiWxDY$" class=3D"OWAAutoLink">
https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/s=
ound/virtio/__;!!JoeW-IhCUkS0Jg!bBq1USPrJoN1_CBJkW-XBknkCSEOUP40V1ctr_OU0ts=
YyEr9pXjSEu7n5ibc5BL4fKT3Utk-cpGw6FiWxDY$</a> . I was wondering whether the=
re is a repository where the virtio_snd
 driver has both the <span>VIRTIO_SND_F_CTLS</span> support and the ack cal=
lback patch.</span><br>
<div style=3D"color: rgb(0, 0, 0);"><font size=3D"2"><span style=3D"font-si=
ze:10pt;">
<div class=3D"PlainText"><br>
</div>
</span></font></div>
</div>
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

--_000_37eaf0dc2bdb4a7b936618b48dd00ac2blackberrycom_--
