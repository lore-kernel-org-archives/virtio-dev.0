Return-Path: <virtio-dev-return-12796-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F7C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 22:22:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 90B0F29FD4
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 22:22:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A2EF986416
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 22:22:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7BB93986243; Tue, 23 May 2023 22:22:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 651E39863FB;
	Tue, 23 May 2023 22:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpu8Ey4CuuRBxSu0rJIUunkfgayUA2CqlJLJBKxirTOX+L7zDdttgFz9hz7ydQoWnCVKzOBuhSnCKXah3Sd7zOrKrmoPlQTS3CaAZ2VveeICRGy8gPxbjHROFRadbK0rCO802Ltv8b92JGp67uVQqFOd9hwB077QgBMOiYsOdiR44nNW8LQaFNMY6Y/Dc17LlXDmiB8ixakOUywY3MBkgtdsX7kECFedBvyQTTIB7fTarD8WMTIgQC8p4qGbr1EKj0H0WYgivbbvKGdZhJGFXHBJrpA2adU3OpVde1dd5Ounp8db5uLEGmJziroIkNgzHzgzCBqMriMryCWblNxiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdLb23LSEnJGf8vUwUkmFhZoMeemKFqTbdA6GKCjVCI=;
 b=T7P9I89P5Pqd7Tvv9XycuXKIeIGZX5OTOEKIb9NxJ0Z2N0caySDCsh31WmKcKl4BCBfX7AkQDMGDgvVlTAbrhB6sTyRb+8M1YnUXqkT+MmZrcdZ/ze1JZTBjuajt2KXnr9HJA9aXhcOFx1Oz8IiSOblRkdgaKy2w4WdhsmcemA/VZICQqlCe86MI9Kjf3msU1l970hqBCQPKocXMWSKa46IjiXCB83Z+bQAgNXSg3k5kx+rWe/nRYUCiPxFWFHTgGB8p8r8KpK4/knn6SW5FjetKDVwPzeF+MqAk9fyZ1eRAAFE60ZQ5Schg3hLZFWrp0eEHrcGdN1Jddqs/y0aNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8IAB7w8AgAABbZCAABb6AIABJ5CwgAA8YwCAAC3WEA==
Date: Tue, 23 May 2023 22:22:27 +0000
Message-ID:
 <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230523141718-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5101:EE_
