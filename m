Return-Path: <virtio-dev-return-13058-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC94EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:12:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 229A688E07
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:12:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D0D99865EB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:12:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 114449865D1; Thu, 22 Jun 2023 18:12:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1A879865D4;
	Thu, 22 Jun 2023 18:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T20cz/1gtmhA9Em9sFiEoYA9MOXN91OyOU8vaLvso3pItERXIuEQvtwWwmEQ26Onc1oCXQjfwRSNsx3Hlvx9CcEBQ7S533lQpweXs5WxZfu5+dwLJOYON4vnF6SekttGtu8Rmeop03oaekAFitvQhNE3TWYywFPpDlthMueFlPVOkjdiF/DTL2Rw3ciGwrgTp2k8w9Uo6mOnFO9/MollZH2iJj6PDqF30hOrr0iogGy7L5pfi8fO9URaD5+o6vomak17WxRrDMUJht+OJJjVQC/vKxzy9bBW1214ekX74kdSmPW+CSGt8eqNUF1eA8obt3Zw0nhck0PW7rg2nf/fZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iHxWBSGLF3XFkwkywu0FRJdZXYEETF9Q1IXQWHTfEk=;
 b=gjD2rfFxE2FDdqdaOIz5YssKKc1ruJgiv9TBsVnUI5cFgxjlnmcag8JVjPtu9Y+rReeU2sfWpAw/YA5Nj907cI+QnhmqWqWcqpytmXGuSAyKLc2N3gA7djvzFdnE86Dps+mzciCkmsgGDk8hE8ofR4xaodnScRUugShyspabO5AD6cBAmaBdTLizQ47oeNaUl9dW0R9qdXJudz0vFSVbtITFhMCdnU9Y+tThfsoQqTIT1zm/q6ihV9ZThI0WSRsNm7S2A2nNhBJAsR/20vFfMZNjFXYvEebKQPWXTVG2/CR14EVn/7MW7QCofT3fp7dBt945zOTpNnUXIZm2ZkFT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABFu4CAAAII0IAABUeAgAAAscCAAAT1AIAAAI/wgAAHmgCAAARLAA==
Date: Thu, 22 Jun 2023 18:12:09 +0000
Message-ID:
 <PH0PR12MB5481EDA41A3BA3FDF9A75E38DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131120-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A92301E4D27AFA43CB0DDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622133802-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622133802-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7872:EE_
