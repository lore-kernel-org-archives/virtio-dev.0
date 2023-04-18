Return-Path: <virtio-dev-return-12284-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C22EC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:36:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7BC6A1CA245
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:36:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7723498641F
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:36:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BEBB9863E7; Tue, 18 Apr 2023 12:36:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58CAA9863E8;
	Tue, 18 Apr 2023 12:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdAgqwEvW+k7eSmdjJwwPJZneviqtj9R4h6ZguOESQrJCQh4FGK8SaAZOmlBFk+/TGzUqRbN0oT7A8PNDJKzmxnQFxhzlFMXdZLsngwgzI9klBOs1iWXEUPO8OHhr1jvtZ+lMy5f9BuAl7h+HpY+mh3rt3vPMgViiNSJqd7bk0ZQmjFEJjRqH6BlRsAchgbXBDROLc76068vPRS9P5cLNAqkOdcvnK7tnzlov49tQAh+74fK+4w5ULrGkc4i7BoCT8P9ojJVMfpzUMIlrpfaVhhNb09v08K/lT+OlQh0QdBNM8L/09jqiWF+sx9HpuGGqhKa5/UE/xdFBHTF+2bv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl9gXhc1z+BO5cCMxKXODgos+x/ZP7Ld9hkcVBXQBYY=;
 b=M6aAdU5uv6evtmLRqfxNu8an/DFCE1mdZL3tfV7tUjhyz44wEGxnQyco0B+4lYGCCwjLncNs22wHx9F4vJlF7JSxO3/MaPgxTa6AEJqA86q97ZVMeQWcke9S8XwNkDvrNdNgZ0sPndfeXAicQo5KAAwTu8j63x9H3UoTB0eypn02nkVtVw3NSMhHdpanlcAHnPxm4XS1EbMMib3nAi5ELYbHHiy9dwbTfAWiQfOyciWzr9ij4z57qfLU0Xp+NjmQ1eFNkZrQ6iJfYczKlCt3uqMOHuUwcUdZ8jkENKh+qUx5hAjDFTJo51TjhkrjdaN8KTNf4wnMCE9SpO8TXEfhZw==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5CAADloAIAAAFbggABFZwCAAA58oIAAr/mAgAACbiCAAAayAIAAAU2g
Date: Tue, 18 Apr 2023 12:36:31 +0000
Message-ID:
 <PH0PR12MB5481D97874D0BDEF2C7E05E5DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
 <PH0PR12MB548113626CD6C7B2F8589042DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418075401-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2E9CCDD9B813F420A81DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418083018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230418083018-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CYYPR12MB8752:EE_
