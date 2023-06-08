Return-Path: <virtio-dev-return-12904-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48381C7EE29
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:12:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABAC429FCB
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:12:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3C3298668E
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:12:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 990C6986681; Thu,  8 Jun 2023 19:12:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8349B986682;
	Thu,  8 Jun 2023 19:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLk5VUhKq0QDsUkKkM8qugs5n6oohihNffYjYO+bEQFtJqgkO04SRDVgvU/XKKbgVoUg7Ftec8kjsX+SIz9Z2PQbwOk0gvc4pE4oklyhzo9SOrWw+gaPOKOW11L2SQzfj9673K8sppZy++JHJjEtg3KbL5ZnP5QNGaMYgNH/NzFL2AMK164WvYjKK2Q/y9ud5yR1sz0zm9TZ7ZbUNtS9vKzg5a2614Xj3cnmrqCwoG44lsZIqI+++xrRmBmUClxdSJbXvq6+YscktHWs6g29WW2bfStDXMYAaFAjIBxJ8pqyHaXS57SCR3nxN1l0qDNEcKkGkSUgH0knuYjZ23a7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+Q5GhOFki/AjjixKr/ChtfcIXCTTBWFt8Tg62yogks=;
 b=O5OT0G16muqFWXHq0QRUxpJq3BMd4TOrlaXgQ3idHKnlthFLl1xVRByhbQMbeyrZsIOVdzOEipCcT43Mk4AkDwf7+7wxBChwdl5m1LuQjLiSyXWQrohouy2+B2n+AqnOFDdw/dkC7/cLhnwuDyiX5OvxFZ/FW/YpPrMUM6Ysc47xrSJzpQoFRPQl+RpFJlFWxKFh5ppePMEXsFpH2XNJAghSR8HbFu3WLCh5b1FwASjc0mghHVDe+Z1GRFNTlvfLSuM0pnHlLqiW2BYGXaa0wdaQnSQFYqdUiev8/m2O98TpiJihQjZmdfbSqpKyHOE/W38vBbDWHIwM04sMF0OvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAAwqAgAAAcVCAAAT9gIAAAt+QgAA3HYCAAAbroIAAAh0AgAABYpA=
Date: Thu, 8 Jun 2023 19:12:25 +0000
Message-ID:
 <PH0PR12MB5481D7AAAAA78AB60918A6FBDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608105640-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608142527-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124D3E867D25B5DB65610DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608150118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608150118-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7783:EE_
