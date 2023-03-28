Return-Path: <virtio-dev-return-11821-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99CBC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 16:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CC61629FCA
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 16:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 646072A8CF; Tue, 28 Mar 2023 16:20:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C20F298645D;
	Tue, 28 Mar 2023 16:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa2rJ8zFjSSf6fcHpMEOAM9PmWTcY/tmL2NfU9X4R5Fn9/3GSUxWDDdrpK3P6IqNnNQPZcak6McFjcv/kEkC11krvoOPVhx90VHKv31OUMxv6LIqQYG2RFLMkLkaBbMZrF7fD+BtLvkMnGRLCs9Hd22fiaKwVX19/LbtdNXcVH2NXUdqgPo5PLPWZPj9ZljLvD4gLL4EB7sBx0XBF6JTT5VcWeBPdnXd4esANjwiV9z5UJlJK6thG4R1HYnYBh6aDCpUgqYuHgsUsCjN7lwxjcBrcjsh/hr45zsOnJxfnw4t6gDCVo7BPTG7e2bJFe56cttIPe72gXkBUCLg41KmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxgn1P+vaFblzt/Njuxka7OOGJce74dMwwG2kJfHL1c=;
 b=mC8WVLtEGYZYI4D1txojwr7HjdypgHVUimhavEdsXHS9prWiVJgor6qs8pjSPAO+buqi9cKA9k682XWNpbNarz4gcg3VTdykcJhpb9FoPFYLLUHxoEq0550VKSRqdYkRcW/ZnZTByyvySGQ2wAY+PApHO8Qvsbu9zyFCW2+k8OEQkPTL4q/ldfpofhDpmEzUjRnkNTwzMSB3HmT/qpwdRMio8E3hB/FNZQ1ICJk6wqnwDfY0OAR3V/gBUCVgdnK9ZrAGPjH3I8uMnPsAcU6GfosQnU7KBbLLMv/684N7T2vD7gteA7K7jvQRGhn3NdxZSgdQQa6rW/JecwxHQ6a1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports
Thread-Index: AQHZYQhBvT6BAHREJUyJENmtmnZCNK8QOyUAgAAO/2CAABUfAIAAADew
Date: Tue, 28 Mar 2023 16:18:57 +0000
Message-ID:
 <PH0PR12MB548157EA4D285FC9D3654E8CDC889@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-6-parav@nvidia.com> <m2wn31as15.fsf@oracle.com>
 <PH0PR12MB5481B571104CA387FCB74EA7DC889@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2pm8sc0m5.fsf@oracle.com>
