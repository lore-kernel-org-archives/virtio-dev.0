Return-Path: <virtio-dev-return-13442-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DC3C00528
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:13:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 533FDC6108
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:13:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AB819866DA
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:13:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 26B859866AE; Thu,  3 Aug 2023 11:13:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1422F9866B1;
	Thu,  3 Aug 2023 11:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU91Usj5YA5BhsedptIg+Js3kr1DRZM2ux2rjJ/Q46yUjfAhzzNm5bOdtQYg+XcOLNEeIwLNFIG/Ka2QXXAKUg04j0DnY5vzoZCsG7WiC0DYTVfQwGpDIiJs0EMFC7ZVqEftT3cEpWSl9XZlJ0DV5d14Bv5HWqWGmegDznypVyruhs0jfVwOVQIGUwax6asNUlL64nPS3k8I5QApjOqcbkQ9jousNzFjIhtJWINi7d1uLo4qnMTuemzT6F2NO8qOafxqagFgTB6/fWVl0xGEqTADEbEmdyU2LCFOlMZMH9S6SjQc3cKYV2U7AOTE1Onl2+7Cn34D5PEzo5ulpqwkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAYSxk/fie2xrAS7H3kFHv2jYj2EnNO5WfgDT2drNjw=;
 b=GpS66/uEiazqdQ7j0yO89FZ+djX4foL6UUyjdyHOBT48D2Pn/fqCOaThqhtczg53v0iGGm2Plxmem3X2Qa+L6GTd571u5b/Ch4m5GcELGeb9X3lWUGz3Sn6iieKncoOdo2yhP8rfkszSmjIJ8iRMwAw59udNSQrqf9rCiKpmq1vM8nG2UC8TI6yCUyhORqThQJ8qfQzYtK7QVfPmF8U6VJZh+FSMILd3IW3NLSdEo1GixAXl//x8e85YHt74U/JYqvLUW/+vu0Nrm8Wc7tfU86hqpnrlgiJ1s7BeeZ4Vg+Ll8Xsb0o2c+HpxrtrXuU36h0SXAuexHQFTYwaI2NBMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: [RFC] virtio-net: support access and control the member
 devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YW5SQgAANlICAAAC1wA==
Date: Thu, 3 Aug 2023 11:13:28 +0000
Message-ID:
 <PH0PR12MB54814C7410C51E08348B14A4DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060755.2124963-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691060755.2124963-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8147:EE_
