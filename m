Return-Path: <virtio-dev-return-11383-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41139C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 16:12:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7998429FD9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 16:12:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 745EC9866A2
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 16:12:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 69062986674; Thu,  2 Mar 2023 16:12:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55BEF986676;
	Thu,  2 Mar 2023 16:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4oTGXR3Vy1L9HmCfQpRBijFJBCeJ41TOWkOw3act16Rejtwd6I5er8bTh2F9hwwZrjgGbWBcl+IXyY7y0oprltWyHVCDIv1rBr3bOxVU/fYReXAW9s3LXHFb8pQCBvJme8WxjYCyFH8vku42ezfAAsqLRk1pP99DqTc9wAVb89AUJX2uw3LT9ozfVuhbeLxuGeSu919QmLzZ4kAFMMZ6CeG4qgSHI+3APnWMIxupBYwj9lPR8K/8W9fCBQxPvQRhOdGnPol5dGjCgXjGbUSIkDuZzpnExmF58vVEHdQ8JsVy30xOU0xZhh3/lGtgRpC0ch413QZOd7sdnexVZJc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmQ8Y0EFmsn8WLMhaCqvUK6tT0O81J0DazINcH9D6dg=;
 b=eM/MmDZ6nKDvuFr632fJrG1rlUXrQlcXnFv96susy0VRE6Hr92/rAnAuIzjG4W+MyXr4q7/CyoQxoQl3Hxz+h7B4TCgVjksn0IG9nzNvd2L2v28bgXSSYhiW2joM+RF8EKT/5/DgRQqPJsTTjHRpxMwOv+D2n5GTDyZMDGMOQafnYZmVtiSm9W8PztPVpqm6ysBFDgIdXmDA9ofgu9IG9pYOaQUEDpONLsCCavsQMVoj593e9FzWOTXOg8V4Wq9n9F8DOd2KkMgsoe/EcoQ4ZU3bA6fZA2Vcthv+xQrHpRwdUNrIpyzm/8IpL4lpcDk9J/GC18AzPm1oNfYXcV3aYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Yuri Benditovich
	<yuri.benditovich@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number
Thread-Index: AQHZR0pAxGvxqZYuNUuHEK6ngQ2mvq7jFlqAgASY/gCAAAOdUA==
Date: Thu, 2 Mar 2023 16:12:48 +0000
Message-ID:
 <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223054624.168042-1-parav@nvidia.com>
	<20230227123751-mutt-send-email-mst@kernel.org>
 <20230302165216.1293d066.pasic@linux.ibm.com>
