Return-Path: <virtio-dev-return-12988-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9E0EB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:43:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 67CBC157F1F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:43:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5585D986509
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 20:43:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 482789863E1; Mon, 19 Jun 2023 20:43:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 338609863BD;
	Mon, 19 Jun 2023 20:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlaZtKonKjYe1KdNpV0ukO64EpfooSjHgw6q0qciuHEcUqGD26/prvnExzR1Ip2J5rcv8tjv6lKzuHsGQnsc7P868ZQfHXDRkfIWc8Ze5KZ14RA2+qfSBSRnf/ufFvRW8czqCy1JaHbibXhfE5E0Lm1K5l7onfcC1JgZsP8RfSbdy80N0N8VG6Y8DaxTYWP25qZAtEn6PEg+KG3LQOeoOzQcDS/xJhRmqHuZKnRUiTbVvtd0DzVKKblx1vLlKST6w0m4CmN86IEsB1vB0pqEztWH/U4YGyJI/Q4V4pNr7W/CdjqoZ4vfpXHhSBhU3LmcrcYrWR8/3V2xiwssO5/H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjqIWKijqPwQGk3t9mLkoSexjiievJ2cDeB/OVm5VJ8=;
 b=KzP4hVnRHlbkFB3ptLv88vK83j4fl9ti/5nnPgNNi/Lbrr1UuZ+nk8PhQB26swsDCGLXaFA77f4mXHfznvedMtg+/25iZ3U2OCz4QzrI4DCh18Y7V7OfL/QqCI43Koc5q3SE9U3QdTKlzZq344wYTVQCqDyPNM//mvKrchCLsFJ0kkrmk7hIzlfNAcMCpO1N8JFZXVEIkvf5zr73Q8pqfCUxg6Lmtx6cHjXTpN7UFqw31vC6iELd63PJVBy/3BKD12y1B6C8ZTPvMsROoidffNGnvJC6IPraiU3uAzvvn60kPx0L872AhHcbiIb/+28HfbsOxAENA1mgKisMdsIRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-comment] Re: About custom device counter
Thread-Index:
 AQHZnPYBhAj3P4GR10mqaBAnc/G3uq+Gs4AAgABUQYCAAWnBgIAC+GGAgAIVnICABJomEIAAHvQAgABqpBA=
Date: Mon, 19 Jun 2023 20:43:36 +0000
Message-ID:
 <PH0PR12MB548187B11DDE81B452E13507DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <20230616101113-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D058584D7AF742C1FEE1DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619101745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619101745-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB5019:EE_
