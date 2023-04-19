Return-Path: <virtio-dev-return-12301-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ACCC77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:54:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 544CF1EDC9
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:54:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50D21986426
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 01:54:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 458DF986410; Wed, 19 Apr 2023 01:54:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33AB7986411;
	Wed, 19 Apr 2023 01:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYHc2xUFAGJ/3glVuf2Y29HyOJ6pxjA3aONz0JG7UkY4EM+HU5cSW+En0RvbA8m6wXo6OGarlZKLZYJMHbWNo81W5XEfs9Lb3er9xOnlAgk8dUol6aAx+Eyupmvrd1rfg/S0MAg3zeU26DvdEFEet9mCZVsmDzvdFLsr6xhIkG4xnBSN8xEbnSzVM2uLaLlLRG3nNazW3i2F+txGdWWHiNjgCqAXUECp5ul/qxcDCPSCLVYNkSeLppYhHhky/ysYhU8EY+NFAXV0EPOGX0+CKnMrmv7uayccGtGjHEAFD8UvgOO9yQG8J0urM7qHumsp6z1kdY1AuITyHgczre58Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laZBLVJ91ZUbStnGJob92HeUUpff425/VxE5Dzkbyrw=;
 b=YKvLmDzEjRyC2J9dzPxE4GxxhQunB2Wpp3QHEsbJxLkRqojSTzQrZesTupZuNy/GqxCF+teKcBudAtVEphW5eDanfj/QjrFHHsxHPtM+oXTmyLgqwZ/6I6FNwehF1R7WVz2ULJS38/UGCn4zKT5WBKBBpni5krU0tkm7SskoTqM9kFIIiW3w1dIeIiMq4V3bzhoBSkAWQpxH7969kMSNBlq4PIO/l4IaWTLogtl3XXgFrJHSuLeCw3IEJswNXvmtVP15rSRStyjkIHSHV9L58L/3Ap2qX4Qnmv5fTwT1IkG2szgUPeEB7hzt+30yLDZ/OzqrOzTUXylkP9ziKk7b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] device-types/multiple: replace queues with enqueues
Thread-Index: AQHZbLDQUabXUOZYdke6uzVPKsmTjq8x6iew
Date: Wed, 19 Apr 2023 01:54:12 +0000
Message-ID:
 <PH0PR12MB54816DCF95D0E40FC3645ADCDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411200358.753101-1-parav@nvidia.com>
