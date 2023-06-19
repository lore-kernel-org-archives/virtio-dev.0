Return-Path: <virtio-dev-return-12985-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEE4EB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:07:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 838E21CA24F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:07:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79EB49865D6
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:07:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6ADD29865B3; Mon, 19 Jun 2023 18:07:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 358C09863A9;
	Mon, 19 Jun 2023 18:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtUlnAizaOb3RGc6qyVy0dmJ22G5CyLDB1wBTx1G1UaWtvwfnkqkMlJzFY/54OHpx2KDICfIXVuRm4IyLkqIWjsEZ1GMxkyecqH25H7+w3nA0ln6h23Dq07s7s3LczIRkIbg/7Qr/nGkcYSRigSGrAHxSyu/ltxRQIOU2dBkCQ3D7P0Z52E8BluHmtxh/5yP9/zWtdv0KUxyfUCRX5B3PP9V2Ams9O573gnEtThcF+2UvTFszekDSwpjG8v1zp82l8ZkXl+II6iy4F0CMgEHvp1k2W1uViZzI3tMiLvaRSEXO5P2QgP2hoVrGlMkyKHtuZDlLP7BW/iHnKFfvdvpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hkf5YY3xbcqJUmP5BLwnVMwNnv9xt4fZkOX9bvyU5Y=;
 b=FIiHsi/CyPlpjbUp2TBcx1gpzn1hD6ibtQURwW5wjMBh3Lzpn97MKhB71Esr2Ow/HQjyTnDOakdV2BvNszMyctA+8A8ldXEH7427ZVsZ5lCfbPGgHnTztlCH0ju+B238oqeiiQx/aSwity19S8MhBHtkQVj7kv+h/2YfJZ+FAF6zNfKZhLM5m2Mk8MJLuViu3TdwpQkoq1gCphPMm9tkEC7Zggu79ISAUH+cU///KxvDWISbsibxD+QQS4K7+R1QXzMxrj71LZX8P2BDJLmG5fwmT7QFA4zDtJ3aWygJEdQe1c5HiCvUnAxxMbQ5ntd8/y0SzecIKG1gjuzdEhpQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABE6AgAAA1fA=
