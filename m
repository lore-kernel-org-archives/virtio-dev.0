Return-Path: <virtio-dev-return-12122-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4FCC77B70
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:35:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 95BCBB36
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D47C986613
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:35:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8370B9865F8; Tue, 11 Apr 2023 13:35:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A8F798636E;
	Tue, 11 Apr 2023 13:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGGm61bFFKOUefWH1SUqdiq7l+dU8pMnt9Ss+1j5JdttYcH4eAJCJzTESr19qUbFo9pWa4cWPsl2MbV8u+Ygq9Y3rnzfMe4xY3OTbcEANOeEAqtATwDdIoIgRJUjk5pHUs3DRPDSLh9ywZgPotQp1rW/L7I5NbKWecpXgdt9TLZE4natCHt0/nNPsHpKB4rKwBysC/wk8kKK4QmypyCFzuVui2M45lNF+clZRz4nCVJx7KWXHCLnnKVSKOot96q4U8NNIq9zRoVHUct/jYEaSYm8jlBXIE8ts0uzSqv/E0ZRp4wZHxvFbZFmKNhS0ylM8DgpwFOcDi8ngSj0UQ1qUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30vaeAYzaaeYoc4H6+M1ECIY7GgOkrdPP47UE9UwoZc=;
 b=KtuZImCZtAcy1OBgdiv2MuOnss+I4qKD6PedihAoh5csFmDYmgebw7mtAxVrZMacWjp2laR1t8FTrzvxMGA4G/CCq1IQRTWc4LEBuHg0XMdqTYaxDXAxhc8NHsr9TmStRlR8Y3VW8LEDmFPBZA5lZ3B2KFejyLDD7NqesUy9xQsUebSppUjbvuDwSVLBKBdw4W4N7uPqz0AhnF+/a/d15auqahUE/J4alkcaJW9bKPkKAnbLMxJ5lZyHJ8D36UMg7Xuh84vyqeXk5L7pLGynw4GF8YZfScI7P2T6ZuSMf+frxLtmk6N9FVTqjSL3Iy/kZgDGZSQCicprdXiLTK4KXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [virtio-dev] RE: [PATCH v12 03/10] content:
 Rename confusing queue_notify_data and vqn names
Thread-Index:
 AQHZZ1r8zVHaZ0BrZEO8XVrJh+aoSq8cMK8AgACDgmCAACNfgIAAAQJwgALlEwCABhqOAIAATR3w
Date: Tue, 11 Apr 2023 13:35:09 +0000
Message-ID:
 <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407073308-mutt-send-email-mst@kernel.org> <87ile2kdav.fsf@redhat.com>