x-ms-office365-filtering-correlation-id: 478245d9-83b6-4932-209f-08db7105dad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F8CEOL07QEP6kiXPO4pNjqG61ahzUaw5n2vv742q9uW3pG1SraYJ9FVgRMVnYgSi15UmoHgSHx6AfC+IzG6iHWSkF6aGP1EBC6UTNKzOkZyMU4be4ERrq4M4N0y/rGG+M2HvxKA6V1C6yEN6PyT2VK8759CCAaKUnjaBBQ/2ON74S5XQhFR/yObtq5R9gKrlUudGndXhtV8cJpokuuGmwb5XnZ039IcRBfhfgr04LUHZdF5soQSwK88AvZc9s+buBqlakMAxtXgV82LYcLlWUAtSUHGeU07E86EDgyPTcDD/UnC2nzdox36VHvNx54h9cScbhPK4U5pnik3nKeWxqaBNq/zP482BwIIOGu8VIT/fXVZr+ugKeJnHFyR/V+UPN+/Ez0vz0zMAY01iwUCEyj+yFR8g739L5yiVYqbI0tVp7huSPrAKH8A/lqj1bc8TRZWacQ9E38ByHjotycxceCP0h/smEG57ddr/WCI9NKXornkIFuKCytspIznAPRGfKnZF0HOzoLDbsbpq2tkOvv0sSH4vbLCAyeE3vUgGrvkO7wQvvdZq+v4mdt4bdxl5sMOHFUCPNZm5Zofratd3thUs01vYDKzHqj8k188auoHPnVS+TUytErd8Aa2U0Nmz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(2906002)(52536014)(5660300002)(38070700005)(8676002)(8936002)(33656002)(55016003)(558084003)(41300700001)(86362001)(7696005)(478600001)(71200400001)(186003)(9686003)(6506007)(54906003)(38100700002)(316002)(122000001)(66556008)(66446008)(6916009)(64756008)(66476007)(66946007)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hTXGo8ins4Ckg7LrE9dcNeQE7hNu/EwDRXfeTepnSQ5Im/94Djuun/oXErI9?=
 =?us-ascii?Q?JDOOCzaZul+hODySNO3p8V8hl/UxXUCr1W+6miQodrJvo+Snjl99gYQSRyoB?=
 =?us-ascii?Q?GjV6RH5S6NlRMhlMDEhtPsThlVD1+KzgNfmsq9HD3H06uV/WjhqvBFfWz/Vi?=
 =?us-ascii?Q?z6MGg4h1nkMcbBwAKwYA0r6rbDONZGvVn8rW51hHlkkTqtnw+1KCeELfM2Uf?=
 =?us-ascii?Q?XfvNQPxhRo9yMXmhaFjkSO4kGaNN5tBFuGZtWtEpTkK6HlTZ3cJ2Cdy2+Lnv?=
 =?us-ascii?Q?iOs4u8c+F10fQlYlfAfhOws7UA9haDbgBfBQ5WB+wJ4BtITXwWpkjxVC3dJd?=
 =?us-ascii?Q?XBkbZ2xNfL3a6RWZGcyfNgvzRh5f1h2cbdm86ZTm00Bgv8XEddNj2JBnu4kQ?=
 =?us-ascii?Q?gkKNNjRib9TP1ogZi7lJVxyW0OzMMhtJuLDobfiBBAWn1dhAXjRGr+UvrSmR?=
 =?us-ascii?Q?+MCAiZBG0ePRIFf3eocEqytBceyO1qBVwX5TuUnZiZu8ej19n3nW74Kf4Zbr?=
 =?us-ascii?Q?iITkUYpY579fdiUW40MEHdZm/3Ofq1HQP4hBAySZnDLp2iWxgvFPsWCo49LC?=
 =?us-ascii?Q?HQQnyTB1n1CShMjvgUFeB+quH4pUGmCzlqm59nhFXmFu+f1wEM2mhLGHU3Hi?=
 =?us-ascii?Q?m9N5EEq6xzZqiXvkisuDJZEoAWMV1Jdpe9cY6o0ae2Vi0C9xQEiS9QxP6Ip5?=
 =?us-ascii?Q?ILm+kFDO7JKTagp5LDq0CBEZcbgI+Cn0IFs+KvxUgXc4XV4r6B4L9Sg4clCr?=
 =?us-ascii?Q?XHypOV/X74aBo+S1z9FGSTwEkER/eBscsp9PIug/NlvS7UtyYHCK/oaAS5kh?=
 =?us-ascii?Q?vR1oy1UN7S7WPrsn4L6R8iakSDT216PnlI6ml+ZzaHpKihsBxlGRVX32wiI2?=
 =?us-ascii?Q?4k9Pgbz9qVMEEYruMMUpYv7824Ka8Gtx4DIK+NWZZOtVgALJajcYGeeYmaAF?=
 =?us-ascii?Q?9b+3v/Gjv+HVCb6mkReB+y1VGGcBJ+bOQmKquAsLxXDuVPgjKMTy7qADtigO?=
 =?us-ascii?Q?huiZaeIPoh4Q5YwUMw4FinFIUB8dWnt9/j9FxRUxpKUTTBb23bm/xc6dbxZ+?=
 =?us-ascii?Q?9ynmprRYeOxaWOS4sufc0/c+1/mnddf1Jc3+5UMvfhkAOK2nEKIwkrrLQsTk?=
 =?us-ascii?Q?R27xKF/J+UcoIOs9Wh2SUUT92Q8BIveSdWuiSRs6+onVpfzNnq/dmxTYRDiz?=
 =?us-ascii?Q?t4Fgw7xsBpFaRkFzvpyynBPIHTyuX6brSoJWbsM8WNyXdZxTle1Qb0GHAtsj?=
 =?us-ascii?Q?E/BkbZxg67IcMu/abJwb1103hpAOlliwSo4ZgXlTuLJuiZg6i35STowvlgXo?=
 =?us-ascii?Q?Ease5OfcHcKSBTMAbTZvvRF5rgYIbUDk3JkLWHBT6nKIKtSvPVhG5W0Pq4pI?=
 =?us-ascii?Q?wtRs4uu1awx3AhupsbCn7QtDaiM4Heah6qRsNoncV745B8J5yCjpOUSEKFcY?=
 =?us-ascii?Q?ggUOdz4e8/tD9ln47uImRG40ePhYumdH/lo2zy23dDcahmnjpUSvPWbrYmGK?=
 =?us-ascii?Q?a5tlNGfvxQNw9GyKyiwFMIMPW1JMfS/38M3YQvs9eRwpK4ENtKBvJy5lAK8f?=
 =?us-ascii?Q?4R0jBWa9rSHFSocAY1fgNPqsMlvcNiuwYUZsJoNF4rmBocARlCkpPDkdhUux?=
 =?us-ascii?Q?FHFqsLm4zaCXZMV1JCG9rZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478245d9-83b6-4932-209f-08db7105dad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 20:43:36.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBsdTLX+itlM1a6JQ9lohCcLETzqGyk8rVp6GiKDz27ChVFC0YNYvI7hgY0zeH9FoB1YDZ0DjT9p33d8rU59hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
Subject: [virtio-dev] RE: [virtio-comment] Re: About custom device counter



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 10:21 AM
=20
>=20
> Yes but Xuan Zhuo here is saying that he wants a register that is like li=
nk speed,
> not a counter.
>
I understand it as counter because Xuan is saying counter.

He wrote " The counter is for the user, not for the driver".

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

