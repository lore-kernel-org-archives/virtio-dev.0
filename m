Return-Path: virtio-dev-return-7198-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F333985E75
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 02:00:42 +0000 (UTC)
From: keens keens <keens312@hotmail.com>
Date: Wed, 29 Apr 2020 02:00:39 +0000
Message-ID: 
 <MN2PR06MB6030AB1BB9DF369159BB235A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
References: 
 <MN2PR06MB60303B243BCA31472FD8A4C189AC0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <MN2PR06MB60301F725442727DCDDFCEBD89AC0@MN2PR06MB6030.namprd06.prod.outlook.com>
 <MN2PR06MB6030882BFE3EC7A8D332C44789AC0@MN2PR06MB6030.namprd06.prod.outlook.com>,<20200428100215-mutt-send-email-mst@kernel.org>,<MN2PR06MB6030237A3D6C56DB9369FF2A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
In-Reply-To: 
 <MN2PR06MB6030237A3D6C56DB9369FF2A89AD0@MN2PR06MB6030.namprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [virtio-dev] Re: Transparent compress in virtio
Content-Type: multipart/alternative;
	boundary="_000_MN2PR06MB6030AB1BB9DF369159BB235A89AD0MN2PR06MB6030namp_"
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_MN2PR06MB6030AB1BB9DF369159BB235A89AD0MN2PR06MB6030namp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hello virtio-dev team,

I want to compress all the data or files when the apps in VMs writes to a p=
ass-through block device via kvm virtio.
And decompress the data when the apps in VMs trying to read the data from t=
he pass-through block device on host.

My idea is to add a data transform layer into virtio architecture for the p=
urpose of transparent compress.
I am reading the virtio.c, virtio_ring.c code, but have not found the place=
 where I can do the data compress.
Is it feasible that we can add a filter into the virtio, and there is a cha=
nce to do data compress or encrypt in the filter?

Thanks
Keen

--_000_MN2PR06MB6030AB1BB9DF369159BB235A89AD0MN2PR06MB6030namp_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">Hello virtio-dev team,</span><br>
</div>
<div>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
I want to compress all the data or files when the apps in VMs writes to a p=
ass-through block device via kvm virtio.</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"x_PlainText">And decompress the data when the apps in VMs try=
ing to read the data from the&nbsp;pass-through block device on host.<br>
<br>
My idea is to add a data transform layer into virtio architecture for the&n=
bsp;purpose of transparent compress.<br>
I am reading the virtio.c, virtio_ring.c code, but have not found the place=
&nbsp;where I can do the data compress.<br>
Is it feasible that we can add a filter into the virtio, and there is a cha=
nce to do data compress or encrypt in the filter?<br>
<br>
Thanks<br>
Keen<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR06MB6030AB1BB9DF369159BB235A89AD0MN2PR06MB6030namp_--

