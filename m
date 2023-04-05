Return-Path: <virtio-dev-return-12020-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476F4C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A977A2B065
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 966D09865BA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8AE409865A7; Wed,  5 Apr 2023 13:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 788989865A8;
	Wed,  5 Apr 2023 13:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQrIpTXjRsiofn5CqUWbQf6zGv1Bk6zUKkUnUAehNfP8/Q8pLyhw8J3FPBo2qUpsEAPPWAUpn1cEkOmK4XB57q46tmXDzP/WFAb7FlOHhroiJoOU3ST3KXjn625LjQVI7gB3czOAjaMqG2qD5/Bo+RubW+xSwxhFHnqtzZ/RR3nXjxTRvgeVHxbM/0jZW2ZFibS6Ezr+bByUcCZio8tlKE/3t6UUj5NDnRPEQmRNT+tB5wpP2HTcZxMeJYfpxg0mjw7WS7rxa3N5yPp3fpb4AMctvQIpBadf6cY4THiERqAuasC6+R3r6PSTEuSoZj5CF7MM1/2MJJu2ETbWXAQkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KdeZSMGdNG3ObMulE7Y4QnxWGg4x38P6BBMJFoE064=;
 b=lpjQGU19zxTRS8hQh+HDQGulL7eW+UDgBgJ5i9BOm8ELdnlYk+nteaw13BtbVmH1QdR/THivUKbqozkd2LnD53gNbKxRPduMR9wFO0Sk31Cg3unFAiE7NbOJtQewkccx+aivLnc+Jn7bcs+apOzIUTadjjj3yZGw/2HRXF8hT9SnVGcpvGtsgAt8Xb+mTwyRCmM7olsmKdc+QLJWKOgyV80t9jPqx0+fU+sT775NBj/EFFhxdRTid4cvjGquoEpic6zbbHZfzAgYV4XMy8f0tY1mi9jYxxYbxVmroAatyU9Jk1ASqqvFrvsj477kncvTvA+tfa4zpJRLaQQhYqH4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 00/10] Rename queue number to queue index
Thread-Index: AQHZZ1r7qcAtV+zCXketiXJJvf9y0K8ccQ2AgAA+b0A=
Date: Wed, 5 Apr 2023 13:05:26 +0000
Message-ID:
 <PH0PR12MB5481BB606DAC462B90DBCB90DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405051855-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405051855-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7180:EE_
