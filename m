Return-Path: <virtio-dev-return-12685-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E3C7EE26
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:06:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 32BE533572
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:06:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2266D986706
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:06:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03B689865D7; Mon, 15 May 2023 15:06:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7251986509;
	Mon, 15 May 2023 15:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZIs8xiKVNPAdz1dIPROxgf+Ek9xvu1K98veuRUgjl49fHj4rQ6MamaOVIUag4CrDiahSzhfgw4lUbwSqmsg9+PeQIBHzTGUZeWHMjYZAfNqzWCdPkDUaRGUaTqs0L9NrPimJ+BPsEAO2pQJ0zr9PoNf6XFlJDcSMM3fQaVT3jOvsPTCAlPec7wmZEVb/Fbqd7Uq0LLUN8H5NGt1DUOCqr0X86ONtdxCAStgWCEV3+iZ+KZ76mVKpp1SueE17orq3CyEdlLJ/G0/N4e9puLr9LQrvDxOxSwM1sjuG3Xpkuw+0v12+LWYfcYDzUY/DAOWee4mNYZj2oHULo/KV2POPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE5ISNLSlGHFQbkizfH5Zx9N2/szHLSjpxIklsudwlM=;
 b=F6BctNOpz94uRF7vglaB4TW7luAr9SfnzIzVH4iOJwxTh7uyDJgExVImLtnCKb3Em2y+KvLQQIbxhGHTk7+zATmsTGjeHAoFJJbHcb2I3IhY4IIU+1yxNGUn+wMoJOEHCGTnz3RedXii6M3nicQ1S55XWN07nvBdA+lkjyD/kC2GU7yoMY+AJuYFqDM3Q4O8tiVhVtgCt4mJEHCJkQWM048du7Cj3cxpGEnvODjpq8r0jMpxU281FA2GyfNlYGqOLtFE7aRCZW7fCDLjzKaGIft7mcghW44/vmWjsqpo1S/4rIMk6kD9uQuaC7fSLvnVf7DiDOz1zSvg4KzBLWj2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] content: Fix type error
Thread-Index: AQHZhz6w5WDsIj1w5UCRPVh+cBbuaK9bbu3Q
Date: Mon, 15 May 2023 15:06:14 +0000
Message-ID:
 <PH0PR12MB5481AA5BADB2A3D928C4838DDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230515150457.760478-1-parav@nvidia.com>
