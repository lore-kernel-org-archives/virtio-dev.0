Return-Path: <virtio-dev-return-12941-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966C1C7EE2F
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 01:57:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ACC1F157EF9
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 01:57:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9588098657E
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Jun 2023 01:57:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7EA96986422; Tue, 13 Jun 2023 01:57:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68ED498653D;
	Tue, 13 Jun 2023 01:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scz8V3qqb9nsxSTn+j1ZohCJ2Reea0baiys5EOV8eLtw3NC51YCK8m7r1B2I76bF0oXHVKxFlbyUvpNoTWHkEt9t65hFKdIcs55kGx9Or5AyLm5LieVquQ0JNR+ustcM1Eg+qd3SZ0vp1BRWEsTKZFUnPnHi6ecC4jiWgkqo3fMvC9q9r1us/OQhSUDrLl6jWzyrmJJ5p3uX1tRMaoFsYeNzHfBMDjmSylj0o8AovYBqL0xe0fGYPyPwRRJ+u+tUWl0NLfxymGNg2MG4xVHyNv+Lbgpb/fQCJx8eQRnreZrAQnvScEnhhYtb+YqA+6ehQMsno8JBq7iXu8JeoBfU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnPaXnr1IbIYYULxJjc94k7NWwpyUJ+eW/ULG9TPlvM=;
 b=j/Pen5cDN7+7eHcTEFR3XdcP/uEljierSfCBEvcrfYyIgdmSigqNLlIXTfuv9L7ubfWYsTV7Vc+CgW/qz/9riHtHZJ4E6GjUm/5mbOQcu/GTiWwvTV2lwpoKPn5N+hernEbPbXgEdKPi4oCrCc09CoUl3wZyYeR8AUHAXFGodvpObCvdPOcoxet5KPsWHqGPNvVkIgeSHazpks5sC6fRx8JcBDMQVI70smPrdhqdJlNE7xnTDmpRyMKdn6fZI663wftY99uaSvQX8969aaeEquUHDvLuylufwbetOKj/mPl83At22a/LNt3PXT5yCJh+6/C0pnTV/8WGieR7Qq8Ynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: About custom device counter
Thread-Index: AQHZnPYBhAj3P4GR10mqaBAnc/G3uq+Hyx2A
Date: Tue, 13 Jun 2023 01:57:39 +0000
Message-ID:
 <PH0PR12MB5481B445FDE3A718260C0A0EDC55A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5635:EE_
