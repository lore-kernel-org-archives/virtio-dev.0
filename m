Return-Path: <virtio-dev-return-12972-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD922EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:11:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 07E38157EF3
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:11:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 000119865CF
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:11:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E595D9863A9; Mon, 19 Jun 2023 17:11:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3A6C9863BD;
	Mon, 19 Jun 2023 17:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIq59l0EIhbqnfmnby6dj2OGP98oDYMp+2rVOr6ncY/7oQnPHc2xCt/56PpFCiNpXyCs2kH9B1yw9T+ahZKrb/PUDjGUHrH8GcP5286wRSzTJuFnXuiszmsf9NRmvv790jTUBbL3puD8+vytebIvyM9cDagi/5pyaOstKENSZPELXmHWHnQ7zn5LNZha/8t3qqmG+kzjrS10G+kJe4Dkqt+Rt4oRciX0T2BSpezJdczFtRNnwgjQXdWxNZbphVDf6kQpKJtMNHnSi+HGy++BAcVYU1w/H2AyFX4R6V+gY2DOwniVrM+OhXddL6TCaJq8U7xk/2w1EDu4A0lTkPvhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO8t3S9wHF3gjFmG08Q4qgSZ2k4bpqoTgZ7PgU9JDe0=;
 b=PXSKwdnl98+bXVtcbNqbe7unLkJp9yJuPuXsjCsWXnUGnf/cw2YoeOocNm3xFzDVH4Cbg/Ilmr6VDe+IsnSXzCLMRHdj7VLVZ1WNAnhlY+5mPHzj7QzF3jZ0vieBBw4Cmd+DC/w+ghryzOCvb67Gv1hstTHmTUq7Nf7Y3LhfQoHvVserNyxO+6i7HOMFaaNfZzaOw1ft0IvrQwz1POLYDkG8EXqD/nJ0r91M1qXKbP3lFFViZ3z/3HfQY3hBQgrJ7sWiY0sMoxBcj2c0agWTBbGLxbkzDnyi9sDMJ6bPU4EHaG7Y7WToEO79VG7eV/t/TVWI3sJt5hTzzyLxLBKn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SY/mAgAAAj+A=
