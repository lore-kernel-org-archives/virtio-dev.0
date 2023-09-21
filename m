Return-Path: <virtio-dev-return-13924-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFBAE70719
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:13:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ACBB92B028
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:13:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81D6D986686
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 11:13:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A07B98667E; Thu, 21 Sep 2023 11:13:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B5D398667F
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 11:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeRIktDXiAS0rGJpMRdy7jnAeRcFwisB3avIM85KD4w+ytUNMHNiufQ6j+jd21w25802hdEInkBRLHaqHqf6l4vtrCHfCggp+a0grh5H6Nt1PDnQcUxaN5IdNpobYKhPp149niuWTtXVKcNhlfk8GNESE0eX4oxpiWRNy9ONanItfO4/FEPUZ2VT0/Dsib6gBAJb/dI7y41hRzDFGZyOiS2U/ziDQdErM3k2nPSR3aUeAGX/xB/rt0a1JH4XPMb84Pg5Njrq2CQviuKxDjPVt3WscA3cM7C8bTqkqKMXMCug79fvix3Ztj/SQozzkdmHLa2RwsNg3DnrmMfXa8a57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnEKwvIfVDfASsqfJ/IAbfg6IGpJ6IGiNI2ORCRmrds=;
 b=Rbg+mPOGLrVtxo1XsycFFksTwCVLt5hmZInxDILcFfHj1TET9I7Og79hHjrZSxOXYLxqwStosEzmreClhmGjdKVAQwDvYOnwAf/bgkaqIxnBHjsmycaL6tDhao9mgGtl8/KbTUJskLLq3rcdwJ54fYGPb1JNKJrNnHxU31d8pYXJnUppJFFsOEN2uFTMybhf9lhPB/eOBOOk9Gddatk8SR6y1d475JpXZtV16x5rZJGXBcMM84k/ukXsBQjukp/8zsZZV5qOhwLawQ9oPUM7Yxjuc9luRXDWeiY6474XuCeKcDMaTt5fd07URTt2kDheMSL1luDcqsR+LXv3uy9N8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfwgAAT/YCAAADbUIAADTWAgAAEM0CAABqvgIAAEDPA
