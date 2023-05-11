Return-Path: <virtio-dev-return-12658-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC9C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:35:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 10BB2127CA9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id F2C3F3D8D4; Thu, 11 May 2023 16:35:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3654A9865E3;
	Thu, 11 May 2023 16:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBOwePvA2ZmLFCaqB3eQl2mK7E8bF14g6ZWdQ45cenomxmYJ1ypfli84dO3LdLejrAAJXHvMsFGmxhJusv/VEcaLt8YPj7VxAnFLX9tnkSKTb5A77PUtIMrMUv5PM1pAnXRju8hqMtkXMcSEIsNFf/Sbgajl0oYPYbXv48I4ozp5NheV9MfiVKQiQpKaASdXvXJP1rkk+AcMpqNCQvAFu4bOcvJhfClmKQVN6rpY4ExoxnKDRBCcf7IfytRXJMXvpUHLo9w+RtvLHSL7slbR++mNXOjS6ZecyAjiq1y6J/kzsZRuV1NaIA20ucDx1KoIhOKb4tLtpJDHadBY9GJ4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zg11MG07Epu2Hl4gyB560Cp7BoCQs5DmbpZ8PlRjTo=;
 b=MhVhi5/8tobl1LmMgKcvoqUwqG5uS6eRTq9b+QPRXj8f5rYNL1+zakAfRvh03Tr86Vgd5cPZ8Aej//sS/PJnbW71ZmmrQwQjvkPVPGPcEm9B5QHo5mDvKApglvjPSMrugkj5kmqWt7JKkqI0ogW2Rc0ObXLU7FVYMJm/hZrzPdyNThHy/pcnDRkmoXy3vxI6eYrIbiqWueZWyin+PUffCU8Ydhlb45zQnjN5KGYdblcBq+w/SfzwWcSvOLr8ek0+G2/8wG+oBw0tJM2baTaxbFtb1hWFR+wccXXZQQf5nghtzA9LDUDtP46WcxEYU5OHNS/eGrzH/YRz4fxVGJH6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH v2] transport-mmio: Replace virtual queue with virtqueue
Thread-Index: AQHZhCX0ZNSsM0LYN0+xYndRQO/JD69VRAYw
Date: Thu, 11 May 2023 16:33:49 +0000
Message-ID:
 <PH0PR12MB54814C6590DCF50CFAC66720DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230511163020.708427-1-parav@nvidia.com>
