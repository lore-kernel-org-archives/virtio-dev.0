Return-Path: <virtio-dev-return-12738-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659E6C7EE23
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:31:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4AC94434B
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:31:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAF349865B0
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:31:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF1189862F6; Tue, 16 May 2023 21:31:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D2DD9862F7;
	Tue, 16 May 2023 21:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDeUVYT/nNp/gk/BnKMhbGmjV0I8+xx55zysFy9UGSupzq8umW8oURZz1nPGzRf9GkgQ5qQCzJIceoa6Q+JbAJXSi7+HnUH7ktwQH+R36w/uOKDOVBm0f1pNMeI43luKnxR7A1pSEVLukzVjKJQbvyrlVqDxKU3MJHfaS1A6e8YrjhAjHwdz3wFblN47xCo8PrqEHk6KQaI3PZ/nuTs9mtscCQ6GSGXI8joLgeE8cWJR8DUoJi0pkfyi0wZboS+nMLfrDSXef/fGNbxs2wj10U7VD2vUvCZm5Jm7PJ7pXYyP0pRXgvAH134kH8W4qCpPd7TQ1MD8c1IuxA5uopTLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjhUTIPn0HBYFPvk2ML7cYyThKhyOmXuPYx0qQ8uVQs=;
 b=InQ0kGoPY+I31EKe3LPpmEHezrosVpQC4+eiHTFUp0QLV5Aza4cYkZyF0eiy1HHsodnKVLoMwnuqEHGhy5VDccFoUdfrZx1mDIWMy9Qh03KSQQmFbrv0IraBx6E2bGxsrotalptSWYG8CHuW/M4XNdNxaEK7G5GZY7JquH+T/PvG2M4I/KhWXbAKNPtGOTz+VvtFIHJWi/vVm4WHj8uboMPAZFd2T58iMoi9yh2GLTbYoCpF9x/moyEgd7NgA6eV8WsJ4M4EFiZoWpNpWHKjBDCBPBy6GYokQgkX6CKsL2Yu5Xj1sh3ZH8VDC1NEK5iUWB6OdvEBXq58Pe6ABheIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] content: Replace guest OS with driver
Thread-Index:
 AQHZh6LOHXgJrNfl6USbWvfsD1oXE69cZmGAgAAp7wCAABxFgIAAoImwgAAS9QCAAAK9gIAAB8YAgAAAN0A=
Date: Tue, 16 May 2023 21:31:43 +0000
Message-ID:
 <PH0PR12MB54810B88AD58B00B329D3466DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org> <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481451FE5B75AEA9864C0E1DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516164254-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155D503296E253EEA0395DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516172348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516172348-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8245:EE_