Date: Mon, 19 Jun 2023 18:07:02 +0000
Message-ID:
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619134649-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5247:EE_
x-ms-office365-filtering-correlation-id: 351c9f69-60d1-46f5-7109-08db70effba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UuV8CGsc/13pMJ9ZR0fBt3sozIgzd1yM1YZ3/ilWP2KiSWOrsX2gdpr+HeAikgDVxwU3vsuG164XhquljMosJzfWz6h7S9D10KKGvpA5u9zaZGorPq4Y5XcjrI5P81H3gghKtwXFIU0mYsHslatKL1QcH1CzYbmSidX6AB9rqxREm6wfaNeMpl01FPGGt4n/rmDr39aQj6BKSdgZMVoLBk4zvbXobBzYkpZzCwoAIPEyaQ0Zhd0qIqwcjOITcmgK1UThXrxQtaX4kPUyJ9V8a4133bhFDtjUPJ8F7dQXp9qUT62z1NsjqEBuBRg2KQpGwL+qBHAr2QkL5YWv1BZDsipXhFxaQMdgDc5pREhPnxRXnSf4PxZUP0la4y93xM/BPaCs3J+QqqniCI4X3lssGvs5bs195TJf2y+kIeqgdCNv9N0pPOZEPwZNB8Y+3FigJqhto6SLTubaXvR0Aky+FVQ2EdhxZl9Or6jp2B0LYgHaxmA9Go6ZFVeXkNiUkodxIklFIC+3ZXPf5s2dpKrJvqArIKPcE757gPFkyY5OJXJhT8D41/Kp1sFqemqMTrFG9ZLHNp14+gb92fCV4Nc7MspBhAzsNtFVeg0dmuqx2KkqEXn6+dcsPIYP9DnVbzM8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(186003)(478600001)(7696005)(71200400001)(9686003)(86362001)(26005)(6506007)(54906003)(107886003)(38100700002)(316002)(83380400001)(76116006)(66946007)(66556008)(66446008)(64756008)(122000001)(6916009)(66476007)(4326008)(8676002)(8936002)(52536014)(5660300002)(2906002)(41300700001)(55016003)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hf8+vuZpUQW+CJaXG6sj6pKuJc2zrLh6yD0SLOMwgD2Pyt6JhuJxerNiio63?=
 =?us-ascii?Q?gmxdUxPsC2wjG4voHsIWh/IVLxKsykDi5pexoyDfzZoN50rv6f4BM4OeWFve?=
 =?us-ascii?Q?YO0QlWUpjCjOhco7FCKqLjYyUREwL9ukQdtbhBWehJ2zmDAqxIapTOLwuZsS?=
 =?us-ascii?Q?Z3VDu+wI7dlH+7/UI6LN41TzQudAx+OWnIK+F/L/AwRec6FFmsdg6X5xVOjD?=
 =?us-ascii?Q?xq3pN8Va142ZQVblKZ5tOYKKcG9q/qkjA7KlYFz5vIbllUWlbmgdVw2I0rsn?=
 =?us-ascii?Q?JVTM7qCV1TFKQodROjl7Xs0hTi6gcKZHbrx7IwgDU0jLZ0YEwmYAmYzmIkHx?=
 =?us-ascii?Q?wTir0gOfDJ+/qYHIUjI2LQdoOdG9yp7iuC9bMVQH/r89GxzWcwHsq7K4yVSs?=
 =?us-ascii?Q?a3enPCuY/LTPjd7iBgVZvpH+hiVc2Hw+JUcEbLcNeIOcTSvrDQSeIidhNT9T?=
 =?us-ascii?Q?EpgoctZP3dpqNrk/n2KmtxOvm3uE5dhqTlMz6EQaYsulGS6EfjCXZB5Jp1IO?=
 =?us-ascii?Q?k/9LEgMS9locqXdVH63Yf7Cl8Ap+QkiRMvnZDxr0nSTiHhWPrqrJTBE2xWjJ?=
 =?us-ascii?Q?qSxDzttUcLmP6xogMBXgIh5K5L88uWCarSX2JX00CoXfkCRo90toIetiIhzS?=
 =?us-ascii?Q?WVfFgSEQ9I+BEe6texDOsa+piEdvpjW/dKG6VT39gNcfIvm+gcRUllDRDL2l?=
 =?us-ascii?Q?IcvA8+k2X6ZUMGsgF6rFHnn0eRXrhXbH+QKVb9uUga6+iLDXm6QXdFMpA9w1?=
 =?us-ascii?Q?wtGWkW9NsGqJ4UDi69PMtWuOAysi1GZ9jd57S84RNqKF4Z/uK3QBjZcb983G?=
 =?us-ascii?Q?/S/Dht+qwtSlxoJ3N/HiKkVcCYs6NptalRuasRXENrw42H7U/SWZuQk24PyM?=
 =?us-ascii?Q?QSfvtKLohIoFaVMs3dr1PU1sL1R+m7mJnSuqqucBHuCHwqhRUkTentKTj8Vp?=
 =?us-ascii?Q?NRqqoAzXfQ6eoaLhYsGCQTk6+sJiZbZkYQTDWeJycLHMAbfax5ezFI42G9zU?=
 =?us-ascii?Q?743yvCGa6a6Jlkc/mmMrXlPoHcio37ztIXVsGAx4g1dvQWpZKXl093ggLR0U?=
 =?us-ascii?Q?HVVo+V6gNcfFsIaS14m9re3LH4EoOVClHFOEtyqhq3DroheOVQUKbSm8yLWd?=
 =?us-ascii?Q?sFBEqcqnvU3GGwoh+kg+ZXLzbZ01lu8Wg4GCIudG0V7BMy2nYt9s8iPaJntL?=
 =?us-ascii?Q?Rj7eMGjrdttKv/cai3s/XGv12Mi77bBuFsh2TAfj3POY3zY2j5VH54xtvWcu?=
 =?us-ascii?Q?TtCWgXLqjLH6gf0Y+VKshjCZe8AwsYJ71V+kGOwGUn2+6Q18T64HJh2fiBAu?=
 =?us-ascii?Q?VDZbi0OjzBvszsiuqDarC9XH8D8UTBXmCbqOSYZK3Y8zW2M8DP9jWpsDku+1?=
 =?us-ascii?Q?ZetXt8BfN0A1vBWhMEcazljG+40id7IY8JNiFecCdFFuON/YqqPakKoZtq9K?=
 =?us-ascii?Q?rGqdLCxbdInypHBNuECGvPGeHYjmaGW+7q4qR8FJFhtSLD9/fd44PLDEhy7F?=
 =?us-ascii?Q?ESrrl+zxcepUF/t/yRlU4fBhqNW4odzaXtV0hJC36nhv7ErDD9yTqZLI9CzD?=
 =?us-ascii?Q?QjFULI8ZKTRcgRdkFBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351c9f69-60d1-46f5-7109-08db70effba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 18:07:02.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beR2lvABXcaQ5w8DrtNRYzQIv6qjAI5F+eMKCg3R71VQQZunGKzOyY8/Vw/cDAbpbqZ8aI1FAXwCu2rGcswZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 1:58 PM

> > AQ command on the PF is self-contained and extendible without baking th=
ings
> in very low level hw centric pci capabilities, which are hard to get rid =
of it.
>=20
> I worry about systems where there's value in having VF driver map memory
> without talking to PF driver.
Such driver will not be able to use AQ legacy commands anyway.
When such driver arrive, someone, somehow will build self contained device.
And hence, adding such pci capability in that future makes sense.

We don't need to do it now.

> Current VF capability is kind of ok I guess ...
>
Already proposed one?
=20
> If you want admin command to query then it would need to map in PF memory=
.
No need.
It is similar to rest of the configuration access commands.

> I understand two concerns with this:
> - you worry that this forces ordering requirements - it's true and I
>   don't know of a good fix. So if possible use VF BAR by preference?
> - you worry about wasting physical memory space
>   this we can fix by sticking VF# in the kick.
>=20
> As an alternative, if we can make the new command able to communicate off=
set
> in PCI BAR or in VF BAR or both then I think that's also an acceptable

A new command proposed was for VF BAR that member driver can ask to its gro=
up owner driver (like rest of the config commands).

A future command can tell for the PF BAR if needed and some device wants to=
 do such extra implementation.

> compromize:
> drivers that have trouble mapping VF BAR after querying PF can just map P=
F
> BAR. WDYT?

PF BAR for notification can be done later when there is some device who rea=
lly have the limitation and wants to do that.
We don't see that additional need as driver notifications are present on th=
e VF already as listed in the alternative.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

