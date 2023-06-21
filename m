Return-Path: <virtio-dev-return-13030-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2456DEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:52:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F33342C25
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:52:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65C689866DA
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:52:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A6089865D0; Wed, 21 Jun 2023 20:52:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46FF79865CF;
	Wed, 21 Jun 2023 20:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nka/JjVN9BsEKZh8s5/bun02Y70mipzaHV/AEmAmVO+OxvesnnZdX1X9svIzK5FWGUdXRAPenu9iW8gibDNnZOy0uw05Ska7VRxeQ3ntVM5qvPsruVHh4FUsaf35NFrkawjOqF+KPN3Q3f5OAu84zPdzcKugRBHLgBm1D/bmUIjNFIg+O+Ta+5+3u85KAy0z9QjdR6mEbu1r2TNpHerQbsV6EiQ5mW8mdZ4WnNQd4k5T/bZ2fB7zScRBLqXCfZ5lGttUn+s2EXsRU+YJ5kOa9wZwJgdAAPp3cH16x9TBmQSOqQQYfLAohuomjcaZAgNUFw16SOQ3Xm+Wcn8p3DxpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDImohfVKe9THwEdH239ALbAAN7WRVQjFB4j8KFngPk=;
 b=c3dPMEoTtY+dy+eOmMzCiQugQ55P/cxqW0pwpDZ8cMObggKZkRdf+SLAM0uT+t6XUpj51qGVMF2tpGe9UoHg47BTbQ/i9CMHyx2rH8PDJVE6V93QolxZvRDkGbZmu3D2j4Ry9PcVOHS5+16uj3sHMD6u94409koI1Grn8ZQBDfs6m6hgVGeTOswn5hZ680BAGkOMAhpQ1ZqzgEFJsgZlvrEVrapRO2IqGmzQND9WUtDkiR3R5Q2OpFoqsZPF3hZDxZiT+0KN5NVRsXOwrlomG2aP/BVzzu/DzqFCUW2Z8AwAc+c8kJlLavL14CfXnDBj+3tfBJKAXNr60WzJCr/EJg==
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
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cA=
Date: Wed, 21 Jun 2023 20:52:04 +0000
Message-ID:
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621163116-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6419:EE_
x-ms-office365-filtering-correlation-id: 3830715d-2bcd-4f27-cb25-08db72995e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sda/RHPtm6A/jEddXKJ+9jhbaBjeImV/gLWgmuWmMzrlM1UpqGVOJ2N0HMLGmvvzJNLnc+6N8GCIu4uTPxfGebbZ9VOWmzfN3IeNpDf9mTufDPguOPzDTbbrnBQLvI5+D5eh9Rsv6omiCJiGzNCLvQhX42ZiaoMW8Gxjmz7/FnZmiHos0VABmv5hfTHB2ZVXInY7l4AIehcJiDGZIUdo9MZE6Ikn2gN3rU0bu6saXApHdlKNS1VlQDNjvPLpW5q0OMRjejqFFdh1ggGf8t3GfuagR1yf6i3dl2hpUm/ansvrUMQB3JISPQr5mJVeKpuJtMhL6W1IyEpIxaztshOqK0yTwMgxUYI8/l7d7/cRlZKcMs5/kR7xWyLk+4Q0hpVlvT8vJOFd2ahu3s+osuD66g9Qwtq5eHPqFKGbHJMwqiVihrErRc9/BMKCgZcehbGVMpcLsDgIFzB8IJyviXQNtxYeEbqkWUlMuPczKkohL1Sh0iaV7ghq3f0kPihhjykXNYvaW/QWpWY+4LP3Mkfr59ps/Efwj2Opf0BA2AtdfSCSOh3gtWhCekJ22BFuUR/OWQWCuu5YlgiXqn0ykztrJ3T9ptp/x/oDJts/5ffjP+90QGjpSxiwTrWX5v/xBm3U
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(8936002)(8676002)(52536014)(41300700001)(316002)(54906003)(86362001)(2906002)(5660300002)(38070700005)(478600001)(6916009)(66556008)(66476007)(66946007)(66446008)(76116006)(4326008)(64756008)(71200400001)(7696005)(33656002)(38100700002)(122000001)(6506007)(186003)(9686003)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I+T8OsuvVL5JzejkvC7PNHEuIVOj45F4paah5L/Lp8KAHDvyOvFBcgEmq/fw?=
 =?us-ascii?Q?79m7140cdtFywGLG+nsA1P+21suWflQIFTlnm4AQfBxAlH2bZuFP8gAAyPZS?=
 =?us-ascii?Q?+5cBFXhrMKjtu2S0GKX54sr27vNbThZnHAMbSZ7uLjthFiZP/2ZowJ6GspX7?=
 =?us-ascii?Q?h8gqJT0XY5mYapHGV3QtpEWpNDTvCniRP0Qqwi5JhUk9YxIpm05u2/RYWktD?=
 =?us-ascii?Q?DjlA8Ecl2enF2COCATLkxQLuOz+qnIfT4CaZU/GqlWshjwADIfm2sQh+Lxzx?=
 =?us-ascii?Q?pmx6DFDBWSQvKsG0uZNSA6jQcIIY9QWSz1XyzQRD+2FUtwjo0924OnfJXbjg?=
 =?us-ascii?Q?VkYiDM/kje1OurcXa36bzgnWWmj9jIW+t7EH4lH145WJWNNuyevLrQvmnozU?=
 =?us-ascii?Q?aeqU+dBWqasqRQj8K4BnyZejlspJcPq3qJOQVkwzkHxSePL9GhBPXYbTg3yQ?=
 =?us-ascii?Q?AnfKIQWXgfswMC65kq0SODAzMjgx0t8AGEWet2YO4iISE4Qgz1wn506CyEUy?=
 =?us-ascii?Q?D1HJnHvu15i4T/nMPTX5Xg2SzuEqJUQjT62eUiWaAYB20JSQtKRPX/cirqqM?=
 =?us-ascii?Q?WdwCMOCtJKkASSw9++ciHoNsiybzqFNp0navfsP8lG24aOE9l1WGfmB2KU2n?=
 =?us-ascii?Q?UOsd8JNjfeLDWkquOA27Es0ARSmT/ZwkNGMkhP8ITVoq+oQZqUeaepdnCOkA?=
 =?us-ascii?Q?SM5YMSWRlPkNjoNB/p6QXUbYE51BSiW39LC65Ii3DO1tTSHHd78yWWNWBxm2?=
 =?us-ascii?Q?K7Jiw3Plk++hZZuKYq4DbMkf0hb2QyqzFGLYPL5I+cR8w7ufDxdPchfpK0/d?=
 =?us-ascii?Q?JgJniZEgNz2UjXjt4GGMEHMBgS4fvi7kIEMNhWzJDliyxuZfiJMXQb5cTUyu?=
 =?us-ascii?Q?2fSMQt4Wp0C2L51hLtynX0i1vgUMDDjfNHGobzGvGxtFTdTSB11JCspwfXyQ?=
 =?us-ascii?Q?GH2Uiz0bwxFcC48+Fn354vXOCUcfm1J878c1O6mWYJIqBbc2ELtXsIanRMr2?=
 =?us-ascii?Q?hFXlTfQsPjyUj+1a0b41+42aRRmYYw71VC//dfM8y/X8ReE6Nrc0tHE6pYPQ?=
 =?us-ascii?Q?pSobmWmmwLFkei1w1LUBpQfOzKlSCZzMMIDjfcOiayOmZUSpNSYFTm7NBgUW?=
 =?us-ascii?Q?7OwDQVV7sCLo92KahN2ASiMRvdnR7KwGhCJLqi63530lMkLQImTSTo3tpna3?=
 =?us-ascii?Q?k1p4Og2zcGwmb5WdCxc8eTTs5pa7NHKU9tIoN+50UUValIyCDL6zYSwURhcY?=
 =?us-ascii?Q?sCnwXdaPjHJjFEGpd2oAgJFV3EgMcn9PAipgFT2wiRtD496t6BKWtEwICU8+?=
 =?us-ascii?Q?PBzl4tfx25noEGi9/tAZqoBqv0PFx+So+ScV9iwUoUrjv8gnXodgWKrUj61c?=
 =?us-ascii?Q?S0V9nDbbg+ym1AopG3bQvWNfe9tBNir8zgcmdXF862SCDS88BlZvhXDly+Y+?=
 =?us-ascii?Q?ZTK4Px+p3WQzR+TMxfRnt4rnvI4ZpMBIZ5WvixCIXk2lcGdw+k6qyGudOuiW?=
 =?us-ascii?Q?s18DUdvZbXZnvpBPhE1P+pKrJ4H9E8LZJfFi+5KnfZTR4SdM8lvOVGZMEf+j?=
 =?us-ascii?Q?lzqxo5ABIiP+L218wOVEcVcZZ9yfNKXrgi2kXq5bKZX6wkTDRC47OWGzs/6w?=
 =?us-ascii?Q?Gk9trgMD9s1BC3MPfFOoQrQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3830715d-2bcd-4f27-cb25-08db72995e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:52:04.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CS9KMkiaJuQf+jfhwTgJxFs3UH+FRbLbWV2VCFKNk1siWgd9hOHhXLlK8OqHg4CbJlYXQ8p494wQhdaaY7ArEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 4:38 PM