In-Reply-To: <20230515150457.760478-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6857:EE_
x-ms-office365-filtering-correlation-id: d9958c32-cd9d-44a0-2717-08db5555ed75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fa9jtesSZbwxSuCYuiA487CfEoR77DsWmyfMFoweptOqID4+f7unQiMj3S3788IC9PFvb3HeYLhDy9yFi4ttCv8OTt3o2WdoXEbxQbkAT52q+LL5/b0ZFedB6qXHorD9AXMhL+2CpzRii7wuoD/TQzyQwaKpolHu+S9Qdd57CIADsEnt6ZzjPOCvMGlRIqXH+NAA5bGd6Tc/vLMGCNh0LqPj/5rAQF3UwjAQ/HdFXfBQw5f9hDwGqGRcPpghEfB2Lda2DDV0h6HutAPnobMm8OnW/GqJlMKd8C9aUiB92vjIX0+HgxaZY3/o44s2xKHTsJiRMbPD2DaJiMinP1DbPkzIoA5dmZpRBiRShr7JssOUZPrlu+TzWTNlmZADZnp4G2WayESjijR6GrERTzFEv0KTwLcgmvPIH8F8vDL+lif4Vkp8x1Cg48qeM/fx9GUgDU/8y8nfDYniOFnvzw73s5xMvmyvUAPA6VKUs/c8nbHwV1H4Xx1CmXo8x0V1VygWDgHJtRJr3U3KfAOC5WvwM14zwitZwaaKp7WKoGalcraMmI2SEZWoEmAzajdf6TrWwuYkFa0W94vpMsqf8JtUThMA+Zj1S+vOA3OAiF70QQM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(8676002)(71200400001)(478600001)(41300700001)(55016003)(4326008)(122000001)(66946007)(66556008)(76116006)(66446008)(316002)(64756008)(66476007)(110136005)(54906003)(8936002)(38100700002)(186003)(107886003)(9686003)(53546011)(38070700005)(6506007)(4744005)(2906002)(33656002)(86362001)(7696005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IotjVKVpRQvep9eUmtJNejgkdUN69A7iYkKB1bwI2NsRIIwHOzsiAooySetI?=
 =?us-ascii?Q?WSMhfb788xgnJ12hePj5zEDmmhv1PgtVJNEk5FMpAKTVjVdGtg9qCizXvTpc?=
 =?us-ascii?Q?3NZrPrU44peflqZ/Cq+gGR+VPD/Ojn1G96EhghaqPhWudybTaLFfSyWQTj4z?=
 =?us-ascii?Q?9Peg83LVydctv+9H7bSwqJTw9lIT8tj0yas/AOX+LepPM2khXj1ADs0cQt4p?=
 =?us-ascii?Q?z/yLhVszQJAWV3WW0SYMceeCdgr6J/susZUPchje+wZMQZ3CgZuO9x6z2zEl?=
 =?us-ascii?Q?ZB7nid3FUkL2iWzuE9k9t9goVEoNIgJhF+4bsnrDBH+dosny8GEQkDjj7xWl?=
 =?us-ascii?Q?Tbuj7G/ne+clr79momo3b1D6yuOCrU6YP2YdTMvsXn8jESZcdzOLtDwjhF7M?=
 =?us-ascii?Q?h2AT7bTe+HO8neBDm3WQE506GdrcGilrKV/1ekV96rlRs7b5ppHXzDuQHQDN?=
 =?us-ascii?Q?7zOJorpoGmV2F45HuMdGgpN+H9aCtp8kIBEbNTiw1hpDbn3C7iNLF6eVdoaB?=
 =?us-ascii?Q?BtFDHN1P4ATpwLApL9eCijA5NvX0nzQgCoPhnbxzQeDWD0L8/OLfrqIt1emP?=
 =?us-ascii?Q?F/EcU0wByo407TtRetWK8/Ve5orugK0kQKD5zbWYw/KPiChpjntHXtZjOzN3?=
 =?us-ascii?Q?YHaTKUGq/l+7Qs8MHbtsZ3wPfNqQGdJAadJMCcCYpb8vNeH1eGafXlVGnzgz?=
 =?us-ascii?Q?ORAf+5AamIY/LCbReVpP7ht4YydBOnJGSi8QDOJhSgXb3CGV8c+izKctYaAN?=
 =?us-ascii?Q?tRRTK4DHLwWa0Q+HDAr9WlPa0iyMoey/ANKeaXZbiM63LyL0xIAkgD8psuSg?=
 =?us-ascii?Q?knWCZgkUW0WtiermmjhcW1Yj3CuuvlEdikuFmK38UcNVTXDpE4Akxp4kJulK?=
 =?us-ascii?Q?L8hpxNa9s+Zy6Zii8fCUqZJnilHCSkqlDso/ZeXgnpBD6urECnWxYZY4vjTA?=
 =?us-ascii?Q?cvQ89Vm4aZWm1cLIcFQkFNkgeBfSuhMbFVcz8Re15kUdfK+V3M1otzWUAnzD?=
 =?us-ascii?Q?GCex4DU27nRh0hWvu8o3Tcf5sL5+564ldgcfAKd98b+lzJJnSWhG91+nyV3W?=
 =?us-ascii?Q?9zNTK4r3fTh7yhSOsFML5T/w7aP4rvAM+3PbMkjKvXjGR7XWguFcqQ5HbERW?=
 =?us-ascii?Q?GeTTw8HvAIybnJgTrtmWR7XtkGDefoDO62sP7OI3fcAHLpJydIeGBM9eb844?=
 =?us-ascii?Q?RGpI65suCL9CYDUdtGL+myWtWop12qnJ7YsxUCol8/5N/bmIcGSmTPyGghiZ?=
 =?us-ascii?Q?GctG0HFCwPYkgJVc9zRsQirKFyu2rT6dkqN8lypvsuJyFkUPcbGQlhFwYSsd?=
 =?us-ascii?Q?Qb3liVtyoB21XVSqjp0YFDuMjv8MVtUja29QrpfFJuSLiOCcyvNU2s0QaSeb?=
 =?us-ascii?Q?3X73R0rDKLEg/eVgTOdG0WRvAcuIsQ6fGtmeCmGuh2pTmeILL4Ci8MQgSZsg?=
 =?us-ascii?Q?fUpA4nffF8thDhnlr50mqkhKiUzIoZHHc2QfEUFtnOTEU9y07oNVKfF/Wdr9?=
 =?us-ascii?Q?nt8XOf7eutcjZJ9uvBGqHnaDb9hJ3O5PLf9W0S2ZD6c3fIcgVoPLxyLO4PhT?=
 =?us-ascii?Q?PVVSyKhJcXnS8nBzk0bKCzey83G96x7LtXbTM+x3jgeSJYw+Sz5zMqT8tXUK?=
 =?us-ascii?Q?VaicKMMsNzLAyOsfxHqMriM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9958c32-cd9d-44a0-2717-08db5555ed75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:06:14.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zhQJH55QtckWt6bNQwJO/uZfNj8q8Ll43uA2EpE0Bw+vQQ1iQ5cfW2mnwlwS2uLspfucVWhhX8WFfi4PxuDvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
Subject: [virtio-dev] RE: [PATCH] content: Fix type error


> From: Parav Pandit <parav@nvidia.com>
> Sent: Monday, May 15, 2023 11:05 AM
> To: mst@redhat.com; cohuck@redhat.com; virtio-comment@lists.oasis-
> open.org
> Cc: virtio-dev@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.com>; =
Parav
> Pandit <parav@nvidia.com>
> Subject: [PATCH] content: Fix type error
Sorry I was supposed to send for self-review and used wrong script.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

