Return-Path: <virtio-dev-return-13539-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1CAC04A6A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 07:25:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 118742B136
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 07:25:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE67A9863D7
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 07:25:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D995A984035; Tue, 15 Aug 2023 07:25:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C781598633F;
	Tue, 15 Aug 2023 07:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD5o/bxnfbZRsyCWo2KLVk2O9Kamo4czhfsjvERji4wsQNnBXXCcqM/Jpwf2yO5gYMxxXkRal4L20a8lbSzoDxAZqpfHSq7v8H5mszsD457iO7uJT0CaSnCvar9ki+/67d7p+WONsMPuYNXql/ESK6mzZNSZ0INQsbql1BGKZmCW7AMilchFegk0CfXPN6eUPX43s11pRV7mAQrPs3svl3tHTDX8EVOP5UqKv/Hxu+dDoFJeodGfkgVX0a2dEuz/NIbw2/+kg7cEMpTx4aLS623SR8Tqw7qkFeNQ6YRc45pLkRutizm6HofASdNZW+n3G6RnArnieU3TvobXINB2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bhbotsYACPrhH5C2qd8uKol14x4n9uOvt2ADKRTXXc=;
 b=l1J/ftd7njCppIw5En3CCMVVzZJKfB66Olspei4sNbKRQkvyUVyffVsePVplPdUi05RZtV46ZCvJnj5RRYbTaKwtIV6JLBQGvMA+vLMt80Cj4pVI5qvg25GBicUvAWdFBMCn04FTI9PjhGbZYk3u5u+T/kuxMoA74Q7BHlUIL5HU63bj1QhU1cX8SWxxiFZW/+sstacRzVqpL/xegyVWs+AciLhGrutblWcchtbllmIRwDKkSY47b6wf/i8Su6/3Txq35qXwJcM4LYa1IonwwXoKpNy7UjnxMwMSTpvb3G3RCEF/4IGx/ZLexybIZ0S1cAA5xAp48aBA+5TMuKdHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support
 device stats
Thread-Index:
 AQHZw4OXY4sLFyf1KUOg+p/lWPzH1a/eZgaAgAxnGoCAAA3Q4IAAGTWAgAAEDMCAAARVAIAADziQ
Date: Tue, 15 Aug 2023 07:25:30 +0000
Message-ID:
 <PH0PR12MB54818284442C3DE2900F5E13DC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230731074945.108883-1-xuanzhuo@linux.alibaba.com>
 <1691388913.8316696-2-xuanzhuo@linux.alibaba.com>
 <1692070761.567899-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54815E430B977F2969C9FAEADC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1692079141.2231495-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481A89E24577A0FBC1F8D35DC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1692080940.1446962-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692080940.1446962-7-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7163:EE_
