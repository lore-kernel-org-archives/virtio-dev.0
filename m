Return-Path: <virtio-dev-return-13021-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4272EB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE5A9171D1C
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA5DC986855
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:06:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A0DA59865D4; Wed, 21 Jun 2023 20:06:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 221AC9865CF;
	Wed, 21 Jun 2023 20:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5K1liXIR8crzqAlcGbXOMQvs1rWgQSfHno+3M6U5A1R42BLHTFUrsfWS+R1mhj7MJaTncBdT5KnKPszqbwX6jZsfQzk5300kYhbBWvYSjI3icCYNbS0e1cZvcWyG9j3g0zv/3N2bxvcAfPU+hFjvCaGhjL2hSu88XfgwWhQ+TnUffKcRGFzCrq8IqKuhKCFKFvyJ8O7JSct9uKK3IojeNdim1Kco3gVBd9eyXE9eQOCg/NWzBdFy78QHkyITeQywPCmDJIZ75VympAYTMyo3prylzRsdyPyDs1JBaiqRbOd8Iz7hLGfaXh37ceewGfUh/OA3ku/bpCUKajFsBhlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH6BQwJNoLgacnGGw3ERbVHkpY2ylpVQkGxk7rtCBgs=;
 b=L8+WlaE/MoGWCgh1+agaVUV0QwBoCO8Sfd5EQb0ZjxSFhE6P3xhDeSfsnw6a1axbNH7JUT45/rKyI8C7t/ScrzNfAOOkqCHzO6blw4IDBos2zQrDESzvLZdtO9nOiBFZt65BLLLE4lytHXa1y8L8fCUS4K6jmUCsRSPlT98UcoXVlq7VkJ7xuEWz2nXggwnayswBYKrhoWjQ+tHUja2AxC+TDaLolJaa0fI4bF0ljRdtfPxKcBp7v7DL1DQl0fBfdjKJgHW4eAoVZk9KBdaoMLaO7dQNZmOnc+Vpkd3onvg7+ySbaPbdeCkg9PJwpixHHsRidMfLD9LM7PuqM0VnKQ==
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
Thread-Topic: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABE6AgAAA1fCAAVC94IABrvFggAACRgCAAABYYIAAPwkAgAADZRA=
Date: Wed, 21 Jun 2023 20:04:22 +0000
Message-ID:
 <PH0PR12MB5481485BA45249130E309EE7DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621115131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F5232331A63C138F8754DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621153559-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621153559-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: c69ffdba-6c39-4b62-c0e6-08db7292b472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ciO+b8OHvOtwTafB2odkq+ViVatfwR+UAopTInfwQocdH2F3a5rm7MN6sr1/kGHtNZG3TWwy71DUz4XA90QiYQ9RQDKB8gnl7xByud7gGIa4iP2ZQyd2Iu+PCwbdOGc2ZRV6aoz+mS/cGwhwng9fU3SoRD+vdQZfkqMUalOkbpoXPU6mA/yd2es+SkdibQT21tEdci2LNb59/68lPaOu1noSckQxPu/EGJefN++R4IXcf8yjuJ9KP7vvtexNrF973rVMy6+ybR2tE81E9dswPfqEqoTEjVn83nGbWfrPg0APXONNajsCxD/LwcTjTl9KUw7OQGJ9+LfF2KzGAVG3rxb9GjwnL8z6+lWIduZFlZfMpSjS8xwrOAfW7lQA3fy+NB6wnqINSU8AtN4ToGMjX5zYRIbOSyqICU5uUcgaBBDfQ2T2jYZa3l4VJr+eJMMsK9cYE4QIYEHMnk0YdG8hqddPQ0oZK719d1Zq23IGCzXAk77T6OYBcvyUpU/Fn0YnfDv5p/Kjck1SMBfQFvcybHO6FqHcCBJCq8oVff/dUVFgLJ9fa8z7XNqBzHMY9wHVumyQDRa+eAp+IWMgD/dCjBJ0CN9OgS4Z1KpMCaMhSYQu3nCpMsoFd5XfdoZXaQpHgxAbRQ5wn6PvjktFtGv9H/P8bQGcH89SX8uje5LenRoIbSYnuQCMpoOWfAY/k0N/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(4326008)(107886003)(2906002)(478600001)(38070700005)(54906003)(86362001)(7696005)(38100700002)(71200400001)(122000001)(966005)(41300700001)(83380400001)(316002)(33656002)(76116006)(6916009)(66946007)(66556008)(66476007)(66446008)(64756008)(55016003)(8676002)(8936002)(6506007)(186003)(52536014)(5660300002)(66899021)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KE/5YAQn6JR6v0dI6NTP0E8C0nxyYNLG0yuqD2iSWZsyKND3T2e8VX2PejIz?=
 =?us-ascii?Q?b7jeExaNh6D524PRdHCERzssUCsBfRNF0I2f7j6sDnWPmY1mPSjDpk0vV5J2?=
 =?us-ascii?Q?eWVvDfuV1lpKm/Fjw30ZT5AmkKLjFrTycNA0o9RykKyiNES33Xoc4Zd7ddiP?=
 =?us-ascii?Q?guK0n0aXZNHH7YC/o1DhmzQULF/q+mM+mn9ZT5gn3+LAyOV/clj6vkT1GcLs?=
 =?us-ascii?Q?S0UcW1veG9UdethV2iIvQHAP8TB8Row71iXh5azo2T+feOOnd9Iov7nqE8Aj?=
 =?us-ascii?Q?6xZKGTUOwgrDymMv5+jZhlqPLzo5XUxsI/zBAaHdzrjTkcE3otVCHC89ieh+?=
 =?us-ascii?Q?xmmUetyjNyAMfp5KWBt3S3kWyWPSe+APwuhdImkD/Fz6U8RT/M9it8+o/Vr9?=
 =?us-ascii?Q?MDqSncpexcjLUYavLmyn6GwbbxfNW73nYWdvO9NIBGgdbZIh/6pwgBH6wLHg?=
 =?us-ascii?Q?p1V91Q8vLqjAEA9WWPTgjb4OUUHxQenmNa9UpvP3j3CgS7kBjKyyATm+OCSb?=
 =?us-ascii?Q?oExRsiNubhKewC8NCum2zjFOKyGmb+9VG5XxEz/nkKnQf7210DhsQb1PbeRQ?=
 =?us-ascii?Q?i1YQClM4kFrUyRKugKC7CvWisHpeP8FkM6n3/a/U/6FMOCEYMsa1K7hkUgxw?=
 =?us-ascii?Q?vpPwAhEuYIgJxrnDbVLMRwBtcpt2BM4nkLBnwCuJJizd9JM0egkwF2Vf3/kY?=
 =?us-ascii?Q?z6NVlBGszxKOK7eYKozxIMdx9hHVfnZhzy2xbxACevYMt+5tCoBeaAn0QnOR?=
 =?us-ascii?Q?xEII46Q9iiKjtFxYyLeiAcOL3VIViCc8gHy8iO3I1Npa+g0i8zoLBeILVmQK?=
 =?us-ascii?Q?v7XYOMuQf1Y5iQRdjsIysAxosRN1aflsYDDyk/yjL2I5U4MaqEnHKd/MqZqE?=
 =?us-ascii?Q?tX7QlrwfDviEqXnXTErWAyDSd62IC0LReouGpYJrEo0uh2CucexefbBQBzNP?=
 =?us-ascii?Q?NHvo5KeUHGGUF+W/3cNRLPYoLgmDuR3Eh+DwAUB0ByJQfkoS9K/3g2lJ33f5?=
 =?us-ascii?Q?ivzfioI+3m+sELMBI5znquRKLX6hE7POwimMERiKIWj+aAkpZtpe1p7N+ZO1?=
 =?us-ascii?Q?tfTPUtugjzlsvUIWDm//gdW+KfD91LrTU0lMyOEyWz57R2gcUr95feT2fNOH?=
 =?us-ascii?Q?qCG159gUN6NHEijpz5q8JAiUeA80Sd0tCR869KfK6ICJ3w/2JMtI1/VW2lrp?=
 =?us-ascii?Q?w3eqK8GNVHGJdfUm2ILv5sSxQvhcRrw321JNY01IDd18getGX7lVIHkItIvr?=
 =?us-ascii?Q?lG2eYBYUqHXo+SIksL7Gi9K8SoGYQqIg7UtDJ2kBjRh7bmeFHthdvmxePq3t?=
 =?us-ascii?Q?XeKiB0EikO4bEw5C3uc4pZYx6xs6QQFlWOKZ0LzBwCUU7KZv6qS9kJl9toxT?=
 =?us-ascii?Q?le+K4tODh9bPNQbnQ3D8IqnJkuLVHJUOThVdxRT992RYmnloEkISj9f0MgMy?=
 =?us-ascii?Q?Az+CP33EhujCJ4hFqrgMlur4G1MD/KoqhX4mGVDpAXNQXsh17OqnyxQ77KAa?=
 =?us-ascii?Q?TStAFXpnjlZVuUrSXAhAFhZjyr7mW80Xthm5rKfdd169ic52qHOAhX36A8JE?=
 =?us-ascii?Q?q8r2ZGb82yk75e6X9oBwB/0AAx155Pb9Dh5HR8B3xD4d9k3zK9ElfmvvGcsc?=
 =?us-ascii?Q?o+VG6RMAoZQZ8D0fkDV8edA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69ffdba-6c39-4b62-c0e6-08db7292b472
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:04:22.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9d4IiX2Eo+CISTLbjTx5DRKlvffQKlBLXd0NSK0tkj/AEj5NTkx1GDe72jS5ybuWFsCB3sicvLs0GKFTpP5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 3:43 PM
>=20
> On Wed, Jun 21, 2023 at 04:01:00PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, June 21, 2023 11:56 AM
> >
> > > Not like v3 please. If you want to re-open this:
> > >
> > >
> > > First I think we need multiple offsets just like notification
> > > capaiblity, sorted by priority. Second I think we need ability to
> > > report offset within owner not member.
> > >
> > > So please add ability to report multiple offsets, and add e.g.
> > > a flags field, with bits for owner, member.
> >
> > What are these multiple offsets for?
>=20
> Different BARs.  For example, IO versus memory. Yes I know VFs don't supp=
ort
> IO but PFs do. prefetch vs non-prefetch might matter too (non-prefetch is
> mostly limited to 32 bit).
>
BAR type and its prefetch attributes are told by the PCI anyway so no dupli=
cation here anyway.
For owner and member I get it.=20
>=20
> > Do you mean two offsets? One for owner and one for member?
> > Both bits are optional. Do you agree?
>=20
> I agree that everything should be optional sure. Let's not limit it to tw=
o though.
> There could be multiple BARs or whatever. We have ability to pass buffers=
 of
> arbitrary length and device reports the length.
> Maybe have a SHOULD recommending not more than 10 of these (1 for each
> possible PCI BAR one for each possible VF BAR).
>=20
> This is to match the functionality that notification capability has.
>=20
A device can expose multiple offsets within the single bar to a count of 10=
0 entries;
Also allowed in the notification capability.
(I don't see why any sane device would do that anyway)

So I will avoid such extra restrictions and limit the scope of this patch t=
o be minimal to have arbitrary number of BAR entries limited by the command=
 result length.

>=20
>=20
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and to
> > minimize spam in the list archive, subscription is required before
> > posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License:
> > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines:
> > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

