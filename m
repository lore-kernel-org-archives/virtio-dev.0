Return-Path: <virtio-dev-return-11909-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A437C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:36:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9BCF541F0B
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:36:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94DA4986596
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:36:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8AA5398641D; Mon,  3 Apr 2023 15:36:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78C7F9863DE;
	Mon,  3 Apr 2023 15:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2N3QU1rqodd8mRek7CmRvLSbEP5G3F0DmRclZuXQMnSXB9AmZHzgqaVs7u5jY2jjvapmdyrcfxLZXnjXeXNyraM+8np9dnsxxdBbE1v+R7mAnj3+tEn7mvtx7VaJCYP6G6yMbRrN39pfVAwqDcu0WXOQXFMzrsZd72ebUeL4lq1Q+t1ljzs+RoTXBj8Trd8g+IDN6IVheA0mN0eLr5MLV/L/AEXBp9tA/VCioLEA0oAhHryDqOyyy2ULumo3RVJ3noJqgClVeYeT1FTmONGhgNcewbYClnP3m1/cxfBtRq9kztPhv7zmy360++BT0Y5xriRHd8EElCC2cJ7P2lVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGwH7E6lb9TP6nt/NwVT3CEBXsSZyXBwmgmZQIf97x0=;
 b=ULKj7aSYtyPfjt1enPqTwKtxGu/IvBWr0VmyXVqXZZ5Umdg7aSQF5B+qetsUkDasns6kBaFPg4bo9WvWWxO3LnwDqjxdjcZDcbgyIQ4kPF8YtggSAXUjKVwBpClL2fmI2bbXuCLjrgoxOykvkxXY1xT9S6tKZe+ihckGsPprrx0R3SFeKidER0CTKvY8t+/eDoigoTIjZmxBLEiOjs4kU2s9oUtMhCa0lLr92NlsQ61qM4oLYNx99dlNWFJ5xcNhbqXIbPmDioHNonDFnNzjFa2FdHZHmvh9sW5eS6CS89YFyYdIjifsvdTeuADcR8jY9V5A/Tl21zRjgj5W8QMQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index:
 AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8UdveAgAD15oCABER6gIAAAE0wgAADeYCAAAA9cIAABE+AgAAAS7A=