Date: Thu, 21 Sep 2023 11:13:18 +0000
Message-ID:
 <PH0PR12MB5481E90DCC1580B710B69FD1DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921054959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921054959-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: ec9afb2b-24c1-4464-7397-08dbba93c210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4IsVnlxxxrYmW3nHsZeJBMZPQBoyClpFo+c3wUxgopeY53tC6d2FwgYcdk8m8qXm9Od+btpJeNExCkX1IgI3eN/3Fsu3/CQXS+KmBzPIuop1z0MJHLXFB0VkfE3WaBv4aILcBdjsvDua2T8IcDFMF7oXIHQczeO6LOa/yDs+bUCL8/nUJsbcilLXrrpZqznVJac8cjaJXPZQjSC/pdh+XeqOgogKko5xjN5k3mp6p+/pQ7lrpJYFJA1dlCnb+rJ6l9DJm9zs3Syb2qqT/6ZHXCKK1FbXeGWR+B1nHf0yP6EYK3L6hvO2O5J75ssEnVYw0pJ3hP1wuW5gwBTbNgKbF8KiLjT76gb5wuJ26dl4WVLW3XD5o8BRdQIBeBVQuOIAOKJVaevmRrWC8QdxWafzrV8+agvvAU39jrei4YwaO99ZwAa1r3SwAZ0HvSZvtu29IyiuvDGhjNWl0neE2ug1qLzmDgyAi+IlYMdB1dZcynpuOBVtSSWTJYxcv+09uqJNRvXhD1FhKk01xAYsLqAsR9pbNpguYssE5Dq9W8qh4jxJSE3bKXH1JDahDUtWI+mEB+4NRClYFy6Qs48oxni2xkYhKPvx5CR96xIQOh6btSkBmwWC4E+Lfo8XGDuVh9f4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(1800799009)(451199024)(186009)(15650500001)(2906002)(33656002)(86362001)(55016003)(38070700005)(122000001)(38100700002)(6916009)(316002)(66946007)(9686003)(66446008)(54906003)(66476007)(66556008)(64756008)(76116006)(41300700001)(478600001)(4326008)(8936002)(8676002)(6506007)(55236004)(7696005)(71200400001)(83380400001)(52536014)(26005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iLhQqi8/G/DJfNxHlZNP91oPcOOVEbv45melp1ftXDHiTJssYPNvdwUAVlBU?=
 =?us-ascii?Q?lz1DNb34p9+ScPSGLU1ufNoe58vEFRE/lYJLce281wIX//E5HbhHjPa5tz0D?=
 =?us-ascii?Q?X2govIulIwNPGvGvkvW+qn+6fnjhKttuCaqsfgn5dE5HM5pVBNzkadD0eRti?=
 =?us-ascii?Q?fF17oZ3tn2/cBN7tSXbFIZFLYURuzEdWVIwPqWM2pSA3jhrsVMEUNl8p+o97?=
 =?us-ascii?Q?dnO228457jVuoVaD5/MB0rLPLeV5188s+0tYPf13vjHqi21faamw2eKoHXrP?=
 =?us-ascii?Q?HkLYFjIHZLdkvwHKELjflaB1rlj0PgmC3SSZMQy7mgMqp211Pvz1HR+bVuzz?=
 =?us-ascii?Q?Aln0pLiFDPBG3J8Ys59NZfpFulr0LMPjCl8vp9tLlSVOHBncsohd/z4kTRLW?=
 =?us-ascii?Q?mo/y1zNEj8Ejjo6wshcyM96IJ0UGJpfoCDcStoaaNlCqcocL3DFfewYmoJqK?=
 =?us-ascii?Q?mWbmmQY4hovtZPQ9cPZrgnjjA66RWq7GhiqNasFVYDEy05EwQ2LPAVozqUdi?=
 =?us-ascii?Q?pIFvwaYy0/5ejdJFkk+LgZJj4S3Rs3k/3Yi1V0tjqpZD0LRYdnZSlPNzD1p3?=
 =?us-ascii?Q?1FfanZuZ6yHiBF7uTIdg9/Pb8dFthYpkULvT3k2j7UiiCs8naxdG0GhJzy5l?=
 =?us-ascii?Q?0k1NUD0MGnbnNvu97Ziorrfq8NX6Vun5YeBV4xbLck9pBSIeEiO5ZpAkXq7P?=
 =?us-ascii?Q?QjNzctHSzY1TxGmFIH5FKE1wXyrEKCeOqgwP8Ib6spbYs5wsf3PmH3uEfXNb?=
 =?us-ascii?Q?bDM1++fJd0bk0+FWE4R1JB0DzJ9ttajYzLcpLQTQ1GWJyeCvF7dZKb5v983H?=
 =?us-ascii?Q?jzTr2yj8BgJ0uykebRVN5c8zOgn6TX7PE3xiI044DMFR2kRPV+Mi97kHXpJc?=
 =?us-ascii?Q?WMAxW9b6ogK+U7sptxU9nQAGIuIkYb7mmy7y3tVTtQ2dOyZrPHLIojoUQVZJ?=
 =?us-ascii?Q?0jcgi2MshTquCeobFzyPOeGf4gD7kDOmPG3YlfeQkS+k9XldejiqRkceyLon?=
 =?us-ascii?Q?+6+JKp8jBHDlgeT7zzQgE9NeWT8UOjqz0ENR6EsKSjA15GVLs1R4q3/voXfg?=
 =?us-ascii?Q?YyvNRoTvd/h5Sa0jVnpQF3Tg7Z8kdQi1ivN/+X+F0mPmXBh7DtRymyHYgIVe?=
 =?us-ascii?Q?eEQrMiadd3MplSj0WmLM9cLHEc3yNE1W09g1GlUe4K5tJh8Wk5/QDC7OzIxi?=
 =?us-ascii?Q?ZSxV7/zdyS3OZBqXtbGJyzxP590eI3m8tfD1ikBsWB1SaPPHafZ229s4IdSe?=
 =?us-ascii?Q?gJ7VsF2pE6SoFGqvTz781Rnz2x0qdJYWEGl0Ddtszlj+qU73QajdT2Gka2R5?=
 =?us-ascii?Q?1Ba7QIZOU7rWZoecmUEwtua7deAkwpjZBxgV9LvFpuO/LF8vrWgFks8Uua5D?=
 =?us-ascii?Q?4tfqUyv/sVpOyqcXpLIsB7MZYrC+DsH24vEy9k+NRM5yAPO2pO471OjGY4xz?=
 =?us-ascii?Q?+SDBA+cL5/nyPMb8xy3BE3R4RxZ0D7jJCa9AjyUk1vGBPprF1QsW7GSDSOy5?=
 =?us-ascii?Q?5YX78SKGz97585izuqL81wV55BrZG+XrfqpsHWFeKkrcQhGXWqriPAWsxTq5?=
 =?us-ascii?Q?3aaIx9cOiMk1B1x2NRw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9afb2b-24c1-4464-7397-08dbba93c210
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 11:13:18.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTNMP3W7NTIbsYv55xkYyQiygZQg+Ek8uGWtOs22WrReETobnn0gJ/ROfqN1RDwYwV6fQ3YZWPdJpIiCDWVnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 3:32 PM
>=20
> On Thu, Sep 21, 2023 at 09:17:53AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, September 21, 2023 1:41 PM
> >
> > > > I mean to say,
> > > > Virtio spec has not achieved mediation less, device migration.
> > > > Virtio spec has not achieved device migration using mediation.
> > >
> > > But yes it has - it was implemented with shadow vq.
> > >
> > Shadow vq + several other trap points on config space, cvq and more.
>=20
> exactly.
>=20
Ok.

> > we cannot suspend the whole device and resume from where it was left of=
f.
> > Those extensions are happening now.
> >
> > > > And two proposals are trying to do it.
> > > >
> > > > >
> > > > > > >
> > > > > > > > > 1. For mediation something that works within existing
> > > > > > > > > mediation framework - e.g. reusing as he does feature
> > > > > > > > > bits - will require less support than a completely separa=
te facility.
> > > > > > > > > I think Zhu Lingshan also believes that since there will
> > > > > > > > > be less code -> less security issues.
> > > > > > > > >
> > > > > > > > With approach of [1], there is less code in the core
> > > > > > > > device migration flow
> > > > > > > because none of those fields etc are parsed/read/written by
> > > > > > > the driver software.
> > > > > > >
> > > > > > > What is or is not executed in a specific flow is a separate q=
uestion.
> > > > > > > But the point is vdpa and any mediation have to talk virtio
> > > > > > > things such as feature bits. So reusing e.g. feature bits
> > > > > > > needs less code than operating the admin command machinery
> > > > > > > to check what is supported. Yes, you can operate this
> > > > > > > machinery during setup and not during migration itself. It's =
still less
> code to maintain.
> > > > > > >
> > > > > > I wouldn't go down the path of code comparison.
> > > > > > But if you want to: we can take a concrete example of what is
> > > > > > done by similar
> > > > > device who uses admin command approach.
> > > > > > The admin command-based approach migration driver is likely
> > > > > > 10x smaller
> > > > > than the actual driver driving the feature bits and rest of the c=
onfig.
> > > > >
> > > > > yes but mediation driver already has to do feature bits. so if
> > > > > doing mediation then the cost of adding this specific extension i=
s low.
> > > > >
> > > > I thought first you were counting the cost of the code and not the
> > > > spec in your
> > > point "feature bits needs less code than operating".
> > >
> > > yes - with vdpa it's mostly just
> > > 	vdev->status |=3D SUSPEND
> > > 	vdev->status &=3D ~SUSPEND
> > > all over the place.
> > >
> > + inflight descriptors.
>=20
> for sure, this is just stopping it.
>=20
> > > > > > If one needs more precise numbers of number of lines of code,
> > > > > > I can
> > > derive it.
> > > > > > As features and functionality grows, every line of code gets
> > > > > > added there in
> > > > > mediation too.
> > > > > > I agree such mediation has value and use case, as we know it
> > > > > > is not the only
> > > > > approach fitting all use cases.
> > > > >
> > > > > Do you see how this extension is easier for mediation than
> > > > > driving admin queue though?
> > > > >
> > > > If we count the total cost of code than building the mediation
> > > > framework +
> > > extensions, than it is not.
> > > > But as I said, I wouldn't compare two solutions as they are
> > > > addressing a slightly
> > > different requirement.
> > >
> > > yes they are. the point of comparison was explaining why people who
> > > use mediation anyway might not want to also use aq. can i assume that=
's
> clear?
> > >
> > I am not fully sure.
> > I frankly don't find it right for member virtio device itself to be med=
iated.
> > Vdpa stack make total sense when the underlying device is not virtio an=
d
> hence emulation.
> > But when there is native virtio member device, further mediation is ove=
rkill
> for certain scenarios.
> > But I understand that it helps to utilize a vdpa stack and thereby over=
come
> some limitations, while it introduces other limitations...
>=20
> yes. whether it makes sense depends on the use-case.
>=20
Both are valid use cases so vdpa over virtio can find the uses to overcome =
some of the limitations.

When one wants to use virtio member device as passthrough, when needed attr=
ibutes match, one can use it too.

> > This just fine, because FLR is not resetting what PF has done.
> > PF is not touching FLR side of things either.
> >
> > > will get you a VF that is not running and can not be given to
> > > another guest. You have to
> > > - queue stop command on PF
> > > - stop command is seen by PF
> > > - flr on VF
> > > in this order.
> > >
> > Since you are discussing the admin patches of [1], better to discuss th=
ere.
> > But even if we follow the sequence you described, it is also fine.
>=20
> well then flr itself is now insufficient to reset the VF completely to it=
s original
> state. =20
That is how it is in the PCI spec and other consortium based spec and many =
vendor implementations too.

> stopped before assigning it to guest or not.
> a stopped device can't be used by guest the way it expects.
> And to make sure, one has to wait for some admin command to complete, one
> way or another.

Yes, sw stack which dynamically keep mapping VFs to different VMs already d=
o it for virtio and non virtio devices.
The migration driver will make sure whatever it has setup is cleared by it =
before handing over the VF.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