x-ms-office365-filtering-correlation-id: 398799ed-fa01-4e95-13a8-08db734c31e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WB6sqYQY4qMG+dbnavwVeW/WZ7uX3WNa+FG48WU8lqVTy1b/xwF6x3PlCyGIERNjhsfGcDJ5EiHJSDvn9cso9QTE8GOmdftTCENe9cVnvtKZrSAABFzJ5GpBDwFvScoWCSG8QBSV1Q+uN8QPlc/A0rWa3RUjnvVN0T2BUjt1SbG73N0pSDM35Z5+xunbtr0S3voYwHPnwZBe9lDp1ZI4iowx1M/1yiklYLr1gpAoqaX7lpQ7jX5Z28er/NSpJLRiB02fl18bsEZI+YQsXZQMQvS9RZY986E+Y1Gg7DKbgtCuhZj+EngS8wHe/tGLRhU8okX4MhixI0+nnEEffr0ogJwriyKfNuHHhLhjNcIlTUUziEYRagLE87HRvSceGbMCyzOfHi5ahRR4B9gtHhn91fl0VERKNdkxoEyixMcHePTVyLiWnEx/RJXNUbq4XgR1RwqoCQBYdIDyJTTLeHgrZ5zExK7qSA5Xkbu4qD8H5PBSm9zmlDj2C5qQlyHH1DYPQWBs7u8931XW3a1o6eweymLryqIEEBgVxbBwPfi5/DB1Ksf1/2bZysmE2tVmI6Hl9v7ztyXk1LV1HRvfbm12zstg4IMDgjIsu17SijD5X4BwRvKaAecyO62js9gTHWtB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(8936002)(7696005)(8676002)(83380400001)(52536014)(122000001)(38100700002)(54906003)(33656002)(5660300002)(9686003)(478600001)(26005)(66946007)(4326008)(76116006)(6916009)(71200400001)(66476007)(64756008)(66446008)(66556008)(41300700001)(316002)(186003)(6506007)(2906002)(86362001)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5rlhpsGFsXMaNc/iGLWM6qCU1SEQdFpjMGKwqfQSiiDkG6VJkp2inVQeb+p4?=
 =?us-ascii?Q?Jz1HiZ9nuj9NXwZoL3/3cJHOmFfJopq0oGMre31ZsBtai4rP7kzX1e623ob0?=
 =?us-ascii?Q?PeuScncCG6CFZEkJ3DDvY4VPnIdB19H2qoy2xJqok8UDeI67YYX1IKFUuWIR?=
 =?us-ascii?Q?2gp7vkVIfFi97ebEx7b8kUWpD6qQnxZOuJel88w+Oqwhc5HmgAmB1RZvLGS/?=
 =?us-ascii?Q?IBamUR6q7V3DzA6fqFqrX9p1I9jlgMybF1hoAncfxGzl88lwaJG4T4V1nDL+?=
 =?us-ascii?Q?sSRgQL4lI+B184vQCYxByEmgAFa2d0LeyINAw2hS+U+iV/TmzFG+RC+MjOQ4?=
 =?us-ascii?Q?Uv7DMo+oHJIT+nSE7HsNkB8loMj+uxQE2MzFC40Z1iHFAmGjjaJB9fOSQYJi?=
 =?us-ascii?Q?esbkplhAEijy9hvmYBYHviqC93hYhtshd/wjPHpGGLKXFPH8lx7NFJc/rLkZ?=
 =?us-ascii?Q?n+DZ2F99zNIcTye0xoDQXmSaG5K0Qn6jr1NH+YU8+ESwqCG4++vA0k2VquKR?=
 =?us-ascii?Q?cGj6VZ78rIjP1J09eF6PVUg8HvP7jd8M/4qiAq7XfgYU3dV+gBOi5E61tIRl?=
 =?us-ascii?Q?Z1O5kXqrh7KdiyZ620tX20dfZsqgldXJZAe7xpGof60VZ8cj4iLyiCvFvHYQ?=
 =?us-ascii?Q?LZrkoGWGAIXWmKI/Hf5j/00IEHAq2qeT+4ed5fyHMuwb38uJSq1DXRED6gqs?=
 =?us-ascii?Q?sv6272Rpqs+lU4jIccaV3L/z7xBq3EhHXG8bUxjTWTQrEQ+jKEx5vMiVs83i?=
 =?us-ascii?Q?BbfgZFLln4HDP4griyp/9epeCQ97MvDEvOG2Ib2PRU9AoDAL5WjGgXlIBzgK?=
 =?us-ascii?Q?eeKNp1rtbSv3dUOpOn+wmMXnZ0JE+QLFYMSm6d7zkxS6n6VUnk22Jli1aIJt?=
 =?us-ascii?Q?AdZ1cONYdiUCgOIMbP0S8HDJ2JAAx+FV62va7ka0wdQO8dKLtl1MtYQWfBOA?=
 =?us-ascii?Q?uC1gD8So4XZ5f0Zjfl9ywnke0W9/GKzB3IdulAtQDnAlS3SXIdfTFZjxS8Fg?=
 =?us-ascii?Q?jooJJXQ9tpWgI506ZD1pCYwwDc7WUKUaIJWCF7RP+EV/3mBrwgoy7NvaDGZa?=
 =?us-ascii?Q?YZghIMrzMy5I/hih2BVJuj65TZCyfuvXc39FJt6QqBk4I4X8Bha3HKUj7WaD?=
 =?us-ascii?Q?P6GnKn6TWGdzVpf8TrvJ568wipm9vWMjNTjXniLrMP3i2cqQMe5UZwV8MW76?=
 =?us-ascii?Q?Z5Razg8uiKTNDKC1ppLy9LSFnLtXAMCGAwe+fUQy7npROefuJiK2vAU0TuuM?=
 =?us-ascii?Q?t4Vf6WRIMntI018rFsD8kZYy/uV8XL6Bgkk74ZNZkMybJre50iY+rdms7j9V?=
 =?us-ascii?Q?bq59ucIGFF+xq4+0sIHmPY3FUsQvxgNtFAdPcHXmsBmg7tMpxe/ROsGl8cqs?=
 =?us-ascii?Q?/4OTwZAmBDciEffEtUNZ4ZyVU9RQxTU011EtGoLpSTY4RRsA34rhgUeE1zkK?=
 =?us-ascii?Q?oPwfYEn/caQI3IwmvNroQuHYxKTm2x/B3d4v9TDyB1/LFD4Vn+HaStygyun1?=
 =?us-ascii?Q?24oHKDyFnW+EtkDVWSe56HqMilMAQFv8a6yPe8H/dwNSkjVwrddGIaY8rZcV?=
 =?us-ascii?Q?86/FZo49wq6Ghrxou6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398799ed-fa01-4e95-13a8-08db734c31e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:12:09.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pxB/7yhLaHRNv6jS+iiMXfUd/9EKAK/DQAKO/WF/6AlTg5VLwH4YmAJenOuP3urlr+2nPJ+c8cMHCaHfEVVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 1:44 PM
>=20
> On Thu, Jun 22, 2023 at 05:20:23PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 22, 2023 1:15 PM
> > >
> > > On Thu, Jun 22, 2023 at 05:04:04PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: virtio-dev@lists.oasis-open.org
> > > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S.
> > > > > Tsirkin
> > > > > Sent: Thursday, June 22, 2023 12:54 PM
> > > >
> > > > > > Admin command as I recall are not accessible directly by the
> > > > > > member driver to
> > > > > the member device.
> > > > > > So a cmdq or cfgq is needed.
> > > > >
> > > > > Possible, sure. Or we actually discussed a self group. I took it
> > > > > away until it had a user.
> > > > >
> > > > The problematic part of AQ is that its index is placed in the yet
> > > > another onchip
> > > die register that does not scale as each member device has different
> > > queue count.
> > > > When admin queue was discussed, it was only for group owner, (you
> > > answered to Jiri).
> > > > Hence the scale is relatively less, so it was acceptable.
> > > >
> > > > Now having unique numbers for VFs is not good.
> > > > Max proposal was the last index after existing defined VQs of
> > > > num_queues,
> > > that saves the storage space on device.
> > >
> > > Surely, you can just have a very large index and be done with it?
> > >
> > There is count of AQ too.
>=20
> Make that same across VFs?
>
Queues are not infinite, so when one doesn't need it, better to not make sa=
me number.
=20
> > For receive flow filters one may want to have multiple flowfilter_vqs a=
s the
> perf req is high for some vms.
> >
> > And device to build non linear PCI steering on the driver notification =
for this
> very high q count.
> > It is optimal to have finite and linear q max value.
>=20
> What does this have to do with AQ? These are data vqs.
>=20

I think further. Ignore this comment.
We need few bare minimum fields to bootstrap the device.
So num_aq is one of them to absorb.
This is ok.

> So 1.4 will maybe have new migration capabilities, and that is great.
> But I do not like it that we are adding in 1.3 features that can't be sup=
ported
> with current migration capabilities.
For 1.3 vdpa style solution are anyway trapping the CVQ so no problem for i=
t either.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

