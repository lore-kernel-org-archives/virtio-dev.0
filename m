Return-Path: <virtio-dev-return-13472-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB5C00528
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 12:50:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3CCA433564
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 12:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BC219868CA
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 12:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 072379866E1; Fri,  4 Aug 2023 12:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C19C9866DF;
	Fri,  4 Aug 2023 12:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP0KwyJj2b1iQ5Bnn6tnlsOZL102xT26Z8y1NQ04CbBO+l+Wgyds4nr+k0sRLnCcPy5RNuWHSxs6tEE5+V5NZLpu/l8KoGtHPGBu3TWsIQJktB/WM4GkWivNBluiB8wbUsoxr8uL8gTqZGuKlsbqAmSqp/7dXdDDdtkzM0dKH2csWqEkxdHB1saqFIksImJDNqEXGBP2I9fHgrKjeh+VDGEWlIFhaDHPUfhZBp2u0DxtULcvr4knqAPaX9U+PwqJLyMVNSaVjMl6XDqph18c9xDgPQKa83gqtILLhdrr1BgMHYPxLSZd0wxzZLKfanAxHyuL0qkK7qpBo4/8ExHKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wzMvo6ermtKfYkWE4OxhTskWACNIMv4GhSGA1EAjQ8=;
 b=G57jUqyJWwIcPgRCW2hk5m1+WZmyw1641ibwxEVbg8sxwU3TWi8QMz30OShGbrWQuJR+L+LJsuyyGgvvLAfycGHlNvPJJHHJfNMxER43sg8N0u7FICpDqvZrmfOK1XeOYTlbOQZ4tH/nMjgwFTbI0pvitaWqKE3AQ/M5tLFWfDvU+xCaWGMc2ThGQNyFXAPGpxwBSKxVrfG931ut5Xqo0S13ljnW0NQ7+Qg+5xKpVtjzqaEAIOo+jaKlolC/UbsvuG+Q6S3uKudx+IELOukSasFkJykToN5QASxbkKULCtCqF5hX39G0T84do2dakx90EqR/tDEQnoE+ist+6MUaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIA==
