Return-Path: <virtio-dev-return-13619-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24BBC83F3E
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:52:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EE5AB66DCC
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:52:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0A019865D8
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:52:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D3B07986596; Tue,  5 Sep 2023 06:52:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2560986410;
	Tue,  5 Sep 2023 06:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9FWLoOw2OyINgozjGopa0CUHVHuPBeCd9Vixq41jGoGMcvdSxMYT1WRXPdLOwd388dHdOc+2CD94A5eZdxoYCSE4hk1KFC4r/yXCIPJtxpP1c9S2tyKLL8WGSAoSHbh4pTq0ZHQxwECLIHBXu4/R5En3shA5cNtR5yl8L3T+7N12eP6HnD1ZiqS+9rYVkgAVuu366o72PdNMorg4kfivRT6mODwSgek+M+b8fQYHXftQ1rAPVqdpLHujqheO5KlA0JbNfCUcaKdrYRvje5S4XJTld565/b1o6WjPZMIvWucZ5Qq8QcXTe3AyBIhsKSZaIno06mT2rnkCFybhMrZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA/DkcK5ZSOjPDdpBiItazaZcI6STTRO8tnhHk6AkfU=;
 b=IwLN9+LE1zo+JM1BL7uDBvaAnFAuXt30FDkIvwHdX2xTJJMsVgEZ1nwsDE2FB70Fkn4Fv8KJOZTIfLTNX3ecu1hqwRQzks9o9+VIb9MFxXYAFTckB6VWp1NDFLQ4DCOECmUsn1eUDpwBL++Eudk3Qn/exbny4j/L/Ujt0IQR7PqR4r9plsGZidASqaC06mJeZG3ib6DKJkpmsERaSeLwkK59RzORB1wS94m9mwD0XkTRgy16/k5gVzrunv8HMtzDhd8bnfjAIic6OiUFUK5O8vBC9dlFd+9keYjJP3cAvsyKYZu/PVt+6vpThSkUVUvMo6aS1cT6QlKqIyYZ2VIEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Heng Qi
	<hengqi@linux.alibaba.com>
Thread-Topic: RE: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net:
 support device stats
Thread-Index:
 AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeCAAAy/gIAAGFyQgAAOWYCAABFEUIAA9qeAgAAI84CAADZYgIAAAkQA
Date: Tue, 5 Sep 2023 06:51:59 +0000
Message-ID:
 <PH0PR12MB5481AD3E8B95ED755FD8FA73DCE8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
 <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693882549.2640717-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548108B8FB8E60E9A9502C5BDCE8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693896141.8898118-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693896141.8898118-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB5465:EE_