In-Reply-To: <87ile2kdav.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5728:EE_
x-ms-office365-filtering-correlation-id: 6c985041-ec3a-473c-9602-08db3a9191e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tRgVDtXmr4mz3CYai8WkkA/4qJZ7Ic2ZNln1jCFQl8eThcjFQrETv4ydnn8N9PWrPCGqy7RHJ2WYMSCDht0KZpf6IZT00mvmtE8n0tQ99LPILUIHikl3TiY09P6roIsfN3Kusc/rLV5HjuXOaxJtt7O8U3S/aGywiSU1eCJrIqAwnQlEOGlprlE6l5rm/QEnN3KRxgTBsCIJSZSrK/ulpb5iHT6POKGvGzoqUXJAhBE1vgtMANbDFsy99Z3RkebY3rnnnvClFt+fqjLkqo/r0PuyEgCDBjoaHUBDKLIxVCJW0w5goTyYCEEdt+3xDaHbpbXtkKw0wai9REoyYB+fRnQJxRytIXA0KjxzfaST3gVWKOL4sVi9Jqdad6UHhBV7a7MVwC6Fkkv4LKH3DgMrCnj+4enmoHWgKTiOZCeTIbitE3gwwGROGT/YvdaxZagAAZlrsb9uqqabeoJLs50cKUcNaJqG7rQVQIdSf/UUqRepCXrTlujkb4f4tHSVuKDaDiIX2FzYdeDFp4go0H48KzeG8hOrxBhySYbc3wihfV3WUHR+Nr4WYmYVjIL/CPZC2G2Tys56O9vNGKJNg+O0Egny7qChGi+jluW/IE8W+/+DbbzgjzZpZMZDCHOC1Kcb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(2906002)(4744005)(76116006)(5660300002)(33656002)(4326008)(41300700001)(478600001)(8676002)(8936002)(66476007)(64756008)(66556008)(55016003)(66946007)(66446008)(52536014)(71200400001)(110136005)(54906003)(7696005)(9686003)(122000001)(6506007)(107886003)(186003)(86362001)(38070700005)(38100700002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pBKPSqiF3vZsfk+/6Xjd1UGtYAxNJ4HqiyUJ8KxJ3lCuDnY+MhzhCVxXnuoG?=
 =?us-ascii?Q?ZOnDTfat0HIH66jD/zov1Yuk/O5qZg+hNhG/ReY+MxMD0psQFxYKMsIsSnXf?=
 =?us-ascii?Q?mt2gC4Ec1F0yAnQ8a+CpBGjfIFZqu0ugJJLprwVLiHF0dOiHycQUd0P1XmXw?=
 =?us-ascii?Q?JZssINwuSmWGDELKXiBdWyJMxGZuXzEQBs3f/bH0sq7hr4+ZKjprDIqoylSv?=
 =?us-ascii?Q?U51RJipwgDTH34Z0a/hAu6I5B2XSy8Yl1yKgG7qBQp8fZdg+g6pQyZ/Gzq2L?=
 =?us-ascii?Q?wLOIYO75mBC/Z+QRTx3X14fiJLr4+zUIBzkn3TBL0d7jKBE961HQ78u205wO?=
 =?us-ascii?Q?Cl7yq7jGjJZASxB5Hj/AVcF8JV1Bk/WVabwIcSC2sBkmtJhyc+uG7AHWNb1R?=
 =?us-ascii?Q?qSVoygs9dJPr7ke5BxB98JnuhdkxtkzoCxOXPPszboAgImLidVfKdRpopED6?=
 =?us-ascii?Q?m6JdBNJpBvPG7rChBQe3ec/1f9lgSFG3xRW+Xqlv1xDkpWjRHsbzQ7gvEq1E?=
 =?us-ascii?Q?Ohhv0Dgb514WVDMQ5xyG+xbmzi1yLVnB1QmwVVLq/d+utM+QgTZ5SLGdt2em?=
 =?us-ascii?Q?3yOPzPHixoFbvDRsSoxNUcpITaVHx0HyOMbBMJAASkJ80/S8SutxqeyEdVth?=
 =?us-ascii?Q?I1PRYgot1jzNMeu2M0Dq8EpofoXlqk/2R4tIed/z8SzFftpJdDqdQXGSZVjr?=
 =?us-ascii?Q?cUF8A9/nfiS61q+mmobEFu4q0Yp4xo+x8gDEWFEEetp0K7+o0toJH22bfY0l?=
 =?us-ascii?Q?h25LDO9G13Ovb/kAkfLqZun07ameXdX7EKjFRMfZMSufe98fRy2neaSsUcPi?=
 =?us-ascii?Q?DJJygBmTplHp/lu3Xl12VhRpqqotzBvnsRouyI/R4GB/QQUSwdkylpAWI1Aq?=
 =?us-ascii?Q?h6A+rBeSGZZFSyrMqSDjhwNB9MnCIdebvu39rW/doM9XqBQsmfUJr7aZUOQK?=
 =?us-ascii?Q?NF7qfsazO52r9u9AN5DLE7u35u+aNwbKUD5RVTeV1YItxUQyxpvkMWwqxqMF?=
 =?us-ascii?Q?YSpLFOqFgPTFENBMCBjhahsrRjpxbXRj0tRnzmkEUyjvuxGgDip5JTcFcqsK?=
 =?us-ascii?Q?TJhOw5lqHJP0aneGLQZufosOZ0oTqnMt2BouuzMzkdEyUzKz7GdMljPrw9CA?=
 =?us-ascii?Q?UREkTjN2h/K377h8bhSNmm++25MslZaIpBKPJIo/9A90IhmZaPNgoqY9PLgM?=
 =?us-ascii?Q?vJ0NkYC2HFUOo8KqQrQcvXoY3/F6y99wsjVy6SytRr6OWn3YIqhFZCPfyLAF?=
 =?us-ascii?Q?CmRPD90BTc/6nniC27YHFGj85fN/JkvUkIXZkt5OFOebIVly9NwdGDykM5Su?=
 =?us-ascii?Q?G4RqXK5bpdY3HbU1SoaAAWwrOm+IcCXEfdtuZgeMRpSKI0v/4fkiJFTQjUUg?=
 =?us-ascii?Q?/j7MJ/SiZpo1n8FZcP4RpB6mtIlQwXlw2mDnaKzhWIf9I1i3Lno0V79XHLQH?=
 =?us-ascii?Q?lCFlaTK0ZFyc6324O4jjy1Qwyat/+RlJ7AzYEXT0Q7BLKdKcv9v0dW1acG1k?=
 =?us-ascii?Q?IcWXchkRSdBJ8sRygIqCivlucYAY/JVtOgVVbZuaGDH9vYB2WTdn0ShrbeVp?=
 =?us-ascii?Q?ryRn7Ks28LWI4h5Qv+MZOMa38YIENenY+UAvv1Z+B2g6rG6+EzEvZtoGMOWK?=
 =?us-ascii?Q?Kds7qDNcVJY7VmXvN/QomK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c985041-ec3a-473c-9602-08db3a9191e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:35:09.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0w3UZKDIp5CbhUoUd2Om+V/gkoVNjz/mutjbv0da9gXVWf9gTcit3maMzj3J5fQhw4rZ4xFNBhYHYPOtm+AZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
Subject: [virtio-dev] RE: [virtio-comment] RE: [virtio-dev] RE: [PATCH v12 03/10] content:
 Rename confusing queue_notify_data and vqn names


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, April 11, 2023 4:56 AM

>=20
> Yes, please leave it as F_CONFIG_DATA, as we're just putting some "data"
> there in the end (and F_CONFIG_COOKIE might indeed be confusing for the
> ccw case.)

Since Halil didn't respond for 5+ days + Michel and you propose to continue=
 use CONFIG_DATA and this is rare used field, I will rename=20

vqn to union of

vq_index
vq_config_data

Thanks. Will roll v13.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

