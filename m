Return-Path: <virtio-dev-return-12183-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ECEC77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:15:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BE6E03E303
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:15:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1C54986619
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:15:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A75E9986514; Wed, 12 Apr 2023 05:15:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9585498650E;
	Wed, 12 Apr 2023 05:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz8cMtmUiQWH2q2nhnvqq3vzcf1vtOeMyx9fWXiDDoV8O126vvilY4aSmTGR6Z7i+SUgvZxNfCOYErRMUKgz3MxnZ2oG9MdNv1q/ayE4icxUM3LPNwKoXApBL3WXLj1pFDXFb7oVUPobGWukXZHNMsmojEEy8BfThsVZOIvQuORBA0NO+1cteg56ydmXRY1xutruCaNyn3lpUHnHTIFbBMwADS888Dc7SugId/zYDyVxnWTzqOR2gC1X8OTsArF1xz4bjLPiC96y2V1BPftwI8yvsSSfVBIdTnugxNIiyUXROanDEyi67d9VDGTHw3u1Pde3PSGJKNo1SvtZa7MpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi4UKls9qOdX8qWeRrFAiHAIl2BX2wjco+gIPLvuaR8=;
 b=GMdWSqhQd09p0nXichkm73uLsi7eyWk4ecU8VGQAeTaglwVh4/PfL/wnNZ9tzgXfXBLZbIDOrtqTPEKEOYx82j43PkYVkrf22dqELOQhLvWC6usiv+pale/Q9TxlRSOlBYknhVFwvEPlGfAuidIMCeKfcwhOap4C+vxaIP1ckVXeRrtVcDB7srdppHFNtWWMy4/28GjUmwzViKl0xwyZkctJ233sjXMawgqAYXHhR+jDS/4EfIfkawN6WnbeMay4UnvjxlYjQt6gr9smBL5ft/eNgPu6iWrO6JR9H7QQ/D7NIlUJXtaPKF5C6BcaMGe4ABiIPESuIvMLKjKuafd2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8nLToAgAAAdXCAAAY+AIAAAFDw
Date: Wed, 12 Apr 2023 05:15:40 +0000
Message-ID:
 <PH0PR12MB5481912FE593E532F4566AB8DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010437-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412010437-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7733:EE_