x-ms-office365-filtering-correlation-id: 66376742-3f61-41be-e95d-08db5654f19b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 87XHBfQrFtXmn5iTi/3UOJzhO3Ds02KljobZjkQfOHkHjkRxMZyBv6kZF0wkLDownHIrlT951/Jdo2GkbUITZCkK7j3DB/q47urZtHpXnpv9xHDwOp8zUshh+l0fY9gkDKki02D5z/GGt8olIoS13wL/IDJfS3kYnR+yIzZLVU31OBDjhDeoqeCw4fL7etEQlQiY1dJcmBKMuLRQH25ZnHap/67PUFfE/WmbiU243UbE3QQ0pTC8cRNipngvvjHFK52EhfspmRmwIaVEr4VXV+Ej1P4qfeCMpIOCfmN1N2SZ32COFfASmVEZVE7B1abVeDxhnGm6putYOpykoGbWet/+9O5qtZqzc64cS7mG6XNqStAZ/XMSdtVA+Z7jLQ8Pupb2Sv8evwF55AVIJH5g7vd4tqWH93nF2G3BnQggXzfk7QG1hF9grgZhSqvYDjK1qkhRZzFTgdYYbbM0hnIyhWPrVxSA7X5J5Zh7cUeuI30DC56Naod1MesfQVSixRhxYrEuOx2jdPS+2N6cdtOUvad1Op9fYsfqfqsJcQrLylaSH7XhRpsgiXwcJC1z2ex7qg8/gKlzxTMAG46ureVlJd9xwY028KVXPiNWW7miADd38e0WO+mkYtFnWmZW8gqG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(71200400001)(26005)(41300700001)(55016003)(122000001)(38100700002)(186003)(107886003)(6506007)(9686003)(8676002)(33656002)(2906002)(8936002)(5660300002)(52536014)(66946007)(64756008)(66556008)(7696005)(76116006)(38070700005)(66446008)(66476007)(86362001)(4326008)(316002)(54906003)(6916009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?orAvk2pjcwdKd8IfBfWwABgeeB+RT3IfcsEH5Yn6w3OtPTFZK8fwLlprYwij?=
 =?us-ascii?Q?FB2r6zYimECdak+y66bj6KoGRfGC1wbTRo1SQKCK4pnwSeoYWAPnmf1r7+bH?=
 =?us-ascii?Q?emySAVCIDDDsQc2qAAZwnwlzIdybJV8BJBSqE68st+3fkyzdvzyaWooOe8CI?=
 =?us-ascii?Q?I9ItobvFkJ6PAuxdPBrdCKved9fS+Hf6Ch3vBrgA1O/pss3OjUaVhkvzcx5w?=
 =?us-ascii?Q?Kh/SpMD5fJ06UHGirRLgH4SsmDPUwWvEmtW//c9NL2r6VwJvBjvTLD2aglcb?=
 =?us-ascii?Q?+9OEMyeOYIt37e3fRiU0DiRyTSrLK3Ij1yUU7zkh2WqhX60s+omAJKfRNsSU?=
 =?us-ascii?Q?C3NmTN5iKoL3uVuA7u5dJshX0Q5je43beTyxPqrThIy4fKnvCVPrcbZtv0wg?=
 =?us-ascii?Q?c479OcYLVzCqg4EWlR9tTJeVap2M2nZ1HVkbsP42jNLsRznTINsuI23s7uzI?=
 =?us-ascii?Q?Kj8+Gp6gqBzdQZBEL0ND/G9eVbNOcKql66FmFPnDtXqLnTQdSA6ciTT+cYQg?=
 =?us-ascii?Q?Lt1sJVNb69CQTXGaBQmzzEsoEvK5fBDkbQntiLgmLFcrEMWNzBEPdBSvnT79?=
 =?us-ascii?Q?jidVU/UoxUctN1fG6zmUpnHs9YgvngGHcufqVCjc4NwIP/QIEzPJhkF544tN?=
 =?us-ascii?Q?AoT6KzsafPCwMgtLJW1U/0fSa8f4O5GSsv4t+ZVnNJI5dSp5YgOENQnUgJSL?=
 =?us-ascii?Q?BeJWydh6ed4ML0GQPjDHJItkxqqFKJju2NIsWhE7sq2kiaiysgQOp74Wz53k?=
 =?us-ascii?Q?U0j8CMhW6xeMSu67ruXh7aERnM0KBzH7r2KJyZd5GALC4+7XmImRxkR/OnOy?=
 =?us-ascii?Q?GemaoJ2No1f0YOcJISbUGpC2LJUjgPmsezLO5qblIsTNkmoEPojZQAbBnL8D?=
 =?us-ascii?Q?QSWtPXE2UBM/gFzRAYAjNSYBI2vcHIIKFYsE6EAOqlXmE0TlVxJYw5OsQaIA?=
 =?us-ascii?Q?ckWvJt+u85nBgFxqAjyjR2KgR86kv8fhjxlq5YxMd+eDnort5Sjfzi+pN+t6?=
 =?us-ascii?Q?b0bSf7sHKNVx5G/VRWOYVHOAg1UF3r5gjbMlx8t+dKqbCzCMlnGbXQ+ks4+Y?=
 =?us-ascii?Q?xkgynahJ+zjBCzgHbuFmmpVa8Aqux0TEhF52gx2s61+IOgelaNGSNIvEqZqD?=
 =?us-ascii?Q?hm8rC+kRnTpwc3Km6GOaIE0I7UaZQW5z7lyzrBjgChmoush/nYSp60SCcGEm?=
 =?us-ascii?Q?+tX+AN4qbGSKXTUq4fLGoEV5WcSe9YT4q4l+7tAZ2d8RiBdwTmPh8PMcf7m+?=
 =?us-ascii?Q?M62dF3CZEfJpdC0NHB7XhxmCORvgN2gTnK4r3mSRSbcXju6BbJjPOi8lPH+E?=
 =?us-ascii?Q?9tl9mMMiUo9/FqrAX2eBbmPZCHo5+m2zURv1BfZEzUF3WiuSJ81FCZR2LuDl?=
 =?us-ascii?Q?/2ySq4uDDrKwCUKKM4nbtTHDhOTZSqrMMBzmlbXByltnP62R0P5q2lBw2hUA?=
 =?us-ascii?Q?jwr6LZefUHG/6wqidh5ymSfda+6PSQhXC5hvKsWeG9ws4OtacXw8/DwQFf+2?=
 =?us-ascii?Q?k7v4u+EMx2Il9NMLRDk2Ybb2lpr406ws+ODF6W9gmZxOYnbLsx1Gu0AshQw3?=
 =?us-ascii?Q?ezeLZE6IwRodWQVDJLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66376742-3f61-41be-e95d-08db5654f19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:31:43.3652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UC7rUsYzJiHNAqrxFnx6f8N3IWVCv/uZ3zBuDDvmXq8AXq8kaxpU+5AzqQbFagrQ1KJRDt1zByMQPzcJg84f3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Subject: [virtio-dev] RE: [PATCH] content: Replace guest OS with driver


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 16, 2023 5:25 PM

> > Flavor of a RHEL has inbuilt.
>=20
> What does this mean exactly? That virtio core is compiled into kernel?
> That does not matter at all.
>=20
Why does it does not matter? What is the definition of driver, is the devic=
e_structure structure or module binary?

> > > > Does driver only matter with device_driver structure or module bina=
ry?...
> > >
> > > Can't parse your question.
> > >
> > > > Driver is largely the software entity that drives the device.
> > > > I think we can keep the spec simple enough to not mix these
> > > > details and just
> > > call it a "driver".
> > >
> > > Not just linux there are lots of drivers like this.  the two bits
> > > pass useful information the way you changed it this distinction is lo=
ts.
> > > I agree it is worth thinking what exactly does it mean.
> > > Since you researched it - what exactly do drivers such as uefi and
> > > the unnamed "some OS variant" do exactly?
> > There is just one "driver" virtio_net_pci that has sets the required bi=
ts.
> >
> > > when do they set ACKNOWLEDGE and when DRIVER?
> > >
> > Not any different flow.
> > Entity is one.
>=20
> question is, what happens
> - before ACKNOWLEDGE
> - after ACKNOWLEDGE before DRIVER
> ?
It follows the same sequence described in the spec as "driver" not as "gues=
t OS".


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