x-ms-office365-filtering-correlation-id: 6b52302c-fbb2-4562-1e29-08db5bdc30d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9NwIkqMNmsNrrf47ioJyILk9/H/P/nlb92u/AdrLuHQNbMReNrAGh3srUvdGTsF/NeYmGZ/CfJSc8JfafnnZsIL/rf7QC6I4wlNa7NIpddZs1w8AEf4Jg4cN7/aKFFxmrwnRsRKcyUxsd3h12jdTsUdBpoZkCq3sc0weH4yoVfFO4jrd972prxLtDZvsAShx3FHDQPul4Dgpnqu3n32mhYFzvu9mWNDVaP6ev7idhxy80ko3J8u5FriepjDckXcO/Ko8oTtENjzeanEQkd/cc1cndq1fC15AsqJDjIbAlVrYU9CEwrTTkZ6IumNVQZxwC7uZFCO5nSELVMBk0dZx6ETtFEPToVQB73TPcgUv6sHulIKurdlFPu3vksBZOf8mXyKcxKzO+0HTRaJ1tD1cD2+WAKsNOcgaiugtBV2aKpCwlUlRJe3AXBhWkjpQpW0YUApbKyllqHW3eDOXpvG6Kd4RUHOqeHEL+0m5s4BEUUS5ok6MiAg2nUj1z2lEgfJhfcttfa+qxqjPi4o34HUKoti8x1OMhDMi117L9DJBi2T/a6oKzZS+ZB/KJlsvmcMiuF/BkfpMTQtMxWjL6IRGqOwZKu19gTDnM5yyMAba3gZZWQKXRNwCm7fK3silFxUL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(38070700005)(54906003)(83380400001)(86362001)(478600001)(38100700002)(33656002)(186003)(6916009)(76116006)(66476007)(66946007)(64756008)(66446008)(66556008)(2906002)(4326008)(26005)(71200400001)(316002)(9686003)(6506007)(7696005)(107886003)(41300700001)(52536014)(8676002)(5660300002)(8936002)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wHkw9vAd1UZgOirUDKeN7E5pxcoRviidmAx/9On75kWZhQl4r6GxbbxyTvl7?=
 =?us-ascii?Q?x8kJHkAKwzs1uTAG8EZ5IUBrOpg+97Fw8LphzIBOkvp/KMqjquv09Uzjm5L1?=
 =?us-ascii?Q?gl+KZAFlkEtAOvZ+D84rWvJ19SIGwpclFqqNIGTaIXQXkmziZiF5wmjva2Sx?=
 =?us-ascii?Q?ZJyrlDo4o/LbCsNfTJS2mcWKTHx1mIOvp5WEHH8Tgwb+VSmAsnblDSoaXo50?=
 =?us-ascii?Q?g0L+DgQT1H7Ar07kQyWF8h5JBhQyiUtYsB0G6zxaiCEbXSnL4+PDmdDl3ewV?=
 =?us-ascii?Q?klUQroCVoaJaWo3RVdWlLnAj6TppldzR2W0yb0vpdaGcSqTpRUuzLdjdp/K2?=
 =?us-ascii?Q?2uQpLgqCNDII94ePX3Q0ZqtPc564t+mNMiEAuwX3CVwte/4R/RMsA0dPqp+M?=
 =?us-ascii?Q?uSvKkKxQrictA413H6qoV/O3fe8q/PuOOctfVcVBydzuYGo69YukxmgucXSw?=
 =?us-ascii?Q?iuSw7uktYsEDC+GKNHbgZUrLBsh+ci1Ztir69iXrh4RDwRFt/TJxTPUMsKBF?=
 =?us-ascii?Q?Z6qV7oPDbn6n+c8TOn+w/+8f5O9PEa55jayFDbK5iKkfRiZ4kILx0TL0Z6K1?=
 =?us-ascii?Q?81zkpRnktTcEaql768/9yQRqgVU/r0LQDJ08QqaHlmF/r5t/Lphv9W3JLLwO?=
 =?us-ascii?Q?cg01BM1nAV/WOUPWZRX78oeRSr2iA8BLDQ6LqshxXpEZoH1WoN4x0hjblB5Q?=
 =?us-ascii?Q?7iBJzglymEiI8aWaiyUs2xtUAdUnWxhqLvcyZ8Uo49N7owVTP87aQZdj9KSJ?=
 =?us-ascii?Q?oP7lSJ8jAa8XDwSFjgZJIW9Xcl7VgE4STZb7YUIRsNfO2m2SaDDWa6NkkT66?=
 =?us-ascii?Q?pN1WMxgrRDaqqbe2CMZM0Vc2d+XQ2YrvJN8WtKSJ9W3Z59XeTakQ1GKpUyLv?=
 =?us-ascii?Q?C73yZb2BWc4fZBnsrdr2ThHWClN5YTfEbWiPM2UIWqk7q71TPB4k0wHhNMx6?=
 =?us-ascii?Q?WuxgWP6r1jjf9lytLy3+x84Hwwwwp5R32osM6h0VXjaDXQP5VztqjjS7QCAk?=
 =?us-ascii?Q?ERF5ClMGhnbF15jPbzty1HxZpNI3xyScm/EitTJzfsTbLz6pG4pEQF8I0ZrZ?=
 =?us-ascii?Q?4fzbE35PFOY+vGt73M0vyVutcYXoMr3UuQbyFiJQoalZbLjAmAtMMd07Thco?=
 =?us-ascii?Q?lhC9ccmu4laj8ohNTpX9jW7QYOtryn5c3YleI5VZoG1Tx/F3NmvvhKpE7MFR?=
 =?us-ascii?Q?g2HwwRknzPgshwvxjqONn8nEiArBw/v8utbcQKyf7dSjtr35mr7lRFZXs7g0?=
 =?us-ascii?Q?U8JjklDrsezghlt70HeeU2yC6BZi0wEB6A9kU2M6HsGHYpDnW6SScfBzebiP?=
 =?us-ascii?Q?6jOkM94ckJ3urprMEkrADWortoyEurbFfdf9/zHndwF1ToaLGwMe1Np0lsfe?=
 =?us-ascii?Q?VzXVRGHhgxaZI5TQo93X1s0fXWT142k8q0VmCAMwhdVGgIQMONQtd361004c?=
 =?us-ascii?Q?SMzuwr2s+lPbmVNdFxSozMUNwi1TMaWJsKIVV+OQmlECfnhgIIkLxvm0KJAR?=
 =?us-ascii?Q?/BglfPb+7vwqZkJfWw6G5cy3vlDWjYND2elRNLM0MbBnMmoYc4mYB49lCmFm?=
 =?us-ascii?Q?6CXiZtVtkXVolL+KStg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b52302c-fbb2-4562-1e29-08db5bdc30d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 22:22:27.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkwfNA6x/mJDgCQFQI/RMeNjxm92wAsDJOqFW0+NKSgyFTy1vlk/iTYxE2fxGrT2Q9rA+96Fyf1sDKNsdncuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 23, 2023 2:49 PM
