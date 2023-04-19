Return-Path: <virtio-dev-return-12316-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1815C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:11:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 356C841A05
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:11:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CCA9986637
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:11:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 21B38986621; Wed, 19 Apr 2023 16:11:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F06A986434;
	Wed, 19 Apr 2023 16:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdF7nSfQRN3CT2b1FIY/Bpuc/WSEKWH1tlRCR2zGMqLKYduLvNr33d++Bdp2P8eQ2yYP+BpIRHd8cLAF7RiUVbatgKKgH9p/HYcmhEuAfEfoKPMzOyqnMeUuZKNR6EmOFMu6BNKPkXn+4Wwo4VO0Kz3k7EDw8vQ1zDAN7yzICY+MMxZYQravZhwDd6qIhnq8tRV3ycwtmo5Mq4+5Qqt7qXd5fL0/vbA2bUiPzrcwoxSK5iW+7wsZsOdn34K3oK4rKj0yntmYgPIG4mxEImdLCkaqzrYzgDIE2+H7mGVPFJQBFG3wh/eYPRFg7zt/pEVBhEqBAAoRK7VwCU/3m9xRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPpGEZxCKP6TAI78otkCBjMuPTOumygEYYMYFOpaTxs=;
 b=CSA0wVf/OpDkuRpuClYuo49msA6dhbs8Eq9j/Ek0HkVpUV1lUVEn/kkA5rnn74cuoZ+phixfECpwaoxQPBT4XWojDFnVIXjxIFL3XOkJhIDvnqjlNfasT3T7AUUhHWGKJJSzDfO9xYch35vQM8RhVVpAP68V2r25yR2teIeoLqwo0XoN/J1daUh3lBBsdbLNqfRqTf+HATAseqDIluCw4hFpbVpieCLn3xKl5IdCVoW95JroLSjsvny6R0Ohnd6kFh4mCxy0m+8Sua7OugKKwIH6IKosvU0sID6hksVkb40gZxNz9H2ggW8rujFLnzQcqPkFCc0ge0P2UcXDVPJ7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v14 02/11] content.tex Replace virtqueue number with
 index
Thread-Index: AQHZcmDaiV18uXUuw0SDIEMnml9vSK8yzaaAgAAAd3A=
Date: Wed, 19 Apr 2023 16:11:19 +0000
Message-ID:
 <PH0PR12MB5481C46E4A5787F7A8A18315DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-3-parav@nvidia.com>
 <20230419180839.2add099d.pasic@linux.ibm.com>