In-Reply-To: <m2pm8sc0m5.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7698:EE_
x-ms-office365-filtering-correlation-id: 76362855-6460-4278-42df-08db2fa82213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kfxciEKVzyq3OE7DfsNw7/6NPMedCsfrD+NXyLg3yes93kyicadT8wimC9pddkIpg6obPyocPCjKNRdgBngMgkjgt1SlS7Ew4UfJQ+1J6lhV0036kbBG1e6Q0an1vrtLlSSnwXhUItmtX2x0sMCdD12kq8ZVJo7fcMYz5wd7A+gpnUc4iMrCYiICqtNP4Xz7Pavowdeul+nuylC8R/VnK9FCi4X1GXYuoDKCO4hVI2BHM8efmxH4kEyF8xCQouPe3q8Ypz/R0tm9MACG1+2W3nRG/5LQaYuaOG+vOemNkH5RF/vQGBUjBcT7K1C36YHGnAgAucFNvgnNf7KnBj8CJQ6fwTmG+a9InLuDuMiqRoSSH5QyUhJgyfrCNTyn442gaO/f9+WzEtzvz2IaL33L1RxPlyDRSR1sQwcE5kpyjh14RR323D7JTV4Z6WqZlooQRIN+foOq8iExjfEJkMZpfxoQM7xCokGGZA7CWOuugIXKJIGTp6lJPYfDNwZzLbAeGKntuS53G5KQbxMaqLpoBj18YRCp6vqgoElSlEfUvejKy15KAAemgmQK5ntANkbFFTX7stP1c6zsZbg93SyrEqb4xUmQKo128Ko6Z+5BQQ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(64756008)(8676002)(110136005)(9686003)(316002)(66556008)(66476007)(66446008)(66946007)(4326008)(76116006)(8936002)(5660300002)(41300700001)(186003)(122000001)(52536014)(7696005)(71200400001)(478600001)(6506007)(26005)(54906003)(55016003)(38070700005)(38100700002)(2906002)(558084003)(33656002)(86362001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JWuZhIXRO3htT1isbtBtgH5fkevNKvyKZLXdNZG+ghRlGSZMVz2ZypP4zDgM?=
 =?us-ascii?Q?w5QOTHT1C33tOqaJ1eCe5M9ZV8QBb19CpYa1Jnz27TYR7Rv/kBgtP4Zb2LWO?=
 =?us-ascii?Q?mJ6YfIjzBoHtJ3fx9ffLpXdWOnijomhAjm2A/IGeDeTeiBR/I1TcxHYrm7SA?=
 =?us-ascii?Q?NHSg/Oym+8E7Tuug8TPEofVWxQkd44dVvvrO8hxBXjTCnL9mswycy9HMjEp1?=
 =?us-ascii?Q?03P289PUCd/1ACEcHZe4SLKPEQ532gyA2TzDV8oDvR4RshXNHbs19SRzfOKW?=
 =?us-ascii?Q?+JD6jUvlT+ng3PXCXuWHfFyNvfbvtbU/xyWZXVjo1Yqtey8WWfSnZBJYlILk?=
 =?us-ascii?Q?Q05SJRkF6ePI1lIYerUa8xpKWlPDwgm188UtLZUbsoX98i1laqfW0C9L4o07?=
 =?us-ascii?Q?4lhyMz2Kf5U3LImkPL16jR+4CBEh6JCptyoIG/jiyWSNGFsVEfQX68dhZtPT?=
 =?us-ascii?Q?1I/k2Bbhc3Z81UFMu+z9h2/GfkoNM5x0ub15qvgD/I2LGJPfhfFJDYw6AQId?=
 =?us-ascii?Q?nQfNR6EWg2Mfw0Y8xLaeGHofBMHSqSGF+tKXNXnmnBMO1Cq2ES+cKiWa4C0w?=
 =?us-ascii?Q?0mHNvwcEt2na5L6nPWtXEuCW3kszqfnsOKzfv1lruQATFyPrAz7KFhAgGAr8?=
 =?us-ascii?Q?BQwNQBM5b1mxrhzUew145OJkvnBl01cHFyHuLRwUQqtJ2rhT8sNMIi9LjDZ9?=
 =?us-ascii?Q?3JfsU9DGceCZqAHTOxjBw+aFDV8nvlgehcPtMBSGUwVMBeXJqwal0kQbZN9e?=
 =?us-ascii?Q?8m9X+7kmEatkhJSwO99mgovJuKU2RybFDCbnT49E757lNhbQ43srtpUtL/qz?=
 =?us-ascii?Q?cJCqMoUPIP0qt0aA8yeZZZQpDKqqdUzLlghjdlNBBBNPfvpAu8HAQ3EFwNfF?=
 =?us-ascii?Q?o3DGKZiMxelFvc1DP01wUDlfYmx8+6MPJfBgz/xDAXg+fI2EyYzpQvXL9PG9?=
 =?us-ascii?Q?qG17Dmdis9XezwuHjYu6WFX8qtpunD0gauhA78LLQTDGMr600w7TjlzsBRwv?=
 =?us-ascii?Q?1+6NPd+nWTdEnbjI2eBwHmv7ZWNn7f3Cd1YZwdhoAXXzfnddAIHVKn2G3tbN?=
 =?us-ascii?Q?p6yduI4HoqtacolTT2jnsAZdXJyXWAQiwt/LHZEynykmCLbrDkucT4rVCwxl?=
 =?us-ascii?Q?CtbajCKye91NTryyOn81Ka9B/jVXijcb4GwtwQY3N+CQYqVrnObxBWSEaSpA?=
 =?us-ascii?Q?63uMvJIIzKVSXwN2uba+Vtksgn2tOyf8nDjQgdznezaXLxAhlVBm4kXiQXJs?=
 =?us-ascii?Q?gToIbGDX3Kjkho/U9rmdZqPz2b+ux/6UxzuhR8U8KNu6ON2kA5euCMT/6Rrh?=
 =?us-ascii?Q?GeQa7gKCFfU4lsYhcFsHCMOh5ERpGmcGMpVAUbWPsLybKTtVIrV+6tW+fLQ+?=
 =?us-ascii?Q?BG3Zuos+GZZnagVmojK7/Dbt7h+cLGKvn6njHna9+R3ZpZpEO6NeuWQNiX6T?=
 =?us-ascii?Q?8VtsufuqnBPXXKTlFGfzgMLsKgvASOeYEJM4ofVEjvcd00bzNpDMP8Enr6Vo?=
 =?us-ascii?Q?VFN+wrcOJJX8cq5cKiPIUMF7RI0Y7qgyErEmh4wSFPZnCSMpDwfi0+PuV2JE?=
 =?us-ascii?Q?kpl/nBHuxhDFB1TqhMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76362855-6460-4278-42df-08db2fa82213
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 16:18:57.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOzCM25nfRlqMeXYJQy7A7brEL8gcuvg0ABU6GtENHYuWErdYIau/HidK+oUAZuB21r/g3YFe8qxE3d5pfnKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Tuesday, March 28, 2023 12:17 PM
> > So how about,
> >
> > /* Previously known as max_num. */
>=20
> Seems fine.

Ok. Thanks.

I agree to most of the other comments.
This is coalesced ack to rest of the patches. :)
Addressing them in v9 shortly.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

