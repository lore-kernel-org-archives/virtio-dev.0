Return-Path: <virtio-dev-return-13535-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F57C0015E
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:37:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B21F3747CC
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:37:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A30D798644A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 04:37:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9702C9863AD; Tue, 15 Aug 2023 04:37:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84B3898633F;
	Tue, 15 Aug 2023 04:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epJoeRCeTP4Q+sw0+/crKOJ1jNJolja8vqwZffrX1kzynJDqe7EuX+tKUKIj8uAULIkk1IQdjyauhcE/rWJsdVJvAt4OMJBkFm8GrJcbLALOwUUTo4G+GZVw+Rjq7PpSRln83MRtDsfDnXFhNggKRkz/TCdEoxyuGI0/P9sX5dv7w/iaxSUkngHqNV6puG8DGFPIF7p8XJEqA7vJG1/Jhgl3JddO1Et0C/6CtTmus6jWw4BllAcJn67dPRNB5i438Ov4B4kjZB7Jj2LXH0+E7rZ1lKjXu2xwEWL+Ep+nXHHnXBzFw6VQ+GjwaUnieS4/nDPGdM94lmF/nm0Xy2Ax0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMAMzhwAS0B2JDgIsrwR9I0NPFr5fRdFpcAwHbIGJ68=;
 b=gCE0Bhy8n2Kx2ASAzQQAbTrUJt88G0CZjwZ8FJb9zm4oplVoLMV3qs9Wu35zVLEYin/kURaaFGqwAwQerU9cs2IEUY49ieSebZHJ1aMlhziK98mNO+xIU7LOWbUkdDVGWLiUzDJLc2MJmou35q7OWPD34JGqBdX1WezHkpoOpcbyx2oPhF8WeUigSLoAfKPOujOisiOxYVVFwOR5JsAD8rDEJTHabWod5We6Jj6YEkn0XFQDVHVj8n9+QsSNRg1OsdHj+k3NPnm8quBUl56y31g+HFHKZb+fNqrUFdmIOvEmHcO77vSRj6fZqYZlw20kKEBe1kEunPpFvZAL+tOrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] [PATCH v14 RESENT] virtio-net: support device stats
Thread-Index: AQHZw4OXY4sLFyf1KUOg+p/lWPzH1a/eZgaAgAxnGoCAAA3Q4A==
Date: Tue, 15 Aug 2023 04:37:41 +0000
Message-ID:
 <PH0PR12MB54815E430B977F2969C9FAEADC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230731074945.108883-1-xuanzhuo@linux.alibaba.com>
 <1691388913.8316696-2-xuanzhuo@linux.alibaba.com>
 <1692070761.567899-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692070761.567899-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5726:EE_
