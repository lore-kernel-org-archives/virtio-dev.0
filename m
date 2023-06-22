Return-Path: <virtio-dev-return-13062-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971C4EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B246C85087
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33B299865E9
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:50:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF07F986813; Thu, 22 Jun 2023 18:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5C2C9865D4;
	Thu, 22 Jun 2023 18:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU11WvioMxMiMy0P1NGY1Bc2S7c6d3liCwcHbv38Rv9O4AeKRc8c5HKvVxLsZV3oBhCpHEe79REr0vqiQCxYW2Bk0LganMEz4FkSJXWmnQjxpvJ/QdKW0xTCQ2jtbX641eh6KSHsohNzqV79IyxE0uKe1bos8BikVzO7kYMPNRq74FISJ8p2cKqk8Djbrxx48wJ5c0vnRZQvfPrWeLaA3sRyaOMlByhVvwMWF6dp6c/m5hZG+K84X1tP1qg4kxaAi7qRnceir/VzwoHOoE+opnscPstcE8uMI7x1Qr4OafmPGJvprWHwzYL3Oq+69dvL/nsR2Qna6PSKLO8+koClxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQX3yfqI31XLBHeXnkccCUGKSibBLeCLzZufGJEcHoE=;
 b=FoSPpKGs0bJ/HEJPN/kK5wQT2hBimE5nzpKUABDYrs9iPz6yTutFxfkISymKqhSKwosAay4aFWOpWdpDVUF4mX457W2jRbX47Z+bLtI2H1b9z7mHUrS8e6cYBiwrhb8tF1HdW4WnrI8OKtzeZABjaYMN4R414cx49mZntw8iDJxGKMDkRg3avDY+WR81Fo/s7D3KP6KB8oZCxltlgwViQPK26tGYse4H44nTMkVQHsnqLbuRjgfkOikH2UF+fz75B4t2F6WcOjIh2cVCnemwHIm0+tOcH6LABQDeRBXu/B/X75zgU5P01lp3NVymRU+qt8ULcF/tg4Ulqji9DI5JyA==
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
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v18] virtio-net: support inner header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABRroCAAAA20IAABzoAgAACfmCAAAb+gIAAAMtggAAHJQCAAAHV4A==
Date: Thu, 22 Jun 2023 18:50:16 +0000
Message-ID:
 <PH0PR12MB54812621EAFA660735B3A8F0DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622140412-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622143626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622143626-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB8518:EE_
