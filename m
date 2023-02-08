Return-Path: <virtio-dev-return-10819-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 19:23:12 +0000
Message-ID: <PH0PR12MB54810BD4404DAAEE873BF3EEDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208101323-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E095570E381AA498CDF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481E095570E381AA498CDF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_PH0PR12MB54810BD4404DAAEE873BF3EEDCD89PH0PR12MB5481namp_"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .
 org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_PH0PR12MB54810BD4404DAAEE873BF3EEDCD89PH0PR12MB5481namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You are right. Two commands are there.
Regardless the ambiguity remains
________________________________
From: Parav Pandit
Sent: Wednesday, February 8, 2023 8:57 PM
To: Michael S. Tsirkin <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om>; virtio-comment @ lists . oasis-open . org <virtio-comment@lists.oasis-=
open.org>; virtio-dev @ lists . oasis-open . org <virtio-dev@lists.oasis-op=
en.org>; Jason Wang <jasowang@redhat.com>; Alvaro Karsz <alvaro.karsz@solid=
-run.com>
Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalesc=
ing moderation


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 10:20 AM

[..]

> >
> > Most performant data path wouldn't implement and read the extra mode.
> > It is always fw that is going to program same value, or per queue value=
d or
> disable value in each Q regardless whichever way we craft the CVQ cmd.
> >
> > The sequence that bothers me is below.
> > 1. driver set global params
> > 2. few minutes later, now driver set param for Q=3D1
> >
> > On this command, a device need to decide:
> > Should Q =3D 2 to N
> > (a) either work with previous globals, or
> > (b) because per Q was set for one queue, they rest of the queues implic=
itly
> disable it.
> >
> > If it is (b),
> > When a command on Q object =3D1 is issued, it affects other Q objects. =
<- This I
> want to avoid.
> > A cmd that modifies the object, should only modify that object.
> >
> > If it is (a), it is mixed mode operation, which is ambiguous definition=
.
> >
> > A better semantic is to define such change at device level and no extra=
 cost in
> the data path.
>
> Ugh. Looks like I didn't explain it well, yet again :(.
> Here is my proposal in pseudo-code:
>
>
> if (cmd =3D=3D VQ_SET)
>                vq[cmd.index].param =3D cmd.param;
>
> if (cmd =3D=3D TX_SET)
>        for (i =3D 0; ++i; i < maxvqn / 2)
>                vq[i * 2].param =3D cmd.param;
>
> if (cmd =3D=3D RX_SET)
>        for (i =3D 0; ++i; i < maxvqn / 2)
>                vq[i * 2 + 1].param =3D cmd.param;
>
>
Currently we have cmd =3D GLOBAL_SET the code is:

 if (cmd =3D=3D GLOBAL_SET)
        for (i =3D 0; i < maxvqn; i++)
                vq[i].param =3D cmd.param;

>
> there's nothing to decide at all. No modes. TX_SET and RX_SET affect half=
 vqs,
> VQ_SET affects one vq.
>
I explained above that, when cmd=3DGLOBAL_SET and after that if driver issu=
es cmd=3DVQ_SET, at that point, the device is in partial mode.
One VQ is running with its own param, and rest are in global mode.

--_000_PH0PR12MB54810BD4404DAAEE873BF3EEDCD89PH0PR12MB5481namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"font-family: inherit; font-size: inherit; color: rgb(0, 0, 0)=
;"></div>
<div style=3D"font-family: inherit; font-size: inherit; color: rgb(0, 0, 0)=
;">You are right. Two commands are there.</div>
<div style=3D"font-family: inherit; font-size: inherit; color: rgb(0, 0, 0)=
;">Regardless the ambiguity remains</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Parav Pandit<br>
<b>Sent:</b> Wednesday, February 8, 2023 8:57 PM<br>
<b>To:</b> Michael S. Tsirkin &lt;mst@redhat.com&gt;<br>
<b>Cc:</b> Heng Qi &lt;hengqi@linux.alibaba.com&gt;; Xuan Zhuo &lt;xuanzhuo=
@linux.alibaba.com&gt;; virtio-comment @ lists . oasis-open . org &lt;virti=
o-comment@lists.oasis-open.org&gt;; virtio-dev @ lists . oasis-open . org &=
lt;virtio-dev@lists.oasis-open.org&gt;; Jason Wang &lt;jasowang@redhat.com&=
gt;;
 Alvaro Karsz &lt;alvaro.karsz@solid-run.com&gt;<br>
