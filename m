Return-Path: <virtio-dev-return-13211-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4627EC001B0
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 20:04:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F3D641EF1
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 20:04:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28B93986597
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 20:04:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04A7B986559; Mon,  3 Jul 2023 20:04:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8898D98655E;
	Mon,  3 Jul 2023 20:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuzrv5eH8vSt1M0NbR7IPKsZU0nXA/dETUoKKW0jPdhBTiFH9CZrEr2uJdWgFgniF+fxiZXidWjwK96MKfcOEaKGf/hz1xHLyAKuDN9IRQ1nYNtui05A0+U74NjWZ5dByFEH3CRSC+SUI7y/M23z0khusza/Bpeg2gaYVUjvjt5fiAqxKeeXhctTGQONV6S/t3ysgwxCmwvLpKk1FnOHIOL2pifYlCv4YKpC/dvLQeFN4H8AilDcYDt6eJxolPPZjVt04tXjkJvabniyXPQxcTnPQQ9ACkYfZMf4eE7cg/6re3AxqUGP6uU2k9qfYoIDNn4pmjnInfa0JyM3teIdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZQNjmScCcvAnS9/hl5i7q+8jeJJWfHo3TwafYMkzOU=;
 b=RqbY2J4AfoMbELnDv0EDln/Ivs5irUgGGPkFdQO+YM870BKr7vm9B2kzpnVj4BgHzewxwgYaiaJ9pXzJ7wSrAOXLk5rvD7iZfZljfmpXfBHNMCsS2Xws/+26p2i2tC6yuoiTP9Jnta7WJBKeIDnJa8vv5Rge8Qoz4q23EEMqHM7ohKPXAD+fMbYATCg7hrpbltmSANOxQs01Yi/628/ZGHeQgpK/ZloUPHoY2xonbjpnT06CTx4y9IV2CphWSx0ydpzksuuQNHD9xMvSdNHNY2/sdRCZNze7wwGIJTQeWBvWHaQBrZ+/WO1bfe/r8zdpJ85J2e3ey9KUsNKjVI9J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind
 the group member to the device
Thread-Index:
 AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+eUUOAgACAaoCAAKzGAIAA34IAgAcNCoCAARM7MA==
Date: Mon, 3 Jul 2023 20:03:42 +0000
Message-ID:
 <PH0PR12MB5481BB42593C9BAF209AA8DCDC29A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <20230627115247-mutt-send-email-mst@kernel.org>
 <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
 <20230628112107-mutt-send-email-mst@kernel.org>
 <1688354491.871065-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1688354491.871065-6-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV8PR12MB9081:EE_