> > > iokit is from my previous work experience not virtio.
> > > For virtio we had a lot of trouble with hacks like this on windows.
> > I don't know why windows driver need to talk to PF driver until now whe=
n the
> AQ doesn't exists.
>=20
> What is it you want to know?
>
Why a VF driver needs to talk to a PF driver in windows without AQ?
=20
> > > That's an important platform.
> > >
> > I am not sure how important is it.
> > What I learnt that a decade has passed and even after that virtio drive=
rs are
> not part of the OS distro.
>=20
> Because with QEMU they are so easy to side-load. So we never bothered.
>=20
I don't understand your comment.
I was saying to my knowledge a Windows OS do not have a virtio drivers in t=
heir distro which you said is important.

> > It doesn't need to because guest is anyway going to do whatever it does=
.
>=20
> yes. But hypervisor can do work-arounds or detect broken functionality an=
d
> stop cleanly.
>
You mentioned this several times.
Below requirement still holds fine.
=20
> > The clear requirement is: to not fix legacy but to support legacy.
> > Fixing legacy is role of 1.x. Not the role of legacy interface itself u=
sing
> AQ/MMIO.
>
 > And for purpose of BAR mapping, such BAR in the VF can be mapped too.
> > You didn't answer why VF BAR is a problem and suggest PF BAR.
>=20
> VF BAR by itself is not a problem. Discovering VF BAR mapping offset thro=
ugh PF
> is.
>=20
At the end of the email you right that "AQ is fine" but here you write disc=
overing that through the PF AQ is.
How to interpret your comment?

> > If notification for VF is in VF -> hence other config registers also in=
 VF, such
> blanket statements does not help.
>=20
> not other config registers. what's needed in VF driver should be retrieva=
ble
> through VF.
>
This applies to the modern device, for legacy emulation, I don't see this a=
 mandatory.

> > Your comments and suggestions are helpful.
> > Some of them follow the loop that doesn't help.
> > Again, thanks a lot for the inputs and reviews.
> >
> > The design discussion helped to produce two solutions here than what wa=
s
> started in v0.
>=20
> OK good. Now I suggest you make an effort to come up with some compromise
> that will make this thread stop. I really can't say I even remember what =
we said
> in the beginning.

> You had this idea of starting with a problem statement document how about
> doing that? Because I feel every time people bring up some idea and a pro=
blem
> this idea would solve, you go "this is out of scope". Let's decide what t=
he scope
> is?
>
The requirements are simple and straightforward at start of the cover lette=
r.
i.e. for quick reference in short: A PCI VF passthrough to guest VM to supp=
ort legacy + 1.x.

I propose:
Method-1:
1. VF legacy registers access over AQ of PF
2. VF driver notifications using MMIO of VF

Method-2:
1. legacy registers access using two MMIO registers (data and addr)
2. VF driver notifications using MMIO of VF