In-Reply-To: <20230419180839.2add099d.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5808:EE_
x-ms-office365-filtering-correlation-id: 609448b9-4926-420f-5928-08db40f0b638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b/NvBWiM9HhIWi0JWG9GgwU4cQJMpvDoDPPE3qbk/D8/U3hgIOGGelCCzxzMQnNU8Zb6463V+h3E7JSv7cT6LW/Kn6GQGkP8HpS4cb3lo6xcixICY0eI4em8tGcDuKRTpnFKffOEtB+F3PJP/e3sb7YwNsCdJfy+tGamDvVrZOihYM7wf0L9qddtC+3lhp6naHlENOIxeb3AHO+gSDbMty0kCoq6ROV2eASbUxzfdyXvOEMs3qXBa2c45jvRNJKFvuru5K9G8K8m2rEmNUwcGQMOBb6IJrgP5neL91HKnz4GAD1cTFlF1awavmwBf8NGHasY92+DtxR/l4bOu516sG3pD/8D6vmS5x2B2asvxorud03FpebQ1VRk+8LrNh0OnQeI2RUxaGsc8K10n6rEXmlIPe/pmULpNVoqqK+Xoa+xJ5rnfi7XjlTxxPQqngdZx0mcjTXyPbj+AOx6uP9FuEHJpqb8w4Iat0lXLtq02XwVMreCLSwy4y0PVadJGEmmF9cA497Z6bHq6bGjwEYcbwL3COKeVnUUE20Oout0jpHKmFL4DDcJpxTjBVDWZLvxCMXNgTdSl7mchzKptsqAk6+99a+Nm0ERqTulohPVjU3jH1mOEhYoxd5M7UgdDJzM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(2906002)(4744005)(478600001)(71200400001)(86362001)(26005)(33656002)(6506007)(9686003)(107886003)(7696005)(186003)(38070700005)(55016003)(41300700001)(122000001)(54906003)(38100700002)(8676002)(8936002)(4326008)(66446008)(66556008)(66476007)(83380400001)(66946007)(64756008)(76116006)(316002)(6916009)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1CY2PPnCHYUmjXyeGNjoQ7t9NXCgcxamuQ8MfkUf7NGDGawHU/YkadP2+JV/?=
 =?us-ascii?Q?PuYh8lsQ+UpojAOtlzbm0NbNrgxUXTPqlitCEXqjgXDG5fkN6hNaY7CgFZNM?=
 =?us-ascii?Q?2irelFSrFyRKy7AOeb5AiVkjr59SPvtkfkLku2Zah69fFAgOSVhnNP81I7Uk?=
 =?us-ascii?Q?CHDtj1TVr2w6tZ+Wg3d3zhSKz5R4MvXD5JYTnUsZ77UdLOhKWLpL/1IZSUCS?=
 =?us-ascii?Q?U4YWUAjBNjBpSueieaAMHlSmdYclCMWatXQHE7TkP5Q7PhR8xdsIHnr7hdfy?=
 =?us-ascii?Q?qEuAa1e8awtnhhPyTY+8d7bJjO9O4129q6CCfNQ62F/rOi3T6JJkoRe+h/q4?=
 =?us-ascii?Q?VI6ioIYz7HJY7VAo4Ma+QXktkU8g48y/FM711TciU42vAOLjpVDFFe7a7jgQ?=
 =?us-ascii?Q?xDE1p6IfpfFPYkhrTjOht4zBsf4iFJYhzEpqYP85da4iie20Tk0/7x/RyBjF?=
 =?us-ascii?Q?dkQJMhbe+FTz/vpshy5Qe9pHQQ3Hx6KrW+cD5YalpTOnJwVXGK6/K6YZiF1g?=
 =?us-ascii?Q?b0qkD43YJFKIr72oYGrFbDdbuyhYa+zy2bBgEUSRI+1rzoKI4Z89IrzSM7i5?=
 =?us-ascii?Q?kajpRIOGm2OR3r2CWEivyuEYSWmnDvPkBdviUqpbfekwbL7+bsPI2lrud94M?=
 =?us-ascii?Q?GlhQpRJnkbhhmN0KyWIs/tQUOygq3jVSLvcwRA/bC17RBCsR19TmovrZQqJK?=
 =?us-ascii?Q?0ECmijwaWC0OJ59+8UiaYhqjjM3rYIeAKpevp7Pp6dq36QBV3DxIhWBBLcFl?=
 =?us-ascii?Q?peOzLHGJMQn+D53P42bBqTYb8hMW3ddTzoNOKN7LFRfBmsk1t9q23/YB7ycD?=
 =?us-ascii?Q?kGBFnODTlvDtbqdtgU/Y7rjmZh412w/2FME7uxStvWCJBtuRzfrVvne+pRLf?=
 =?us-ascii?Q?ds/2yfnLpymTkMmKwDBpmoZhgfouqtWGTXdofF+jhP/eZC4ahoHj+a72EoxW?=
 =?us-ascii?Q?PDs/R1/vcAftMhGgEwZXG2XE7zqJE+bBPHHjI1ok5H7qeKC2Kh70LPHTsVRK?=
 =?us-ascii?Q?CQxdY5UgGUbXYrNTDzpmJF3Mrlix3tlVBsFuKQTY6xSx3rUf6oY0u3iF/QOg?=
 =?us-ascii?Q?PyoGWI3CvoYiFw6vdm0pSudLIYexYg+ni4wnm+oZFNPAIqdz1Hi8hSk2xmyR?=
 =?us-ascii?Q?8bxQk+xEjv52ClO0GB/y5nPk2Zi0O36Rizh9aAyGxAhnxuXtcGAXafKOrwOG?=
 =?us-ascii?Q?E59vEuQGr4xaBlUcIKtEJfnA3zEHZgh203wbRw8LkdNw7EtPHryeveHYMX0r?=
 =?us-ascii?Q?DaYl9Krc09jK51hMmb2ZUlBoergkX3qmnOqVyv/tEyN0ZT7YnNatZQZa+P3L?=
 =?us-ascii?Q?8gXZ4ThEcVeyyt7H9g4PNUS2qqR9AVLpPf4akQygepPop4zGBnkMb9zYwTVG?=
 =?us-ascii?Q?RQEX68mC9ekr76qIRoh+Om1VMrQ1qg4CTj3CWcK/Dss8jyBZ0ZoAw6wNpmQQ?=
 =?us-ascii?Q?0Rjzo0VvPqNtig6fZh/5I4Urc+xhC4lLTdr4HXKK1hpT0/sSwwSA8Lxx5k/q?=
 =?us-ascii?Q?HP2yBJBO6AfW2YbO8U5SkJ0tOPcL7CzIHXDfN09a187TKdIACrFutrnK0w4/?=
 =?us-ascii?Q?xBwRWAXodFOas4wEFtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609448b9-4926-420f-5928-08db40f0b638
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 16:11:19.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioJddzTl3nRj17aJEqxOk/JyTo5svh9+F5tGUywZ4GVSADxJhd1iPAB3M2q6ZuxjeG7KZBKV6w+0/659CKvr7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
Subject: [virtio-dev] RE: [PATCH v14 02/11] content.tex Replace virtqueue number with index



> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Wednesday, April 19, 2023 12:09 PM
> >  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,  this
> > notification involves sending the -virtqueue number to the device
> > (method depending on the transport).
> > +virtqueue index to the device (method depending on the transport).
>=20
> This is not entirely accurate. If VIRTIO_F_NOTIF_CONFIG_DATA was negotiat=
ed
> it is not the virtqueue index that is sent but the vq_notif_config_data.
>=20
You are correct.
Patch 3 further fixes this as part of CONFIG_DATA related cleanup.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

