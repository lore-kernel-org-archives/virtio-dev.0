Return-Path: <virtio-dev-return-12281-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E02C77B76
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:13:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D18FFB32
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:13:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDEE9986416
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:13:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C37379863EA; Tue, 18 Apr 2023 12:13:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABE149863E3;
	Tue, 18 Apr 2023 12:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB5zHve1vcMCXjdE2fDuqDUoebWFNUMjlO7arc0n6Ynu/Av7nr7pane/wZKh0n3+KwnyOBDn89+DYHAORKg4WStxZKOEZCfq+cL8dzfRfWteRBxzMHQN9VnhHWtoL3XEW6iYgy+C+Y+3Fg+I6gbr/Tj54tfGeNR6yon0dkbBbEHbpJxD9nCe4Yd219Wp6Oze9X43ViR/hvEykidU2fw3wTS1JeryPraxPSyr8BJefqmT1EEk22yawbec5hncw3RFYH5lUe3kB52HH9VcG0nDWwkkcs14htT1dseNuKwpo5PGKwPhQABNVG3YSwMaYL7aRu/L5AJ+X68yXLfjk664xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgs6VnynknSCsi4TNAbXfXLrSnqDlYIS8ib4vetFP4k=;
 b=P0zSrEnJRP6JKDVNftq5VYRD60emlJbnSeqk60lUVSnI6B2uaRXv/cQNkvExGA7KWimw+DN8PZITMZ4JErAWT6pc8TVPmP5ketlQpMlRMZROA34GGh3shjng9vo9kXYNOrmrp6rU5VoQDHYV+N+LUwAPMWV7SGgUtGy12NpiABrZ54oUlHflwHTgHo7pcvNrHh6mbv4HTKviPdh74JQ7hoQcplLOIcqK0CkydW6Bu+R6ghDWtPC1zgnpWqqWPOYX7Y9KfVMEHLjE7oXjmVqo+BZHVdgoOdk/oUeqY1sfzep+PiXXZcm/wbUNdedICNPZdW0hJE0d2pVAFkqEMGHgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names
Thread-Index: AQHZbKsw5xtQpz9Phke1SvpgoB/q7K8u476AgAEd6fCAAPoEAIAAAOqAgAAIOEA=
Date: Tue, 18 Apr 2023 12:13:14 +0000
Message-ID:
 <PH0PR12MB5481BC472E23C26F43603B5BDC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411192341.751841-1-parav@nvidia.com>
 <20230411192341.751841-4-parav@nvidia.com>
 <20230417054149.5d7f62e8.pasic@linux.ibm.com>
 <PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418133958.13d5b98b.pasic@linux.ibm.com>
 <20230418074307-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230418074307-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7193:EE_