x-ms-office365-filtering-correlation-id: 9babd389-3604-4e60-da31-08db3b14f584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ATUGqZNd2/eRu1JDlkxnbQnrkit+4lyovtYmeWEEhCwejw3Fym6l7YvJomZXZnKV556xznvhoHq4UDZfa+IC693cKqJ8gNPG8f7muQC03zn/Xcw3VDGYuysoCsN3f0RvAmgQ2z5mFdNHyji9jGgaUD4C05ClP/X0Bjv1xrIo8Q9MmnwKoKJoVtwhIPE6zFXvmuPktGt5FRNKRF4qhZuOxPNbtLGv05CbvxS1ij9HtIzo+3qgjPHCALahDL/mwjX29V4chgJxWAXMFrUhn0/R30a9TEMg5dOZms39U2TkGJflEAjDgIJNHUz0l0J2BVF1VDuj/kiOGHam6cPo9+R7mNsDoa5l3Mck2v6kHW6FacC4KVHPXE9+twQDXlwPTFw4PbY9SbBBQEPgwK+t1ANtOXo5mLloxJq6BWeRvDzxrKxUN+r4gzItAYUo3icZwiY93dOJi7ZcYgrivEus14lQutYM3yJIRKj2RKEoQ/j/oBpiOZLsyrQ9OtDMgKHmLZPp+SiurFugGxsDw4wb3dwxaWdM2bL4BKCjk2MN1IyygST6LVE8BgWkbOUqD9EatMWlVNmF5AErQmbzhNcp8mqRdFdVsdSj0rdphgi3n4e6hT0r2rPLQYZcLFxm8adMjVzS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(76116006)(8936002)(2906002)(4744005)(8676002)(5660300002)(52536014)(478600001)(41300700001)(316002)(66946007)(66556008)(6916009)(83380400001)(64756008)(66476007)(66446008)(33656002)(55016003)(4326008)(86362001)(38070700005)(71200400001)(107886003)(7696005)(54906003)(122000001)(9686003)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7O4THq+yzHHHjHqTi+WL/8I0rH8mJqMfTfyViMr0Qq7FQSunhu/zHVIGffU+?=
 =?us-ascii?Q?yhSfowqXlz54LAGDfgbAxl3yoMY7DtfPBl5xo3G8cCEBrHt/v+WNucZ+S5Pk?=
 =?us-ascii?Q?+I0n4ul8Ty+QxdWnwb1n/R9f0qTuFUQPYl5uOStmxOdMsE0zk6kRhC/+AWWJ?=
 =?us-ascii?Q?E8wEV7oB5x0ydrrxI1/XsOsAqz82h2RWU6XS97X2nO34XWKKKBvwiq2wBM70?=
 =?us-ascii?Q?H6JKE92dqNLRhAyanPtygEtxst2KXCuX68BEB6ijg5p5zj/qzQ14MZdVUGo2?=
 =?us-ascii?Q?9P0W9PMVRYb+kr0UnIICEmxT5gW6crouhCk712CqKDOnbOn6qRNGfAb634ao?=
 =?us-ascii?Q?6EjW8YEl+m6bgDkI5aVZKai/aYYjnkuACUq1VVn6SL0cdZ1eC4nYu4vtl18s?=
 =?us-ascii?Q?SXOqJBx3UQ2KqPaFyQqULTp7t4iCB1rzZf4jpCUFF2aGnZkFZV+Xyvo6mKIz?=
 =?us-ascii?Q?BD1HWPSaZWynsDgkGmGzr/wepOGsR0eph7C7rh6rWfzcdT8o0DIjwyXX3jI8?=
 =?us-ascii?Q?SpU8NUusZ4Js+Yxiw2T1mTl59YUkVotjTYt0GiKqWiWt7KnVSCpPA+beIO/N?=
 =?us-ascii?Q?jssK9XH90wrGxprMK0Uhvu36wqLzLGf90pCHnmjkMBsp3IYyEXskJEL4dhR3?=
 =?us-ascii?Q?J6V1yPT5smncnuO7NG7uWta0kXkVCjHCiBr8QcgFsgJ+qptNDo+QUUaZAz5P?=
 =?us-ascii?Q?WqLwo2NPnTLY8rCVqFGhW8KXOEZYuoDFtmwk9lZPepRPpXX4G1bupXkMIhuH?=
 =?us-ascii?Q?AME3GbRH9on101o+NruNS1ljjbtJ5w1mPEYyphQAXk56CTAKDQRv+7jDoAua?=
 =?us-ascii?Q?0GUtDhw9Nilmvsirc/sXgWmEHpwM+8ahN8PnxMMDn9oP9lu83zBcEO3ly4lN?=
 =?us-ascii?Q?Aa37M7ydopUtEsWJxstfqCellBcG51iCJ65kMc6xEsAL2NpgojD4fQqWfV84?=
 =?us-ascii?Q?bfkWP0egvj6cVmzzdBeRBwxCJ/yPPXmHEfpkQavo0lj5FYZCGisreAdzPsTV?=
 =?us-ascii?Q?um/XI6VaVEuJD0a80EXh4z/F1F74fEKeX/wnEcnN2L1JDlTuubrASxmEtyBP?=
 =?us-ascii?Q?/w9NQBcSaCtEbO9SC4C2k6iAV1noXnB6rl2Ae+sqzWMLjAh7uHtOpoTLO7ip?=
 =?us-ascii?Q?9f/15h47fr2Z2p0Gf5YMMm8qwXT9daBGl9G/Z+g6Sd8KZbuW8Y79AEkEOr6v?=
 =?us-ascii?Q?70/685j/zhcjd5T/N2Ygw4dYoc6HsBLvjbFgHFoAfqxYQFIMPbp1IgGFr5CW?=
 =?us-ascii?Q?5znseAkBdjwHko8hPjnpthc+aY2tLs89DtYmuzpxWKTgoLr/ez3EFBA3d4z4?=
 =?us-ascii?Q?O+3dVRB1mXy7VUucm6XW8CwWHnt/YpIsjWAbfG2L5BYBOjmc2RgCSFjcCJDv?=
 =?us-ascii?Q?D2F3cA8qjJXqpBnYdHSfsTvTZH3KpXZwGY0V/3O2AmlH5bISwMgr+EjaWuqI?=
 =?us-ascii?Q?7CxOb+DW8rHdn286rvh81+WPJYbuX3H5lUnhzuuSxTozLHaMFxiK3YmiWqkc?=
 =?us-ascii?Q?TIGm2s5n82ZkI+5Pbkqa+VZDRhMv7QU+8mBETGOQLLGDGCu7SKqp3wJpa/pU?=
 =?us-ascii?Q?r4FSjp3rLgMYj1fW4n0r1qzxclVhjku3CMg2HMA2v9DDQsPykaMLWqGmlHyQ?=
 =?us-ascii?Q?225J/TYg1uMrBTkgvVsOJI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9babd389-3604-4e60-da31-08db3b14f584
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:15:40.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoVjLM8+L+aiKr2FezlTLy+0iCs9f8hhTm9nwA4d+7U2V15WYgaemZh4e964tLJA63shaQ2ebKoohM5fmoibaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> New issue I found today:
> - if guest disables MSI-X host can not disable MSI-X.
>   need some other channel to notify device about this.
>
I will look into it.=20
=20
> Old issues we discussed before today:
> - reset needs some special handling because real hardware
>   can not guarantee returning 0 on the 1st read
When done through the legacy MMR as we discussed, it will.

> - if guest writes into mac, reusing host mac (which is RO)
>   will not work, need extra registers
No. Again legacy interface section of MMR behaves as legacy.

> - something about notification makes you want to poke
>   at modern notification register? which of course
>   is its own can of worms with VIRTIO_F_NOTIFICATION_DATA
>   changing the format completely.
There is no NOTIFICATION_DATA with legacy. So it is not applicable.
Format is same with only vq index.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

