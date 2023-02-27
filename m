Return-Path: <virtio-dev-return-11302-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27EEC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:07:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16A1F2A82A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:07:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FD1C986654
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 03:07:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0460F986605; Mon, 27 Feb 2023 03:07:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1D009863DD;
	Mon, 27 Feb 2023 03:07:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrddRjA08UXpVO39K655wVUDHrC68/Jx94lxa3vtpDnIOInrz3c91Sqm2PEKk72W2gj7tsUs5585gxj4Y5vboPo0jm/pVyuLt7A6Z38gcNCb+vZc4YgfCav8WX6k16LsrzwQUtpYBcWX0oEvf8Mh9TjNrz6/b5cVma1JbD9eaeh3fAKL7aoKHFogcaauk2YozEVBgiqaEkn/lJW26ZCsmR0oa5dWaQBVSWL5VdOcH2SXtW/nR6DJK2yLf/GvWtjl63txYEoY6zyfhmkup7l+IlJ6bkeIZmcJbLAvXCjNVfzV6KftmFUndh3H90hu+x9sRDshxI7eziWyNmjCAfFvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwGLxL3NkdxFM7z+G7js17Hi9cb36vpvPBSVcWZ4cpo=;
 b=kmao+d7nV2NyZYDbTap333K9wBPIDAdNcGbOBOaf9g5a4eUUbN/NQtTWg3yzajMtqLDJQZTW45hblDppHBQlzPxkBI8BBUZHOkA10UQy8oszSdks35vP47we078qDLfUQaa5UZm50wCZEi5+YfGyI5waAV7vP4dwmjvOGpv/BWNIoVVd2MMi49gtjwTjOcutnvdtFLZKbHmCPalcThPV+SSCZy0DaaeH7sBNbQRYflEa++JFqFcocIsrvFiOiNPu3WkoYXTcMB79hD0CsfGXlO3XY84166kCVXbItZ9mhkxmMLg46+y4F3O8ODh5JtW/L6BNBqs20K1nHc9IzBF2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 3/3] transport-pci: Relocate common config legacy
 interface
Thread-Index: AQHZSWjGRIGryXxju0264DstWdboeq7gS3sAgAHSnPA=
Date: Mon, 27 Feb 2023 03:07:41 +0000
Message-ID: <PH0PR12MB5481691F4FADD7A4660D849CDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-4-parav@nvidia.com>
 <20230225181523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225181523-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7036:EE_