x-ms-office365-filtering-correlation-id: 87096544-72f4-4292-c93c-08db9d495c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fNJ7niu/HYzrrn3xr/OZkFVCdMo+13bwD7oxLGsQI2vjzZBrtmFcITY1HTKhc1H4tLcZYHQuMZKNJuLWXo8IIBY4V1p1VWbgFrpg5v1U2XTrratF23Ds5vqbfyuMjTsZySzV5M8zUX/sbWUFyjIicDEwlwKnIF9jgueFJWOg/D4a6xdcZe3fAR6pGVmOmKmojJuURjI0v8FdctU1xaN0Eokd547ezoXlkHZ+Rjqjb2AGsoeZ2sLd6+i89WSbsdGf+0tTOyJdY0696r9zphFRapIEJt9LNie9X2z4HqZUXvcWvTr2RXWJL83VTJIn7YEOiFevsq9KMLQ08uc/JsE399r+phOU15rTwmdSKZcmKTrYzbvONATfPGcyBUzLJtXEi+h7FmTCWuy3XjJA62TMSnkEC90o8swhbC4z9kzYQmZ5yzseEA5wJsOgYHOFf/Mh5aPsmNalm+Il0PpwxqnXX6aLdCl5p6E8+eW+MR21kWjLdQNsUWtMpxLQuqXyiMbBOjIw/IZNfiwqoPrrD2INvfNVkFi1SCGUrVQZvZFE7tRF31qqw5ycRkK5vdy7x3kdTq5eF4UacaA7tVKvdTpJdgEUJsPBxU2h4M42b/EA84EZThmfTxFklm6r2VvcKcgO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(186006)(1800799006)(451199021)(2906002)(316002)(66946007)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(55016003)(41300700001)(6506007)(7696005)(71200400001)(478600001)(110136005)(9686003)(86362001)(5660300002)(33656002)(8936002)(8676002)(4326008)(52536014)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4NRQmLbFooXIx06rg7vnCRBsG3Qv//XHI6btmzmBSuvSmhbWcaw6f6BCqHBb?=
 =?us-ascii?Q?dxn1P/sIqQNbaWH5D/c4iLW1qgv2WOpOBZQ2xFRiVG3siUf2YkS7OraJB2IK?=
 =?us-ascii?Q?gBclPgzrqn1YUmcDqMUIjjh+ucKMxe/Z2szhFNFN6SIyYnlFVv5L4jmJ2ITL?=
 =?us-ascii?Q?UvVGCxfTGQ/v/7Uq/DNDg5AA465KHog4opMc/35q0ZtTl6URthJfJQ6rWPB5?=
 =?us-ascii?Q?dN+XyNLRbZtY7xFdUtWXgAxREJ9S6Ugod+pMipZaNO/ylYo2ePHHVvp6Hpn9?=
 =?us-ascii?Q?YUBi9La0Rkvok66JITh3ZM7QMafslXrZsrxNh/qHVUNeKjW0e9o4mpIOH6Sr?=
 =?us-ascii?Q?eWuVBW6JzH4wSXW1Hii4X5Yfqw8SLMP44hLAm7GM4tx/XPY83EV5Ty7Oywbl?=
 =?us-ascii?Q?0fPOnfpvDMuzIZKBEFZRvPmyhGVdWMYKrDEmYVTLSLYQzWMt7VPSZigtac1l?=
 =?us-ascii?Q?fa0ZdR4yfKAlTu/egTBadTOpuwtr1jrJ59rMPPihs+42Ww9JFLiWR5sSKdK+?=
 =?us-ascii?Q?UIXLKpYxpiv/uWwxf5k0dkJlwZf7T9ZNDFGoqPcpWDOvsWSltcfP+5k+lVOK?=
 =?us-ascii?Q?9fVyJWFfi6TKociA5AWesiEwlE2rJXGHO0ZiC7Q6MYj1VZMtnFffRkDorNEW?=
 =?us-ascii?Q?nW5dzuODp460BJByrKslAj5wcIv5YrJdI8QpNVF1GnkFj2RNtTnDSRcNopAe?=
 =?us-ascii?Q?qAC0Xj/ypgQMZyiKbxMuaWS5BFQ9CAECr4+4jTiHUfG/zIOOF98QpOdEYpsp?=
 =?us-ascii?Q?e53Kxnrj7L1H66ZjrQ00m/Wzj8G6uKqY6jHNtq94TaNrWEIR1Qf1URHP7iis?=
 =?us-ascii?Q?+O+jR7NSaZ2H6GJE5nVif3OKW+fREtVbAP1zdJHlJa8YSaJjnaYrJvSd/0su?=
 =?us-ascii?Q?z/VYsUkO5gRf8PRdH8uCNqdEC/a3OLUt3b703fK0PAl7LDU01Hdy2FMtteYC?=
 =?us-ascii?Q?TQ59zcfQs1+C3D47WGI/26caAcexNwwtyS9J7BTc/iUpnJ7GLiX77l+BEcC7?=
 =?us-ascii?Q?jddPnI6KZ77pB+p0Ttw055FIwU8Eglhfvf9ko+Yp4W1OV2wfWXjlpPJ6RuAd?=
 =?us-ascii?Q?y47UcXZ2ho4iM3TvZKmr2mtrm0xza2BcxNKEZYC8DbuUayi8ux/q5E+/vlxJ?=
 =?us-ascii?Q?mDoCqmh7suwI+dZ5igukomAIT/hlIMozGj4tPRX3cvGfytiXehfw9s8IVK0i?=
 =?us-ascii?Q?SdPw+l5IaEt6/cRD+8HkKYjuhs/qztoita5I0fkrgP6NqCZFg+kosuS0a1k6?=
 =?us-ascii?Q?A8PyZhVhdIlaNY+oURWB/5H8+LVXNCvMIT3A2n2DfJ2OTgXHcjZ4armu5nAN?=
 =?us-ascii?Q?W/E+0dyBffxOpZACdHVRynfVJmGU2b955C7fC8rWuwN39kSwY4vRAIJtfxK+?=
 =?us-ascii?Q?4icf4slNhRC1QuaIUpqGtuODGQdIyDOkKTRL9i/2QzNPJqBWMNBs3iP2neo1?=
 =?us-ascii?Q?qCd7FCnD51XJRMPE1vlsmUNFFgCJHQ7u+Z62R1nLMg5e2hbhLgBoeScjwF4S?=
 =?us-ascii?Q?21irwGVo7dNUuznpWdNQ6p1cqPuBQlf+S9LNpM1D0B1zeP4YgOzjcKrejUBI?=
 =?us-ascii?Q?MVfGACFTtnCFSO1dEqcG5lXEXHJOPAUaka1xZJXWT/UhC336AAsakfGQFWxZ?=
 =?us-ascii?Q?pqtaz0pvDFxBbrnhPzFE9RM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87096544-72f4-4292-c93c-08db9d495c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 04:37:41.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6j0kl54UIVb3lpU+SlvecUYxwXe0sYUUQcz7z+topUWWbEGRI3wesGkfjop6YSqIRwJrLZTwz7QrGEx3U6S+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Subject: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support device stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 15, 2023 9:09 AM

> On Mon, 7 Aug 2023 14:15:13 +0800, Xuan Zhuo
> <xuanzhuo@linux.alibaba.com> wrote:
> > On Mon, 31 Jul 2023 15:49:45 +0800, Xuan Zhuo
> <xuanzhuo@linux.alibaba.com> wrote:
> > > This patch allows the driver to obtain some statistics from the devic=
e.
> > >
> > > In the device implementation, we can count a lot of such
> > > information, which can be used for debugging and judging the running
> > > status of the device. We hope to directly display it to the user thro=
ugh
> ethtool.
> > >
> > > To get stats atomically, try to get stats for all queue pairs in one
> > > command.
> > >
> > > If the feature is negotiated, the device must support all the stats
> > > listed in this commit. If we want add new stats in future, one new
> > > feature should be introduced.
> >
All or nothing does not work as its very restrictive model.
Many stats can be cheaply counted (or already counted) by the driver today.
Hence it must be an extendible bitmap.

Finally supported bitmap to be queried via cvq of supported counters.

Didn't review every stat yet.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

