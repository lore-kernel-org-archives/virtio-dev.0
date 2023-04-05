Return-Path: <virtio-dev-return-12024-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBFBC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:21:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 33FCD42912
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:21:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2692F9865D8
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:21:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 19F4F9865B0; Wed,  5 Apr 2023 13:21:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08A569865A8;
	Wed,  5 Apr 2023 13:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii8Y7NGO14CX7tSg9UodVN/cAzDrsYsDey8gN9pnyiQTP6ANnNd3wGwDZuV5MgLFJHbVy2aw5S8zJfZ/XJm2JQYxZ4IunivhO/M4sb7SQVxLBh1KwpPmHVCG4ZQfjN3c4MasHFnXoz0A7scdMzJdhPa8O778aapP7HvkHYZIgDCecRawWL8GAUInMbBShsP4dAONGtaYMPGjEtNzPNFccNOMLECjmk5OquGPD8Y/yYLVKNriNEdXtRtpTvwqDidTYFSkoglJ+2H4z+qQ35HI/pvroICbYPcqMktyysR8PXxJc1uyjgvDdIP+tqpo2jsuaR06ctIqAE7/kL1LvQAKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPtoswo0HjeMSO6/p0wOJ55ZOQBoN9ptiBHx34ytphc=;
 b=Eb4tj37sWOcS1DtJWnbNf89zOqeDoWWCxeVMBY+oOlQasJmhPTygvIHexJtYNld4lslIu2DfbNKp9rwsWkriBGeh9Tfw+XQ2DalZT4i25XZCGDQ2qFaymzHy6m1P2MRknPKNsmuqxisbMQqV/6VGpB9zfVrV6CQirwjucqd9w9ikT0bwb9x5Kg9e9XvZqZzB/yDvTDaUpSc2TOKejglLalXPjZmqqMCvh+czFSB1S4MWNmLgStGPqOCMiUdDAzB8JSOZlV04pBvimNWYWaB29l+TqH0/d/nCguRiMNfGdcS0o8K2HXX7xa44rJdrU0og9WXVXvQaW05aWjXfdRVrLQ==
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
Thread-Topic: [PATCH v12 03/10] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZZ1r8zVHaZ0BrZEO8XVrJh+aoSq8cMK8AgACDgmA=
Date: Wed, 5 Apr 2023 13:21:40 +0000
Message-ID:
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405012723-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7083:EE_
x-ms-office365-filtering-correlation-id: b9daa262-3630-4c46-e96e-08db35d8b120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hjI6zAVCbhklWJgbInZBCu+rl415C2zgKvGCVd0NJmi0A+0+BMnomZipLdEk6KgPYR3B3p1Rw2pZhl63kJVlocR8Q/1o3I7IzfZ+zvamVTxSo6qsoacld41v4fztgOS8v5qxBj4/TqYWVOxpLCkDCyIS/wKvgp13lIqiEBsoJswMF6HRr3uCF1O06eCZ8Pm57QEDYn7skCFr+8XlqCSBrygsLdSx4+3/EC8dquHYCIawtQffqy+73MFZuP1iIJAucpZFILMPw+RjOS2naOKuyUHH/NY/X1yJziBw8sB3BW8gCgMZoJAiivB35z+09z/WXFK8qoU9ovaTDBVMewAJMJFU+s9U1mAVxkyD7gSpVeJQqylvqHT4Dg3r4U44d5gjE3Tde53nLB3LGz0oRKGhJxoMWQ7/z6IcXqwkBO36U8FK4bLgweVQI0K4tZUwmqC6r8vGpF+vGmAU7EcJffoVt1c7908cvFh4b6/HdMznyIFuoBPERD4u2TzGEFOlRvvVa8TTOWpsxcgq4p5wXzhqXGL6tcJiv6zfHyO2C5YnzzDY5J/TtHAKFx4EjUcs5i2j7HriMpyNBGDkrWGhvMcHqOzQ09EJcq9wo3bPnuo5JgFOxneXcxQD1ajJ0acAxaxQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(107886003)(71200400001)(83380400001)(55016003)(86362001)(122000001)(38100700002)(33656002)(38070700005)(6506007)(9686003)(7696005)(186003)(66946007)(76116006)(54906003)(4744005)(8676002)(2906002)(41300700001)(66476007)(66556008)(8936002)(66446008)(316002)(52536014)(5660300002)(4326008)(64756008)(6916009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VUPcgcLUDi6y775YcpupqVXJH0wKwDMsa/AOqIRYdJtTHLHBBucXNu/VEw1m?=
 =?us-ascii?Q?2nj26oqhWvz14ZADur1UjQL01gfMFz7zD9sHLnlTxXnvVffcYPqatGVwJXEe?=
 =?us-ascii?Q?JjD8Lz0iSAfl0pCWagO6mUJRjBXoKSMuXq9BCaMQefsFHUD6qgw19CGEk31l?=
 =?us-ascii?Q?gvtdjzyRM3YAIJXERwWriGWi4ukXDciWvnTDORhSPTDV7Oj+w0wQNWnxGioi?=
 =?us-ascii?Q?wQbJ79MbOvZ9dkQ8g1y04yJDuzPlmmk3wIn8XSgKd478tk3QG3YvvDsdeTvK?=
 =?us-ascii?Q?nlb87Xr6dUebXa+ihFlLTBFqmLdthziUirn3pu9MvCDzRHNzr4ZjTKp+6cPS?=
 =?us-ascii?Q?2fS+iPGcePZ0PD1+XVDXUxdCyheuGM+MrFwgx+Ye3fLpTqfg8+DUaWTnCHeR?=
 =?us-ascii?Q?2Li8vYj54RqlM6+j1qrFsr1U1WSUZ2g1jy1zGWKducVkuMjc3OmLM3KiLx58?=
 =?us-ascii?Q?Yn+SPMIldVFaGcr8XR9oNptfvo12XrlUpk5GQETpa9S+xCqflcw9jntBtzAg?=
 =?us-ascii?Q?42k8Xkz7kC4K+MD/TzRkZ6Ravp7K5ppCHITRpv49qbe4DZVkRJdaHmteztWX?=
 =?us-ascii?Q?4Cl4ikA8bjjArukOGHwx/FLydgKFEOsVangSK30jGAokRROHB+HyhCETyj1O?=
 =?us-ascii?Q?qfDGnJUKtFejnSRKqEB1szr+WkDVgV4mWnPwrrN5hQ2KomkVOoi+qa6q2+ky?=
 =?us-ascii?Q?psCXnBuYeMnuWa4iUhFiXXozc+jm6KtyJcXnwo4BxxbWXYI44EEWOvb/4E0k?=
 =?us-ascii?Q?4r09M7xWTb9fywrLhAgv969M/1GONlHSP3CFwdF1ZsXmvk9297pqkse+wjXN?=
 =?us-ascii?Q?7Voek44VMnRE7HRatoCtYEdUWBvedkj7Smu4rYnjlycbrNoITVhxuL38k4Qf?=
 =?us-ascii?Q?GKQbs8NylMNLN4OhSOxBCVJ52qXJ2kDKslUWqTiTXPoWivpL8JCFF+EFMp6e?=
 =?us-ascii?Q?TbYaXDCTNKrzXk7kIY0d+Q3ipIhNGVtEzaCYf1GC2HMNOWYn4clM8IUGxfIG?=
 =?us-ascii?Q?gdz5ue6l70N+2JQRO2NbfWVlSBi09ZZ+r62plSWrz6phJ6OdTVl9o3jufNJI?=
 =?us-ascii?Q?mHyjPWor2sRflMIQe0oPsvYlBQB7gzAsyPBYCO9fQ7RNYhEgRzJuKNr0YVdF?=
 =?us-ascii?Q?HufORtRsipRAyubd1lTB2wekrJ9UtYndtLdHwMEStBtwR7MViBjH9p7jJYFf?=
 =?us-ascii?Q?zLapkncHpfJr4XC2WQa6+5Ty5Om9Aikoc8F/yAp/072s3EekgborHmHbVopV?=
 =?us-ascii?Q?xhtvm1Q1tkWEX00wGp9HsO4TKFyFtIYh54QGzfnr6d+GlQPqN/RmQKWNRGGZ?=
 =?us-ascii?Q?xNx93BfKctWc6BG5RlPzNOZDFidpL5gGMDQblreBgmzEw6uqYrd0dfC+86LK?=
 =?us-ascii?Q?vxsGWhICRCwO0vNeU84u6berns/yvGeXkrEiYGFT5lCj/mKPGxZHYo6/S3lY?=
 =?us-ascii?Q?1aNk+jywz+zKlUXFpf8seGrB+k5tHcZ5ucvynOXigCd1T3elsLSwvpHkBxP2?=
 =?us-ascii?Q?IbGFF6mfLmsz0uy3zUkyfW4Kv7Tsky4qUY5M0Rf1GM4/5Z6B/Z7WDSm3A6dq?=
 =?us-ascii?Q?qeD32zWiMgAoWkiVth0VlzhkFU2rj9BrAN4PBNeAaJJ11an9b4M3KAAaRXEo?=
 =?us-ascii?Q?CidqaIN0swTsrHGq6VK/HOw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9daa262-3630-4c46-e96e-08db35d8b120
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:21:40.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQMWeozCU7DszWAFpLdBAJ/bCmxhoQDR/Yrsgglp5FN2vrPoe/qcWx9VjTddw6+gIHJ2diEedE08UpXz3n8yIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
Subject: [virtio-dev] RE: [PATCH v12 03/10] content: Rename confusing queue_notify_data and
 vqn names



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 1:30 AM


> VIRTIO_F_NOTIF_CONFIG_DATA is such a narrow usecase, I don't like burning
> "vq identifier" on this. How about we just say something along the lines =
of:
>=20
Ok.=20
>=20
> When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this
> notification involves sending either the virtqueue index or the virtqueue=
 config
> data to the device (method depending on the transport).
>=20
> And then "the data sent is a device supplied virtqueue config data".
>=20
Sounds fine. I will reword it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