In-Reply-To: <20230302165216.1293d066.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6326:EE_
x-ms-office365-filtering-correlation-id: 95ec7423-2294-42e7-aafc-08db1b38f788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 itrqRTWxmK+WskE1sod/Ls5lbayk1D9cCosWKZbpq7Y65Un2V/wiIHINNHIPL3geI5Jz8RGQBKFXY2NXn9k/hYhvwO9VJTe5pcrIJjNtiLGgtYrJfh0J8Wewpp2Rt6XFoW9Od2rXeM3FSdR+P0aRuj2gJJOWWl+rj1tuTOrxDo6E2tM5Bg7q6j0UZFSix29T8BygukWdltcx2Qfs88Hbgmnn8sglJQyg6CUigdl1q7SEZO2gFKZcdTDHf3FeTIbvR8mqDr0StotNCaJyq2HE+ajZqfv+eSSz0jNn2xOc/tqHwlnfgFGFwdrSmIdlsekQw1wIF82MtahOwyB6JoUZnK16+UV/9vwfhn+Hgw6dm/NgjS6zZzslk2P3GfHHecrUE32+0Agcmxa1Tke4j8Z5tyEy3ihBnOjHrMt5rViAu7OMtsuhXGpMDuzRGgnfnRRBn1p9zWH/C2gXV4Hqd9bWrWrnuZqXWwZNX7up2p95LSgaGBTvzGJBFZ0epiEb5LD7fkGcpv8jjsfcFKKkzwQOyD80idDjZCaeSNataJ7m4v0dXuVMogeNliSRdotFmSeEpImLrmlIBxq6yzKZVDCGaIEFcANdOXh+L5ISz0xoUP3uBN+DHIIlBLTRIYayYhTi4DroPX+Q4ttQ4V5E6IGN281Xrk/knCWa32k3HsDyUfVSf8GO8rtODT3aBq0rT1DOZ9hF0Nkq6PIr56BqgaR5hfKBh7P0JO6XBNtHhkiO9Sb/2NMT17oKD92pBoH5KyRf/MpDSFrDokIYlJoowKmNjA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(33656002)(86362001)(66946007)(41300700001)(64756008)(52536014)(66556008)(66476007)(55016003)(8936002)(8676002)(5660300002)(4326008)(66446008)(2906002)(122000001)(38100700002)(38070700005)(7696005)(71200400001)(966005)(478600001)(316002)(54906003)(76116006)(110136005)(186003)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PTSvcCN+kRRRq4qRQjwqwQ7kqLoTI5T9r+gnc39tB1mzcVJBvKwNIlF89Szo?=
 =?us-ascii?Q?0E5dBKsPQp0WLSmQMpe61I9jwN1vghyAdqAyjZt71umXdt511/fNpWFyF15x?=
 =?us-ascii?Q?o+ovknhKBlLyqI0Zs8ccbnv6pigLBz+9cqXlCT9GgtWI7gmZTh3YJhSkRBPY?=
 =?us-ascii?Q?XIdoNwJT3oJKZcA0rda/CyCe48HFHQjAv4pc3srjZhnZ3sdvITY2aP1TL2ML?=
 =?us-ascii?Q?Q6GquYcVKf502ZFZ1QQ2OshFVw9DYJDI2uAnZIZ/HcMv30NNL6kpahznILwD?=
 =?us-ascii?Q?uK4hVg0Da2zDrMuolg+2wjQsDrpsEVk6JbD/Vou1Qj3XwHWuv8sEZMeky+FL?=
 =?us-ascii?Q?IOIOUBMG8Hli0rOraUygIPoOQG+pme8ccQ0qcolyTjelOMeCBsP4lEyv5Jo9?=
 =?us-ascii?Q?fSqLt5NiOYfUep/8oSqm6Y7xTTeKx3sibuXWuTRH/fmGR2IOjJgaiw1wm3gV?=
 =?us-ascii?Q?9ub1VwKZ0hK7gQAzLV3DRIt//gR6Il8dPxWYQOYGfy7+NVp5Cs20QC6kInHo?=
 =?us-ascii?Q?98XClP6OQ4CZWxkYmUljARR9re/Fvqtz2S/Bv5EvGJQO+gLiKZQR5oJ4q20s?=
 =?us-ascii?Q?5zKQKf76Sipeaeel1MmsOiKDuZRXV8ydqhRo/M0Ec+2gDSGY1qiicuBoPtrq?=
 =?us-ascii?Q?Qdaq4w4Sev0Mu0NTPDJvtsbizGm0AaM5dR8iATb8qHM4mvJLLeHmeaNptgzB?=
 =?us-ascii?Q?gNJ29d5WWSz1ehSnbn256WiUQq7IfHbe9u1vb4zKELf66/8+1H2Zsdtz6rI0?=
 =?us-ascii?Q?p4x4oiKdHTonmwoSknvJ8QhtYiG08qjPY0gZyyzNaQnkapFJD3bqnqOK1UiA?=
 =?us-ascii?Q?tg9+UhzgQ2EGB3gIj3GvP/UloMdAAJxlK4WznP4+Y64WVkS9NYLXg7/EVvnm?=
 =?us-ascii?Q?AaSyPFmCirXobo43coYueO59p9QcD8JSm222Z7FawJqYcVxw5CKt4trhuHRT?=
 =?us-ascii?Q?erY/U/CidEWnRQM48FFIY5EQyHKFI/WQrmhM84OEqKQvmqaoIfjQ2O+ULelf?=
 =?us-ascii?Q?713n0W+vPR7SoKRhWBl/z+eU1p6w40TUix941DIb+Ldxsqiky8bgAoHxzSfZ?=
 =?us-ascii?Q?o8qlIaJ6wt/6hayD4iIkabAezyz//SxIIP1hPVjyh353sBn4ExnidzVGkEbI?=
 =?us-ascii?Q?d+2QzN3+wfDM7p3GCKGKlrz9nrAGmbT15fRXtfLvlqGjsLz/CW61msCTnMm9?=
 =?us-ascii?Q?M1sD7DY5vDrpfP1JRJXzXlvZwvTkd/xVwoKJq0bh+g60ZLhNRkd+IZbV+rqB?=
 =?us-ascii?Q?pHTTvldNEiEhkIqz5bxk6eabd8maC7zr3FbRE9kjNMHidRJ8yG/YnRIiw4kt?=
 =?us-ascii?Q?EruCfeFf0lZZLztIOcLP1a4ReoEwO+gd76mxkhGWiUqGiOxfFXxz3cvjEDtq?=
 =?us-ascii?Q?TkUMyrYSCryQDwDfTC3ji7LvoFW7JOWDtcarY/5sUPxY1Ey5jM0pMVZnjOt4?=
 =?us-ascii?Q?I/yY9KS3jh/iIY4xvGdHpsC1OKo4Fh6mIj1Kcz7svb3nlM+0dARseHjSGAo8?=
 =?us-ascii?Q?5Wfubz4csT89ORiQANCwouylkW6k4fUPXWRc0PLKdnnWp7WctYRYshp1ao7w?=
 =?us-ascii?Q?2P7EGD5FqSEgrzjJgb8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec7423-2294-42e7-aafc-08db1b38f788
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 16:12:48.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHd2/CqmkhwFToKewg9AOJc0YqgPgDkEywy6T66tI1kyYfJNWG5QibKHq4vWEd+pkNzR0KxcM8niVcGrzhTHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Halil Pasic
>=20
> On Mon, 27 Feb 2023 12:39:39 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > > This series is on top of [2].
> > >
> > > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> > > [2]
> > > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.htm
> > > l
> >
> > What about RSS description in net? That says:
> >
> > description.tex:Field \field{unclassified_queue} contains the 0-based
> > index of
> >
> > is the index same as vq number? or something different?
>=20
> It is something different. The full paragraph sound like this
>=20
> """
> Field \field{unclassified_queue} contains the 0-based index of the receiv=
e
> virtqueue to place unclassified packets in. Index 0 corresponds to receiv=
eq1.
> """
With vqn it can be as simply written as.
Field \field{unclassified_queue} contains the receive virtqueue number to u=
se for unclassified incoming packets.