x-ms-office365-filtering-correlation-id: f99ed128-12a0-44dd-7e81-08db68544b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A7RDgsGwrQiSaEeQPXfoIPwhyrL72DxQbyGl6t4Vd0bpUUZk+5skN5PO3VphSo9RySwpBQVLYJ4sdvRqMGx+jN8jsmh5Xx0Vi6oNiDV6CejZjh0sIA1EtiryPm/Athaq3/LUWViEH40MjXouw/fd6ettM59ewL9EzQ1vk9ZFfn8IQZHv1EAKtiUJ++2z+PHNh38WEtqWpqe1Ay4vhNTCR6lzAkJEpwa2U9iFVZdE0j2f3o4da7Mp+miOOM5kvVr1AoaZ70H3+WBg3BWfoKiyvT8/UQg57AI+TRWM9JPelZytZNoAsY0pcDl1JhQGI5s3hURH6q2SUrDkJ4hVBMQmMBlfBaup9IzeUWdQswg1a06pXOzzV7UJ+R+MnNVuEa/FTvPFph59CaoFDa7XP87FTcNedoWyslBDnBSXdUUE23tp5q7WWjhPuO5tsXxidfAjZ3goaMbui6Ilo3GakLM+b1d6s5giXFnxkXgWCk1r9YVq2EmwVInxUWHq8H8iNsd6Vz5q0U8vQD1wHOUXu2vOltNgYu1676BhzYZLwp385d/BG+yR20C/JcDNCaCeKFwYjRgS1Kos0Bxfkc88GaE8nvabRoNZNsRaeD+qWDGNrSL9Rp0MRkIF/Al7o7iKvRbe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(52536014)(64756008)(8676002)(66446008)(316002)(2906002)(8936002)(5660300002)(66556008)(66476007)(66946007)(6916009)(76116006)(4326008)(41300700001)(54906003)(7696005)(71200400001)(6506007)(26005)(186003)(9686003)(83380400001)(107886003)(38070700005)(122000001)(478600001)(55016003)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aY+Rudt2vfjNth31PK/CtDY7vwybyA2oBrNTtjY6mB7dSHm8JSd8KZ15nSIS?=
 =?us-ascii?Q?GNSB83DrRBqlO/ViqFUVwGfy16h9pj5ewQSB6vKzuc0o9OS10ENpamrfRP1T?=
 =?us-ascii?Q?poRfKaCYB1CcG4+/LAqpUUwk1FIjaLjtjYj0cj3m2teYPU5N91ngllGKB9aJ?=
 =?us-ascii?Q?JlPqd9XYITiwgTXWLPTWa0CVonDVYLUj+ONH7BwyhGffbOvLsFLEHEIng5Ha?=
 =?us-ascii?Q?cCOS+E+pt2OKlB3TEXuIowzF2JKGLBRYZB7AaVKxeL34nl2Z+FtiAXUcVjmR?=
 =?us-ascii?Q?wlGcAoYlWlv6NSTv12De0ROaNEj2EfzmoBKSzSOpV61nBXWcmOghEVEKgxDy?=
 =?us-ascii?Q?hYFej+c86lZhC6rl9ImpmjvU8YBw77wm4CgHu4mujLe89q4sw9svwf0iNumi?=
 =?us-ascii?Q?dF6sSFiW5tTtynh7dTXE1V4QGp+WtAfzeIgGCd7W3mDqtWY7y8gYuPkIYEkT?=
 =?us-ascii?Q?XkFhsOQXWhZpCOBhVMwmDlemij6cfdVjpUICrFeTtOqf5cO6bpgrA+X7AZFi?=
 =?us-ascii?Q?duiagiegze/jK8AmF2B2rZ9LLtGPseaDnXg8BjMADHCr3LujKZXHFhTQUJrC?=
 =?us-ascii?Q?63MkKLvJiuEtxQZBtpFCKSPMZrGsviHeLEAkeTg5RN/mp7iSIAfF1kJxvzKv?=
 =?us-ascii?Q?V/w8NoNi+8FVa52YDgwylTuZeBPhYlO0VPNWUILvagA6sdLLK3tv2AIrbpCd?=
 =?us-ascii?Q?Iee6nfnB7j1uxwXCobp/cqyw13TCtNw/bpdhmGGPq3kIJzM1VQIrIW9nXTO+?=
 =?us-ascii?Q?tTDc5sCQ3L+zrLZInSb+HGU8e3ww17ahh8b4M04Piw/jZn5+PwRPfJjQ6zTM?=
 =?us-ascii?Q?c6CHE2eOBLF/IMazpdGWfjD1fprStTrX43bmhLhV9YGTZ8Wjlbb5JdU/H9Cz?=
 =?us-ascii?Q?1aMDLUjtGcW9Uko3t5pFhDDtMi2b95hG/2/n9vS0VxmKwPKFnOkCSAbm3372?=
 =?us-ascii?Q?ItlFKTfv3TLXJIJQ6qC63bopVjsTtvLIrz4QCl77L2ghs9jJBxQloV99LNZS?=
 =?us-ascii?Q?cNgpyvIEzZX4iEhj4AZucIEOcpUznpojjp/GL8fCLZ2HCUmZuGSDkprKLfGa?=
 =?us-ascii?Q?sAJOl7nluUKnN7a9JClaDMZ5gQhEf4YVFUanHfCRwgZh719zV1RazLdKmrn2?=
 =?us-ascii?Q?J2/Awl8Za6w9QaGclaWw2VtgWil5r5k1eH22PRgVsB+w6ee+GHNA8T15oPjV?=
 =?us-ascii?Q?sxx9tLUjEIJ3T+BckC4a435xKAA3uaeLp9oRcMb+bGS2ySdK54GFve6+eeVk?=
 =?us-ascii?Q?ih5BcTq1txGd7ZymD4AUMQPdEkjViKZW4aV6K41R1QCzzR6FtCnz6kq2/Stc?=
 =?us-ascii?Q?+2Wzy+QzeaGnfIVKidOGKhXtaS+NNMuWufn34i+u7M0f6iI2ClTxOqH4tlNb?=
 =?us-ascii?Q?CnF1L5+j4aZ0AQPxq6kdrHMNORzaR5Tcte9Zq1dN4+M8tuESnqzRysC8pgsL?=
 =?us-ascii?Q?txkrWYEWZDiIhOINCzdoPP9K2zL1dvXZ9FQFhPeSyBJ89J3xT2UwhvQi2P8e?=
 =?us-ascii?Q?dYW18rDPrlRWhqIhm4ocMHV9VD392qZ0fjCygEH8DilNnuONCK1M9yO6z1pC?=
 =?us-ascii?Q?w288jwOyUARicj1Eg84=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99ed128-12a0-44dd-7e81-08db68544b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 19:12:25.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9BuzaKVq8GvmzHIIUvH7EwC/l88Fg6oObbAq5UudX6E84+Y6t9/v2P52HMKFqzKgtxuO6C6NbQ1gaCABaO2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 3:04 PM

> > Moving now to admin will surely have more back-n-forth as it needs to t=
alk
> about PCI part and that PCI part will reside in PCI section.
>=20
> well the point is that it's *back" not *forth*.
> IOW add the command description in admin chapter, make it point to legacy
> description in pci chapter which reader has already read.
>=20
There is no back-n forth today. Reader interested only reads the pci chapte=
r.
Only to know the opcode value in a common table it reads the admin chapter.

Putting command descriptions in the "basic facilities" without referring to=
 transport will create back-n-forth, where reader needs to go to PCI chapte=
r to understand the motivation.
Come and to basic facilities and implement it.

When there are too many things common across all transports and very little=
 changing across transport, placement in common place results in better rea=
ding.
I find the opposite here.

> > > > > another example:
> > > > > 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers
> > > > > to support
> > > > >
> > > > > VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capabil=
ity.
> > > > >
> > > > Yes, it is exposed by PF, the wording of "PCI VF device exposing" i=
s not
> right.
> > > > I will reword it.
> > >
> > > So here's an example wording, I don't insist on it exactly but the
> > > point is to show how we should use spec terminology whereever
> > > possible:
> > >
> > > If an owner of an SRIOV group supports all of
> > > VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
> VIRTIO_ADMIN_CMD_LCC_REG_READ ....
> > > then it SHOULD NOT expose VF BAR0 (of non 0 size) as part of its
> > > SRIOV capability; this is to facilitate emulating IO
> > > BAR0 for the legacy interface in software.
> > >
> > Yes good one. Will use.
>=20
> right and my point is try to word all of it like this.
Yes, as owner and group.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