x-ms-office365-filtering-correlation-id: 03c5a1d4-a2dd-4322-06e9-08dbaddc9a13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u775nPIrx87H7tu7q9LUF4UAcxf4t4cVu7CwAjXdTZVoehl70WXZzQm6tKXsB+WbRi7dddUI2V5Rbnln16ptT6chQyVslZf9wEZwWGl656oZn2dYXh6mSOI9TBspv5dw/3zuxAiOe4nSCNKhwX4b0ra48NHP3rZjP15kWZj5uhJAh/ttQ2LoLKPglP47KvzHyRb6cPNakdROGDdnoMawoq2YOffxoWgB91UDpqOxtaveq8rlGa+XszKEPmZ3UyqgO4PFenvHn17ZHq+Ih50ZqigPn5ReQ7nwqB8kwVIyLZQqTBs9GeutVvtTG2Pny50MXF6lMJ73MRR506nFZ1ryal1Oh4/Yog3uvWlnxe5Pza1hibfrQgvOtbGL6ZRXyu6jQO92sL0OtqMAMIIfm8sv8J1cGHIhmH9VITqF9VQlMbSeG6etNjF7vj+NpsS9k8iKprO0soH23mSa1LVtActY40Mu7bCwrS9Dor6MiY+KXww4lo+GuwQR9/HGxrU4wgBtEW3rv6Judz3jjkZUKOyPqFooNYIUT2zGE944i6FlhZM4AwlI+6ODnMQ01mJ5KHZN4vrxdKSoPkVbEhryZfc9hzffkjQ5gP+vwLHhpNGPWSbwWx5m6ilJ2+JYY6SWAjk6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(7696005)(9686003)(6506007)(478600001)(83380400001)(26005)(71200400001)(2906002)(316002)(6916009)(66556008)(76116006)(66446008)(66476007)(54906003)(64756008)(66946007)(4326008)(8676002)(41300700001)(8936002)(5660300002)(52536014)(86362001)(33656002)(122000001)(38100700002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VyDTrJdPBZ4TPIHgcCV7MKbpfZO2epXgR3isJjBZL5oxIWjlD5jxGB/f1LE8?=
 =?us-ascii?Q?HjYWeJ+CDLPvt3TPBzkiuv6QJ2F1MMACffPd+73Xv1TcqNiCQwugCKNEPvHb?=
 =?us-ascii?Q?wBO2J4HtxSJxLA4yKx6VZv53Pzj4wCWQAGhvgY/X3J/NRqMutRv72wj8jr9u?=
 =?us-ascii?Q?9StU/dmejs/c7WUtI3TYBI+tfJGI9x8Be6Tp35gP9kQcOKLEzOlnKud2/pNe?=
 =?us-ascii?Q?yACjYjq2oB5HZMfEbwhXC8r0lUL12LdcVrm9mQD/pXvnmJWNl4mLppsSrJGK?=
 =?us-ascii?Q?EoaiXod0VFfFLNfwXIMwD2ab4UYcvacEOfRWRvI5yodFif4IKTSGFil/QSyd?=
 =?us-ascii?Q?1ymAG1QMjPaHr5NE5Yq0RUG8uh2aDAy9U/ZOSaja3bgnDyPMYgO9/yw76RRs?=
 =?us-ascii?Q?KC+huDO7kUldgVIV2gMTwU/3bd4in7OwWWDE9zwg3mtEC1h3aBcmkL/stbXg?=
 =?us-ascii?Q?KQEjA5swOY6rGNJxzjGj8bSIkwxXIA2hcGpO95VNvpmq6NSBkPY4pPTMmqv3?=
 =?us-ascii?Q?i58x79Bx7skPKYIZqBE0es0Syhm1H7LwJBxkqLYpNqUcFHiXoaNOmNaSR2we?=
 =?us-ascii?Q?A5PnSSxbYc/UzTTuTM4GjvEL42bSKPtqb8o7emxkWaxC17jcTnyGNik82w0M?=
 =?us-ascii?Q?Q3jH1EvoQzD1LpSqXGSttq/pAjFxq2gX5pQjzegA3/H+hw3/bR+4D+sxbgyx?=
 =?us-ascii?Q?2jD8UbFNOBCaz5pnLtI4YXbtGmQ4RZVYbLBrD5QuVtD+AoH+nvqHvjuYxWdD?=
 =?us-ascii?Q?gMdKALAqWYZdnoF+EK8lfhkxtg5eJ65Q9RnHRNhXIIFp347IMvY8Dl4cXvPn?=
 =?us-ascii?Q?ghuVFp1Fl2OI8py0IMGYM608B29kUNlfMn5i5IoCNdrq0Rjs7q6e0bJoXYtb?=
 =?us-ascii?Q?/SGI8MsIxHA0RnqP98Z0Ehtn70gX56C9txwDibOUv3Q+SdfZruVpS47zk87a?=
 =?us-ascii?Q?hkysSMXarch5NO9ckOXIq0rQpfvmXrDkZxrRokdmLaM+OzaNp4Cx41pnaoey?=
 =?us-ascii?Q?Jnrtj2dfmTRlM9CTywK6vt4jeoX+sZ9DzbVsFImheoS+PPxbKcBRiicXsN58?=
 =?us-ascii?Q?0o4gQ3/cewvGx8GsOyWUX7N7wWAkzFUttRtS92Y0ZRrqUnQxbqoJ+fJBsb6n?=
 =?us-ascii?Q?+ffmqxGxlDpyOAg7asimEQ12wkZr+YuD4r5zNDkEnqJTYdvh3tKKRgNmxERn?=
 =?us-ascii?Q?pK6PAIMmjQiLkqdIbBVDBsdrdrVDWoTJ9xdnx6enyFgwI7nUIsagIFEmpxqv?=
 =?us-ascii?Q?CNeU3u7m2xXJ/FGb8WwwIIqCWxMRx33ZnziR2pelyOoeMjR29Dc2aQF6ow/A?=
 =?us-ascii?Q?fkDIM/OXglWJTq9tRSBJD3QMQC4CIoDAyRSnOu4tJQwAYTgFKNylkGUh5UXB?=
 =?us-ascii?Q?qQKKAJGqO+dmXYHPkp9kyYk+FEx5Er/FpKyob+B2e+/7JP9+pkz9jncqqKmP?=
 =?us-ascii?Q?Uu8RKTB4yaF1Y5IGizesa/Zhk3VHLap+T9TNm0ehkF2FgJwF5eUMK2f4v3TJ?=
 =?us-ascii?Q?P1bmi95WTF9ntwOA7ZdwQDiEjWVipZaeH8CyZYYTvCXP3u/ODfGa4FGC+P1S?=
 =?us-ascii?Q?BG/HvONtSbCs0f/gh1Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c5a1d4-a2dd-4322-06e9-08dbaddc9a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 06:51:59.2098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJUf+p2lUMeer+cFHIygW3IUI6u79N7w2mCFZu49wV3DSiggqdAJSAtZDsdxYGu8dq3ODMtTg1BBfNTQ+T83XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
Subject: RE: RE: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net:
 support device stats



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, September 5, 2023 12:12 PM
>=20
> On Tue, 5 Sep 2023 03:31:41 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Tuesday, September 5, 2023 8:26 AM
> >
> > > > Sure, it can avoid segmentation, but not at the cost of skipping mt=
u check.
> > > > For example, sender sends skb with gso with each segment of 9K,
> > > > and receiver
> > > has mtu of 1500, same skb without segmentation is not good.
> > > > Because gso_size should be same as 1500 to match the mtu.
> > >
> > > First, for me, I think the size of the each buffer specified by the
> > > desc is irrelated to the gso_size.
> > >
> > > And the receiver can set the gso_size to match the MTU.
> > >
> > > So the sender can send a gso packet with any segments, any gso_size.
> > > For the receiver, it receives a big packet, it copys to the driver
> > > with multple buffers, and sets the right gso_size.
> > >
> > > Is that right?
> >
> > Right.
> > By definition of GSO it is segmented.
> > Soi counters should be for the segmented.
> > And for special case of "Note", there should be separate counter to ind=
icate
> GSO was requested_but_not_done.
>=20
>=20
> I agree. So the new version should be:
>=20
> +\begin{description}
> +    \item [tx_gso_packets]
> +        The number of the GSO packets sent by the device.
> +
> +    \item [tx_gso_bytes]
> +        The bytes of the GSO packets sent by the device.
> +
> +    \item [tx_gso_segments]
> +        The number of segments cutted from GSO packets.
> +
> +    \item [tx_gso_segments_bytes]
> +        The bytes of segments cutted from GSO packets.
>=20
> +    \item [tx_gso_packets_nocut]
> +        The number of the GSO packets which are not cut into segments.
> +
> +    \item [tx_gso_bytes_nocut]
> +        The bytes of the GSO packets which are not cut into segments.
> +
> +\end{description}
>=20

Looks good. A text can be bit better than "cut, no cut".
May be something like,

The number of the GSO packets transmitted without segmentation...

s/nocut/noseg/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