x-ms-office365-filtering-correlation-id: 631be4bd-a81f-4dad-f07e-08db9412aa0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ro9iCnM6ggY9ZgPbar5xhtoIeCSQPv//SF86X4hw/8ENUWTZpCXyjF4sl0rLNdf5VMnDXPh3VAcA0sWXvoIo+KofMDqUZ17M/9jDyfd0Qc6pbTI7MNPZG11QskeghvhREJwZHuAbEDZBI5DnuEPF9EAjiZl4YCje1AY/5hL0qsR8PcvkKZ2HrthXWNGH/8iPgVTdJIEOLWc58A0jcQjuPPL6i7cnyak0Fc7UI+coRuwvxSCn3bR27Ds2f3a8+Flldtf1cywfjZkisjecI7Fe8vSwH+3rhJtWrlAR06PlQ6MN8jfnKrY/m6wEo6m2NXQ66RP1qezk6BJljTJgSfDDjujWDWPw5dA21fyhZVIQU6FMhS5xRDalsHMo6SFYb6iWhmMTodQ0k4Jb0FS+NVu4S6h2+tCzJp8GEJzd6f9eOS8lh8S66XdrqoZcz1UFAolUfTqfIjShbe8CTP1xQJ2uaKeGGKJjog6OTyuPVN8NhyxwJ5LACsolP94FBdmpvcDW+NEfzP+VESPQiftMRQM7c4qMiVUmNa9WS/1WV5euzJOG2aNIdtT2bv0qPXCbqPf+1b96sKyAKbMYgbsDNYgGYJWwzk5BUjqLnSQ7U/FkprN3fp7E4k96ONb1rMPYjdaE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(41300700001)(66476007)(52536014)(66946007)(66556008)(6916009)(5660300002)(4326008)(76116006)(66446008)(64756008)(54906003)(38070700005)(38100700002)(2906002)(33656002)(478600001)(86362001)(316002)(71200400001)(8676002)(8936002)(122000001)(9686003)(26005)(7696005)(6506007)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Uk3FAf5P5LHzEXoJBiIYJ1TkLbOHJQgWWJzkMpk5rJ/5TnsGase6WhB/ofhm?=
 =?us-ascii?Q?aGegPMYADyyhdBOvaKY/1Cpy983UWRuyWkJcUACVQXBQ80yw3rwiKzivchhD?=
 =?us-ascii?Q?n0JfAawrVao2gncuDb6t0Wtf5NmvMm7DUEGSTgmbE7QLuGWPrqaOaNiVoKj1?=
 =?us-ascii?Q?QuSVxa/Q68L7mpvG+J3b8uddA2Nce+cQnpynLm2EIw1yF9g/7QwHsM3cyhGa?=
 =?us-ascii?Q?xUjh3HrYEB4s4AcY9xqljlXcQESBSNup3nZ/yulB+euW80Xvk097a02QBCz9?=
 =?us-ascii?Q?L+PHmwREbz7+qspdZzYqUkCRRXSznZA0VZtgS1ROyo+0Y7KSZtbJCqqY08vr?=
 =?us-ascii?Q?YdsE0Z5OYMANdeqFmmrpvlJ55u17qZN3XoY/d0q8JJFFn3MTNvhS5OemQpx1?=
 =?us-ascii?Q?1sC2uJBQbQmD+HEfosXiqaOxlG9DZ18tYQmmJF+5tFs8t8z7Mmtx/1mLXiJs?=
 =?us-ascii?Q?DS/2vQSZO6y5YmUu+A/t6qSiA+kUmPMa7X6IZqiP6yFmLLFTlgVRclZrr/FR?=
 =?us-ascii?Q?IPjJXFchmNKlcM2IIpHDYgFHpWDa0IFGpAI21uZAROvxzNXX/j8bMhhpK8Aw?=
 =?us-ascii?Q?yllnuOUWSNxAAysZghxaeEzvv0+BOeh910Yyl8sX4sC1ei6XNNpYK68V+GNr?=
 =?us-ascii?Q?9A4JeuCvGGas9s3oKBpbpjqR49AA7V9cSA7qVBThgybUOCevI9bz9w4pKGBC?=
 =?us-ascii?Q?pFVsPzBSOOoYoQqCEPm8XS0p/Itw2SEKVIebDkIZ6QXmKAnfjRehBS2hz3ra?=
 =?us-ascii?Q?MKlsnWY0bciVj3KxqJ0PBmu7wBcL768T1GnzH5yH4Ea+f9ZtKvfy0ZCBbj4w?=
 =?us-ascii?Q?JeIHI3rzhVqWVIP4Cn6GRROsmDCSKkNDd4V4TrJuBI6557TO5SmvD4O1A2sr?=
 =?us-ascii?Q?U+HJl13n57NM4VzXvYMpAlWsAaNH+aiS7ja9OKgAhiAOw5U/L5hcj14kH5F/?=
 =?us-ascii?Q?QGxMSDaJci4RHEadKkSGrCKIKBrkUmF7GE94ihSNE+SXgrd+TTMZVsz+oJOR?=
 =?us-ascii?Q?2kpOJDuC/SlfyIN6s6v/PndPTquUJuL8K7I4donshZjtpnMuKS/LaoByU71/?=
 =?us-ascii?Q?aRXD8M6bbMUtPFbvxXVUvBnT9IpM7RapZBaysWatJexpveWMIAuEuQrwUg49?=
 =?us-ascii?Q?PH1PgEuxCe6K1iTL8jjrqMR9i2u/g7S4EDQNwGjXxPF09APQRKbao0upnTkV?=
 =?us-ascii?Q?Tk3fnZY+63Wc08ZykIIH8SZkb5+0LQOjVP/VURmOho1zIB5FaS8plvAn7E99?=
 =?us-ascii?Q?feylAQViUonLRrYKaMa8yOVkN43PZi3TppGwKYkxS1vGYsSSwYm+RkXV6tL7?=
 =?us-ascii?Q?cvD7ustkJkIRB09vICmnCByiChULg9I1k0auww/Xwq2Hl4zA5xSAO2UsJk5a?=
 =?us-ascii?Q?6N2PeXnlN9f/2u8ZdhEQbZ2KOwo3FZJIAxK1jrw7h3FDAQwVaWeiMGu6kX8w?=
 =?us-ascii?Q?f4tW7QKOZRkRqxMIJORPeAar0kVKycubd4NVRErKRDO3YhNoU5j9t78pqvMh?=
 =?us-ascii?Q?oWUAf/VQYl+4Ir/0B5d0AFvfBsseeN0zJDimn5ZyQwRhmPywTOidTqOMZiVL?=
 =?us-ascii?Q?SGR4uUjupQachWPaL0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631be4bd-a81f-4dad-f07e-08db9412aa0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:13:28.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25jDvHzn9BgAc3j6C+QaA9ELziCRfxqtaHeXHjSfelHpOyYYJ/pl3xScbB+YW58b5txTDswhKiExL50wLmGwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
Subject: [virtio-dev] RE: RE: [RFC] virtio-net: support access and control the member
 devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 4:36 PM


>=20
> OK.
>=20
>=20
> >
> > > +        u8 mac[6];
> > > +        le16 status;
> > > +        le16 max_virtqueue_pairs;
> > > +        le16 mtu;
> > > +        le32 speed;
> > > +        u8 duplex;
> >
> > We should above split constant config space fields and below run time f=
ields
> meant for debug purpose.
> > We are working on the member device migration proposal and below fields
> belong to "device context" should be available through such separate comm=
and.
> > But if you do it before, please cover the whole device state and we wil=
l be
> able to reuse for multiple use-cases.
>=20
>=20
> I am not sure I got fully.
>=20
> I will try.

Something like below.

struct virtio_field {
	le32 type;	/* contains the value of enum virtio_dev_field_type */=20
	le32 size;	/* size of the data field in bytes */
	u8 data[];=20
};

enum virtio_dev_field_type {
        VIRTIO_DEV_PCI_COMMON_CFG, 	/*  struct virtio_dev_common_cfg */=20
        VIRTIO_DEV_CFG_SPACE,	/* config space fields, for net  struct virti=
o_net_config etc */=20
        VIRTIO_DEV_QUEUE_CFG,	/* struct virtio_dev_q_cfg */=20
};

In your use case, it is VIRTIO_DEV_CFG_SPACE, just blob of data bytes.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

