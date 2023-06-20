Return-Path: <virtio-dev-return-13000-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD13EB64D7
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 14:12:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A2C1F14E68D
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 14:12:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9921298650C
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 14:12:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C6D19863BD; Tue, 20 Jun 2023 14:12:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 736FD9863E1;
	Tue, 20 Jun 2023 14:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k86TSsAecHeQyZwnftrXczqjzlG0QuYaA84phzJdUJ7MNcXgyxMh2b+dUqKf4+wyu8dclft4r2bwkXQ8aajGFDSFtW21zh5/zRqVFXmx6Tua7cZzaBum9zmiO3gY2RxFfZlIEadRSnVgucXAr34Rolsz6jj6eaCtXGyOhoP5wMlokNQtHC6T7HWhwsYtw6hdPbkXn0MIkwN46TGWOdEHGgWUvW3Y6WI+clQySWiBtCkXnOwm90MRzPu4vMAW97njnMwJYWrLzc0BNjG3lBfn4ReAStHsXQAALyrej/dskdI5yZf1Rj2ObDJ0YrtrqEeA1+gSyamV+NVKnlEDmLjP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKXoB3Cg/s/QEu6eem9jIHsPz3HV1lACJDYojQc7Fe4=;
 b=YGDOZXBCbiE/386ie9fsIinCwYHWvse95wkACDtN+PHLbB7rn7CfZRKgO8CRf3eyC+uRqLy1sxUoRgqkPj24V226Kkf6Ty8ptP7NRaQrS2qUmeReSSvDZ9U6+coESgENbrAS/PQ3ISqLn9oEST68ykVBWwcj16mhD1toC/gXtVPlAjDMGdj4NoShZvM3NSgQ8tsh9MJvLZH0CkyNKG9AJkM6C8feXJrej9s3vV6YWKb1VWhM7LEI/8sFwN7eSoGzWXPiyf6vk+jylOiWmcE2lGxaz2FStDtOmNHkuBGt778ElIRhDwfIdk0bZc/HpW8I2BaSSehjmzqdN2uZpPBl9w==
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
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABE6AgAAA1fCAAVC94A==
Date: Tue, 20 Jun 2023 14:12:18 +0000
Message-ID:
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5225:EE_
x-ms-office365-filtering-correlation-id: 9e3f6ad5-faac-468d-1094-08db71985b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xxgOgflOlB+Mxacm1uxrkNtKNBPENys9sqQXp4McG6cXzTidSg/pufyvh+Gu1HQtfc9MD8U3WW9SQY2BAih2U3sI6LhtIM2zYNlvrU1wyzzdSvLYPvXXNeVytnunYOqFMNC13CGYkjALzKH2dbGu3Otq6PybmGMhlKtwcxEk7byTTw9kBGyXVHjV+SOLhN96QQJd+90J3pwLqwHcdH/C9JTcabidss9E9LhtLxu65XS1y2OLtJWRg8dTWpEZnOur//IXT9/Se4OQPxNh+4yC3Cz6IfmAdKNgkm23hDIrRo0kzxIQ2v0qYsdfAvq6HJSL7hYWraXUh63FqnrDlouAdX6l7TunEWf3AtRUFBlJAWsb4hi5jtr4+x3+LQprk9Un7J56IRwojhQRcqtEzOYPDfCJpZFKJ47TatxeTS/WptyTytxw9GS7CDhAK7zC/7s5pwKwDnbbMX6sviKoyCF2oXbuPhEbuFFWboCHPg0ENYBZEgewuCMujcR4GL1odQ9oVW6I3oHkkq5tbCD0Z0WL5/Kv1EMv6Xz6QqQpqfFqvnCGHkGeoK5LKdDcjVpMwaWbiI20OgxS8IeHn7Pa1To8GFaQ0fhD2qKiA6hiweKvuTo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(7696005)(4326008)(71200400001)(478600001)(54906003)(76116006)(26005)(6506007)(9686003)(107886003)(186003)(55016003)(2906002)(8676002)(41300700001)(38070700005)(66946007)(64756008)(66476007)(6916009)(66446008)(66556008)(8936002)(316002)(5660300002)(52536014)(33656002)(38100700002)(83380400001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tawo9vep2m3H4Gve4mxGiv6844i0hXT0/vBMCYZiC3X/hFoecYYKAwZem9rn?=
 =?us-ascii?Q?dgpuXJsd1PvIvM9AGMudDNz346VB20ph/X3sCi87jBYU0olYQcV6ruvB3BgH?=
 =?us-ascii?Q?D85Y0LM78pLqnExLEbrD/kNcllUpx1g4jc56hSXh77zwET2YsvVV3ZdMv/Jt?=
 =?us-ascii?Q?aQR6S6GZqTseQIuC3Ep/GHw1jEfDjv7IH9YRBNxvfEJ2Ultfq/0YAXtQ068e?=
 =?us-ascii?Q?sXN3sCjBnOQ/QZAp7MkZcCJJ8QQpHJED+0nkUhaqv+qsP6vRdndf5JNHHym2?=
 =?us-ascii?Q?xiAKQuXWhTBIWA5sgywgnuQvgrnqtKgDbf0qKL1H9s/lvsUsnSypfC9xWJN2?=
 =?us-ascii?Q?8zkC0qm/hgFZwP+N0Uk3itY+xxd1JS+0mHs3O5lfmDI1F1oxof9ngyH0Xcxa?=
 =?us-ascii?Q?43jvEysfa3OwHEVcax2r/ltJvMMFS9Vghu9C4ckLeTBfeVJelYbVegvDx5az?=
 =?us-ascii?Q?9wdH28E9FP86oXwjF9R9PUgnViX6b/wXCbLvL/2YTQckQrjjhQYSwANnIDVp?=
 =?us-ascii?Q?T1LIn6z9C988a10MsneObSF8XobkNPgxZoTCzlRKdk6cw7H/PKRNRG+QZu4a?=
 =?us-ascii?Q?xOIYpWgdQjK9/WNqeT13Z1coqWQ91iLMn1Ig5zIno6pYQ2nXSTjTWGng6fu4?=
 =?us-ascii?Q?rJv1213eoVXt+gqE9Jnb/BfKkxoJZOyz6mH4mt4a2SQzdupynPv0QsXxqnKt?=
 =?us-ascii?Q?T27N1umI4TXFk5WKqQ2Ky4YJXyF1v51rPyVBPc5u8l1MXL1EkG9KKWbVb/O0?=
 =?us-ascii?Q?2oINh8yhDx96M9Dr4U31WA+NPOazxEcpsFErYta78BaxrHHdR4IW1UW/UbUr?=
 =?us-ascii?Q?X9fbxwKgckD4+2JHJi6ykJ0dpWy8c6ORZj4orAFlwRxRF+0DTHwa71RmUr9V?=
 =?us-ascii?Q?D+V/08YdXVhzGk/qellSPhpvgEkeIhvFXUmtzEDV7QYRw0kNrubZ1DqxPJHo?=
 =?us-ascii?Q?3ZVBANMTvRArUkBz5VKNwJLi5vz+6nLYuoKgbkDRETa82Li7di8oRP9qJ3le?=
 =?us-ascii?Q?kW6YDumETX6Pd7/pC+bwscTXyTD8DC7BoGfbx26UnglQaI5OnmzpwniRffYL?=
 =?us-ascii?Q?rcfY6k+VmFe837ZqxouqpjdanIu8Ecz1icszE0k5a+R6GcHEvYM47sEy3Rvw?=
 =?us-ascii?Q?xle0N0UNM9q3o3rl/EhLXxe1NEKCEtGbygk8jB/A8rZOVWqQrywwbFjb88Y6?=
 =?us-ascii?Q?ow66DhwhMXeiuUnSigHO77M3K5Cl/nXk2ze0fuzL03SccWTl2sEfRVHgaFY+?=
 =?us-ascii?Q?wFD0LXeDUg/0n9vQ8Jx+0MTqak+MJ2/tiaH93S3ljPxO438+4sRV75pUiAlw?=
 =?us-ascii?Q?/Q8mSFGSlxNr+jo2h7kyvB2OhTLB3LiUm11WMz4s+jTYmuFddE7LrKdBbK4m?=
 =?us-ascii?Q?Mj9cKSniU6+DvJlWDCAsyP3dBZYMSH8psL7HGlNYXtohhVHmhRekH48cFZUv?=
 =?us-ascii?Q?4JbPjHYS4LaM3otLgQAG1LLE4QgJZZpmau2sXA1rD8uLQO0vJll38C8OAFp3?=
 =?us-ascii?Q?KmYp880qnvCr8JBpIX0y4HWAAY4mDlB55Uxl9030KdJebwUB50OcTu3lrOrQ?=
 =?us-ascii?Q?NSu0m0mke1VWhyoA0f4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3f6ad5-faac-468d-1094-08db71985b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 14:12:18.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAIKahk/Gf+xbjN3aOZ3djxrP0piPpsjmFO5ju2JE6pGXoI2Gi71FKIKTKmCsM21WGhKwLK2NQ5OSkUXZgXVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access