<b>Subject:</b> RE: [virtio-comment] [PATCH] virtio-net: support per-queue =
coalescing moderation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
&gt; From: Michael S. Tsirkin &lt;mst@redhat.com&gt;<br>
&gt; Sent: Wednesday, February 8, 2023 10:20 AM<br>
<br>
[..]<br>
<br>
&gt; &gt;<br>
&gt; &gt; Most performant data path wouldn't implement and read the extra m=
ode.<br>
&gt; &gt; It is always fw that is going to program same value, or per queue=
 valued or<br>
&gt; disable value in each Q regardless whichever way we craft the CVQ cmd.=
<br>
&gt; &gt;<br>
&gt; &gt; The sequence that bothers me is below.<br>
&gt; &gt; 1. driver set global params<br>
&gt; &gt; 2. few minutes later, now driver set param for Q=3D1<br>
&gt; &gt;<br>
&gt; &gt; On this command, a device need to decide:<br>
&gt; &gt; Should Q =3D 2 to N<br>
&gt; &gt; (a) either work with previous globals, or<br>
&gt; &gt; (b) because per Q was set for one queue, they rest of the queues =
implicitly<br>
&gt; disable it.<br>
&gt; &gt;<br>
&gt; &gt; If it is (b),<br>
&gt; &gt; When a command on Q object =3D1 is issued, it affects other Q obj=
ects. &lt;- This I<br>
&gt; want to avoid.<br>
&gt; &gt; A cmd that modifies the object, should only modify that object.<b=
r>
&gt; &gt;<br>
&gt; &gt; If it is (a), it is mixed mode operation, which is ambiguous defi=
nition.<br>
&gt; &gt;<br>
&gt; &gt; A better semantic is to define such change at device level and no=
 extra cost in<br>
&gt; the data path.<br>
&gt; <br>
&gt; Ugh. Looks like I didn't explain it well, yet again :(.<br>
&gt; Here is my proposal in pseudo-code:<br>
&gt; <br>
&gt; <br>
&gt; if (cmd =3D=3D VQ_SET)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vq[cmd.index].param =3D cmd.param;<br>
&gt; <br>
&gt; if (cmd =3D=3D TX_SET)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; ++i; i &lt; ma=
xvqn / 2)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vq[i * 2].param =3D cmd.param;<br>
&gt; <br>
&gt; if (cmd =3D=3D RX_SET)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; ++i; i &lt; ma=
xvqn / 2)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vq[i * 2 + 1].param =3D cmd.param;<br>
&gt; <br>
&gt;<br>
Currently we have cmd =3D GLOBAL_SET the code is:<br>
<br>
&nbsp;if (cmd =3D=3D GLOBAL_SET)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; maxvqn; i++=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; vq[i].param =3D cmd.param;<br>
&nbsp;<br>
&gt; <br>
&gt; there's nothing to decide at all. No modes. TX_SET and RX_SET affect h=
alf vqs,<br>
&gt; VQ_SET affects one vq.<br>
&gt;<br>
I explained above that, when cmd=3DGLOBAL_SET and after that if driver issu=
es cmd=3DVQ_SET, at that point, the device is in partial mode.<br>
One VQ is running with its own param, and rest are in global mode.<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0PR12MB54810BD4404DAAEE873BF3EEDCD89PH0PR12MB5481namp_--