Date: Mon, 3 Apr 2023 15:36:25 +0000
Message-ID:
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403111735-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5295:EE_
x-ms-office365-filtering-correlation-id: 9e6a30a9-25f1-4729-65da-08db34592f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jHbygkHLutzXzZ+1k0ML6rUT0nIY0OxryVacUnKYQQHit/HLkUppDeMj06W0eP55n5OhJLKyCs9iuHBboqoRPjln5QKYNzB1/6zqv7DZuXhcJG9X3g1/41XHftJ0VvSxlWN4TqQwe6zLIeP4S2gIRcW2XCTYzC2oqVGTf1dPFasBgxHMtL4fTvdw1yCSkINcxcwyADX6itf6fLwnBJ8HsE2iYr29Y7AAcVRJWd0jXZGl2BcwTgwpO1UzVs+eV8i+MYfkXMP0u+tlnceOfIr0sn5bTPIU5T5g5HkjZP19M5cl8UAFXxPTAXbXADFvTT2hmCh1NCHl7bLX9+NuZUzqBEVn0D+HLBUommYHC98+9CtqsDsQhta85JFQMXiSVwF3eg66oq1VpffOTY8hO8L4xWW6hlC8eLBWhAOnIZi2XkOQbvvctHvHeQ4xa9zqIMrbq67Ov37Kofqt7Ci5A3EJmc7rOXfXOrB76+ZiNV6NG5vIil82YhFGKunbL9FnYwD9Xj9pr7ZrOEv0OlSiQmJdlgA55usViDrB3LwEDouLysM/k8oxglhS0V8sJtSbL2nDGxINB8Xs3dSrhoLKRdbFqZIe3RDiiF7TIOFEEaNrpIhjeyWKp7xI7aDWfXP5DvED
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(66556008)(38070700005)(52536014)(316002)(66476007)(41300700001)(6916009)(66446008)(76116006)(66946007)(4326008)(64756008)(8676002)(5660300002)(122000001)(54906003)(8936002)(38100700002)(478600001)(86362001)(2906002)(71200400001)(7696005)(55016003)(186003)(107886003)(9686003)(6506007)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sXrG5xv1oeIjTKzvVr6lqHsu2VR2a3sscLxhZQNVm2oSxCKGzlhCXu1RZp0n?=
 =?us-ascii?Q?ZmqMlQi1fWWVsS6SRzZZVynWsQtc8LADFY2pWp/s075YGgrqVP6su6itWlsN?=
 =?us-ascii?Q?JTX1kl+7s1QCPILDNElqYQxSBYTCVBocCuxvU/oABMnXJu5Itfu7U6qSvb77?=
 =?us-ascii?Q?I2APm7cok/l67XduDu47Z6aDHcjfjgW9+GZPAzb4ITijBhREMYRZ36Glpm87?=
 =?us-ascii?Q?pr4RpURYtK3jvN5T9F5g9TgwLeGZCLgIikxNzgqpREnhott+WkbuXQUKbKtZ?=
 =?us-ascii?Q?9M8fGg4LwBCZ2hyhnMS6gD3gZ/TVAo9EO6O3pBy5TnJHQPfBep4/eGOt25SM?=
 =?us-ascii?Q?nG5IzAQdXG47tAv8KoWfcdQSAGni6sVBLuWtpYpqMYkEDgPKgK7oz4i4QRZo?=
 =?us-ascii?Q?St8NnVfU3bFzNEBVSJAhYjQax50jB6ivwhYUN+yewHfW6gAnKZWLInjHAyz0?=
 =?us-ascii?Q?7bN9Fvyp65ftd+UWQZqOFHRI8p8MfGyqBjwzncID5DT6G5S2U/8+bB4/mXhR?=
 =?us-ascii?Q?q5sV/3SnOWKhYxS739zJ1UHd5a7MHOEw2aS8+kIiJRbpKT1Gn5horgdhqap6?=
 =?us-ascii?Q?SCfWsBKfhX9CGlNi+G5nIoKHc9BFqoTcykMqTDpV/QVxf5RIOAJiyvnVivhJ?=
 =?us-ascii?Q?ukqg3F8P9JCqCODahDxlnw08e24/OD0uWlnj9RIxfqw+rm5NoO6zVIDdcOO6?=
 =?us-ascii?Q?e295MMBbzYvZYARdZdPKzMvGRTRGXYi8qJEvGka/P9NGqHV5sW5PNUgQajIG?=
 =?us-ascii?Q?py00x8LSwyTSpza7SZarrM3CdlayPt4DzXI/n+xNeuR7HXYjt32T0VhTm4qj?=
 =?us-ascii?Q?HJttUN54kzrdWCZ2VQeZBuE55peG+rr4XbjPAZ3ta+oWmog6sUSWYW4/ullO?=
 =?us-ascii?Q?mONdlQo2a75fQgr5mB9AkuSx+BhbA72XGUT6fhFdaz6RcujxcwSltA7AUhF/?=
 =?us-ascii?Q?6mzhXDsiJKylsH8fw6Vbm/V7ZE6zRVwgi1nJ70axKvjqksManw1isjFLLEEo?=
 =?us-ascii?Q?3Uk/EIosUiPXM8eJGSOmPdgy/377p83LspfopKHj3ahVM6ynygAFXZu7CrVU?=
 =?us-ascii?Q?2ax62j8xUClXAOptLt06srCh2ND75SatyO1c0axQ7tmzSWRbQ2miFQV2pjzd?=
 =?us-ascii?Q?mATfY6sNqt/DIKfVlPdFnz9V4Btof2Kj5TwNfCTHbFfjQ6/H8ekgpD2Z3ETm?=
 =?us-ascii?Q?HBGbOpBPKznihQxaok6o7KlFxYSZxjIXsfreBZ9YJTdAzQsT2ttAnPLOiZpG?=
 =?us-ascii?Q?ylXR4uzq5naCqoa0MgpDZEweFNv40YK6qZI3tOGbR5mrVYCb403H0InWcTkm?=
 =?us-ascii?Q?jVQskKUdFLW5v2hDY7HIc5GLGnKAAL4IeQa5V804d+OQeAgvQYobympPqfUo?=
 =?us-ascii?Q?fmr24G4ly/fn6xBFcPpVcMSDNkK1sivDrZOWmKJdFIvZ/HZJZAWtCxtYPsGB?=
 =?us-ascii?Q?LM39EDiGO1oWZ3WskLP302M4abJMlOAJPpe069/yx8Z6v9IzJvxaPGufYkId?=
 =?us-ascii?Q?vFTyCYANgAVJd1W1qE81XeAi94AOFudbvqaWnUbtWEtAv/dzdu2HpJYeRHrv?=
 =?us-ascii?Q?zvs4iEg0YN1TTMPaqZrf/O6s5g993luXR/GMu9Uxk9FgS/jYhldsE7Ko5ngb?=
 =?us-ascii?Q?1wCYdJQOHQOnG1vRtzwHp6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a30a9-25f1-4729-65da-08db34592f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 15:36:25.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIubmriKPiHkp0P0V7Jau/G5iDzHJWuQPCzFOwQ13rSZWUOz0C0QErypcGdaiPJKnLUc6cB47to6m7q2CC0IvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> > Transport vq for legacy MMR purpose seems fine with its latency and DMA