Michael,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Monday, June 19, 2023 2:07 PM
> We don't need to do it now.
>=20
> > Current VF capability is kind of ok I guess ...
> >
> Already proposed one?
>=20
> > If you want admin command to query then it would need to map in PF
> memory.
> No need.
> It is similar to rest of the configuration access commands.
>=20
> > I understand two concerns with this:
> > - you worry that this forces ordering requirements - it's true and I
> >   don't know of a good fix. So if possible use VF BAR by preference?
> > - you worry about wasting physical memory space
> >   this we can fix by sticking VF# in the kick.
> >
> > As an alternative, if we can make the new command able to communicate
> > offset in PCI BAR or in VF BAR or both then I think that's also an
> > acceptable
>=20
> A new command proposed was for VF BAR that member driver can ask to its
> group owner driver (like rest of the config commands).
>=20

Are you ok with the admin command to query the notification address of the =
member device bar?

I presented both the proposals.=20
We need to conclude this now without keep flipping between two from version=
 to version.

a. v3 with admin command
pros:
1. self-contained via AQ for rest of the control path operations.
2. Can work with future siov device who may want to support legacy
3. Doesn't bake things in low level pci capabilities which is hard to get r=
id of
4. Able to add new command or new response if some device wants to support =
this on PF (very unlikely)

b. and v6 with capability extension.
Cons:
1. Does not have above advantages

Pros:
1. Uses existing PCI capability for the extension


> A future command can tell for the PF BAR if needed and some device wants =
to
> do such extra implementation.
>=20
> > compromize:
> > drivers that have trouble mapping VF BAR after querying PF can just
> > map PF BAR. WDYT?
>=20
> PF BAR for notification can be done later when there is some device who r=
eally
> have the limitation and wants to do that.
> We don't see that additional need as driver notifications are present on =
the VF
> already as listed in the alternative.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