Date: Mon, 19 Jun 2023 17:11:19 +0000
Message-ID:
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619124042-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7816:EE_
x-ms-office365-filtering-correlation-id: c2d29055-182a-40dc-faf8-08db70e83345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MJDndd2ekriYCW2xUhZ+FlaQBemixLWwo6iu8h1owpmGLVlLhRHMA60/5oFS34M3J0L45c1ubFoGgQj8eRHz3VKzhcBlqPi7w+FUMPO0V1d9EWWuBkjP/KDXXeNBYBpMWdK04OFzNicfU+J1ndbvdFB2AM+p4N0gepnL0K59lyxP1krQAghRu+G1kfYpU2kdiOItAru5apiSam2T39S+aFtqITCynI0r+FbQ+xBaMl8ibvjj2/TPJy4unEegWIiJvmSMx47qcKThZHRNZxm69xJd0x3wYqgaXfGYcv9Xyol+UESNAxyh3UILVFbI4jG46C2XWNBlomn7H5s8g4C/CVR52zLQ/6ZZSWWGYPllUwj3nlaNwn/xmNgsZk/YU0anuNk7G+wTH9Ne12CZLJ7Uix8UsfhlCzW3Vx6wjQIQTfcoiy8fYBj8CHS/eveVIjvuBab+nwbrP9knYVb7vky/7BavI4SFxQYmPw6/PZQ+6Z7Da/C+mtorkFeX7SUkISd5+IEvMwhmIJ0FfhUqGR07WNkTFq7ctA9I8bpnpBVCY+lhRxYuWNLZDh56/fZQsJ//EVgNC8mIUNB/9V8/eTnKgYkTYrcXh8NiQ8byGANGNZzbeuJJ4LjnPWRhI9jeO4ff
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(83380400001)(7696005)(54906003)(38100700002)(316002)(8676002)(8936002)(6506007)(9686003)(86362001)(26005)(4326008)(33656002)(186003)(41300700001)(5660300002)(52536014)(66446008)(66946007)(6916009)(64756008)(76116006)(66556008)(66476007)(122000001)(107886003)(55016003)(38070700005)(71200400001)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r4Ntz5E9GSH2ftPfuY7avdgDIecI9xXlhsTwqyLFNTEvcShjdgl8gtmBwTHd?=
 =?us-ascii?Q?R48mu3Z8X8fprjS9eJn6H9WksMPp5N1D+cMKSv/TNjyPPQ7nFhK6hHpC2vmO?=
 =?us-ascii?Q?Aup3Nm76mBwleit0QFMAP7v/XY8MXQ7DTUrrobt+HRAPC1etzN7yBlgtS/vN?=
 =?us-ascii?Q?qRnoXFslUoKmGT7lKWNA6yexH0q5/mY6UOnYcG4Q1guNu5HjvGReLVNawejG?=
 =?us-ascii?Q?5LewPcbAmLQEAi/D/TSp9gI3SgaiCe/YU36NRk8ux4248+97tQUZWrRQ5VW5?=
 =?us-ascii?Q?jtp1eg+KwaeUWcIgG1RMFLl8iHmNWK28KdJDM+AaAb5bNB6lPwL1PouyVcLH?=
 =?us-ascii?Q?X6uLhxyfASnIftmza9x0B1/i2c+HDjSbkhR9lWcf6s1j7aOFzHJYUMe7P/Fj?=
 =?us-ascii?Q?VZQEccdJiKSoLQSNIIRLvxsTthJjhjGClqv7BT2h0oSkn9Z5sOI7rOIBjDU+?=
 =?us-ascii?Q?ilhkHoto3r5GRvOYrwtIhwFBWlXMkL2KbHf8/7TZRAkfSn+LQivearAi4cNf?=
 =?us-ascii?Q?XUzIsmdHNAdrtu0sRkFu5ohnwsmglBZYmuhBm5H0awPKQQZ1KEFo/FOwk58q?=
 =?us-ascii?Q?EWGxmGS/ETHndEOzwe06Qqpon5kDij5MUSbY/d3fpPgpY7k1QJhdldevZyrA?=
 =?us-ascii?Q?BnfW5HhEnk5C08W3HoD+FFIh9P5CKc8N2mE/ccYWaVA4jeLjkQSRsz+R6eA/?=
 =?us-ascii?Q?qv9A1/bziNdyBiKA7Z9Go0FtERyQBJRDE3yCB/Ub4pQODQhKlVh9ZiyR901q?=
 =?us-ascii?Q?eqP7HOhHkSNWtxluYCTAEOeLwrJNEAFb0PZLtXwbTMn/pD6ux5XSgJ9WGGBn?=
 =?us-ascii?Q?/gIvfgiUZk/Vuk6c03NMKXr3C6JVwmRknH2OpiFzsiTyTL9OLKjU01JgJmV3?=
 =?us-ascii?Q?wpANa1RAMoOcL6i1RPPQCNZS/rVzUnuQvtrHkQPsKLuPmPGJiliOGQUW+Btp?=
 =?us-ascii?Q?Btkg2ma9gbSeKt2RUTtDxwzhpSKVxH9cTmnrZuu+1y+gstH6gWU1u0SzH8aY?=
 =?us-ascii?Q?4xynm3NBmqkWGMaNc/4s+4e4zAXUynn1Mr3n0J+jFUkQrD375IoSr6QvpMGO?=
 =?us-ascii?Q?BNTPwcOiu4HALsxrrgYD4Ndff7e5BfLVSywhYWoNNFOuuVhJX7KLsap0MMSU?=
 =?us-ascii?Q?yV2Kd+Tl4dJwZ2R5aDuSVD8EShTLa9atou0d/zrAyyqpaX4jMa5dRXgRYWcS?=
 =?us-ascii?Q?jzQS3KefdEq2CWAz++s0XoklH44xNsIgfRNYiJjbgPLo/iSxxZ2UVPZybUQV?=
 =?us-ascii?Q?HDl65eAPZl3SVl/+6lXLBu3Z45LebTjKbydcCbdDjxMmUH06xr5tZfuJ/vp6?=
 =?us-ascii?Q?N/n72gfmKWfcWIgAqS13H99JWiLztTHdd3ujA/TncIHBVPVnm7KxhgtJbIiy?=
 =?us-ascii?Q?TImO5WcN2aqO5Rb6JiVuwrmUwLA/GTYFqOs35qaL40vY2bqWFwFUSsMcj9XJ?=
 =?us-ascii?Q?qCR87hh6rW0R7jHoV/vMIpdL1tcdquoo5ooxJ/bwNjhQKKzl6Q5y0rvjG1dx?=
 =?us-ascii?Q?/5sb1UTxQnuShmoO5PDVBYFbepmtMU69c0BeNsNgBTqtDlPWkxnAF61l0wEr?=
 =?us-ascii?Q?yDHtd7RlTrnVyuFMv0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d29055-182a-40dc-faf8-08db70e83345
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:11:19.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLWKIlz0JoxuELVr71tknskPgcvuhfsnd6aYiGJ0xlpYVrP6uzYNvUE2PgFzGvzO66ljD+bYqe1uP48/1XEDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
Subject: RE: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Monday, June 19, 2023 1:04 PM

> On Tue, Jun 13, 2023 at 08:30:15PM +0300, Parav Pandit wrote:
> > +Even though virtqueue driver notifications can be communicated
> > +through administration virtqueue, if the group member device support
> > +such notifications using a memory-mapped operation, such driver
> > +notifications are sent using a group member device defined notificatio=
n
> region.
>=20
> I still feel we should support sending notifications to owner at least op=
tionally.
> For example:
>
Let's not please keep discussing this yet again.
I won't be able to.
We have captured this alternative already in the cover letter in the altern=
atives section.

This optional capability can be added when there is a _real_ implementation=
 by some hw.
=20
>=20
> \begin{lstlisting}
> struct virtio_pci_owner_legacy_notify_cap {
>         struct virtio_pci_cap cap;
>         le32 notify_off_multiplier; /* Multiplier for member id. */ }; \e=
nd{lstlisting}
>=20
> \field{notify_off_multiplier} is combined with the \field{member id} to d=
erive
> an address within a BAR.
>=20
> \begin{lstlisting}
>         cap.offset + member_id * notify_off_multiplier \end{lstlisting}
>=20
>=20
>=20
> We also need, as part of theory of operation, text that reads something l=
ike
> "accessing the member device legacy interface using one of XYZ commands h=
as
> the same effect as accessing it using the legacy interface".
>=20
Ack. I will add this.

>=20
>=20
> Also, do all VFs support legacy interface with these commands or none at =
all?
>
Right.
=20
>=20
> Also these devices will use non-transitional ID but they in fact do have =
a legacy
> interface so using this definition they are transitional devices. Maybe w=
e need
> to add when we describe the device ID text like "non transitional devices=
 and
> transitional devices utilizing commands XYZ" ...?

Transitional device has specific meaning, I am not sure we should muddy it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