Similarly rss description can be simplified.

> Here follows the explanation.
>=20
> Disclaimer: For a brief math background see [1] and [2].
>=20
> Here the index set the set of natural numbers (which includes 0, the neut=
ral
> element for the addition operation).
>=20
> The indexed set is the set of receive virtqueues, each member of that set=
 is
> associated with an unique member of the index set.
>=20
> """
> \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtque=
ues}
>=20
> \begin{description}
> \item[0] receiveq1
> \item[1] transmitq1
> \item[\ldots]
> \item[2(N-1)] receiveqN
> \item[2(N-1)+1] transmitqN
> \item[2N] controlq
> \end{description}
> """
>=20
> But, as seen above, we happen to also use an other index set for the rece=
ive
> queues of an virtio-net device. I guess the intention is to use these as =
names, in
> any case the set is { "receiveq1", "receiveq2", ... } (yes, I'm a little =
sloppy here).
>=20
> Thus we can say that:
> * the virtqueue index 2*(N-1)
> * the recieve virtqueue index N-1, and the
> * virtqueue name receiveqN
> refer to the very same virtqueue (for each N > 0)
>=20
Receiveq1 is a name to virtuque number (currently index) 0.
And naming this way doesn't seem to be a problem in the description.

Section 5.1.2 is liste them already.
A short line tell about this mapping will suffice.

> And it depends on the context which scheme do we use. As far as I remembe=
r
> the names are not a part of any virtio interface. I.e. they are only ther=
e for the
> convenience of the spec and the reader. We could get rid of those. Althou=
gh
> the possibility of corresponding to some network device, Linux network de=
vice
> or tooling naming convention is also to consider. But AFAIU Linux uses 0 =
based
> indexing for the rx and tx queues.=20
Correct.

> If the 1 based naming is really just
> constrained to the spec, we can change it without problem.
Yes, most changes are trivial I looked at.
=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

