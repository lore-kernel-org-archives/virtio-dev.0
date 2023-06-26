Return-Path: <virtio-dev-return-13091-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9674EEB64D7
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 22:46:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A888342C2F
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 22:46:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9463E986416
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 22:46:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7F759983FE5; Mon, 26 Jun 2023 22:46:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 634469861EE;
	Mon, 26 Jun 2023 22:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LedKfBOhBxGmEhJ4SXbgQw2kDu3qHclYaV2rjP6jDv9q87ffuH66hthCUFey+sqJXxWpPKTKpBdqEYU12ot25lA1gmBIqGstQ3cCencsYeDjovAl5FdagZ4SC6Zc5eqpMN0+SGIYuCjUg42PAQvTDAq5UoUESTb0umhCcqr2uMjApT4+GBiGNLsedcAWpP4KCfA27/XfELwWLMpeNTCOf7ypz+Toq2awxkvvQI16S6JRgzKy4AmYpoCt0aAnZUirq7fFNPQB6mFwMXPM5o74Jx30RjqHJQN+25lNs1MLiN17PDi++hYu2NCLuN14XkDvjHwBQvvMbzu75v4Dl69HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RshbUuAuGqGiY4BVP+GRPtQz90J8AQJ3Lz2ECz7YFrY=;
 b=JMHd+pzLnWqLqQtVpbHT488ThUFSWghK5YItc7IC/mfSHgw/K+fjvO7IupthhSwRGzja/f7nTI/JjtCoJrCmytLYFdbo+GioqGYY1rQf7A6QF45JKwb5S+wkcSZ6CU3oWq+R+jL2s94ifrjGn8ARUt5KOqWZdBa7yMSBvv8yM9vyelEWKVwJIxT0mrbmV3TqbyeLDm9jebk7/FFU8m2RMgd002WydRQcedm5trZ91hvT5xoMSSrqEfpmWonNSB7rnXePZAFD+y69IAutB/RySxtruyRYRR/wbkjqea3jd2Rx+HVbmFXnyVtmPVC8iGq9UJmZHhKvMq8w9Tc9P7h97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device
Thread-Index:
 AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+cowyAgAAHC4CAAA21gIAAA3QAgAAN8QCAAAS2AIAACv+AgAAPS4CAABdjkIAABccAgACqjJA=
Date: Mon, 26 Jun 2023 22:46:49 +0000
Message-ID:
 <PH0PR12MB5481E2467505F461C30F2B92DC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1ddd572b-a1d0-74eb-1e31-abb6dafdef3d@intel.com>
 <1687763309.2985258-1-xuanzhuo@linux.alibaba.com>
 <0a3cc0d7-638b-a49c-d846-8a4ba6e5501f@intel.com>
 <1687766994.5635917-1-xuanzhuo@linux.alibaba.com>
 <0d536952-bc05-460c-a116-3ec26c25b017@intel.com>
 <1687771000.8174524-1-xuanzhuo@linux.alibaba.com>
 <5809781c-1688-478e-d1db-39067fb45d80@intel.com>
 <1687776645.3360302-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54818E9B1BEE45EFC0E3E78CDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230626083311-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230626083311-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4470:EE_