In-Reply-To: <20230411200358.753101-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4104:EE_
x-ms-office365-filtering-correlation-id: 13f0ded8-3e8f-40db-8b44-08db4078f96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CJe4hvKHvRfNrDNkowYRdnpmleA3m/z2v0GG+kQIiXrTs4npcLXNF9UEEoA85NEVv6JKrRMWFhf0HXdOFuJbO8K8qWtccx9XGgTOAvGGpIu2DMAINoNsF4f3VNaq30syMgEfSfYiLDK4ebc4v5IbdITvVysQ1RLWps/pAG4A7tMh/MgCKSN0zr3mqXOauFUbQbqhZqZ5u7ZypeKJDZTJu09WbmBIXEwIci2h1/M/J2hHwnrLHsCmZ/pL/9L/Ghl1Xp/psgNZZYCHPWxMtkKTpnILETG/srZ95kiQWPH2JwZuGJsWeMDCt9tCCzF+k7j75Y75EFffAo20hgllJvTDqhbmGez6PbK/01M0JTCKmw9x4to1R+DUOkF7RLCXD4Rgxys8ubNHARxMMRHrxv6sUzD1pvTQcLk4QIWthl8cn8pBP2IiB71AQl79aUSNdW9ZCNmep3LiCnhUY8L0uaGDmcWMXg8k7hG8oAE25W3rx6kRfyTX+JHG0f7AvPIaK7zsDNlmol4DiazKHex/LV8OVJeD9Ds0pfCXOP94ShThGhQNfZZycDir7ufdYW8/zY3jb35+psxAmZp4QSctRvuOqUhSzTXZKykGTrF2UozZEF0NbCL/vaeLq+GC8+ii6okL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(55016003)(66446008)(316002)(66946007)(4326008)(64756008)(66476007)(76116006)(478600001)(66556008)(110136005)(54906003)(8676002)(8936002)(5660300002)(122000001)(41300700001)(52536014)(38100700002)(186003)(71200400001)(7696005)(107886003)(6506007)(26005)(9686003)(86362001)(33656002)(38070700005)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nq6g8IlMHVCLoJPSgO4vcA0yC6yilMuGBe6uMejOiqPDiXV+I4evvZnHzZnR?=
 =?us-ascii?Q?/en9z76h0V6inO8ur2JkTYu/+BOfgPEQpTxENCydhLCRM+1hExjuYIt4DD1Z?=
 =?us-ascii?Q?K2aP4kS8GBJbC2Jh1EO2eaUrsFWA64Z4FCygFHBvREWvEOcUGvLMbVAW3Z7v?=
 =?us-ascii?Q?jtrUZs5FRQfmrelqCk68L2Si6KUW06obXzjId/ZQxnGle+9G6Eer/anHyO5t?=
 =?us-ascii?Q?qjDPU72Z81GGxfijxy5eQYHdEuVv3TI/oSoP7xioBQkopG//K2Q/zm6s6zb3?=
 =?us-ascii?Q?nD0xy3rnSFGsxn22gO9CnAW/9npgBT8dqnWKuM/gVC6d6R7uXAKM0UC8/Te5?=
 =?us-ascii?Q?gpoRpF8mFbFQAEw+b6v8QHFfXgBr879B7cALU2m5R/8G5lMXEMRaq9ZhIZU8?=
 =?us-ascii?Q?3JR6drnUM184hheb5wqjR8bvQ/LuYAZMfVQs9gu7oEoH/fLgJrVDOcd7owrR?=
 =?us-ascii?Q?tthDAV3f+tBeVLLqWLvhRQjY0xlLnQm5V7Y+VVaV/3bW2LhE2rTt9fDstJ/s?=
 =?us-ascii?Q?Hdcm2RQXsDWB5zLJyIMz+7HRP3uNbdA9UZbCwsRdwGkuL+hg8y2dkvOUtEmi?=
 =?us-ascii?Q?FEmq9AEgNfz697hmK7b5b9fqQDaHfqUXH3XRoIpUlkx4yetZ1efDtLESGPR1?=
 =?us-ascii?Q?PZNvdqRwETg5SH6aE4oG6mKFzEDBQXROjiZJ2ZPdid9KP4cwkgomMgaY7nWw?=
 =?us-ascii?Q?ohwKzhdGQHgmhk8cFzcnq23PhrRmbEHvbmIuDnbWaeVi2bk5XnilPRNIFA1M?=
 =?us-ascii?Q?O5YhI7YQwnipcl2/jeocaswwQCYTsOx+WklCRva6EgATEzMBlts2aKsY9mdn?=
 =?us-ascii?Q?bNWfW07f4XGnVwvxySZ6B/7O5TqB5Kwm3L02f73tKi897GXF9o8lWVgljX/Z?=
 =?us-ascii?Q?KeLBUD3FTRSDbJi8mfvOIbc2KJlGSlKOHlI6B26He0haMO1Pnd36EszmNqjr?=
 =?us-ascii?Q?s+lZonE9r+fCzXnFDhblPSqGowDjD7iL3AWgOygDsZRbwow54dbHxme8QQ0g?=
 =?us-ascii?Q?alnZxlUvuc1frassNIufW8Z7+HiXQk1Cq7FteAY0PC8wh8C721IfnrUSMnZ8?=
 =?us-ascii?Q?bNi+fanyb3CxvqIdZ1XSHBIlaUNu+O+yjHPVWOF4vuJS/xq/nrTtQoYBhsk7?=
 =?us-ascii?Q?nB/lLlg4BKj7OMHmfJDuExPf7uQkkj7r2zBPHeOfwVbLioOf2RlSFJM+3sBp?=
 =?us-ascii?Q?HfBpIdRUtUrXgz+KS3eLchufpnYCysBAXwU32WOnNDnyUEExt8pc25J5Ky4u?=
 =?us-ascii?Q?O49ksJ5aCJoAVInizKCT1hCsBnCY4uvgpRnnIhFp2CHj8wTMubJNiTP1v7gq?=
 =?us-ascii?Q?gXhlHCqXwHHqFbtNcVXs4y5llo40UTfiU/j5365OmsaqV+apafljLU/v5s6n?=
 =?us-ascii?Q?ZStP2BpV1eTcGjmsmlJycsGoiht1dfZcj5O2v6G6RX5BQLljiRQo/jZ5ieQV?=
 =?us-ascii?Q?fCpEJaxvgTcS3uF6iKJzYaeHE/jBl17GNNBOwLSBflwXRPD5Uhn39rNIoY7c?=
 =?us-ascii?Q?/PJtB3xfM+5UMqG5OOd/06PKSgoSzK7NnWlBOOHvkB72iHbF20lxmpYDv/gM?=
 =?us-ascii?Q?2l6Z5HKRP3RiNYnHsaw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0ded8-3e8f-40db-8b44-08db4078f96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 01:54:12.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otbUwuifs83cDUbMtgSNgmU2oakoysuuE5VtQCYs8L5rgTlLDB6TrDbJS1DooloB5lz7HcdFLBCVlirU2c1IbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
Subject: [virtio-dev] RE: [PATCH] device-types/multiple: replace queues with enqueues



> From: Parav Pandit <parav@nvidia.com>
> Sent: Tuesday, April 11, 2023 4:04 PM
> Queue is a verb and noun both. Replacing it with enqueue avoids ambiguity
> around plural queues noun vs verb; similar to virtio fs device descriptio=
n.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Can you please take this reword change also forward?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