Date: Fri, 4 Aug 2023 12:49:04 +0000
Message-ID:
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230804053958-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7471:EE_
x-ms-office365-filtering-correlation-id: d7cb233e-92ca-4f1b-7311-08db94e92f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UmAy/CakRLo6JZkgI/d+wMnjfnorgBenb7FfgkXtTkAIs5nmxSRAHD1bjgojX+updexR9xgnUyqeb0JCYcIVWBAH3QPIhY/9wPTApoexYcKryu6KOfOxJuhlMIbHbFm3yBmN9bHuoiyWgKaveRj0gljpotkapkYF3WbhYZWLn6OnLUaDC9MJXm7OkuImaxV151ysPQXd9075ENJCFyTn5NpA02ABpUqcYXSHyxp4fWRIyJW0SDyiWy4sS4C2wwUN4i2T/CkUV5RHnLgUPVv6tkhVXgPHZz3y3gGOCI6Wi4Xr4UHk0ur34UUaKg4kH7O420TcxfoMiDtOGudVARZZJVf4Pyup2ieC8ryO5nMl+JyGikI6eOtGhTf3fBAW002V4yAtujNEmQc+Wv7yVpMlYsw7e2AM4RRESla5UYiXQWblc5Dr4zXjjMCr5vZRIpaM4N41QPtMBjSFS7Wlh2p6G/SoJjn9oNVzTQoAQLL6g/8+rQBiDwCqXIGU4U7D03v3MecyZ7uUEcsvmemLSfX0GsbfeG4q3iMurhon+KyJD9aCIpz2np1AfD+AdkfQUim1J8kid1mZiOGWrhhm5/k7Dxu5x00Mv2+PCkRkbJdH3z5iQo1teRiFoTnDqFleH4xs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(83380400001)(26005)(6506007)(8676002)(9686003)(76116006)(316002)(66556008)(2906002)(5660300002)(66946007)(64756008)(66476007)(66446008)(4326008)(41300700001)(8936002)(7696005)(71200400001)(52536014)(54906003)(478600001)(110136005)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RHMBp19QU/qJebWQH/7c2rT59xZuVpN1d7JB8lGpl9xfQC/Ua6FSow2hvSJU?=
 =?us-ascii?Q?7G4vH2um2/IMzBahjvYCo0UPBAHKbhErg3YhdK6iVQ77T6hs4wH+cySdDEXf?=
 =?us-ascii?Q?9JqWikK4uDPvb7VY+t23NrJLftSRtL4lF1g0zVbnAbtfuRXVJsZcULk2QUGA?=
 =?us-ascii?Q?RX3ZzNDtqZSDPNaGB3cozo1lgGhrcsBUxY3IH5GXRI6YBuLUZgz92d3ZiL54?=
 =?us-ascii?Q?b58OpiiUEXiA3plGp7jEDSrmsN2tpTFncc3YrSDq41/TxtParaTpA/rMh609?=
 =?us-ascii?Q?PUQzXRB8Od5HfrdXPUtry/H7Sg0pf6JW8aZ4m4NpZtCuhy3w5KK63x8RQ0fN?=
 =?us-ascii?Q?2TiWVVGlTj2Ma4nJtVy/vWWdOlWQ9sy6y0KanYM2s6aPTWNZPFX7NiN+8i1c?=
 =?us-ascii?Q?yjINByqwprkyhOoM9WZ0aWDFAwXtrk1yBBSZ0541vJeCYjVYj/YPuKctV66O?=
 =?us-ascii?Q?BItZF6BhaYMASgeBzUlXrKiM7i1ntAXQaMRRzVYG/lJuQZ9pLqYgUIvRzEO2?=
 =?us-ascii?Q?HeIxYHHBbpamM2LBloN1RFCbZGM3txQxzRBRe+poxjbW+IUpB0HkF6PPbFbX?=
 =?us-ascii?Q?Lqnyj9FKhfxHyaRr8DUPmAN4ZWQb0ONmRDieAuRYoAYFLcYKldJec7O52KMN?=
 =?us-ascii?Q?YcEmmZXEqNlExff633pQFxWZtC+yk8EZxbk/DY/QWXOIIb8PV9Om4XRcNojf?=
 =?us-ascii?Q?JMlzbEi0xispWgBOh5a7P0ZyV/BMcE4ThVwH7KZ6ha4ElqduiekAOCQkFMwd?=
 =?us-ascii?Q?EgK3Sl+2kgQPFceNIBvP0qGV2nCt7AZC9W4W2uUwUyeb+yAeJTjl//jqIvxC?=
 =?us-ascii?Q?tUsuAZmXKj29iejwy6Ia1fVOfUlOaH8Wjnn7he+kKVx1zu2qMniJRI0y9c2s?=
 =?us-ascii?Q?6CkO+RIlAT1YH2PbjCtsP3AfIxXDT/EkEkuhf1ZtlsEXLFVQ8peM9+WT/5pG?=
 =?us-ascii?Q?/YpVTMW9In6dIi57uTawjYasnnpygTjY1bWWmIPBY6D5KfAff1Q48tbfE84L?=
 =?us-ascii?Q?4yQOBCJbmwC2YFybjcF5rB/ufqqPFKLDxeRknROO3iAJC7HGiol9VogJeT3F?=
 =?us-ascii?Q?nuH9insJeSq+E6zHtxDPC8L5WmJ2IRGTfGTOprlZX7P+K4OAhcSdCE+lgzAS?=
 =?us-ascii?Q?FgVnD5CShEjMvNgQ+rvFj+TXqMFMIB/tSNAGQXqxVLVI61/+oHFgDVpp0rVl?=
 =?us-ascii?Q?wVd9dyO3H1SlUkoiPlXB0IgozFTP/2TJneOX+kfoKBjgo3kRdyHUHjy96wIW?=
 =?us-ascii?Q?SPzzPTr2J1PYUIzEpLKvqtHYMOc5EYP9O94PS9gyjBxRsuuaMY98l+2/cumF?=
 =?us-ascii?Q?FGxdHaKXphA6wtSZKvqD+ZOwqPVNY85pSkycjU2XvTQ43Ash0WGxfZhhaRTK?=
 =?us-ascii?Q?cYRhIXStGZRWeLsTbaoOXgJMbZ1Ou1ie+4oDyRyPhWNqJZTJecztCs09VxRS?=
 =?us-ascii?Q?qiaNo4/qFfNUrmvQCUditFzVTzdJyH7VjLDTa3T/XhRHnl+8YU4i3pvoDfCm?=
 =?us-ascii?Q?dbRPMk9fFaFyp3gewDqD42hzPwMAJwia78yFkx7vi7gohFcztnM+Ze6+x9Ay?=
 =?us-ascii?Q?enGWOmZFvTfpeuO9NHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cb233e-92ca-4f1b-7311-08db94e92f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 12:49:04.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FNGi6eGrWF91JEAr9lC9uFNiDsGtA2vMxeJismGYmgfjG5GVGs2gluqdrQQj+qgzpz/6LvSXw+zexYOGfNSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
Subject: [virtio-dev] RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, August 4, 2023 4:03 PM

> > >
> > > At this point to have port for owner device requires creating a dedic=
ated
> switching object, to be located sometimes side by side inside the owner,
> sometimes outside.
> > > All of these cases to be crafted, please rethink if this is _really_ =
needed as
> virtio object or not.
> >

> >
> > YES.
> >
> > We can hear others.
> >
> > @Jason @Michael
> >
> >
> > Thanks
>=20
>=20
> This is so abstract, hard to have any position as I'm not sure what we ar=
e
> discussing. If some virtio devices have an integrated switch then ability=
 to
> control the switch through virtio seems useful.
>
True, for us, at this point we do not have plan to expose virtio switch dev=
ice because users are not blocked on it.

> Re:queues - it's not by chance that we have multiple admin queues.
> So driver can dedicate one queue to filtering commands if that's felt to =
be
> important.
>=20
Admin queue currently do not send non admin command of the device.
Would you propose admin queue for something else also for rtc or console or=
 cryto device and indicate its role so device can understand what is coming=
 to it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

