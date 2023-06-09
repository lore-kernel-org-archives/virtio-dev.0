Return-Path: <virtio-dev-return-12923-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D91EC7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 17:12:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 64A397912D
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 17:12:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FA709867FC
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 17:12:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4405A9867F0; Fri,  9 Jun 2023 17:12:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2EAD89867F3;
	Fri,  9 Jun 2023 17:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju5mxyS8VCz/dKCMtCfRjLOF/iCCf3pBtRj8yGdyV+2bpZziTXtVK3JHRi37leuMQ/wpO7w/TScbwFHbzBeOaNifBzuRUzQ+JR5a6wx6w962hxILB6DYmw+dFNr/FpgLwD3qeQwUKLeqStHmJDBozBkp2jlHziuQMc835K0q98h+B9qIOLGbUXwzSx60aPsrpVJLBADbza/CAA4smySEnDEE7ABk1AWq9rj66xDWYFODwbQvXtaP9w9rAh2IukpSEPE6LYH31t1nLbOTVQPfkDYyYpx2sPiFVRVW5PXgWCLA5tJETBwddS26QxN+9fGQIJuTWAlYzN8hQAhi/O/NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD3i7qOfcBrl6XIRXtEUXHwJ94Czw1ORDx9XLl6FktM=;
 b=bCCF23mOIN12I7uTAVLTv92ewlwK7axnZEQw4kboGvwqf+FFtpJrqEL6T3+cMheMsriwuVuMunEOrVYDr6OJuX2Qwldr4qaZGTiICODOpfrq4SSvZ+MWISwg03sGa0FtHQionjpDC5x1fJDovU7c2elMd5j7bvG41uxl4oyDey+fZilYijeMrLfxrgzydJEDfjQ4s01mTneW9rj6Lq9GhAmm4D1ZoPFnIBU8D5uOg8gYg9TcUsY7mNtqgnGPAOTYTlRMnGpOKuBtuibxh81nW97Dpc4A7NtPK7NF0DTizzgzR7lWg55EXFfBLZlMpP6nFPFzeUCQRt+EYnV6WWjh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXCAADjCgIAAD1EAgACbcBA=