> overheads.
> > Your question was about "scalability".
> > After your latest response, I am unclear what "scalability" means.
> > Do you mean saving the register space in the PCI device?
>=20
> yes that's how you used scalability in the past.
>
Ok. I am aligned.
=20
> > If yes, than, no for legacy guests for scalability it is not required, =
because the
> legacy register is subset of 1.x.
>=20
> Weird.  what does guest being legacy have to do with a wish to save regis=
ters
> on the host hardware?=20
Because legacy has subset of the registers of 1.x. So no new registers addi=
tional expected on legacy side.

> You don't have so many legacy guests as modern
> guests? Why?
>=20
This isn't true.

There is a trade-off, upto certain N, MMR based register access is fine.
This is because 1.x is exposing super set of registers of legacy.
Beyond a certain point device will have difficulty in doing MMR for legacy =
and 1.x.
At that point, legacy over tvq can be better scale but with lot higher late=
ncy order of magnitude higher compare to MMR.
If tvq being the only transport for these registers access, it would hurt a=
t lower scale too, due the primary nature of non_register access.
And scale is relative from device to device.

> >
> > > > > And presumably it can all be done in firmware ...
> > > > > Is there actual hardware that can't implement transport vq but
> > > > > is going to implement the mmr spec?
> > > > >
> > > > Nvidia and Marvell DPUs implement MMR spec.
> > >
> > > Hmm implement it in what sense exactly?
> > >
> > Do not follow the question.
> > The proposed series will be implemented as PCI SR-IOV devices using MMR
> spec.
> >
> > > > Transport VQ has very high latency and DMA overheads for 2 to 4
> > > > bytes
> > > read/write.
> > >
> > > How many of these 2 byte accesses trigger from a typical guest?
> > >
> > Mostly during the VM boot time. 20 to 40 registers read write access.
>=20
> That is not a lot! How long does a DMA operation take then?
>=20
> > > > And before discussing "why not that approach", lets finish
> > > > reviewing "this
> > > approach" first.
> > >
> > > That's a weird way to put it. We don't want so many ways to do
> > > legacy if we can help it.
> > Sure, so lets finish the review of current proposal details.
> > At the moment
> > a. I don't see any visible gain of transport VQ other than device reset=
 part I
> explained.
>=20
> For example, we do not need a new range of device IDs and existing driver=
s can
> bind on the host.
>
So, unlikely due to already discussed limitation of feature negotiation.
Existing transitional driver would also look for an IOBAR being second limi=
tation.

> > b. it can be a way with high latency, DMA overheads on the virtqueue fo=
r
> read/writes for small access.
>=20
> numbers?
It depends on the implementation, but at minimum, writes and reads can pay =
order of magnitude higher in 10 msec range.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