x-ms-office365-filtering-correlation-id: d16e20b7-bb67-4ad5-b33c-08db7351852f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 19JAybLAiklU2BXovdrnjpOeeCoe3llnTfkL/DD+YxcgYsvYgaODa8mD2tbpTocDI5VPzzKVvpgzZ8VREN9qkyV9rJBrlm2XNYMTBTc9jybnTYINhV25lVMwqV7ySFgJr0JDc0Mso7OOsPesAMAVSAHCBiTLfRzlLyld/PmsIQ+xvns6oJA/qq49DlFfV+s77QH+NGXyoFVtjTDmVGVoZJjmCZ9hcM5SZMH1Sc/DJKlZgs4jzDgA2GvziWMQ9CdhjkA1cyiFlG5FSiI4lUxQXWNyNcEL0JRPiHt/HYUgQfuXeCG99+ChkORjdyar6yvfrSJA/ro9tR5rGdnVJmk+KElZ1QXMTFDgvYZRzTzHYigQgJ5bFUIygztALgm+2BT676Nqt9FzFmQLevRJG6/G8ZVLpD18E5CRW0mzenSzM2Z+zo1bJUEbpP7Fbsjy92OM+T84EQTyYwzeNKZM41VmxK6Yk/qqGJ7FbpeTbU5aACqg2GID77PaJP53J6cGFG1ScOq0MdEOXb6CAHHs4fR3m+8WGl44rnpU+xKBP+n3xoNAtwSK7Z0hEyFtWpkSQAQnMNKHWL4+LsaYrld1Nv66dnnEGYJcMQHBd6HfZEk2yzFEeBldBPIDVcuvFkOKB1Wp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(7696005)(54906003)(76116006)(4326008)(38070700005)(26005)(478600001)(71200400001)(186003)(9686003)(6506007)(55016003)(53546011)(86362001)(122000001)(5660300002)(66946007)(8936002)(33656002)(38100700002)(2906002)(316002)(8676002)(41300700001)(66446008)(64756008)(66556008)(66476007)(6916009)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mO5jOUGLmfkUn9JWqJX2LAUGMystau0EVkR68zg/Vd1h8C4xJqmA+Bp4e56+?=
 =?us-ascii?Q?eeEj7KNU5u3WgDg1NBymO6eSXXYV7yxuuXD1N/mw88QjeWtpd47Kw2I4TkmL?=
 =?us-ascii?Q?9emarRsBQiYPR9tgZFdPYp/H16gWpYaAk3lR4lSiG0jrjBdgMHKcDM78e2oZ?=
 =?us-ascii?Q?lFG553XgftxvNeQeJmeffKwqU2rsCphxg3OJVGpXALYPuvqzUdFx6zbsRn9m?=
 =?us-ascii?Q?96iWF4yBKfzNuVHrW85BoHR4Jw4rZ7gh1xOAQYkeIFIFDvPfYKy/ZoeD5wgX?=
 =?us-ascii?Q?OWO2HfpUHy5PFFHKQMJ7pXrwDAa1eDiXAsrbtXhsmd/jOI6gkiHykOwjwNSU?=
 =?us-ascii?Q?ZBxqRBP8eNVu4VGVSRCzrq78VnuoIozwmoNiqQdmiDYUIq3pWG6Jxtq4lQC3?=
 =?us-ascii?Q?KpWJsQO/TsCUCRdm1QIkIoGOc5RbYizBf6qHNg+rgvJO2jFu5yhxfsajASv+?=
 =?us-ascii?Q?09xibWHA64BFdP07f/OT2C99kmrLAU0wjq7N5OJI/vVMRhZ5eWZI5SeyW6nR?=
 =?us-ascii?Q?LSZF9UORdjQ1iAnb6af3i2Gn60mf1DUP6oSDgpvDaFfkiVoJohtKbQlbNtTg?=
 =?us-ascii?Q?7a8JGcUoK401gUdQlKXS2l2qGEglmpu04PXxn2ZlIEru+1j38zTz7+9e6cLT?=
 =?us-ascii?Q?BKNkBSBLcGLV5514PNSLh4FsuyZjpdd8XZvWeZvD6/Cxv+bF66Cjt11qz56K?=
 =?us-ascii?Q?3W2ExzPakidimLaO14l6gSANxbbxUo6n4tBKQCWwIKSeuMIyCtMCBBAQIWx4?=
 =?us-ascii?Q?XiPvS846hNoE02U5SfqzhEZmPIOd8Cnj5voG0TnFSPJNKAO40c2VX20oLBrx?=
 =?us-ascii?Q?L3ozeys2K1QYib1ZWl2Qy7fvdUfTOyqws961+wtZzye/jOUfb/+dEZbHwlWI?=
 =?us-ascii?Q?bHwXmPIgGi0o4DEVjnhBbSiZh7cHpewiS7tFxwdjebCZCNCuBkedhJiSoMza?=
 =?us-ascii?Q?GP6Q7ner4o+OHPJHldcyJH0xM4D/+k45Hg5bRdDG9Gpnw+dd30mEFwYTeURx?=
 =?us-ascii?Q?gEsV5KXq57aZ0HTry5WCsw87ca7dcDF3a2Ob62Edy02o3MA6AWUhSa6AhypA?=
 =?us-ascii?Q?tpppeeT1FUwZMpmIE9Roq5umv/2+BGDAc02pRHAk+eDJMnAkqYyNvrdEld1s?=
 =?us-ascii?Q?tBmeMTkvBE0UEzPy+I8ODFXjzm4hAbIolrL6hzIpKRQfEqz9RNPdXrBATaOj?=
 =?us-ascii?Q?bwMq2zLGE75rpRGJNAD7srsZxj5k/L93T3RUhiFdEj65Qo5JFb8CfuITmenB?=
 =?us-ascii?Q?qjY6NxV1B9z1NqADc8QWLXTmcA922NHjBoV0PdNaulsxclCIx/zA1Dxu9YT3?=
 =?us-ascii?Q?zgHR26/Wp5s2620+yeM0usdw6bGtCqpBwmMI2umijhWxt17dYoZPk7NJfcEL?=
 =?us-ascii?Q?/pWQHdsIuSLzR9Oy178MJIfMTPC2R+XLjoNVv8yotRBFqpU2xFXc5BOj9Mlb?=
 =?us-ascii?Q?Ie3pFKYv4H+dYLm2driJLUINvKff8p1xMytg7spKmJekZH9sBCtpuKW6T51r?=
 =?us-ascii?Q?OSKvSIz8lkl9tnNEsIUi+bDoQvYOQ0E4ehRX7irZchIfYL89V71ixuG5LUcf?=
 =?us-ascii?Q?TKjZPvWhNosSEz8PiL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e20b7-bb67-4ad5-b33c-08db7351852f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:50:16.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEj6fO6LvKsY28NuLreslRtwrKh/dkItfOo4RlY+wBvonMAroHy99IOWcuABFlmq7yNx+8+Yo7LISSUDM28aHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v18] virtio-net: support inner header hash



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 22, 2023 2:40 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Heng Qi <hengqi@linux.alibaba.com>; virtio-comment@lists.oasis-open.o=
rg;
> virtio-dev@lists.oasis-open.org; Jason Wang <jasowang@redhat.com>; Yuri
> Benditovich <yuri.benditovich@daynix.com>; Xuan Zhuo
> <xuanzhuo@linux.alibaba.com>; Cornelia Huck <cohuck@redhat.com>
> Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATC=
H v18]
> virtio-net: support inner header hash
>=20
> On Thu, Jun 22, 2023 at 06:17:54PM +0000, Parav Pandit wrote:
> >
> >
> > > From: virtio-dev@lists.oasis-open.org
> > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > Sent: Thursday, June 22, 2023 2:12 PM
> >
> > [..]
> >
> > > > > > The proposal for 1.4 is literally very simple as below.
> > > > > > 1. All existing fields of cfg space stays in cfg space 2. Any
> > > > > > new capabilities to be queried, query using a vq (aq, cfgvq,
> whatevervq).
> > > > > > 3. Optionally existing fields can be queries over vq of #2
> > > > > > Once this arrive, no need for new GET commands.
> > > > > > Till that time, don't keep infinitely grow the cfg space.
> > > > > > Any next addition to cfg space, should work on defining the cfg=
vq.
> > > > >
> > > > > Simple, but short sighted. I know you guys don't support your
> > > > > hardware for 10-
> > > > > 20 years but for software people do.
> > > > > And so "All existing fields of cfg space stays in cfg space" is
> > > > > a bad idea simply because this does not allow removing things
> > > > > from config space not in 10 not in
> > > > > 20 years not ever.
> > > > >
> > > > #1 is for backward compat for existing drivers.
> > > >  You missed about #3. Existing cfg space fields can be queries
> > > > using the cfgvq
> > > too.
> > >
> > > Then #1 does not matter. We can give devices choice.
> > >
> > > > >
> > > > > Instead we need to allow two ways to access config space.  Teach
> > > > > drivers about both, actually mandate supporting both.  And then
> > > > > devices will make their own cost/benefit decision about which
> > > > > features they
> > > want to support in MMIO.
> > > >
> > > > If both method is mandated, I don't see benefit at all of two metho=
ds.
> > >
> > > Mandated for driver.
> > > Benefit is for devices, they will have the choice which drivers to
> > > support. In 10-
> > > 20 years all drivers support cfg command and then people can start
> > > shipping devices without MMIO access to any registers.
> > >
> > Until that point devices are forced to burn memory, which is not needed=
 at all
> in < 3 years.
>=20
> No they are not. They can make their own decision which fields to support=
 in
> MMIO space.
Existing fields used by existing drivers must be in MMIO.
Device does not have a choice.

> If they want to cut at 1.3 time, they can, but they also can cut it at 1.=
2 time, this
> means some features will not be accessible through MMIO only through the
> new commands.
>
New commands services new fields by newer driver.
Newer driver can call new command to get new and old fields both.

So 1.3 and 1.4 devices cannot optimize for older drivers.

=20
> > Once cfgvq is present for new fields, from the day 1, device does not n=
eed to
> store any newly defined fields on MMIO.
>=20
> Exactly.
>=20
> > And 10 to 20 years, it can stop for existing fields..
> >
> > The clear benefit is fields defined in 1.4 no longer needs to be stored=
 starting
> from 2023-24.
>=20
> And why is it a problem that someone can also build a 1.4 device with MMI=
O?
>
Why to build device using large MMIO when those fields are accessible via v=
q.
VQ construct exists so it is already simple.

If the spec is defined in a way, that new fields must be accessible via vq,=
 and optionally via MMIO, than it is ok.
One can choose to build via MMIO.
So MMIO for new fields must not be mandatory.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

