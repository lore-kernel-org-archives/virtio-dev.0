Return-Path: <virtio-dev-return-12098-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C698C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:57:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9F7F721E7
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:57:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC2809865FD
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:57:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFFBD986371; Mon, 10 Apr 2023 19:57:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B31B98632A;
	Mon, 10 Apr 2023 19:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCVb7MX1thYi/533Q/b9KwHggos4vdZ5PEarnxFGgriKI+57TBDuaf0xRqIUoqyGMFNAe9/krbe7u9oDZaE0L3X8+IDq/mZZHINkf6WOkLVUPIZS/CKUMVFTRXgqR4hzmfJObUnqn6nsbXoaw0UMrNlz8hY+3JYEM9kIylU96/O8n02ejTTSPHbf+0rMb4sTQHECGhTS7RrDhNvCb4k4Mp1wj4zgkyYQsyxDiOctiT1RFGazHZzxMM23cJK1x5B0wegmEaOlC0htaASwvTZsKcc0hACfTeF5U/+2lQH+aeWFgQt02wRgs9+cqLx/dKHAHvkPqzrIV9oTWgUIZLwTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMo5NtnV6yxq4TtB6MbL+UPHIhfXqGRGLOa21d9KvZU=;
 b=kvT+7hwq7LB9jRAsevYRp7ashxSKWYlSI+pQ9WVRuEJHFXkdD/8+Eq2JzXQXLEy3HrHI3P+bWhirqeMQrXwu4kXJojbyGsd+/dwuxyaFpUZQGDZ/MsyA5GWgEfn1z8jl0A3Ju63dqGMnILb5gBl/hFzo7OBEdqAqAd98lZ9MYveXK+3KQ2GO6oYWGC6YMKBJlgL8OGQ61ZBuY69UK4MxU9uHiF+zvNcxA0kNz2fzin7+eX3eXepYaMBdFmIry4oAiuYUBflDZwdSpc1KpcgmxtSmkgFiZBMiQgPHc72EJcag9jWdtX6a9yEX1L0hjtJZ+IcHvAZnWGbNKrVgKqmlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 08/11] transport-pci: Introduce virtio extended
 capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8ayT6AgAAFiICAAFCigIAACimAgAAVugCACYshAIAAOfOAgAAAfkA=
Date: Mon, 10 Apr 2023 19:57:08 +0000
Message-ID:
 <PH0PR12MB548109DAABB563E4DA3040CADC959@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org> <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org> <878rf7kcna.fsf@redhat.com>
 <20230404102053-mutt-send-email-mst@kernel.org>
 <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
 <20230410154518-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410154518-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6791:EE_