x-ms-office365-filtering-correlation-id: a0509f5f-b95c-4256-5d11-08db7c0099a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f1u3H/RKudZ4dyDAPmceufZBo/7Y3dfLC9gbxSFxJ6zZM2sqYBRXNkkg0WPpKi/xI40UQKVuqYdxM7McIsJ8Gk16cDmxzLKsZ3KzKkn8JSnWj+gUNMWZN5zaySiSHAS0PuLNC2CjlL5ucrGYGm5IR5F7Pee2RFvkIE4qXJMa2i73Qo4w+amg7CCP9jJ6Za6E6WlLSh8FaWpUTk9rpc90NkBn5871zvt2QlZFtSoQ0i5ZGxC3IjXjFKUEMlDppr/dXpxzYTpKRUh864XLx6E07XXU5Qk4xxHQjs+p3KR0j1/AhyXrnUJ1v8qNd/xSR0yJWPUVMcS1vtFSw6J/al7InGA/IdhuWUvGO6HiwH+JEZgC5fHnW5Jh05AWSZ8La8gKgFSlUBEynkb61IktZIc2N2jgBWA61kVlGue7uHYcj3xz/GhelbZzUA3Hs6Zo1iDbFVARR9tg/HzTJbvvUaAMxmjVI3yz8qQjjTublKCk4KgpaR8QzjjD1lcYMp3bTiH3gPu3wP+THO/EANRmZkj6/DIbZ204Z26xBKGEqF4duKSgOSCYhdKmnH83npj39xSUQ2vv91VJSz+CqgJXhaIq7fIrnf9qdwmeMeoCb8HvsRv1yC8iNpQ4cVG4JiFW3QRu/0nuuXEi7jc7LvufD1PXFar2bfGFhJtsWzUHqYGPMCKzwvrcUwXNRWTEio+Mn03l
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(8936002)(110136005)(8676002)(54906003)(478600001)(26005)(9686003)(41300700001)(33656002)(52536014)(2906002)(71200400001)(5660300002)(966005)(86362001)(7696005)(66446008)(316002)(64756008)(66556008)(66476007)(76116006)(55016003)(66946007)(38100700002)(4326008)(122000001)(38070700005)(6506007)(186003)(83380400001)(358444002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3trRnXEWV30sWfGZhRprAq8+RayBAmdmHdfj1MWXwF0s/yQKAo2Ts8vywRZU?=
 =?us-ascii?Q?eNa3y1Za5/sL/MLVLfkwpxxjtTKSzUd8UrjDfOx2BWzXoQaCMTgxJI0z5y6F?=
 =?us-ascii?Q?VEkKjtgSbVs80907HStWC2Obr6hRpZEflOWq8lbdj1beGsr+hYFnQnz9rdyt?=
 =?us-ascii?Q?xicb0JwjfU/ZvBDUgQibe3trnAoIjMEWsYiEBNu1YIpkItPVqNtzs6zNxDOK?=
 =?us-ascii?Q?i4fktHcsk/1B/CQHfMDJB/RCsE+UgRsaFoIIHluFIEr+3k06XeqyiplXNUSC?=
 =?us-ascii?Q?9kwJTRozDiSVOdI8V67S6hBSjG7w1IlSJhAWBfkxrhbKms5yJpVHKZJVN8zU?=
 =?us-ascii?Q?oNsc5BdhkyCt9vZqWmpZ4zlmJL119dg8zapBmhrkdnPhyKalMfrXm2o/S063?=
 =?us-ascii?Q?zTLP1vkPMm6GcCm+XWGj9S7vTxfIwvPbDtkc6tLGjd2CvFARGgl0BXZqF1Vy?=
 =?us-ascii?Q?9cWAmXLNxExFt8+rN+nUJXp9WQ1+fp3pNFPD6dtmfUtIdE+SLJZ9KacsEZFZ?=
 =?us-ascii?Q?IMRzmTUl7UILxdWUpslyco3cN4Y122WGvx2aEaUrmTv0nyHYoHDKZD7+SmwS?=
 =?us-ascii?Q?caPsq9iZaWfI31PjsZ0LcAHbUFuLT869hmlpeqbofSadsjsr1w5NdUpjP832?=
 =?us-ascii?Q?lCJ110ITYirz+AOekIR+Dw1vUmtYLmBn2xTz5ec2pL0nfLi3fHRpNn8kGty4?=
 =?us-ascii?Q?aQphOOEsQ5XvxalEZ1C+h2R+2rYPzeQJzExl38MItIbtXk04mgc+RmA7g0G3?=
 =?us-ascii?Q?7MB9dGXTn3DXijjNZzeCwzpQa4Qt6m54m6vuuGsQh9A75z/mRkmhKiyQ/r76?=
 =?us-ascii?Q?bDXHqq9vei4owvG7YHxTXvX7A39nNPEYWgGLOZuFurssfJKjerApaO/jQFtb?=
 =?us-ascii?Q?bdBUvjI+Q0G1CHMHEkCrl6N0BuGT3A8pQw3xuut0hSAXyTrW8J8yC7h0yfct?=
 =?us-ascii?Q?kDWN5+UDeLNb8gzJTISg5UI0pO6NIZThtm4rhoyy55IIEv8FwBVt6nXbhGO+?=
 =?us-ascii?Q?kWdcanhXQUw3sbTXJZ78uFA3x7FE8+J3o1wF5OXpnVRb0x0MfSvW3WqkgAtk?=
 =?us-ascii?Q?Vcp0+KOMoZUdgkALML4w0s0PYqZ3eejjT6m9Ir4cCNkE1Gi8pF6MHvp2sptC?=
 =?us-ascii?Q?eYr+DuKIxfhWDdNq4PZW2CDSFERg67cOWMUt7zh1I/vOxJ0IFQxzeYneg0qo?=
 =?us-ascii?Q?w59toWV4Rch8tx05tLxEwqVJT2OnSk/EgVo+d4sIMIccBPSKM37jpr6rIfK1?=
 =?us-ascii?Q?axB4lkyL4/3tBvlD4350G67aeuwd6/johTqK9WKfiLfVG2QiXcQqHOglZ1KP?=
 =?us-ascii?Q?v2UqFl0aEvqYMzyXx19U3i/6lNMtMb02+gpxx6Bf7gysl0KNUDwsYS0HrCSe?=
 =?us-ascii?Q?zeqZt7/3n5ORf0io0te6tyL/bPbRvlMQj3SJQiKUITxKa4gZJQRfwZgL4AYg?=
 =?us-ascii?Q?FDMKhP/gRX5+B8Sb/0qv+mYXbiuzdjzrEM5XEWENEzgizSoZKK6saFGqR34d?=
 =?us-ascii?Q?ZMb8+uYgdHfdv3MQc4WjJdICfX5RGfbt5S0nP+4t8LGSUqWfviQm8nxpiyHP?=
 =?us-ascii?Q?DjhKyi7In1Qe73SfA8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0509f5f-b95c-4256-5d11-08db7c0099a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 20:03:42.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FwWmVBfrQNR5SK9tJAKgTAezebZtDRi92l8l64krGFXh7MhB2v2CO0FBsC+oOugXN6Gw+ecsq+3P2OfmuTw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
Subject: RE: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind
 the group member to the device

Hi Xuan,

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Sunday, July 2, 2023 11:22 PM


> I try to describe the requirement as a common requirement.
>=20
> @Parav do you think this is a requirement in your devices?
>=20
> The core point here is that our virtio-net device is created by customers=
 on the
> management platform. It is not a pure virtio-net device, but also include=
s many
> other features, such as bandwidth, such as VPC information, etc.
When these devices are on PCI transport, and if they are PF.
PCI VPD has well defined serial number, and few more fields.
This helps to cross identify the device between compute side where virtio d=
evice is used and other management side, who inserted this virtio PCI devic=
e in the compute.


>  These are not
> within the scope of virtio, we cannot configure these information based o=
n the
> admin queue after creating the vf. But we can bind the device created by =
the
> user to vf, which completes the binding of many manufacturer features to =
vf.
>=20
> In addition to this scenario, in the case of live migration, we can migra=
te a vm
> from one host to another host. During this process, the virtio-net devce =
is also
> migrated from the dpu of one host to the dpu of another host . At this ti=
me, the
> purpose of creating a vf is to insert the migrated virtio-net into the ho=
st. It is
> impossible for us to create a vf to get a brand new device. So also bind.
>
For the VF in this flow looks like below.

a. device id assignment is initiated by the compute side AQ to a VF (on des=
tination)
b. management system received the command and queried some central place to=
 get attributed (qos etc), that you described.

Here somehow the src side already had access to the management system in fi=
rst place for the VF backend configuration.
And I believe same access is/should be possible on the destination side too=
.
So that same parameter can be configured as out of band command.

In fact for virtio device migration, a migrating sw may even need to inspec=
t and figure out which is the best system to migrate to in the backend.

So out of band access is present and needed that can rely on the VF number =
to provision these things without explicit bind command.

So bind command is optional command that can help to do the work that is al=
ready done today out of band.

And if bind on specific system is identified, it is probably better to do t=
his out of band.

Your key point is " virtio-net device is created by customers on the manage=
ment platform".
If they are based on the VF, it can be identified uniquely by the VF number=
 without explicit bind command.

For PF and VF I responded few other ideas before at [1], you probably misse=
d it.

[1] https://lore.kernel.org/virtio-comment/20230628112107-mutt-send-email-m=
st@kernel.org/T/#m99518f22871a223c4dd014bb77e712b3befd9793

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