> > I am asking a 1.x PCI device has the VF notification BAR already, why w=
e don't
> use it, why to build an additional one in device?
>=20
> Following this logic, a 1.x PCI device also has modern common config.
> All you really truly need is a flag to make it behave like legacy, from P=
OV of
> device config and VQs.
>=20
Dual definition to same area in device is not elegant way to achieve it.
We already discussed that some area is RW, some is not. It moves location.

And it still doesn't solve the problem of reset.
Hence, either doing via AQ or 2 registers method would work fine.

It keeps legacy also isolated from mainstream.

> So let's try to keep drivers self-contained as much as possible.
>
You said "AQ is fine" at the end of email.
Hard to understand your mixed suggestion in context of sending v3.

> > And notification also works well that reuses transitional device's noti=
fication.
>=20
> I don't know what these are. You had some weird
> +struct virtio_admin_cmd_lq_notify_query_result {
> +       u8 bar; /* PCI BAR number of the member VF */
> +       u8 reserved[7];
> +       le64 offset; /* Byte offset within the BAR */ };
> if you want to re-use the normal notifications for VFs we already describ=
e them
> using capabilities.
>
That capability is intermixed with 1.x register queue_notify_off.
So, I see following options.
a. either to create a new legacy specific extended capability, or=20
b. say queue_notify_off doesn't apply for legacy notifications because this=
 register doesn't exist for legacy
c. exchange it via the AQ like above struct.

> However, this creates a weird mix where there's this command that mostly
> follows legacy pci config layout except notifications which are there in =
the
> legacy pci config are actually somewhere else.  And this is just inconsis=
tent and
> confusing, and the reason for this is implementation defined.
Depends on how you see it.
It is at same level of inconsistency as 1.x for a legit reason which is to =
split config registers from data path register.
=20
It is not implementation defined. Notification over AQ cannot reach same pe=
rf level as MMIO.
I will avoid repeating it.

>=20
> > 3 out of 4 functionalities are done on AQ of the TVQ.
> > So, it is time to stop asking to replicate the AQ functionality on some=
 new
> TVQ.
> > This was discussed in depth.
>=20
> I don't think I ever did that.
>
It is in Jason's reply when he was suggesting tvq in this same v2 series.
=20
> My point however is the last sentence *If you need software in the middle=
 then
> let's please make it robust.* If BAR0 hack does not work then let's use s=
ane
> interfaces as much as possible.
>
=20
> AQ works fine I think. This new one I haven't seen yet hard to say.
> Probably has its own set of problems ...
>
Ok. you review and we discuss after that.

> > Above example of legacy_register_addr and legacy register_data on the V=
F.
>=20
> Talking about the two register thing.  We actually have this already:
> VIRTIO_PCI_CAP_PCI_CFG.  We could allow access to IO BAR through it.
>=20
To which IOBAR? The one that doesn't exist in the VF?
It is weird to create VIRTIO_PCI_CAP_PCI_CFG and point to non-existing area=
.

We can have new extended capability as,

VIRTIO_PCI_CAP_PCI_LEGACY_REG, that has slightly better interface and it al=
so avoid intermix with 1.x using above two registers.

>=20
> But really since apparently you want to focus on how we solve notificatio=
ns let's
> focus on that. I feel the main issue is poking at 1.x registers and at th=
e same time
> at legacy registers.
No, it is not 1.x registers. Register and bar offset is shared via the AQ.

> The spec was written with a strong assumption that it is either or, never=
 a mix.
Transitional device supposed to support both as written in the spec.
No different here.
Now for real device.

> Changing that will be painful.
> This is why I was asking about VIRTIO_NET_F_LEGACY_HEADER - legacy can li=
ve
> in software then and we do not need to worry about it in the spec. I got =
it that
> there's too much software here for your taste, but the problem with legac=
y is
> really that it was always ad hoc and implementation derived.
> So we need to keep it siloed.

This is why I am trying to avoid putting in PCI registers of the VF, but if=
 you prefer, we can do using new VIRTIO_PCI_CAP_PCI_LEGACY_REG with two reg=
isters.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