x-ms-office365-filtering-correlation-id: 4f792a1d-6e4f-472a-34f9-08db76973a92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 URfvIJV1vezaJ4G3yP5hRcMTnnM8sQF+95kuACcO8kB/e640L6b7XYcc/0POWbPZ+vMqPzZMqAZE+Q3ziHYgev40l4VMlCKHEqFvPA4LplT9NVd4Ro7U5kX60BDWYi+GY+cqA8jndDuPeu+ogxfaS5uzmptKTwidHrILqEPWb/7yCzlh+XpzAiypj6oHrFezUDFOTKLwbeCIyK5PwV50FY7wiOd9IvEuxRW8RdWWDQGrzdWPXzoDqvSZecBl6dJqe8P2gQnbLk0rIJsNjRyMFrWwoqIL2s6RMB6m+mSk86UTvuMXBQTBfV/KNX6lHS1EM+o9YounMbgtJ9pXsp+Z30crKwQBkwMIpfo8pe51dV7Cs3ziJJgMPxkgThBlmeK9aFARotumSkcqt8HZTJy++/Old18MIjms4TgLq4dGgZcH+oVL5RpkPxvBpOkgnpzAmRiFSq1EfkY447d8VnD25al9tR9yK1pLYV/183eCMQ2ePSV1UhcE8Oo8A46Gvpkv+x/ptzO+7qVT9ySYsCD4GgI/brz2Jzp2QOwITlnyJrYWjJxxb0Vhqn9KD2arNi0CW9rpiJ/eK2NXTS5ms7kG3VEcL3lynVsa28mBVXN/9LvK3c+4WekI5uum4AOz2IQu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(38070700005)(122000001)(6506007)(71200400001)(7696005)(186003)(9686003)(26005)(4326008)(478600001)(54906003)(38100700002)(86362001)(83380400001)(8936002)(64756008)(41300700001)(66446008)(8676002)(52536014)(5660300002)(66946007)(66556008)(316002)(33656002)(76116006)(2906002)(66476007)(6916009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9/MK5DMmsNusyU9NYryP+Qx4nBywY9xd78XcvMrLta8E7kx4IiSIL8Or/dIz?=
 =?us-ascii?Q?hoP99S4fEsvSiYbYGtQ6CGiszaXpezf3zTJ621pj+EzwTnw1f5grSKE4XimU?=
 =?us-ascii?Q?/OM7lwsTUk7NzenTjD1sjJSJVdRZVgvA8zRNnUviRctRURz+4OagWz9pOkqB?=
 =?us-ascii?Q?cLlobIXKMmlFgfLA1+Mv6ARIdGhoUey+bw0e419OH0LSrfQX8qTGvdO8wK3t?=
 =?us-ascii?Q?HsUe9HBbxs445BMUQjL3vm9YKBhAp4GnAAUC5EkKlLkY9E9M6NA4ulsANeZR?=
 =?us-ascii?Q?FHotXn1k5qQj0L6Jxx0ifGf3mgu8OXbP6aAgTSUoDfaBE+0OpJoiFtLVJlBy?=
 =?us-ascii?Q?+MeAUg05Yx38tA7qWutONIEtJLIWm+sAOOYDqMu6uyn++BXvF6/lA9uinL0i?=
 =?us-ascii?Q?D9bdVXkkc9KPraKjofFRMoMZiPt43kzXdh7nziZ9KWDHWebCUlcl/tokrMEj?=
 =?us-ascii?Q?CcGKkLfPz/3K+V+5XJUpFtPmtnpkd0oYMT1ha3gBmrwSHmBNfwkbtxGl6WqI?=
 =?us-ascii?Q?O3CZk3qMBbeNh4n4T+1YwNcp0X1iI2Xl4maIVedxnW333heHFF6iCiKOr01o?=
 =?us-ascii?Q?hyLiBnsF+rEmz3JGgVVdm85ftnTZ2oFCnb2k0/ZZotciMSODY20/jL+Ocw3+?=
 =?us-ascii?Q?I0AqYHT2v1txPfT4cv5J1Y5fqf744YP7F8ova/isG/IAV+aBV35WWofLWX8f?=
 =?us-ascii?Q?n8ezbX13U2qQ/sxWUVqbQCE9EXLVTO5fObq4q5vDIupSoNK+NSxFhHqklEny?=
 =?us-ascii?Q?Iy8lB6Zx3B5tZAJkeWeye80s241/J/Yc+QdzjCB7AjPAMhmWJERAp650zZTb?=
 =?us-ascii?Q?M6sWYkg8dM8ywLteskKaSHpDqZO4hLV0Pm9s9JyMoBcIr1qTX9ScQM45sZBa?=
 =?us-ascii?Q?uXWYlGWABvLMKBsZ2DTsQqnUXNJLJRGd85SB95QwelEVLJrcb0NbKVv7jRlm?=
 =?us-ascii?Q?rr2VKoQorWrAmLaQoi6xsmBZZEEswTAue1Uxnp3OuZOyoy63KQGrQYj0Jh0t?=
 =?us-ascii?Q?QuZNtfA5R5HFOE0i1n4yb7t4M+SGy+hdgUW4XaV+vSzv9K+7esI+za6YxbUn?=
 =?us-ascii?Q?rFignSdIjm4mxWZHLGfSGy14Zih9I/jwXamZ9g4LNn7oI44pSPfWRg3lbfhF?=
 =?us-ascii?Q?TE1SHoY224k5ks6Wg1e+wxNn4QL/87FzARh/ozferkP2o11Fhc9GluWywaQy?=
 =?us-ascii?Q?+I2T1GnW6mnyoQFWDh4zkYgXU89Tb5xq2fvUGjLkwtUxH7OHVsr+hLAwFnqe?=
 =?us-ascii?Q?9KYwthkSLx+vNKuPAUPKQWazk2JXCR1gxo4IN1lpnKXzQxX1CT2G5tRLlEh8?=
 =?us-ascii?Q?L/N/6udKeh37gfXBPGoufq2uwGrM2nHzStACqCh90SbWGIB7+V+x/htYlH/d?=
 =?us-ascii?Q?zaeMkqcNZ9fgSK+tnmsAIN/KpQ/TFqmRSy+aOd2ooZa3L6/SnvRxPu8sLoC4?=
 =?us-ascii?Q?r8kKYFkXFvQ0oAyDLhgPWYMsrfWp/hhPXphq32tdz5FAtxg91nhLUug5P0oY?=
 =?us-ascii?Q?7Kocm6rk8SvkakXs01+O9R6h89fFZvMGSByCOpzFx8s71ADBOGgfsTobCt0X?=
 =?us-ascii?Q?eDKivoVxlGkDulSuEbE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f792a1d-6e4f-472a-34f9-08db76973a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 22:46:49.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0GvyuZeKzm7tEu7TROS/TcmEW9F9/ooxehFG/0LSSuxWv9cY1U/SCpnStytI4G++0MvMjicj7YtppoY7B4Mjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 26, 2023 8:35 AM


> > Yet to catch up on the thread, so likely I am missing something.
> >
> > The flow is for one OS (Linux) is:
> > 1. user enable SR-IOV on the PF device in a host, which creates SR-IOV =
VFs in
> the device.
> > (num_vfs and vf enable bit in the PCI capability)
> >
> > 2. VFs are created at the PCI level in the host system and also inside
> > the device
> >
> > 3. A user on the host may bind these VFs to the VF driver
> > (virtionet/blk or vfio or vp_vdpa or some other)
> >
> > Between step #2 and #3, a user may configure one or multiple attributes=
 of
> the VF.
> > This includes feature bits, config space fields, vf msix vectors and mo=
re.
> > This is to be using admin command.
> > These admin commands definition is due.
>=20
> To be frank, I am not sure binding to an ID necessarily needs to be gated=
 on
> provisioning commands.
> What was not explained at all is what purpose does this extra level of
> indirection serve.

I didn't suggest gating binding on provisioning.
As written above _may_configure_.
So provisioning is optional.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