x-ms-office365-filtering-correlation-id: 33b137b9-1c0e-4771-8344-08db39fdc415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xPy6Eiyk7W4QctzZP+70ohyAzR3ppRFR/z1kEr218qz2gT8UBXf7nXTOJs35y0kfWTXwcXMkfS26kvPIkTJbpwTaqZMDh/YJHAp7QveMDI53I9pwKQNgXPLU5aqeFm2K51Gjv779/zEZHum387y0KkS+tnRHty1RZQj6fhU3SAkQE1+g1qbskwb2enm9eoMWr5RMo0zRR0Zx01DnIb1IXY7qCxtOLlyhNDpNl0nLBUt4UbrGk196s7IUxVdqR2FxpUbrihvg2p+RamQAO8fdbPiC2nlng30ahnt0enx4Mv905bDk7c0r/d8zkZhnfAZa1Z/k7A+80j6N6Gf7BzsEVuv1RnI4RrS7v1P7wL85xNFTDouCNlVSDyG2492vHmMs96ft6fOlL2w7jN3t2k0gJgCtXwHVzQYqrE/hNzgMc5if3b8JiqC/9AsIeETO441o0p0nXkvXrXrLaaZCS3q9PL7QpDCyer6M9pVOORw3jqcMtCx9rCuQgZ2VDj7+K63sNJOSwL7oW166V6q9GNFnPn1s1UJnviTvUnRZJmwDA86emttqY57hevGRrYcoqyC0iEZilZYwgUY33RRlOU03Cw8vX2bBwXUGO/0ExMmtGw/YtjpFJJJYGJf0VI91VctILTed1Tk5OvFPKqH6Xhw38KVWOnwLh6fQtv1YWkrOTYM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(54906003)(8676002)(76116006)(66946007)(66476007)(316002)(66446008)(6916009)(66556008)(4326008)(64756008)(966005)(8936002)(52536014)(7696005)(71200400001)(4744005)(5660300002)(41300700001)(9686003)(6506007)(186003)(478600001)(2906002)(122000001)(38070700005)(38100700002)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cR4kdLVm6VynfGxfOIrkdFWgxIBVwCwGr+dBTEqW/aqopzvbGm7n84NSpo/r?=
 =?us-ascii?Q?8BpsHnUGkuiBFIGdOV0ovpe3vX5Zc6CaSbFVXOxMCV8ZbZMOcmyyBStAVh/X?=
 =?us-ascii?Q?r09z7TvBvL82qrTG1E93k4JCNg5eobqNSUgMuo81Gw/td4dXpPBvFbDRzZoZ?=
 =?us-ascii?Q?LZwFyaL2KiNKAITCLuWF3wbTdSFYcqa6q34KjUZTMwVH9o2DihM6NixLV3HA?=
 =?us-ascii?Q?Lo+dZvjmULahbx6YYfg0A/U3mvheAJ2HqOe2j7Te0dGw17osf/WtBzAO6FqP?=
 =?us-ascii?Q?MtsMDhzGOFEgAYkZPoHHThlylN56jQv0+3VVUcoGJcfA4Zy7JpuwzvF+kOrC?=
 =?us-ascii?Q?BBkSYUGuq7TkbMQgZMj+eIPSAeeDl+Wq9QHFYxnrMlxgPF5AawrNt1OPQL85?=
 =?us-ascii?Q?X/8owL0Ot/ckCNsutDT3GYOfpnLctNQUsf7ZbD3pZJVa5QC8bcS2NT5m7M5u?=
 =?us-ascii?Q?EENbhOk7k7toJLUoLGHCR3o3lfF2hayYbZcwD7N3+tWXekckaSR4qIsK9sFK?=
 =?us-ascii?Q?It96m5Xvsgocj7lxbegFWNSg8Z0jFq6jl8Ig9lFOoIpNGqVU9yYGtdVZv83c?=
 =?us-ascii?Q?6F7MCbOdmLZtCsmfBIfyuZA+Qv6ECkE5Yaal+re4xa8GzyVYGl5M+CnAkWxl?=
 =?us-ascii?Q?513VcoucDjIXKXkDZi8hT5LIncpGHwMM9qOmFIlx2dHfZEW5QRz74MiZ2w66?=
 =?us-ascii?Q?/Opd51ju4K8Bk0qXKcDR9k9cCBeEiKFGE5JHVFE8u1uiUl7Hy4oXEKsfdKbs?=
 =?us-ascii?Q?bvNGPTUDpyb9dkP0o9+VZvSBVbJE0r39g3vMvDQZuaBm7aTUgk3Mk1RAmXzB?=
 =?us-ascii?Q?zg3G2OEsi6e/X+7QoJm51eyoGqm4A48ojKBkWymN900bzzIJx7jly9tfGstZ?=
 =?us-ascii?Q?05EkS87t8o9JSfjyYOy8gNnNlqWMC7E3Q9s6GG4QCJWh0kQvlnyaQG78eaOh?=
 =?us-ascii?Q?JMBEQiGBb/nz8WMMsd3j8oQZGPWWmYv76nN/PyTeodF+v2S46LrhP+Q516aX?=
 =?us-ascii?Q?Q0uDMNM7abaCB4y7h0Gu6fg9M2oAHGXOX7K9fbIjaCtjuEXpxC0pGPh3tCl2?=
 =?us-ascii?Q?4lU3To0NbV7tJguMGb3F8tWT6ttYKIhFo2dA8Retlg12y9v+ZLJT0Z6UlN7V?=
 =?us-ascii?Q?aZMEJL3mVDtf/uQC4ZWD6PZXTGclGcAMUjsM5cbVYUKSaVD/6tdxDgAD+I0b?=
 =?us-ascii?Q?X8hus7lTKl8GzshKM3rJZE36NFircEoUFPXdldufnmqY3Ysum89HOu9UryqH?=
 =?us-ascii?Q?hFoCFcVt0HSdtjCxHx8Tu+N1bY3dnCTCVF+hUTMkBMD77RPtPwP7LF/4/cM+?=
 =?us-ascii?Q?dk144EO0n31Wg5hhKigALZbBL8SwmqYDosK03fTlNT6NzqOO/3ixgvVx9uYT?=
 =?us-ascii?Q?KfisBMfoVtTw9qnX+vIW+sy+O3ObvE3dY6htOcEsLCTi0IAkVMpcL78s6QVo?=
 =?us-ascii?Q?sgOnuEaeEkyyIFw8x4alDIHwmL+lRwJ0SXAfOmym9SrMqh7GucEvWbf5zdix?=
 =?us-ascii?Q?m9erpKoah8pGbeK4VwIPTfONEzKBbQ2rgqdNRAv7X5aq63z4ABQuHYR/4Ns4?=
 =?us-ascii?Q?tatU6boNueYz2x7rQmBzEnaMt8VW1FlSxpA7aCC7wlI9Ft7XOMOXUPSZiRvW?=
 =?us-ascii?Q?4aiCrsxEYUsp8rl/VTRKMOg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b137b9-1c0e-4771-8344-08db39fdc415
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 19:57:08.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9mr/o7p0EWo7C/W/x4Y7+Lxf0aX55eGi4WuNJiG5cb/0VMhkq18GT3Zdj6njkCoqH695RIeT2712im0/4WQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
Subject: [virtio-dev] RE: [PATCH 08/11] transport-pci: Introduce virtio extended capability


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 10, 2023 3:49 PM

> Attribution is nice but Signed-off-by is not that.

Then what is Signed-off-by for virtio spec?
Can it be same definition as what Linux kernel and many other projects use =
like [1]?

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?=
highlight=3Dsigned%20off

> And fundamentally people go read the PDF where the Signed-off-by does not
> appear at all no one pokes at git history.
When people read PDF, they do not care about the sign-off. Signed-off-by is=
 not for that.

> Let's just do:
>=20
> Thanks-to: name <email>
>=20
Why to now learn a new term?
Why terminology of [1] is not enough like AQ status codes? :)

> if you want attribution.
>=20
> will be helpful to fill in the thanks section in the spec and does not me=
ntion
> signatures.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