x-ms-office365-filtering-correlation-id: 4fecece2-84ae-4c66-664d-08db186fca22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /wRBX0qHFNaso3sqPV/DjLO+PB0kM3P1Hb4Tu6bXuwJ8d9P9gT3FUBOLOj2cKjHjlgV7VqIjpryJVJONW8h7USlq+CtyENluijxeL2ZmU0uf3O5c9izqdZ3iEukJ5b6wMoTUXEBs3woqWsR5gj3oY4UkTNE1CK8az0x8rujsBlUB4IvinOzCh7UvqKvFs9JUP3ni+EWC5E8eNxgN0C7ab7Y22CA0SEhbGcm2xVFE+EbiUPZK7cv4ZWHCc5rMl4XiqLg7DmyugSdll8vLZWWjfCy9nTPFVdVSp7qtl9Gm8pJjOXn7q4eqLMB9L22LukGVEmFzVew+wc7+VIqsbuL2j8KydKCeRZtrjUkZ03I7mY1AnCYGhAVyRIMMWj8EbFvoLEc71kmPQr0pMr1BxkgUkw80qz4eGARgQo6vSySPECleTG/zl8g58CxIRfgBnGTUFFPdNZ4PH2sq6A2qb1fsF237HAYOKwqiLjWSkbc988S5GJmun2P8QU3/rpl0+rf4AdBiM62TZjkSgqmxobdr+5ToLoqUwEiJLd8URgKU+NmOcTNP4yHZoHpXBkolIj1qUxVnILawQkSyhzVPJjaT/wJzk3PUbZ20mpnOqIwZ86bQlJX9MM69bLsfCnQMy1meI61AlRwQI/gJLrHF04ht7jYqpj2QfQRA2Kz+sn/V49EJzty+I8x5moYMqy4j1RgzInxs+xI8NbwaAhwpOke3kNfL/7pzr0teAqcnYJbCbcAxduPPETB+jMZ6pYPmXCvS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(316002)(54906003)(33656002)(86362001)(55016003)(38100700002)(122000001)(6506007)(107886003)(83380400001)(38070700005)(186003)(26005)(9686003)(5660300002)(71200400001)(8936002)(2906002)(7696005)(52536014)(966005)(478600001)(4326008)(41300700001)(8676002)(6916009)(4744005)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w6JYRmB97OuOwqrTJrnFe7IXpCpMb0WDS8cNuVfUNO7qI94GcN5pKRfy3FZO?=
 =?us-ascii?Q?g6scW2AyHgbx0NBeqPBJooGLXc2jWihMcgrOhaqdFuHMlQhsBiKacT7LFqw4?=
 =?us-ascii?Q?0LfJ3FQPGWtUDXiL9il7+TpojKIzbUBT0SXSadwF9VyUPhtLzr9x2+MEWXbG?=
 =?us-ascii?Q?vbY7iIK6Qi4oh2t1titMJUSI1k1x5QRlRf4OgHD7NebhoWDAdz+cPHsRbhIn?=
 =?us-ascii?Q?OCIut3biKS7ciyBx4Tu8fg9LVZtSwbR/UYjfFPTY/txgfg8KtKfvmnfyP29Y?=
 =?us-ascii?Q?FUOMos2CXb73WXhVrCkJxLDummI2pqdvpoKxCC5GqwR8nh8s4iO3NTH01AO6?=
 =?us-ascii?Q?AS6dCXGe+c8M0mmjLh4Rqw/kdI1G1N/Zso4da07lUGlT48F90vLNy9Wb2Y28?=
 =?us-ascii?Q?dtTh3ymU/1DUCYsKiJOy5Zlqsm3dDBrNKUmMi53ZT5A70cs46C5cmNi+FjjB?=
 =?us-ascii?Q?OF+fCYTw1iMhkvquESsQKzoAVzbYbDabWvQHm/H3hGeVzojg/NUjPob0PhLQ?=
 =?us-ascii?Q?gAUa+Cf6L4urlTmCCGzo+qz4bOkviIs4Y/fhS1VbeZzk5CNGnuwTsPpIv2Bu?=
 =?us-ascii?Q?CGUXbtB9B8/zn0Q7r8KNWFaNUSvSoDe9KFkoW1cIivXj611dc3pKRuAvZMNL?=
 =?us-ascii?Q?6y2krOX3h+Bi2CbwTxD67IlyTDAs+W3XAN2rDT7AvnAB4TMj/CykVRIvfEwP?=
 =?us-ascii?Q?iJRBET2VijbjklU+NSW1TMKZP5AXkRTq5LCoaJ4bWGmLxYVixoKp9rrF8wdk?=
 =?us-ascii?Q?ROaMNZTDgBxF6/E6x0m3IpaJMyNwPPoxDCULGYb+b3ut0DrsWgkPZDIK+62L?=
 =?us-ascii?Q?3waJvoHIbrqUk1cjppNsBdJKTMOXYX84fN91ArQeiIv6P+gpaQ9ewaCRIhTs?=
 =?us-ascii?Q?3eA4xuOmPOTQoDH8EscIb4KhrDz6C7r5Mc/O35X4BHEldnX78G7p1oCISUmW?=
 =?us-ascii?Q?Tj6Mxl1Jmd80v84tG3h7yIJYYgqQXjkHJWKyxrHTzaaF02fYKV4UuacDW9BF?=
 =?us-ascii?Q?VkYCtbNzsjz6QQdnR55DSJCEVSTP/58UNu23GPpq2jfsUXLza1EGg2Hztb0b?=
 =?us-ascii?Q?Q06DNSDPV+7AGKMv4M3CNa+xwLW2Bho69YoopwHTVuhGtL8PRRJ5V/Ney/Su?=
 =?us-ascii?Q?BkotPDkUnOHww+H1zfhBW3b7kfk+NCzM+bsGPtjPJ9UjiNhMNDgVwEj+faXY?=
 =?us-ascii?Q?pTEhR2qa/gvS1c/kCq0QIdk/Al3W7R+5Ihtdhr8lPXk5fc1TWTre9fMB8Ob0?=
 =?us-ascii?Q?j3AjX5E+wrmohDGeQDsPy/QXS9fTnAiwLrf42odIbU0eX5etXHbNjnE97W8F?=
 =?us-ascii?Q?MxZxQmxgnCEtV9gGSsMMbDTYR91bdIX7z/Xp9HlcVP2nZgcvkq/Mk+n1NjmR?=
 =?us-ascii?Q?cHXLxUeT3G8WCN9UpVWp2b+JiI+73wPBKiKysz/2RAKY6Oj1MI961SWVnbNs?=
 =?us-ascii?Q?+Vqe1+r/FQ0dlprO7dRsfw0+Ve7zJqXhZnOv6Xz/A2fHJuJamMCagLeEnfKI?=
 =?us-ascii?Q?niddNjxX7f3Qa9OiB/Nq3jA+GoE5RnuvKUzN0teCAdOALNkrJf5ZpfrNkCLv?=
 =?us-ascii?Q?hoQKyKmHwBim9xojxW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecece2-84ae-4c66-664d-08db186fca22
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 03:07:41.3652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYRc1YtnNESjB7s874wmoOWqb835cu+QGX2cVUTsOfBE1jgaNAwuurrtUgMxOMsqCTxXrkwaBxnj/nxgc96yPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
Subject: [virtio-dev] RE: [PATCH 3/3] transport-pci: Relocate common config legacy
 interface
Message-ID: <20230227030741.4oE0BZvdjZYACiIlVyeYMtfbqlnlewyrZGJKo6uGEDI@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:16 PM
>=20
> On Sun, Feb 26, 2023 at 12:30:01AM +0200, Parav Pandit wrote:
> > Relocate legacy interface section of common configuration structure
> > near where 1.x based common configuration structure is defined.
> >
> > This aligns the spec to follow rest of the other Legacy interfaces
> > section.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  conformance.tex   |   3 +-
> >  transport-pci.tex | 186
> > +++++++++++++++++++++++-----------------------
> >  2 files changed, 95 insertions(+), 94 deletions(-)
> >
>=20
> I can't be bothered to check whether this actually just moves text around=
 or
> also changes a bunch of stuff on the way.
>=20
I will generate pdf after these each patch in this series to make sure that=
 no text is changed.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