x-ms-office365-filtering-correlation-id: db66b0cc-5ee4-4b93-3955-08db40064944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VuLA7kzzpmv/kCO+G0244XJWASsm7WxTmbZc+p0cUzQ4TNrfpljpcGWwW8xWuRzvBLYa6ZLRn5lw9lDn2BvE44NdsT0uML8rMh8FKxx0mczUz/b4wFiqU7lXjKBJNTLBAna1bFbHI70voHWAXZHWOlsMmQHbqHV2qyMvQmhR4rWKmYJ/37OKeIIk/ItYpX6/q21YXl4xst/nCDXyISd/mOQDi/vdvdn8iIFH2MFrDQEuGAOxPABFvPRhGMn3WbqUR26WJTTDJc7KB2j897D2jQiPK9l+DilguJXr9jfbh7u6zTGUWdQKGCZzsKYEOm41WDoM+krk84Qf1efXTxaeLKNFMFLcQnBNXLqti2VxvXVJfGc3eG5q3aWscOkNSp4Ajp3d9R5AryGHLBBshhaB+2fX8SssID9AfhzTTuJmAkY/QfhUbArGrZeoEUfEZGRL0yARtqaLq+zrw08t6p1nLLu2uSrBqg/9Q2LhLk23zSSQ5QbVU36pROnjIga2NAqglf5DXj55UxlEMd90TiaGORSgQTx37vQtCI8X0CRA5LOcKupqAzYRKkCiszSk+D+uY1F1ozjtypRK1s343b3+at/Kszr1l2shkq4UGP8Wnfm/N4LVQmIqxU5u91h7KPjB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(26005)(186003)(9686003)(41300700001)(107886003)(6506007)(110136005)(54906003)(86362001)(83380400001)(55016003)(4326008)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(4744005)(2906002)(8676002)(8936002)(7696005)(122000001)(52536014)(33656002)(38100700002)(38070700005)(5660300002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?atAWVD4aQyUxwFjqSTTL1P0jF9b61KFUVgsd7Haq2j8U7U07swvszcVz+hZd?=
 =?us-ascii?Q?yRHTFezxZFzQIKQLEHPoWb0wJdSwfTfTznxZG3PBEihssyuFgxI5XJRowcRX?=
 =?us-ascii?Q?GAtUCTNidNRroYq51iyeqcMgrtktOrCHDz10IxNTMAniYbBP7ngmMz9mGs/u?=
 =?us-ascii?Q?SD9h9wPLZ5ITYLgbQDmoW5El63Q3qGiZuZKPSBSusX3kFQXlxSe1INHIToOS?=
 =?us-ascii?Q?Sj5d7rThfWz26ddIZ3QiC9QHk9dS8PoSeScozy3xb/vSmkkaZF5T/zIzfoQs?=
 =?us-ascii?Q?DlCePejSooXjKbLjwiM6ht53mkiODdBYKtGTxzvzj9lEVDGrcc1rM5hbZCw2?=
 =?us-ascii?Q?zNSP2PeUVXDfJu7oHf56vXnCxts8fVibP9nHzYm6XLsniQzQZ2taRq+TIrVA?=
 =?us-ascii?Q?JsU8hltkB2qU6lXuA+BTJQ+Woj9ltY7KyVEvRz+Sm0UH+2yFfcvh14+sOMZo?=
 =?us-ascii?Q?qjko/K2wVhpl2/jqaU5YVOLYZoWJIjThwXR8TClCUKLnZR2i2hXuAVwvNXaj?=
 =?us-ascii?Q?57NZsMtusj6JQChtF4bGPV5n7VIfrba50utv5kYR73MdaSRJJq1yQbgGd/PD?=
 =?us-ascii?Q?ZM7lZ30cZOT9YvgAGzwS/1qzM2JN2bl7A9pVvmXYdMYT9J7Vr9zo6STTWlsW?=
 =?us-ascii?Q?rFla9B4Hztp5HzX9Ur+AVGNLFQ90kIoINRCNZ/ExJ+uK77AU4HP8CPtsEeXr?=
 =?us-ascii?Q?5qxQV0cGn0lwGtGNKxfDtN71y3kuAQM3ACP1bKP5G1NzIftI5SG7GlvxDm+/?=
 =?us-ascii?Q?No9ys5DhuGMIDl0K0du+Pqkf3HZ/iv2QUfjeFIHaKaY+yDsHrkrlVnJLzqwA?=
 =?us-ascii?Q?TCpZYlGjxbNRGy4+HI7d4ckjCisV4w2u2/4Ul59F3JgceCrH35WCKNPc5xX4?=
 =?us-ascii?Q?pOhZg6ksys3iTxGIPcWgJWsXy9LIzEE1UhQGMa5PUIkgPabz5gIajVtklukH?=
 =?us-ascii?Q?+zvlN0ti7YXENT06Rp0Idq0HBMznv5CkvyBw39hNAwTehx6+l/Pjrm7R4Q2A?=
 =?us-ascii?Q?OcA8sCryrUCGEaRTXj456/Tq1MG/gh8DKbHU0F852Whno3jxX6B1nGXGOe2Y?=
 =?us-ascii?Q?kMJqJcB3j4RGJQBriRvzDrR7sWCkx1Xk1Aqi5cTRnyHG0Vi6cQd4H+fBUb41?=
 =?us-ascii?Q?fLgQuFQTM0AI6O+AfppuwN9mYvcbChvXbJWHMn8UNMpFqRlwwOmrk1wofuNc?=
 =?us-ascii?Q?YrBsBLXZqRlNHkLlbXMJqOWwl5O1PGHLZh4IOhbDz9SUYeWuNibg03hwDAzu?=
 =?us-ascii?Q?4j5ylm7NKBW7R1JERu+CeE/8d/ES2KCWvhuVeGGQzgoDd2rPxqBpbRF1H2f5?=
 =?us-ascii?Q?4fl2NklXRzku+zoE6vHIRhHZY4XChZg0FU2CP+4mU2DKMJ1Qsf+YPngpMawM?=
 =?us-ascii?Q?bLANjIXDSyxEAsniSNWRCaNC7LXAOCkWx0nbSq13NllOfzhMLeybloj9aoNO?=
 =?us-ascii?Q?ViszH19saqRlUNSEuQyZnspg4KuxZ6EpqOnEJbnysLE4HdMYiHfIaABQaIzh?=
 =?us-ascii?Q?rSF8yllbwGXROsy/uQAdIjasn7E6hiAU3itgn+yGDwDayDXg+Gdm4E3e+HF6?=
 =?us-ascii?Q?KGNguVJvlaObrVtnVNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db66b0cc-5ee4-4b93-3955-08db40064944
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:13:14.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaMGw26cWQbxSmtQEUp3Bez6CaZS9WI2jt7ZurMi5m8uhBvDYFp49F3/9SK99Vm46doSYgjSs6G1m2Z8Z5YXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
Subject: RE: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 18, 2023 7:43 AM

> > IMHO VIRTIO_F_NOTIFY_CONFIG_DATA should remain aligned with
> > VIRTIO_F_NOTIFICATION_DATA in one way or another. Thus way out would
> > be to do something like:
> > virtio_pci_common_cfg.queue_notify_data -> queue_notif_config_data
> >
> > I think as editors Connie and Michael should have the most say in this
> > though.
> >
> > Regards,
> > Halil
>=20
> Fine by me.

Ok. read it now. Please ignore my previous email question.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