x-ms-office365-filtering-correlation-id: 14360149-138d-465d-5034-08db35d66c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u8z8tPJ7zaJ9J2LuokTDwz+/d40jHVuRzXYJizQeLyf6ueU9zaV5P1ut0qlyEx54eG4WjO8CITl03lQ+rQGAMtaKSOYcYH4yUX7sOLt0v/gEH3ShdxuAWCE4WctMSKLyhgiT1L4P5KTSHPinT1YzuL7xmDwngD0n8m8eIm99gD/wrrred8haNiPywjay5Ehhza44G9yfdYjTX7kUOayWntHUmG7mtlboUplf3bMcZd1ppL4w/CrZVRTD9VQklyswm777pZA+dpvPUpeUlHY9Wye9Q2HuNWZtH1z3MWNoc1uhQm8A53TMltfRae8zct8zUFCh1N9oln/eFtlkumDGLJmQAy/XGUl/YOPe1iXc4s9ERIrUXxzYN5QkFghyiiK9ZFrwEZPEC8bgzX9LIdU2GS76ZUbUHdCDgjuQcCb7lBseHbLlL9tNy3w7CFPDTCtvoWdfCDQn+eT2rOBg09sbsu/gKeKxV987enjWgemFjXNaQusxt38sBfOnGgOeq9lsqd+aIogWRS+XNGjmzE8ytd12oqPzNCUNiWGF1xCB7QF5HvGJs/bDtDe/ZMJhEL0cQXgDhUEcba7kcdWSdDW8M5/YOYB7HehL5LN0hhRy1GT/oqBHiq9M6s5ptreKel2khtnPvXt1lzFteDKZ7SqaobOTJGmDkw+/l99fcRrZzKE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(2906002)(55016003)(71200400001)(478600001)(38070700005)(966005)(54906003)(5660300002)(7696005)(122000001)(6506007)(41300700001)(9686003)(4744005)(8936002)(33656002)(186003)(86362001)(107886003)(316002)(52536014)(8676002)(4326008)(6916009)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K4uvgXO7IG0YorsqomSIDJgtWIl9wYCCvB7vYalcLfJGI1WnNwHGoVH5/ZeC?=
 =?us-ascii?Q?UWlUucaHqwCVs61V6GtdMLD/qf6/CPkTqa/y+BfLvZcfzNxiFTV38ysvBlOr?=
 =?us-ascii?Q?aGvThfrQKR2c8J8q1kJ0UlDIxSf5OxIugmBR4oqb42dY1h8nGLUwRVZJ7zhL?=
 =?us-ascii?Q?lg8BtCE9uDo1bZ47vnPgMGyRZkP1UuyLtHjtQFnGGTmUtXt+9+Z57ABGJE69?=
 =?us-ascii?Q?5+22Mw0nnV3s8LGyMocXbspxGK5GzfUxh6B0qDzJRS8b/XHMtDwLovK/Bhq5?=
 =?us-ascii?Q?s2jf4T3ofP0t7Hj2WcK+2Aq992XEyAD2bdvJg3D9QbKGrfo0au2YAMTJT71y?=
 =?us-ascii?Q?pNMK2J/IEexiS7xsMUV8BNiW9NTnxXo+5pEm89UM0EoCSYI9zYDOkVjx7ZeT?=
 =?us-ascii?Q?9sv5o2lMqeVStZwm349VO6zazhZuDdzqnxKbPjHGMoKyAIik3QlFsVN7O3rZ?=
 =?us-ascii?Q?+CDJl/WO1hDDUjiIvmberMCiT/j0u02Q7ywFai4Y7QHLzfifrk1QREkj0aou?=
 =?us-ascii?Q?8fqUm4MesMpnBMTLhjEWTSli2uJEOABZpB3rl1eQvcQ3JzlTWGCCK+d8xAGX?=
 =?us-ascii?Q?/Gbye2U9BUwdZxyS8suXkfAv3ScUTJmt2hufOSh/CfrnfdamX5bZJrAHzW7l?=
 =?us-ascii?Q?U0IjpptMbY8w4xDRznR9NIv3ND6HzTKhKq/+KffM+uKiRrrUJVuGtXYTeQJe?=
 =?us-ascii?Q?Sbzuz+Ce647oxIY5wHYtfmdR5ga9yMSnnvaI9RMkQw7FMfBi4ZjHGUHhzvm+?=
 =?us-ascii?Q?x4Vqo/xeqHP6hC3InxBc7C1tvj62qdZESij212t9fgI1Lz1aQw3gDOZOEtlX?=
 =?us-ascii?Q?y8CLdGkhNcHVitZQ0Ya1OIU9NcnSazPOb2eDMgwhtR5Fq0jzpNUkA4YyX7lm?=
 =?us-ascii?Q?3torPynk8kTSl0TiLPrXJ9op3+9zSvH7+4Ol17hM5Q1lnz0C5q9rv5Q5JCMn?=
 =?us-ascii?Q?jabgKQEJanNDgBZzBf+XrRqO7MLNd7kEXgh7ZvN61BYM1wf7Iqd/VnjdePFd?=
 =?us-ascii?Q?2LojXx84+txV+j/+qnJQov8E1a+oiP9aZFiAt3rehMzHcZSocEVpInG6wZu+?=
 =?us-ascii?Q?chlacYxJAWoAL6lkBtogi9HSn7cCNC7uGtE5kJgMYn4Xpzy9vOu8LN/5el0i?=
 =?us-ascii?Q?GfeNAY4tGGU/ajMx6Ayt5zVOt84nxi8WdDNxfjjWR+tqitZvJtNGfQyb3rHF?=
 =?us-ascii?Q?tbCLYfq+XVs6i3pplhK/VtrTTT3VkpJ5Zvd1BcpuCiQO+N1evbLAiweYvMzn?=
 =?us-ascii?Q?BVSq8I6qGdrNUBMbw/YUFImvXIOIwVk3V3sA9vTfMwF5TsPWX1+OUSYVVLnL?=
 =?us-ascii?Q?cY7rYjvz4DV7pIzTFV9/0SRnHc5Jx5oCr2pgkJGkEkz/iEZ1WUFx5ZVIiCBI?=
 =?us-ascii?Q?nkAWKkEllRMuake+Qh0NP+Spz0XRBo4EoqLptvSeJGOJ5Ins1TauerrJb6hA?=
 =?us-ascii?Q?CHd+Vu4FNVqJREUAl8ffGjmTT8sJZyCPUcm5FwOcMFcuLiacS0vmgtYcP+OB?=
 =?us-ascii?Q?Wabvn043XLPppgR6eOsxM9REGDh17GvaQLmTjVaPYuQS7VHUrYMjweKOL8qz?=
 =?us-ascii?Q?PjangwRRVheSoqDWl/M0ft6Q0Hjr1anDVGTfCVw8zP9yUtzxHoRPOUJMAX5o?=
 =?us-ascii?Q?3i3VLCic6Y/0r6Nzw0bro84=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14360149-138d-465d-5034-08db35d66c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:05:26.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upnklompUhtQoV1B9LAONxEbu1/7AF9FV7u6XAZsn/W5Txf5qqSipDOxvIX2DSgSOvKmGZ5UK7dKWK8ra7FK0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
Subject: [virtio-dev] RE: [PATCH v12 00/10] Rename queue number to queue index



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 5:21 AM

> > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
>=20
> I feel there are now two patchsets here:
> 1. renaming of queue num to queue size
> 2. virtqueue index and rss clarification depending on it
>=20
> 1 seems mostly ready, for 2 I don't yet know how long it will take.
> Split them up, also from POV of github issues?
>
Num, index all related..
If v13 cannot converge, I will split.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