x-ms-office365-filtering-correlation-id: 1ce08015-7b8f-4955-3f38-08db6bb19121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4wE334P120I1lLgwQzzcOR04jYB225/aoOscLU+dV+9k3eaC9Ik9GnzyqEzJNnfRpuE3vNC7YjtE52PXSSWeftvb9QPJDbtarl4GH4ifHvdI3R/sqPLy9qFRR1uoUjvdBSXDtTfgXGR2aH6foam8j4u1D9Pr/0fylxLcSQSbZCBdjJK9simyqhq/ZKiwZE2ahaTtU5afhY4h5oMALew8q1YgYvHNkWevYS0NyK4WWlBIJHPHN3TJv4wns3YIFC7aAZ8frOeY/pe6g+SUlD7KkzNTIr6Uo03aDiKelHpPhFSMhZ2Ya/mV5iH84kEOsHoGWj/CTpeWZ4q58S5Ut1CuZrjRwYetnvKhnA0arWrL+kp5FwiZV44Amu4VRZhgdEhxLWsvfzHgjlNGlvNDn9vJ7ijkmH5M0FWcS1AigOStIfcIg9S5Mre315zMZsGRfS/kmgqemKipTOAvOIHaNNpRtybMmflHlPBvuICsgvnPWTyX2C859nC7pJeA0vHtELxHj12nliX68ilzd7FPjOwRV9F+cS+pbK1tlCxusiHrXPj7qtOgquZR1vv6Y1y0Am+rqsuLiRx73qf9RwmrG6Yt5WUA4fsVEUq4g0AlmRObHGon4x5pXHN3TQXtlXhm/lEr/75z+7X0/DadN2yRobEQybA6femTedEikJ//ll7Wi5g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(7696005)(316002)(41300700001)(6506007)(186003)(2906002)(38070700005)(9686003)(86362001)(33656002)(122000001)(3480700007)(55016003)(38100700002)(8676002)(52536014)(5660300002)(8936002)(76116006)(66476007)(66946007)(66556008)(478600001)(54906003)(110136005)(4326008)(71200400001)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0RoWP4T1qy1PKmvd9m4Pagj1CGbPiyp9XLwCFRmFzhRbDOOzZCU2Dd0AW/oG?=
 =?us-ascii?Q?UK7zfpiYEG4L+Qp3WkV07yqXnKkTG5eRbqRIoGtoVCu9sqymsRzfCfTs/GsH?=
 =?us-ascii?Q?NJZXUBzmyORAJrv5DNa4/RT2vlTXfrNx0mPceOeOfFvX9C0CEpANxzBhWFsC?=
 =?us-ascii?Q?AQpxXVJxgcrJ8qY5DUp0aPQiTYyIV6QeXXPXJJb6I3dT40bNe3RUle1tOMIR?=
 =?us-ascii?Q?0kXuJup2fVy6GYnsEWTrgZq4/WfzRSZRaxwevH7rcDMyn/BUvuMy9QO0kvVw?=
 =?us-ascii?Q?yfLyDGgzjd4YkUV2MB6rLPUDihd5hUu0dZMmzvLYGsaLY+nyaQ0oMAyYppAZ?=
 =?us-ascii?Q?mkugHNNYqaymFZQydl3AWBIUDZgIjXfD4XBP9406a/HuJbdh8S6TIbFO3zju?=
 =?us-ascii?Q?0USbbH7W5Y30ok9u7pYG5YQAG/10H3e8kBmnzOrxAPNUkkgLcmQfNUJKTTGq?=
 =?us-ascii?Q?m7az+B3y6oUKk+x6GJqsNVIufUzrYuAw8CWEEcwsq3E+p42NJgV6elg6uX8k?=
 =?us-ascii?Q?L1iHP2dym53EGt2WONyXHs2r2wnAc7bmBekfmn0MNbI3gxPQiepg/HcJfytT?=
 =?us-ascii?Q?12vcMV7gz7vR7YhvLlsJf0nkCtTovRLCiPUCVPRrE0BzkGyZlCqyDHZekh9h?=
 =?us-ascii?Q?GARv8BH04PRcN9M6UtqQz7caf6RqDKcIrTinm41oJ+DQViSdvQJPgkuJCUHs?=
 =?us-ascii?Q?P50bTTv/93pmwGjueifcWUV+NHKFTmgVINJZdW7ftUWeAE/sqFG7IyExPGSz?=
 =?us-ascii?Q?QkWzCaeICpk7/JDNh+FpiKG4Ia/Zc5tH8TaNMk0WBueY2as1pmTEDywXt2ae?=
 =?us-ascii?Q?5BotNWUvvyV5XM1J6g0FOFd6VXGTQxn+fk+wzV6qGAEJTGnXuFw86uRtxmVV?=
 =?us-ascii?Q?Djhn62/fB8i2569RbfwF8rIQCS3dACCsBMRcwKzolkDHc8milunUbyRGRTwA?=
 =?us-ascii?Q?pvgnKFTYzwjipL+8dFVEauK6+sHpaQhNAC+fl215XHFHHZZPqiUi+JnDtCBm?=
 =?us-ascii?Q?qLzJUONgFQANGx5zT4ZJuniEfCeg+MaNakojitv95HSpMoB8Eik+hTupvDae?=
 =?us-ascii?Q?QfEPQuq2XgKUlbGwEzs1lu0D45ZHHL9FYUp4fSqeuD8KocOWP8mlft8HBZ/d?=
 =?us-ascii?Q?P2NeoeI0j7IATlXiRHuazQHSaLC4xTdeV1D6yKK2ReQAt/1dbK8qnzqf+wFu?=
 =?us-ascii?Q?2Tq9kptjcb8it+Gkpkch7KxQCpO1fzn5izIdPuXZDBSbQZvRkH0j3qh9/yZp?=
 =?us-ascii?Q?IZV29iqDBH4JbDudQM+OzUeW9dp7HBdfmGKqzV8lwsFD7NaYjt9JO7/O3/M9?=
 =?us-ascii?Q?R4JL6e1rfKFEz2I1REhTlvzh4UQsHdGSdpzMEJE0dv/E+ZUwExa6OvI7Hnve?=
 =?us-ascii?Q?rptIFPTUY+IZtU2JjyAEQ3XqyNte7bJWeiKld73pJKSXKAjDM4hWs3Dk91CM?=
 =?us-ascii?Q?Dg18XYrUQlt6UVPTIxfFrOVwTRBOGReEctuu4QtwGygaacJ5kptixNQBNl06?=
 =?us-ascii?Q?eATpX3b+gqsfIRd+5A0FUbjDlU7JiBC8s4kuyR+OcBzZLqQTppcy7BcD5e/R?=
 =?us-ascii?Q?lVNeQv8RG1QXfxo+lpykPQUNS1T0jD0jW23tCPJekLR+4JLoLGrYol3q/9Xe?=
 =?us-ascii?Q?GkwJn9rfGnmoDmMWSEd/5dc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce08015-7b8f-4955-3f38-08db6bb19121
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 01:57:39.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhBjFSYiCXAKiKfEdbJz6mzn4cX5L3SH5mAhjaknM3JpZBhXp4RZR59Lr9DeFvB+SZonfqx4DAF2TYUlADUkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
Subject: [virtio-dev] RE: About custom device counter



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, June 12, 2023 2:13 AM
>=20
> We hope to support device custom counter. That is, virtio spec provides a
> channel for driver and device, and both key and value are provided by dev=
ice.
>=20
> We discussed this issue earlier, and after some internal practice, I thin=
k it is still
> necessary to discuss this again.
>=20
> It is very important, each cloud vendor will always have some special cou=
nters,
> these counters may not exist in another vendor. At the same time, if we h=
ave to
> discuss it in the spec every time we add a counter, or add a feature, I t=
hink it is
> very inconvenient. Manufacturers may add some new counters at any time
> based on some new requirements. Some counters may also be removed at any
> time.
>
Debug counters are useful to have.=20
I agree that they may be vendor specific.
We often try to abstract and define as much as vendor neutral as possible.

So we should probably first put our efforts to see if more than one vendor =
can use it.

Assuming there is some vendor specific counters, I imagine to come from a s=
eparate vendor specific query command.
This is to keep standard counters to avoid mixing with vend_specific.

> Of course I know that doing this might hurt migration. But what I want to=
 say is,
> why does it affect live migration? These counters we plan to give to user=
s
> through ethtool -S, and some changes have taken place in the ethtool coun=
ters
> output by users. Does this have any practical impact? Or do we directly u=
se
> some other output in a way, we can clearly tell the user that these count=
ers may
> change during the migration process. For example, the driver is migrated =
to
> some new devices. These devices support some new counters. I think users
> should be able to see these new counters. These new counters may be the
> purpose of the migration.

Counters which are well defined non-vendor specific should be able to migra=
te to destination on best effort basis.
For well defined counters if device A at src support N counters, on migrate=
d destination, it should be N.
This should be able to achieve with feature provisioning infra via group ow=
ner command.

>=20
> We don't need to support live migration at this point.
When done on best effort level, infra exists, vendor has ability to increme=
ntally implement it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