Date: Fri, 9 Jun 2023 17:11:53 +0000
Message-ID:
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230609031923-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7901:EE_
x-ms-office365-filtering-correlation-id: a301cc07-ff7d-40aa-0d79-08db690c9f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7KHA+phBSBPRSgRy1oYCdE/YWLCUyQvjoshASe2JCQUx8sTEg/bqWFzZJ0u3vbLH0hcp9AnOWH4C6CdPR2pSK4HX2H/lz1FKUB5ZQt0Vo/7YU2ILpYFt1yAGat7/yPuNLbGx1/gMqM8fBR60Womvt4C5edEUz9IalIqRlQYip8VX9hlzahgoimf71/U7Em03iT0Urxa/aPehN/SaQDHMEZVRiSdD9slDab9de3pyrmetZvEoGLNoXPwgAjNnshDsxmoUXCnKk2ZktUtuuYmApG5oBuIdUxTYffzECeSte5PZ1lMC5NUQ7NeECsBWQTB0T1QQWuYIBzmQ8hOk7A6th9yGmp5OeXKIWMQvx+NaOa/3ULkYCYwvhhXFJHxqTsy0c6UaaViZdCVdYuCMztM8gdvqEkKyAumJ2RXYYney1cIbHTC7aiOibR0e5SEJle7/2kaKfe1/fI7wJAZfXe7lKmk+c5VMzVLCHxYOFq0A7/V4BhdK41frhu97FpoPl/j27zuzTS1hYvVDIvusjEM/phOoz6tD3Xx7yFM/bGA23FoWltMhVAxDZZtR6QqLO+xv49ak0rjPKNgMVtD5RE060r0NBBCdYvvoZRXmPC3LF2p0eRID7kEkYs+N4F+OAbKO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(26005)(6506007)(9686003)(55016003)(186003)(33656002)(54906003)(110136005)(478600001)(7696005)(71200400001)(8936002)(8676002)(5660300002)(38070700005)(2906002)(52536014)(64756008)(66446008)(66476007)(66556008)(76116006)(86362001)(122000001)(316002)(41300700001)(66946007)(4326008)(38100700002)(107886003)(83380400001)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SFWTiyuUNt5+kRkNTgL/GSyLR4gVvgHxoYXADx+mPjhZ5hXF7EBQTzOLB5/G?=
 =?us-ascii?Q?6WqfkX8SWr3o6fMyDLzkRpf9/dr1RBu5OtXLJPhEjVilec11hro/7eLZ9GVh?=
 =?us-ascii?Q?TerLiv+ACOrim9OfUWA3zXe/9sRZJ6lBXqolGEc098ayszEym5TMKKaG2kHU?=
 =?us-ascii?Q?e6BW6PjMa8T9R5LK6hHtlAAvkQfd3yJ10d256d15P/wiU/8qjXeS8ad/kSUy?=
 =?us-ascii?Q?VOo+dyhPgxCDdiahR0cRbQ6HpvHbHpokwZnTaG+RuSut0zXx83DJit/G/Sc/?=
 =?us-ascii?Q?yE8/h5HUEqyeaZ3sIUQ/tLlfR8YjDPUIwIyDXQQdeQmPX9HBJrGaNWwhpCD8?=
 =?us-ascii?Q?Bpy/07SQFTv4j3sSfQTRhIGZ9Efd2qbHuCnMW+FHKcLGkL/6FXEmWQCTAiYN?=
 =?us-ascii?Q?5Noa21KXx3WLeBjPK0mbl9Vx4NlCBTNaeyc6mvLif6mznptQWJ658GF89bJe?=
 =?us-ascii?Q?9fvNxvBgPHGKOZXHsMU/Fob6vuqEPM4bjvvZlV2cOPkPTFT3CIPGG8/lxvin?=
 =?us-ascii?Q?mYIT7o2HwRlmoX56YElKCwjJaT+jHFHpU3wUf+DjEce0rJxGKqA63qemkKMM?=
 =?us-ascii?Q?AT6figrwFwrpslAzvTkKkgXq6sOuB5ZgJsmevxldZ3oTTzzm2rtZd9mUc6Wf?=
 =?us-ascii?Q?X5Yx0JMjse1pgm21w5+3YcyqWvNW0E93VLeyvmmjx7oTPsr1l5I268N4VOvB?=
 =?us-ascii?Q?tm6RPqo5R7yR39JupQjsuYAbN5Oj7fSF56QaA2l2mfuLouPh+Gs5yPJ/XPlp?=
 =?us-ascii?Q?r0H8qdI2FDfherhwhfprSziCK22l6gMDvOSJTw4zbyDYtbCBLI5OqPQXgLfD?=
 =?us-ascii?Q?5nAt38FGC9uT9aaNisJCryv+H+kjd8by0XNcoQasSQMBN1hgGz9IV9ozNWGN?=
 =?us-ascii?Q?L4T1Jj8Us/hGwloguRg6o2Dz5LdAJJr4R9osRjYG209DnBMx5vvAtskxWWMS?=
 =?us-ascii?Q?m4GJALfujf0aA9EUUW7IwIj+sBKC3mB/wd8n2jFwtf0noYeY/iuNPb3haMI5?=
 =?us-ascii?Q?tV9qG6z6mpLXsGluOxwkyJpyNp7S+NwVcbr4BKAep5bR7vgB8lifA/PFK/cA?=
 =?us-ascii?Q?qqceGWnfN93XLLkZ0IApq+AH4gswHJsNAWENHbp1UQf2lpMzDtrwwOxv0MAX?=
 =?us-ascii?Q?63fzXj2yHAMmSCFVy+y/bfVP8sr6NmZhA1atrFGiugzCenVT2pgaPKuvciA0?=
 =?us-ascii?Q?7vD5plDWYCqtKWuFpl8F8N0CvRvKD6fsQ3kwRX2IAYZWtSLpsUFjkqFZaoIQ?=
 =?us-ascii?Q?7h1kya+XTl0Q/+md3ihQTMw6jWg44N6JrbkhWuFZvQDowART1ekZK84qq+Zv?=
 =?us-ascii?Q?1hL97zepZ0N7IICBCAIRvrf9GFDRpT91hTuS4NCmIa8sDBGE7BR6OwTMBePc?=
 =?us-ascii?Q?NWGzOiRdti3l+yTIlOL7gUopXNo9+uvk+q8ybdlPME1GmVlA75i847IgiACK?=
 =?us-ascii?Q?U23f8Qbmc1i462EejkjEF7ZPw6c/uXqOhJDFemW5sQZVCBLaSOE0oks0mwk9?=
 =?us-ascii?Q?/iHQS3nLlwiHoj7PDF5Wa8X+jBmRCw14sgFtF4e46hbuYHTWydsjfxokDqRG?=
 =?us-ascii?Q?ysdJimY0u0qxgnEW3zw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a301cc07-ff7d-40aa-0d79-08db690c9f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:11:53.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kt1Jnyc2u15ypt9C/6JFlXF6cniDjNwYrFehPbUfW8FTFoeaSSgE6bt8fHbjyme9+xT+baA5bE1e6c5bKwviyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, June 9, 2023 3:22 AM
