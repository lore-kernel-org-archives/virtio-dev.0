Return-Path: <virtio-dev-return-12260-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3C3C77B7A
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:59:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C60AD29FDF
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:59:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB1E9986615
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 16:59:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ADFF89863D9; Mon, 17 Apr 2023 16:59:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B8E3986353;
	Mon, 17 Apr 2023 16:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3E/27ZWhuGxtZpQLGj4GGP967cGNEdaAL9Imvz3VcvZQkOaoJ+e7dbMKhWUommvHtlH+9/cKkiiEOEA3JyYQPXZDZ/IvDElNqSWCFqU1nqt7Ikw8jAxRpdYT01tFd6212FULPeA7uxdx8zvBqXY3XoAcRhf4gQLXFewXXkrjE/x3tEgmGPjvVvLImMmB9tSHJxMtxScKycS5FR4Ss4G/92UioAy/B3kVGn/DvAv3J4iU6RZjSZ31DtC/o4Pjdawc1EdwU0/b4lZByRFEW695mIt1S2wFudKwS1dJVOySk4T0fSswT9qZopz7ORT2QWRb+dBhLqX5sSKNtDtIWSyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNZpGsoksBVbQt5aYLJ0kSnyj2BGCMSVUIfFhaLezOE=;
 b=oYuOhZ/+S1wakWKCqyCTH4llR7EZmQlEgIKDdO/VqYtIxBAkBntASqpbfgG/0Ce1BwljhmRuwe4WWKHegBQaWXEhCgyy6KBOxtc2P9bbr3jnif34FG1u8k8E/hZHc34hYeUk7ximRTYh3zI5saiHQAaatjxMdj3LFL5FrJIRl/624Xq1kyxRpVvwpPdadMxJ/00BD82WJYv6vEw6wnGDiQYAx9njk89u9XxiUScItsvveHTAWaXWuIblCRFkKaHZB/G/m6D6snAlWyT/HJMG8kS1XZ5g9oEFM7ir0r027CSX6ZCP03q+RGg3TKee/opNQ4Qkn268lcnBB6bY7FALKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgAA85gCAAABI8IAAXS4AgAAARpCAAEh7AIADk47QgAB4NoCAAVIGkA==
Date: Mon, 17 Apr 2023 16:59:22 +0000
Message-ID:
 <PH0PR12MB5481AD9D5B6052C39A946AADDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230414025523-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230416163929-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230416163929-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6753:EE_
