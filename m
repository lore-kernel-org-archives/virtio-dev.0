Return-Path: <virtio-dev-return-12780-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1E1C77B75
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E6F4829FD2
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE81F9863E7
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 21:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D2191983E48; Mon, 22 May 2023 21:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFC9A986384;
	Mon, 22 May 2023 21:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogxXxw2ezC1rBRhJyU2RPGqaK2gF9jipp8htAYJ6bbPTmp3VG5Rg/TJghuvPeHsUqfF2f+1RZ7KY4nfWgJk6tRPjY6aBO9EeKCtLxE3sxeA7IfGZrCHlnW1SFYi6tepE5Don/USwG0tZkZaYGzm8MrFx9355TO7K0IAz9pkEpdtrh0aXryd7kbB07Ty4XUuFIPt6R+o/EBjmic5v34NujRrAg7HS6UhBqj6WxqrDgT1aSYhP6Ph9hdyM5K2kNUeEABWhNIuFiEswr7Euee47FglJ2e+mkYBNed3Km///pKGlEeJZlTwqgAhpzFAk5ccqI/hsAx/npNiK66Zrb5IMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTdgHZD3hngZbl3cETew7mbSa0wfFP2DUhNYiYL3S8c=;
 b=hc1etQExCwj9I8Rh0M19BpOjHoH8oGhT68krtWux351GpbF7XNKE9SUToJeLNcAnyEaNbWXBwp56cs23g88pZdY6Ocg8GpxoC6Xz2XFgQ3nrMMKr9dr4mkPkflD8pgneappcVSUsXISB8ag9SrzaMfo1L6bO1fiEylxIi1Eo0jwVbVqkdHLjUuH87sckQcXS9+jztPC0eFWTMhwpUIrVucN10nJUkNMXK33VVcvyTgiUlhllKWCDbQM8C1vm/Wt48NxepQcho3yCaS4Z+kmdDBJn5wF58M9rlexNOX9FH6TGYnqbeH6uSM+M9b+SloXefdE9IHEj//Qy6dqHtAZHaA==
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
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8IAB7w8AgAABbZA=
Date: Mon, 22 May 2023 21:05:13 +0000
Message-ID:
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230522154149-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8716:EE_
x-ms-office365-filtering-correlation-id: de7df50b-7bd2-4411-1e14-08db5b083c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rHmcGo+L6r1N7GOe0r+iB/TuJOptAi4SA0NICXA0RE9KS7qJ/HjzTgC/IV9OJCjkN7zCs4i25tV6P4GYuozNkUfFJxzhNLSns2NoCUO+ccX7fnpJBwIA5Xdpe7eCtSQv9rWYJLDc8mZkT+/Lgnt/ZrgF9c6Z8YMdKDQBZS+0sWgjvdIonyvT0Tkh+87lj11wyJ73DDrsICasUVv8/Hr3tcVYRbuenmriCU/+6/mhdCT86ZF2Ut0GBdAHfhOrkCt9osCxmD/5Kli6YQ5Wl38/JQFwKpYzUpk5SIRRt8zi2iiqxc8b6K5mKxETuPCLgwJWnQsBH2pRede+dgg6GS+Iz2cpHi0VtPYzGVP4fptrpe5Cj344xiXsKcMJso8m19pURItFYEttNBL0I7x/CfDKe7KPpG5wmFYL5s0j2aNn3jdVtCr/PbjImpRQjJ26YOh8RPobTpqPndKHmRBaYG3ni89zm3hNWTe4mwEAB+GeiaN9IR14qzsHmKRbMQVZ0guL7KD1Uazc2zVioCpZUa/gO2RrSe3HoXOK6H2TgRXIm2OMSG9GVyGgfnn4Y1pp2ZOb8Od40+NHo5kZhd6QZ9lEzO3AxrPQ8Vs2Nv+1E9Jlzf50AUXkvtqs/DfcDErVAI2GY5+flSrd7qgJ/sT2hPAYqzOBGKJyeBxA6Rzo1ECHbaE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(52536014)(5660300002)(83380400001)(186003)(6506007)(9686003)(86362001)(107886003)(26005)(122000001)(38100700002)(71200400001)(38070700005)(41300700001)(7696005)(64756008)(33656002)(55016003)(966005)(66446008)(66476007)(66946007)(66556008)(76116006)(316002)(6916009)(4326008)(478600001)(54906003)(2906002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vow2tyHfmVeF7bhyU3cObkYtKupIY/e36fY1GhZUTZdcugWwq1XigygIjjDF?=
 =?us-ascii?Q?MiYAF8a5K3ZAhcm0Hur6vNMqPXKrzzILy0OLkaWfAC33ZBZKKNoCQgBaboAD?=
 =?us-ascii?Q?UL90OmH/guDMAflTZHrz8Q6ejWTzEoA/eJQM0UtjMnIwKlEZ/NgVUD8JQQfn?=
 =?us-ascii?Q?vIaCvu3CBCyKp4MY39CjavAXCGDxTyU7YbTRIIPxUUMSteTqR9Qh/m0QCA4N?=
 =?us-ascii?Q?a/Uopa16YGsWIM+t0LOSEEwKRFHqWCtpGHXid5RXRDX1LSO/w/CHNCAk5hm5?=
 =?us-ascii?Q?s1qPLPZsAwgTJEQdVNetKCfmH+OyGPztnaQxRqSF0MYpUYhHKDMN+ER+kczX?=
 =?us-ascii?Q?SFfC9gsRb5doOAeX1la4HmN9rWC53vcOYeE4oHKb7LkvG/IyFXZWwzalVEsU?=
 =?us-ascii?Q?YKtL3HHuK1jYajTK6eVuV6KUy+7oFy0B91FHUFWVk3jjEYYic4qIHsumbs1P?=
 =?us-ascii?Q?fReNssu7PsKv4IXP1+Y0HDdQtuK+U7jgogH8mz+5UkGGjTM4JbbomqoqpB23?=
 =?us-ascii?Q?vuForGkcln7CwBoOZItNYxRMxc/2hk0qxSClYK+kNhm7MtCZXo+gg1IgUBQL?=
 =?us-ascii?Q?w2+ErgTf8+tNhUGNiBTQM8J8JRoJSzZSHSSXg+Xa5dD5dpHG3XeMbjWpXOcU?=
 =?us-ascii?Q?hXGtyJPolDOJnaTuJFR1K2zTp/KPnLW2JBXq9SfkmIg7TzxkmnwDm9SVslrA?=
 =?us-ascii?Q?o8nzS+GXhZBT0BNXP01e1qRDSaKUEHqtZ/olhA00fg9AwRUTX9BMyWrVKq1i?=
 =?us-ascii?Q?HnAsf5y8dIASPMsAN6r1ub4mM20exAliyqvLzIKZGQAFI6/CYwECYCXiVYY+?=
 =?us-ascii?Q?PFy9fM5oT4UklLz9B/1/KhrterbQ9q1zN4FsqgxkDbrtZ9zSwUK24TrpnBEi?=
 =?us-ascii?Q?GcAFmhx5E5uxAIAMNCObbcL+mBPlCJS6cNtqm/qcKqZkwSOUEU+mHTtpzqeE?=
 =?us-ascii?Q?y4eQQjSuJQC4QDw67qBzGacuNxuEJ2UdoYUO4Dtur4YBFqWeFp7SDOLqaDsq?=
 =?us-ascii?Q?xL1Mfgq9kELkJsexC07fHLTuBifgrBB+qvcOPHD4g1nbfpM4RS0x4IUW0idq?=
 =?us-ascii?Q?HRqLEnyVfkZ6dFifzLpImabZnUrXW8c3K4uAMgrPXbj5QduYB34ToEJBxvS+?=
 =?us-ascii?Q?61a1UbhiaSKoCsy08OhLfbYTfUbvxjdqkthkcztI6k59HmtAuhBtdYWoc+dq?=
 =?us-ascii?Q?+X6gArrEFSB8szveZfP5yUrb53ZCUCYyFOB4K3eBL7f2wKFFhK1xFMBVsjWW?=
 =?us-ascii?Q?8ljxiJAQh+newyXfh3/3Hg/rALrYrSbNk+5jbgWsfZAaBxqD+hQpst0udYyY?=
 =?us-ascii?Q?Oao71WXV8iw1t1FKeHylTgsixly9FI4MA45dmVLdJ8ByeatOIAn+1uVjJBoD?=
 =?us-ascii?Q?0cTO2fD5rCkL7kUaRyIngtH+DND67lkgxHQA5cj71xAsKEmQ7vZ7J6dBbT3f?=
 =?us-ascii?Q?cxgyPplG+bwlvsRXTAifBCgWJMQowbxHtazak6lA0N3dnJGNGZdUphn3333y?=
 =?us-ascii?Q?QwyuQ53Ho05gtLc7t9BgcGROud+uonpW7aOl7/bLm/V+Lsa/kU9GzmaKqnh2?=
 =?us-ascii?Q?jETnluNIoCrg9p1eWgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7df50b-7bd2-4411-1e14-08db5b083c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 21:05:13.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQEqFNlH0lpNeQFPRSK0RpeeaJrC3ADTxgAYj4dBQeKH6gPQT0jTS7TDH7t4nikvSVPRQ3XzGIMvIDMCU/UHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 22, 2023 4:07 PM
>=20
> On Sun, May 21, 2023 at 02:44:03PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, May 21, 2023 10:33 AM
> >
> > > > Yet you initiate same discussion point that we already discussed
> > > > again after
> > > summarizing.
> > > > A driver is not attached to two devices.
> > > > A driver is attached to a single device.
> > >
> > > And that device is the owner no? to send commands?
> > >
> > Not for legacy registers access as discussed before.
>=20
> Now I am lost. legacy register access is on top of aq which sends command=
s
> through pf. =20

> how are you going to send commands without attaching a driver, I
> don't know.

A VF driver can send command to its parent PF driver using well defined ker=
nel API.
There is no need to attach PF driver.
Upper and lower devices are common concept.

> > Not limited to QEMU.
> > A driver will be able to do this as well.
>=20
> No, on some OS-es (windows, iokit, more) a single driver can't bind to ma=
ny
> devices without a lot of pain. =20
There is no need to bind. A well-defined kernel API is enough.

It's been while I worked on iokit, but iokit has similar kernel APIs.

It is very exciting to think that one has built iokit based hypervisor and =
hosting PCI accelerated device and VMs in it.
Last time when I checked, I was told that virtio driver is not present in t=
he latest OS, not sure how true it is.

> If you are mapping VF BAR, this has to be done by
> VF driver, and please just avoid pain for everyone by exposing the necess=
ary
> info through the VF itself.
> A capability seems perfect for this.
>=20
Why not the MMIO region as proposed in v0?
Capability based read/write requires extra redirection, it is less optimal =
than MMIO.

> An alternative is not to map VF BAR at all, steal space from PF BAR inste=
ad.
Come an iokit will be able to access this PF BAR without binding to it?

> Guest is not accessing this anyway. So I really do not see why not from s=
oftware
> point of view. There's a hardware reason? Could you talk to hardware guys
> about this? You objected to AQ too then hardware guys told you it is not =
a big
> deal.
I didn't object to AQ on hw reason.
I explained AQ is not the best compared to MMIO because it is slow compared=
 to MMIO by law of physics as it needs to move more bits than MMIO.
And so, the capability based tunneling too is slow to MMIO.

>=20
> > > So we have legacy emulation send commands to VF or to PF.  Okay. But
> > > let us avoid the need for VF driver to send commands to PF to initial=
ize.
> > > Just get all information it needs from VF itself.
> > >
> > >
> > > Maybe it's a good idea to reuse existing notification capability, or
> > > maybe a new one, but let's avoid making VF driver depend on PF
> commands.
> > >
> > We agreed in v1 on Jason's suggestion to have the AQ command and yet
> > you and Jason hinder this in v2 with this exact repeated question.
> > Lets please avoid this and move forward.
>=20
> How was I supposed to raise this issue on v1 if it was not there?
> Stop arguing in circles and things will move forward.
v1 version clearly had AQ commands.

Please revisit your comments.
v0 -> you suggested:
 - "why not AQ, like transport vq, it can coalesce partial mac writes".

v1-> over AQ, you suggested:
 - to "drop the size"
- summarized to split 2 commands to 4 commands to split device and config a=
rea.

After that summary, you propose, why not self-contained in VF itself? -> ci=
rcle back to v0 method.
(Instead of mmio, suggesting capability, but not explaining why mmio is not=
 fine. Which is better than cap).

Then now you propose "have BAR in the PF which is owned by other PF driver"=
, with least reasoning.
And it convolutes with your suggestion of PF driver access...

So, I am bit lost on your circular proposal, or it was just a probe questio=
n...
Not sure.

>=20
> If we have trouble converging on the notification thing, how about we mak=
e
> progress without it for now?  Merge a slow version that sends kicks throu=
gh aq,
> then work on the best way to make notifications faster, separately.
>=20
Sure, we can differ, but the VF has the notification BAR to utilize.
So why not use it?

>=20
> > > > We have already these design choices and tradeoff in v0 and v1, it
> > > > doesn't fit
> > > the requirements.
> > >
> >
> > > So, I am saying one model is small driver for VF and a big one for PF=
.
> > > And to keep the VF driver simple, it should get information simply
> > > from config space capability.
> >
> > VF driver is small that does usual vfio passthrough work.
> > PF driver implement AQ for variety of use cases that we listed in the A=
Q
> cover letter.
> > VF driver implements 5 AQ commands that you suggested to split from 2 t=
o 4.
>=20
> VF(member) driver can't implement AQ commands at all. They are sent to
> PF(owner) thus by PF(owner) driver.  In virt configs, VMM can trap legacy=
 access
> and talk to owner driver to send them.  It can also talk to member driver=
 to
> send notifications.  You can I guess have VMM get member BAR offsets from
> owner and pass them to member for mapping. This raises all kind of questi=
ons
> of trust.
Only the member driver has access to the owner driver via kernel API.
Part of the VF BAR information at the PCI level is also on the PF.
There is no trust break here. A kernel exposes single self-contained object=
 to user space VMM.

> If you can map BAR from PF that would be simplest, VMM then only pokes at=
 PF
> and not VF. If not then we really should expose this info n the VF if at =
all
> possible.
>=20
There is clearly no need to use PF for notification when the notification m=
ethod already exists on the VF.
In fact, it is yet extra steering entry for the hw to perform such mapping.

To iterate what presented yday in [1] to Jason.

[1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00298.ht=
ml

1. legacy register access via AQ (v1)
Pros:
a. Light weight for hypervisor and devices (mainly PCI) to implement.
b. Enables sw to coalesce some device specific registers, if needed.
Cons:
a. Not self-contained, requires PF's AQ which is anyway designed for such p=
urpose.

2. Legacy registers access via new MMIO region (v0 + sane reset)
Pros:
a. smaller code in slow register access than AQ
b. Sw cannot coalesce some device specific registers.
c. Self-contained in the VF

Cons:
a. Relatively burdensome for the device as it requires more RW registers at=
 scale, but it can be indirect register.

3. legacy registers tunneling with additional indirection via PCI capabilit=
y
Cons:
a. transport specific (but not big concern to me)
b. Twice the slow as it requires RW cap.
c. Inferior to #2, still requires sane reset as #2
d. MMIO indirect registers are better than capabilities because PCI caps ar=
e largely for read only purpose.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