>=20
> On Fri, Jun 09, 2023 at 02:27:01PM +0800, Jason Wang wrote:
> > > I would like to keep the stateful interactions of 1.x device outside =
of 0.9.5.
> >
> > I don't think this is a real problem, but let's see the drawbacks of
> > this proposal:
> >
> > 1) non-trivial changes of full new transport alike ABI
> > 2) can't work for nesting
> > 3) require vendor to implement legacy behaviour which can't be
> > documented precisely
> > 4) require admin virtqueue to work
> >
> > We won't have the above issues if we use modern + legacy header/mac.
> >
> > Thanks
>=20
>=20
> All this is true. But it's by design. It makes the legacy thing as isolat=
ed as
> possible. Because let's be frank we won't be able to drop legacy support =
in like
> 10 years. But hardware vendors will do that quickly if they can't sell ha=
rdware.

I don't think above 4 points are true for below reasoning.

Hypervisor flow without involving guest; first sanity round to figure out t=
hings can work:
1. reset the device
2. set ACK and DRIVER bit
3. read features and make sure _MAC, _HDR are supported.
4. if not abort.
5. reset the device 2nd time so that guest can have right view of things.

On guest access of legacy area:
6. reset the device
7. set ACK and DRIVER bit on guest request
8. read features and make sure _MAC, _HDR are offered
8.1 Hope for the best that on two completely unrelated device reset on #1 a=
nd #6, the device offers exact same feature bits.
And mention this in the spec 1.x for rest of the future.

We shouldn't be adding such a limitation to the spec.
We have seen this with mlx5 device where 5 years ago one thought this canno=
t happen.
And now with modern use case now features changes across two resets for mlx=
5 device.
Baking such limitation in current spec for past 1.x is sub-optimal.

ok, so to avoid baking such reset flow nasty things in spec, lets avoid flo=
w of #1 to #5 in hypervisor.
So, provision the device to support these new feature bits via AQ.
So AQ is required for feature provisioning anyway.

So, your point #4 is required in both methods and so it scores same as this=
 proposal.
Hence feature bit is not of an advantage.

With _MAC now we need writable mac on 1.x config space.
for 1.x writable mac has two requirements.
1. It must be atomic (not for 0.9.5, but must for 1.x like CVQ)
2. should be synchronous to know success/failure to know when it is effecti=
ve

Both are present on the CVQ, so yet add another duplicate 1.x scheme that f=
ulfill above requirements.

ok. So may be let's do AQ command for just mac setting.

This scores down now for two reasons.
a. Duplicate of existing 1.x feature
b. requires AQ.

So, from RW mac we moved from 1.x cfg space to AQ. This mediation for 1.x i=
s not good.
And now it's not trivial either as it is not just simple *p_mac =3D X.
Hence, #1 of non-trivial starts to looks less appealing.

Your point #3 about vendor to implement legacy behavior.
If vendor needs to support legacy, vendor anyway needs to implement _HDR an=
yway in data path.
and above MAC change, and feature provisioning.

For legacy there is no extra/special documentation.
All the behavior listed in Legacy interfaces section for configuration regi=
ster present applies here.

So, I don't see mac support is trivial by any means compared to proposed sc=
heme for 1.x.
Hence, comparing trivialness of two solutions seems same for your point #1 =
once you do mac plumbing.

Regarding #2 on nesting. I won't claim I understand this as your level of k=
nowledge.
If you are sauing only the VF is in VM as virtio PCI device to supporting n=
ested guest, that doesn't have AQ, hence it doesn't work due above issues.

Then yes, but than it is back to square one, where you need sequence #1 to =
#8 to be done + non-forward-looking spec changes on reset flow.

In that alternative, one can say, hey skip steps #1 to #5, and on step #8 d=
oesn't have required feature bit, mark the device FAILED.
But this is common case and its late in the init flow to discover it.

And now MAC cannot be set atomically either in nesting with just feature bi=
t without ugly and non-trivial spec updates.
And when one needs nesting with legacy, probably PV is better.

As Michael said,
Overall isolating legacy to AQ for config, intx and by reusing 1.x's notifi=
cation is good trade off where 1.x device level interface is kept as detach=
ed from the legacy as possible.

This is why the notification address query also was desired via AQ as propo=
sed in v3, but it is small trade off if you think it should be discovered v=
ia PCI cap like v5.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