In-Reply-To: <20230511163020.708427-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7339:EE_
x-ms-office365-filtering-correlation-id: 9da98405-c0a8-4ecf-ff96-08db523d7ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UMfxhsHwK/4W9CX/BCXb4jNR1FUguiejgFpOPaYqqOAhxqhYKM1rbGR8r1nY36Chf77ZvrVtzsfqiIcnq3D3Q+SeBnBTMXh+wpgwm6k9WS8xPTHNu6V10xT1QTRrHshgHBnrMw1y4JokbTmcrFThWSIWGx01O39t7bktRGfrWbj9fqXeUllFRjT4a/bdKSzBO62qlZ5I/a0TkJoW845SUy4eIs2pz/0cylkZsRCiStweghw0HnlFFsfgSkqOYI9YNzNlUajDt3Hw2Ngzk75lPXFPtWKT0AWhBohIHSi+pEhX3PxeHtkD/CRHij3UR+KHw+SqB8Joc3176thvK4e38bkaQJGgtJ5Qwttsf4Y5aQX2rvZCUZWNTH0gshgvoqtXoNjqm4QB4zWkD12ctGjHgC+O4vtwG6Hf6e9eqBO0tyaIB9n7ICTzA0zku5cWaKj67Uh/aoKVSfaY6spyWNSa0sH873JFjx5mO1Deso+yg8H0NoMatJU2Cd/jaCEdWCqEviwUoG1kZ7/EvyCA5xxwKEWKLi2m//CM+o69EaXmJInCzTL85cgM3MSHWNOjrm74cEaS23EFeb9hDw3/c0MrHs2yEFADd3Pje+hFCj9aBN+oX1iFPECp8yTvj0S64dFsrSuoDVvvjk36l5xEKkx/BpviDf2kH7AIRYY4MsvrM41gL6rfJK8sxHXqon3tQFhGErC1psQUqpouEm5lzN9lBA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(966005)(33656002)(52536014)(66476007)(66446008)(38100700002)(2906002)(122000001)(316002)(38070700005)(66946007)(5660300002)(8676002)(86362001)(64756008)(8936002)(4326008)(55016003)(76116006)(4744005)(66556008)(41300700001)(71200400001)(6506007)(186003)(9686003)(26005)(110136005)(7696005)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DEGakGfIDe6c77NtW4XMtT4WPqA4aaj//ZO+e06A1f6yhTAbK9a4nB5fi7IC?=
 =?us-ascii?Q?UQ2ZfGGSiZ3JIb9yywOfOXGFTgU2EL/ERtuKjfI4j1DxIMkUr6n4XNU4vVJw?=
 =?us-ascii?Q?4paegMyzFebEC9uC1E17yDsJ0JL/crpW7gIwMv/9FsbxIltvzJzfgQtPxa3m?=
 =?us-ascii?Q?U+F/WgekJvrKpZKX7Wp/r6NOQyy/HRd4xtRwJjSlF1x5mDV7wmmbqhzxfrif?=
 =?us-ascii?Q?pVNbhYgMKwX4GENoO5wtrMu5WgV0INfnEwJxRBwNuFoyVMsQNewPRZAE0xtn?=
 =?us-ascii?Q?UII/qn6bgYCYwrnsttsYHvQu/SNQ2oTHtPaOlxOLm4iE7qj8hI2NI5HzYRCB?=
 =?us-ascii?Q?Sy1D73ia+2/Q6b79y/J/Ar7G5lHQNWNyb0boCYH47444445o33BOp0w4kzOR?=
 =?us-ascii?Q?lcGLGOSbjZlJ7cBuHoLaoWZocQcBTFHAH4SHdA5T60G6Y8LvyctnO3XlJBqy?=
 =?us-ascii?Q?/PK+vte4xjZ1II0SsA+ipTXOjLSh4lIB4tgQh9LP90tNsw3mUa8i4kDKxuC2?=
 =?us-ascii?Q?S4qYj6+ROSSdOA5j2/7XOcsDuz5RpMNBpZryyyvfa5eTRvKVsV3m6NZrjVI2?=
 =?us-ascii?Q?dHiqnWe2s+cdqyVlCrW6oL8ZN8OfiEdSgV1LfLhGjBOonk+c1MgF3AWwksP3?=
 =?us-ascii?Q?T4rZlD/bgJDYgFvzV76yALPhPwMO0JMYACLnj2C8IbEf5i4bYu2yiUPI/cr3?=
 =?us-ascii?Q?j5e+ORN7diVi5On/fnYCXaTE8qUh18WsiAmQPL6kwCiWWEYZ/xukXaEjZVnG?=
 =?us-ascii?Q?rbhUsz7yX7mm8EQotr+bHKEfaPPb16q2SUzDkQOgcWlF1jdsft94pmZExVhX?=
 =?us-ascii?Q?ZiyRgfa89SYdanKEEok7m7ejC0ifVlYY/5R5g9ma5YrJrVrtgZyA10NtP49M?=
 =?us-ascii?Q?l3ztwnd6qyQAa9pk7K6LOOv6IgCEZuj2ToWOJP1EeFywm+Jlqxd7QE/ufgIq?=
 =?us-ascii?Q?iYKlNudJUwOw7/G9G0XTo/2QOccMEmH2YqCeScM+sS30OrjGVfe6GtMv4vbd?=
 =?us-ascii?Q?lNrc105umLwdWoKGPUWIhqmHHfqyERmH5AkeyBIqo6gvNz8r8GSppEqWb6PD?=
 =?us-ascii?Q?nA3j9mkxzKDsC3iT7rrZlZUBpR3vpNjwxBn82ZwubLCQSQF/FGKqvI8Bsvdr?=
 =?us-ascii?Q?X9YBoaXwjD8QDsvEzb01iGFZyJ+LMwwO9K6Y+qkdeJVzBIC/LXW1f9UGOc6D?=
 =?us-ascii?Q?+Yqr3J1NWs7K1GQyLu032baIruwIbpBpZpQ9m8hAEYfWylCFz2ly75FyatfY?=
 =?us-ascii?Q?ibxJi2/4lRP901ecq+fLSOBW+elRwVdpet0O3XRkHfjp0str3dxZ/EV389hG?=
 =?us-ascii?Q?2nt2ZIlflxQ9EeQLsabmE1TSng3zSkOeXPuXcznPDH4lKtr0joNcD+Jvzfgu?=
 =?us-ascii?Q?sZJrmYjI6+8XEKJz0/t089trKagQZhCS6NZK1HqDq19twTm6lW2OK+42k5G7?=
 =?us-ascii?Q?/vQSjfGAU4cX+jvdmS3E7Khu//z2Crl7HHBYfIyXzRfMS6kF+8BHFwXCZ+XZ?=
 =?us-ascii?Q?+OYk2fqPWXHe662qWKgKUCo5YxE0cyzlxRwVD5oLZIBcg92wNymINeneOU95?=
 =?us-ascii?Q?Dfi3qUpYP+R3HgzpTVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da98405-c0a8-4ecf-ff96-08db523d7ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 16:33:49.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8b3NT01W5GPOJsvkb93qyY/vRjFEf5E4fBTqS/3jpxOcENJlmqf3zcF+pidvddGAkB0APeDl5+WVhCwzluqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
Subject: [virtio-dev] RE: [PATCH v2] transport-mmio: Replace virtual queue with virtqueue


> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, May 11, 2023 12:30 PM
>=20
> Basic facilities define the virtqueue construct for device <-> driver
> communication.
>=20
> PCI transport and individual devices description also refers to it as vir=
tqueue.
>=20
> MMIO refers to it as 'virtual queue'.
>=20
> Align MMIO transport description to call such object a virtqueue.
>=20
> This patch is on top of [1].
>=20
>=20
> [1] https://lists.oasis-open.org/archives/virtio-
> comment/202305/msg00101.html
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/168
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v1->v2:
> - no change, only rebased on top of [1].
>=20
This has no change from mid-April to now.
Only rebase on top of [1].

Can you please start the vote on this editorial change as well?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