x-ms-office365-filtering-correlation-id: f68e4c9f-36c3-4fb4-1249-08db3f651800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yiuRdjpBGauf0+qjToBLcisBvy5qfSnAayaFdkYnF7+MaVGd1n6YZ4gHNqb6gvvAKYOLEAoMpDb1aEkLUiRX7YKoIbFyy4h845OK3Gyna1XHt79Zg4JVbyJcxqEOOCnE+67T5uNAU2TuV/CdsD+dXCyfCr+nymiHVbMh2TGFsVy76tg40v9QbOh+QzZBdlYUO+t48bXtLJKsFAu/CrLAP0epDdNHr7wRmF97k/AQbVXosDtRkjEveFIN/uf5alfkGFU4Yk33OJY5fIDG1mGG4H10lu0li7umw92Ka0yGbP1AtTCG0hq/VDBtRLE1h6fI9vmJVhAZ6vDLx7K593Lrt/G+Nt+Srd8i2e58CdUs/yMtdwADDKOTiTOR+Klb7rZRQ3GGTv/+MCxGzf3N4Ao9XvBR71nqctVBtuKoiif1YtKBrpAtsio1VUFJq8VGnEei9TkWDM6w4B1F+pCEu98dN1CWa7vUaRZarasPosE9JgeEO5MVxWNSNPhBRprJ42LXD2lWOv5AIh21Jo0VnosEzSEyzBUDWEp4olgVt+KGinjSKqK0ODQT0bpT7WTQR4/+gB4wpug3OHfuv1XBdcFw3iwWOmPLMIIqemOwLRiInlgdMVNG7HpZ6vDfGC5Q3oJG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(38070700005)(9686003)(26005)(186003)(6506007)(54906003)(478600001)(33656002)(55016003)(122000001)(2906002)(8936002)(8676002)(83380400001)(5660300002)(52536014)(86362001)(38100700002)(6916009)(316002)(4326008)(66946007)(66556008)(76116006)(66476007)(64756008)(66446008)(41300700001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OGrlP9Ezy8nSht5ETBMMqg1qM9L55x05aXbwPIxqb1PhGmEuuclqLZ7a6mLf?=
 =?us-ascii?Q?ZDHxhT14Fxla2+kiiSzWtXEUew3qk+C2Khmhi5mnjSY8fxI2pU+pP4MMlGuz?=
 =?us-ascii?Q?sl6hwGEO2WQUv30IXYmxpoDrscJuMLd0eP7uFXB4qczBVRF/m+Ct44ykkBRH?=
 =?us-ascii?Q?l5RjWpqiy2yr+u5k9KR/eOi2pAUCTnPeeXOavWDJ2n/Cap7izCwNB8iBBRa/?=
 =?us-ascii?Q?qOW1k4GVx8yrwmi8tNOoP39m2Lsr0jG7lOYkoDlxd6BQqmErj6pXYPXDxhz9?=
 =?us-ascii?Q?JUqXXayFMpktlCaFJSvLTI0NA+9lKcz5KnAStVx5004yilqxPAIrX/acLtIf?=
 =?us-ascii?Q?obcethAp73E4zjcLg0zAqgLiMQM3bXDmYD04CwFjsWHOhefZgWzGF5ykeGPu?=
 =?us-ascii?Q?BGSUecd7kgwrRP9Xh4jbJewasF1MNRYQZNLtd3dOz59D1W+3wHF+bAeYa4ZN?=
 =?us-ascii?Q?B0FdCsxi1Fde9hej1UhXROlLF0J3ofyjldazt8x+8qFaRocnq9rJ1pabHhaZ?=
 =?us-ascii?Q?WG1uvrgujaFnlMUmg3LS0S84OU3Zga8v25uwkLR/7TppK+3gAFhb0yHpNiwc?=
 =?us-ascii?Q?aU3QU5m7OJJ8veNyseNKmkVhPoY1VsfhnztMiixnFj+CDP2h8ys96en9eqtV?=
 =?us-ascii?Q?DimwcAcEKCAKarmksTbVlcAlAiiPf6zlKCxsYjC5qQAXUByUymum+BtiSd3t?=
 =?us-ascii?Q?olRFE+m/hVJcTqmqs1++7qSDoqroI/nr3irV7KeYCmmsAm1FiWFyJfTaq0j3?=
 =?us-ascii?Q?4LyR260972NNS7SGSjtObsSGg2a/nqtCyDQmep9wR0tvuAysy8nZqwOWfuL2?=
 =?us-ascii?Q?OuXouyaUG77j1w77KcvoytbLtoTo9WlfqkQwZ0RAjwHZLKMIEmfo5gz/0itQ?=
 =?us-ascii?Q?4nlWILFLRwABbk7hsNjozKqguFwW5ZE/Xukvrz56DPu8fEIKXo4eFZ7zHRxB?=
 =?us-ascii?Q?c9uOTW8nXDaxQgBZDapmOvZ4rQUTxMNrEfUV+375EJJNYS0qSkG2rcAU0N4A?=
 =?us-ascii?Q?96lejUthA43WXhEHy98vABsJfgzjesRtkv90YaqsvtyDnpw6runn5i91Fp1F?=
 =?us-ascii?Q?QoqRLPKmQpIjbPR6CXO0uFU7hWjUY5waLpjalYI5OilDMtS3X3q04Y6j42ZK?=
 =?us-ascii?Q?RjNmU149NVni7VlPo1gmwgFgY10M3iHOL4bCf0RZOMewlKmmbJ7EDJJMN0aS?=
 =?us-ascii?Q?roLZzCK3WYTFZFnMxXifpHkxGwSyHtbod6XefvDgusS9xCtUrQHZiEd+ZN3C?=
 =?us-ascii?Q?kvwZbShP/O4MDBdcW/AIFzSFfbrkmxbCm67l/GIjVS+4Y/hK+zIgQ97e2/IL?=
 =?us-ascii?Q?luYq/wqt6ie88/y0lHIrbal9hfLedWsPb94J9VG63KesZqLZwPAljGUfAB4x?=
 =?us-ascii?Q?bhRHqKKrT1buDZLWOwTBJ6hhGeEZggp5vHmwTT+i1mwcBbxBjweUWmM4FeAz?=
 =?us-ascii?Q?rEtXrY/ItPE7W48vpnsXYhsCgdrHoGQpc4B4OH62X5l3pY+x8U/NCeOf8NfL?=
 =?us-ascii?Q?L0PEu+7HqND9Ub1au1+wst5OCOOLwFtNeHbbabbaO3OPUGEqIpVsGKvNAz27?=
 =?us-ascii?Q?l8pV2pbgmV9MAFlk3iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68e4c9f-36c3-4fb4-1249-08db3f651800
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 16:59:22.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tn9d52IvIVgX87BBk6Mp7a6KSG4lV806C/kk7UMIFBxPpUKs58b2zSHN823CA9oP6zbMWBRQDq7nvS12MOz4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, April 16, 2023 4:44 PM
>=20
> On Sun, Apr 16, 2023 at 01:41:55PM +0000, Parav Pandit wrote:
> > > From: virtio-comment@lists.oasis-open.org
> > > <virtio-comment@lists.oasis- open.org> On Behalf Of Michael S.
> > > Tsirkin
> > > Sent: Friday, April 14, 2023 2:57 AM
> >
> > > Do you refer to the trick Jason proposed where BAR0 is memory but
> > > otherwise matches legacy BAR0 exactly? Is this your preferred solutio=
n at
> this point then?
> >
> > We look at it again.
> > Above solution can work reliably only for a very small number of PF and=
 that
> too with very special hardware circuitry due to the reset flow.
> >
> > Therefore, for virtualization below interface is preferred.
> > a. For transitional device legacy configuration register transport
> > over AQ,
>=20
> I don't get what this has to do with transitional ...
>=20
Typically, in current wordings, transitional is the device that supports le=
gacy interface.
So, it doesn't have to be for the transitional.

I just wanted to highlight that a PCI VF device with its parent PCI PF devi=
ce can transport the legacy interface commands.

> > Notification to utilize transitional device notification area of the BA=
R.
>=20
> The vq transport does something like this, no?
>=20
Notifications over a queuing interface unlikely can be a performant interfa=
ce because one is configuration task and other is data path task.

> > b. Non legacy interface of transitional and non-transitional PCI device=
 to
> access direct PCI device without mediation.
>=20
> So VF can either be accessed through AQ of PF, or through direct mapping?
Right. VF to access legacy registers using AQ of PF and continue non-legacy=
 registers using direct mapping as done today.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