x-ms-office365-filtering-correlation-id: 65658b16-73d0-4888-470b-08db40098a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qmopwJV7iNisn07D+uIWXMjI7AeqXXNi1a2r8ERjI7U+oxlZ+0z6tRQV/D1GQsl3jcC1tJJM/xvp0oq2YzMDEFOjIHfMTmwLzs9+qk/rqVYnD5Y8SzKNOVSGNk/Ii+iFaQ+ul2crCelqAIDWHlYUEhNNcBpq9Mstx9NE3mN+mTqZEjjlq1NAkCXZMA9DQIxSyDtZWd2iyDa+Bnlb48B0E68p5Kwwfa7GC9r5g1NHuxfAHlt1bdxmt39eEASQhbTHY4Amy8qr+GQVjOqflLrtVv17NAfxKP8VpB55wQraaWl6vI6uAN/2oqsWNWifNFma7hnqWhf9EhilGz5+4x0Akwoejm9cqE+Yp/ktnzNxbYKVOPkMByWyiPJ+eHHxt70hyYGk/oAa+aZO+vWy69Es3mPKKuQl5s8fjxwOB+C3lwShgAp14lRG6r3JRTQfMpvM24ZRyYHwhLKxEaRUg0KD1GsdaymgKhj2pTjDTlsjJVAXK4NKVM8qAW5i9OJFPByPHpoQJv0dmyKe7JRQTU1UMjudpVMTcLUfprqvVeswE5+cYnmAxNsndsQ7xdfMGaaqlwvkqRWFbzjaGPHUK4g+rzyX+w7n+ewyQOAjFZZ3aVLYC2ec3Ho/xsLxOhObuXS3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(558084003)(33656002)(76116006)(4326008)(6916009)(54906003)(316002)(66446008)(64756008)(66946007)(66556008)(66476007)(71200400001)(7696005)(478600001)(41300700001)(5660300002)(8676002)(55016003)(8936002)(2906002)(52536014)(38070700005)(86362001)(122000001)(38100700002)(6506007)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9RHoB9lR//XYYOrTbEI34O7u39sC8B8WXMQCWutRE9vEWZTrA7j7vqHWqy8y?=
 =?us-ascii?Q?4hGZrszuWpnT9Pa4GAuGFF0C+Oa/BIO4W0jkoxAsTqKWgnlXcXGrWF3hoNwf?=
 =?us-ascii?Q?ikdCDW+Z06smmwXFzNdy7hx9t+iWobMsabnFePx6RgF22Wx9jV3WWEi+Yg17?=
 =?us-ascii?Q?8y2F26qNbl7Gj4T5I703BDPhHUmxj8IF9NAwrSgthFBLawwjiVuYkN1FIY0V?=
 =?us-ascii?Q?8uuaRlm8Wabfz2sQSAFVS0+g/389QufLdjPbXWDFQjr7fHRSreQyaTSeZ+/A?=
 =?us-ascii?Q?9re041iw9WZKOFeY7aTASOWexPnPItiiUVc3Qef/kBYwPi4uFTCtijjNkcPh?=
 =?us-ascii?Q?ZwfYegDnMmWMJkeZxLlG+eiwnoPh3MDfiSRaahLBDKDfD06zzRyjZ8Qhyh/l?=
 =?us-ascii?Q?MLCk40oqM6IrK/j7gPBjMOdGlFhteDw7RFmgS41hJWFchUbIX5NFlzparc6x?=
 =?us-ascii?Q?1G4sbuH2sMjZnTdXKr4Fbqub8EHN7b+blTcVlaiyyDmSD8o34VOTSF2c3fpA?=
 =?us-ascii?Q?xRJ1Bcy/DS4gnGucJRXUeEF1oWwVRpFIJdARKd+kqh8375BigJrN9FDYnfzw?=
 =?us-ascii?Q?NNeQ1kSrKQqtZ7iwfpmyHThH1CPpcdYkMXKsvgt9Lg1Er9NlYdf1ERJN0/nt?=
 =?us-ascii?Q?DixMhbek0VV+OkZOxEUG42bEQDqSPqF/ucK5zZ1x3VBvjXRgwApgzqcesygH?=
 =?us-ascii?Q?/jbEFXeVcNBH03MZavQ96dBp1iPMl6esBFLnFTToiTWNHG3RY5Cleko1he9R?=
 =?us-ascii?Q?+8j4rmrWDk/daUCH3BKMNQz97q7x17YdeL9jGPHDj6IMZeS1mqZXZhuWEmOl?=
 =?us-ascii?Q?f9UKPfzAZHSpk0UQkJ0FuRiVuS5bXAFQ5dhk7NwWnpUfiZpnvTThOZWS2kg3?=
 =?us-ascii?Q?JWc6mGh5UUEIJNVjAecux4rBYeRnwfxl7o6ciA1xzAEgAaBMZhcb4Z9qJM0C?=
 =?us-ascii?Q?EGNstY6Tw/FSnx0LKAN5SwPn0LAvKWo30uWdC53GPPb19/ttT4i0osaT/y6o?=
 =?us-ascii?Q?Iyc6cAI0xKjTtL/doahn5oBGey3mH4Pfj0AXADNJy0LrD8WiBNrlExcSfOqp?=
 =?us-ascii?Q?mG6RrlchCV++A5zS4i/y6bH2eLaa9gwvQEPruu/tohKqVvLN61BYcVPHT45K?=
 =?us-ascii?Q?xkeQP/7DvhblDpBF/LIiUIVcOStetzeOfP9UYl3RgAegX4T1eC8gA/ns1oK1?=
 =?us-ascii?Q?aLWDYNv70lQyrt5vSZ+1UnAxL7vK9fmY7RE7QAj3rI9Fi9TNtiuxw6Qo16bC?=
 =?us-ascii?Q?99mMX69X4asL6b3fyIB7ehvVUZWWwM6E2rvxy17KS12Lon3e12DU9BtufeIi?=
 =?us-ascii?Q?MSkUMVh3+CL6oCsNiYb34UO+mg1Jeg8WK5PGWPRxC7FXgCOti/XbCAGOQBKa?=
 =?us-ascii?Q?TXtkUkzkGyFiuXGsGHveADlfz86DiTgcAhCA6iWx1uU1GKyXIb67jImyeZQ9?=
 =?us-ascii?Q?BYQdqiq2nasfsu8iY7LMPOgDBe8ToiHy7BzgjeSlIxYGRx8rtOvuGluu/mLK?=
 =?us-ascii?Q?IzT4nWp0G2zrfEnk9LywYUSKNEjvI58EXi3mNxnLsHAVKmW/MEm6QXjc+tub?=
 =?us-ascii?Q?ipPZWOwI0njPXvMFoUQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65658b16-73d0-4888-470b-08db40098a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:36:31.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z075rszgdmSTULsmMvVz0vcWojKXgxKAwKx8Zbkqd9+DqmGHHNiIX+JWRbrQ6SbgTmWkWw0NnjmTOFghmP+dpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 18, 2023 8:31 AM
> >
> > > I think in any case, using device through two transports at the same
> > > time shouldn't be legal.
> >
> > PCI is the transport.
>=20
> ... and AQ can be a transport too :)

AQ is on top of the PCI transport. :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