x-ms-office365-filtering-correlation-id: 62d63ccb-0c40-4636-83de-08db9d60ce1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fn+qTIdC3GuoaqHInaCdY/XtALaYTSU8qOuYRQGIboe3S9+2BU/okNPQzb1tMIzp3X6m6Cdf9SXQyOdpEtb+jsQcWRvV4Zzb+BjWlwZG3YlB/Phqah7fet937X5Ylumupzzzin++qpftSypFpmeHVAXvH9N5pEMa7ESKg47i0V9CbYRIWZpia26sw0y5zw984+BXfTc+Z8TMkM6UjZ8ruRSPdSxIg0qtjUcAIU6+Byw74uLSKjaRjTreD5NZYZO2Mm77zkNeBcSI4rbdYM9ofSgJOeWBKZIKO6P2eqt0E4WUIOufEIQCZ1vKO8UBzAYH/7ahnLv4vxJnf7szmPbeHEXDt3NaOuYiaUtLVS27f5KiYlVoP7qG5gHmpx6t7jZqyY9XH1GOVuSLEsG2CZRlFJF5HX8Nk3TG5Md9vgsRCsz8h9d7tEQ7xJZrkjbtPztaP3/Ee8HfLgcuEGbZtLA5ec7+MaJ/GqDMcIvVmitIxfUeCZJuIGxYKBii6h6AUSUDYnOemUzcfL6Gl8yQvReDM+n7qdROzAFyKJJBkLBjBiOWKXV1aTroqjZdkQLqVi7INKTxRDlkSzg7wpm2+ClfBeMe2lnguyRjMRXMrad1O11v1uoxSu8bIjns4RfPaTLA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(186006)(1800799006)(451199021)(2906002)(4744005)(316002)(6916009)(83380400001)(66946007)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(55016003)(41300700001)(6506007)(7696005)(71200400001)(478600001)(9686003)(86362001)(5660300002)(33656002)(8936002)(8676002)(4326008)(52536014)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hu6m6bZIlXsoJu+P/h1MOCCphAa1Iekro9ddIqxBFvqPXBOEl4oBMJjb2eZr?=
 =?us-ascii?Q?gR0tQuizFootEHYAL4v6R7s5xoVDowX1tYSufhH0AfaTp96lmacvR/rkVqnL?=
 =?us-ascii?Q?h7qDXt6tO9KMfJcTHYrq0dBEIgoN9lnh+7eqRGgTfx6PSAzR/q0GMo0tpdzl?=
 =?us-ascii?Q?6SP7nFg1vozCeWBdUOOmkk6fvKwBn2Ld7PQAYjK161BuNUoFT8/muH97OJ6R?=
 =?us-ascii?Q?VQfouKGz40zI3rbnQAAMsAXmNoWSQ5I/bh9AR76799jqswzMS2Ys0vfugmhe?=
 =?us-ascii?Q?SK8M45BylwVEe+EsUsNeZMeQlUy05m4ienkAACJLKXe7qYkYuu+ScDu82XkF?=
 =?us-ascii?Q?NeFpbZPT/FAE6m4OaF0hr/NR2DUGG8Lb4k6+4FpXaTbKfp3j084cLbinzRH9?=
 =?us-ascii?Q?6uAY+7DdTnRoTS6mTOvL3k3onZg+9x34Z13C+9NcFAjX9jNNC04T1tKhsmvr?=
 =?us-ascii?Q?AA4P3z2SN5uIttTEr9uUwsAD0m1tMaSxij5qakn70RAvJ2r4mgYcDXUAwPWa?=
 =?us-ascii?Q?uErzkXLIbUZnnKs018A6mTIiUj8PiVS/EYPJetnfymfThwRSuLRlN9qkBGnc?=
 =?us-ascii?Q?7HwDRSmIaLLMdqidIK/qTSNMEWeI7Gap3Gtuglz1h0gCQ00jK+grlsX4lI0Q?=
 =?us-ascii?Q?i2oSYl9fhOHJuKI1i35amYgbpmbqGFsxEfWykMyG0i+kZnagfcOi2rMKfoSh?=
 =?us-ascii?Q?vBsG+Z6sOYBTpQcqHZxNudFT9xjNCVJmddUggo0zd+G9PCqCgX95fN98RW/A?=
 =?us-ascii?Q?yrAwNy94Kt1MrBE8764QxJcwu/Pr0MLJIyZ6x+3gL39f3CNJzXUAXechZGOH?=
 =?us-ascii?Q?FU8N273Po09jGr2fy8WHsa8mZ58Zf4kjoKIWaDiVervrBSH78tkNeSlR+7OM?=
 =?us-ascii?Q?PkAJlkFf0FW7KNU7gHgwtGxlnxgAh2FeG8shW2+pCHF1jk19GcY+Y1bwQGeg?=
 =?us-ascii?Q?r9PEGXThiNdJy3pjl13Bgq7HAXWiW37WGzF4a9zG+XlDinCaUEdZM83PFS4r?=
 =?us-ascii?Q?KgL8fPEIkxTHhk3WqPrX/wwoRzr7Eh6SYMN84YBlxc4XbYKn6appv6ZRvTaH?=
 =?us-ascii?Q?I4AK43YTI6CyP4XK/v1T2X1Sy6qrR2gsPdbP+0Z5VDQ4kKhZPKRnIxPLU+Ps?=
 =?us-ascii?Q?7VK94zRuNxipCWLODvJFLSSIIP58bDD6rptfzWlKtF4rIJNHa/fkfgmn3V3z?=
 =?us-ascii?Q?V1EWmL19xZZNT47FIvkXVV6WZ1LKhrDgrn6T61Abui6hiJBfbnj/Ewdy+G0I?=
 =?us-ascii?Q?Z6jhqHOX0M4xLeujHoffubmZbN/ZFQOhKgiQ9kwhXKE1HbujfJuk7DO4U7fx?=
 =?us-ascii?Q?6V4q25DBTsyl7Y+RKyCoFhAEaTLGCZ9KtN4a4ZhI502X2IgMVSPMJZOwdq3G?=
 =?us-ascii?Q?0U6Oc6B9LBFV/wuj4L5n4jFOSvxIm9hFXs/87TW+Fa45ZJw7fraMTeVXTbSc?=
 =?us-ascii?Q?WsnsSBFXoEPFTEqIX/PZYfH8OLTKDhLEwfrY4Y3llrg4JG4Qe5X55LpV3GTX?=
 =?us-ascii?Q?VX1kAYKeBGl9QZbzjdDoASmBpQJ4b+6QIy2RJuQcL4xoxGNeCZTJtSN0+7Hb?=
 =?us-ascii?Q?mZV1dvIhSzHmiMjnmB5mV/JIPqpn1t647OlzmMJAUwXinSGicUufTQIpuetW?=
 =?us-ascii?Q?YaLefgw4QVjmXiHskN58Vac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d63ccb-0c40-4636-83de-08db9d60ce1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 07:25:30.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DM1y/GJ7aG285qbxAE2CeFOexK0OMUvo/fWsDZwxD+61FVNbDgQTI8bt9A7Y+lqYuDTSjDiZcmUd+D7TBi03zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
Subject: RE: RE: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support
 device stats

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 15, 2023 11:59 AM
> On Tue, 15 Aug 2023 06:17:14 +0000, Parav Pandit <parav@nvidia.com> wrote=
:
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Tuesday, August 15, 2023 11:29 AM
> >
> >
> > > This version already has the bitmap. I forgot to change the commit lo=
g.
> >
> > Please move to access via DMA interface discussed under subject "virtio=
-net:
> support access and control the member devices".
> > For virtio net this dma interface of cvq already exists. Please relocat=
e it to a
> cvq command.
>=20
>=20
> OK.

Forgot to mention that please keep this bitmap as an array like,

supported_stats[1];

like how Michael did,

le64 device_admin_cmd_opcodes[];

so that code will be able treat it as array + bitmap from beginning.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