> > > And the field is RO so no memory cost to exposing it in all VFs.
> > Two structures do not bring the asymmetry.
> > Accessing current and enabled fields via two different mechanism is bri=
nging
> the asymmetry.
>=20
> I guess it's a matter of taste, but it is clearly more consistent with ot=
her hash
> things, to which it's very similar.
>
This is consistent with new commands we define including notification coale=
scing whose GET is not coming config space.
=20
>=20
> Nah, config space is too convenient when we can live with its limitations=
. I don't
> thin kwe prefer not to keep growing it.
> For some things such as this one it's perfect.
>
Fields are different between different devices.

> For example, for migration driver might want to validate that two devices=
 have
> same capability. doing it without dma is nicer.
>=20
A migration driver for real world scenario, will almost have to use the dma=
 for amount of data it needs to exchange.

> Another example, future admin transport will have ability to provision de=
vices
> by supplying their config space.
> This will include this capability automatically, if instead we hide it in=
 a command
> we need to do extra custom work.
>=20
> > So we do not prefer to keep growing the config space anymore, hence
> > GET is the right approach to me.
>=20
> Heh I know you hate config space. Let it go, stop wasting time arguing ab=
out the
> same thing on every turn and instead help define admin transport to solve=
 it

This was discussed many times, a driver to have a direct (non-intercepted b=
y owner device) channel to device.
If you mean this non-intercepted channel as admin transport, fine.
If you mean this is intercepted and it is going over admin cmd, then it is =
of no use for all future interfaces.

We discussed this in thread with you and Jason.
I provided concrete example with size and device provisioning math too and =
other example of multi-physical address VQ.
So transporting register by register over some admin transport is sub-optim=
al.




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

