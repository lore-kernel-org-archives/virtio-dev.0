Return-Path: <virtio-dev-return-12695-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4031C7EE2D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:51:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 265A42A828
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:51:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08999986549
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 17:51:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB54D9864EE; Mon, 15 May 2023 17:51:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8C77986509;
	Mon, 15 May 2023 17:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROy4wh6LvZK6MOmQ7qFuGSRZdOLTXln+UPQWMhxXvszKjHLEJ6JaUMJQO0s44A0Oo7e8+ajoOLp4dykOCjfEZXqpWjDWTFby8sFZKlHBiknf6U0852z4bMTj2cMyb6cZ4oWaMArvtyNMbAEWk3l4haH7AyKLEVlG/Tx8qddeUT41BYKrKOr3j0Psj1jWEGG7JXVP0t3OnGxw08GCtoVRgRF6WUyHdBlZ/tzVD56q8j06KL5V2+z5XpujVy6bztqAk8hv80xNUeeeLmWfXGlGdak5sc82NCRiwouULYmktBJV+mvw6NTfUHj7ay4JDIijCkBmwJzK2aFrRpm4WaBhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTs39gvMR+E3sU5JsjcOEwHXuZwg62szUuydxCyvaTU=;
 b=lqjKR5EXzuHg2cSzcQvfXY0gBt1FzUAEBRz2vQ8H1/5tSDJrO+7pT4VTBHj3FWItRKVhLxGDhyfZb6MS8oHAIV/RDqRw+YrwAgBS8cXPmgZZHIgNm53gfhtq5/tfCh+qm0LpOpCYNH6aztalKdSUtWhgoP0SbKZh1xOZS+NnpHJ4rwZ2JQrSmCmSHMBgqHf1BvuJt4xKXyPW++PtoLTMMgOjAQ0xOon6YaDBdn15zMAbvVi18+6UA6l/eWza0AGTu+Q0ciAOmuPjIgXeDtGz5Va6Ku7t30Yd/OrxQesduRjHAJwEQFoOiFo10W9d0K8tWQgtOvrCxVcVyzx9VSlWxA==
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
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikIAAJMIAgAAAtkA=
Date: Mon, 15 May 2023 17:51:05 +0000
Message-ID:
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515133719-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8710:EE_
x-ms-office365-filtering-correlation-id: 95947549-baeb-4b49-6d3b-08db556cf51f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RgT+rezv0UQqyU7TuqTGdMfRhgTc5YoCtUOllP3YYYZqYcSjZDA/Qb9q+LV7u8sZowwHpWlAoe/IWfdr6/d2YMEJC9puJG4TW0SRbe02GOE6XQWDeAYTwxbCcAHZadHBQCDYHZJ5JGWXFoR1hyXLmoKxEbOrrh+NRtvW7gojM0+jQC08DTDNsVPRNLqX9B/iy/eS9ziuLzdCRAS6jC4U7L/DTPz0DeYFAw2sejGkz1RJT3ZpZVMvbK0si4yVAJL/qZ8z/xtj62HUh92yIQ4JPCp3XhLqUm3yQtdK19ktYwS/xOW4MZ6/Xo0/V+HnQ+gELpVWit9j1Dmjx+FqVJ5BE0T6qE8wgOKYF5ksI4Bxo+hyCs12eE/TVWDx74/CLk5Ix/j0oa0As58+BEs9QJsPWHphGHgtTI9ScCPJDwLrEfiLXl0Qt8/UqGnB6B8EwsRqBKfBrbi3+z5loTmznLHubr/iy0Y5FgwxTHGE6Qa7dQO9Vv7yUcjUctQVmXQ6JD3NMdRr0+whYcNmKenSMqQvtkb14MgXUDKHFGUK5tBEFlv/B9FyBa0O3fSf49GGQ1eL6XMOGszsKYGp1euWdIyL4UAXkeFrWQ2i+HogyrAZGMISiO3tErp9a1Uxl8VO2rXQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(55016003)(2906002)(107886003)(83380400001)(66556008)(66446008)(64756008)(66946007)(66476007)(76116006)(478600001)(7696005)(54906003)(8936002)(8676002)(9686003)(52536014)(186003)(6506007)(5660300002)(316002)(6916009)(41300700001)(4326008)(71200400001)(86362001)(38070700005)(38100700002)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?64Uv2Xadvy+XJTBJmAZqU0BBnZbIssNhN1+R522NmyZG2Wy4b/tGvYSwE3em?=
 =?us-ascii?Q?+/uwWWGJYcBBpncAq2ORa/E9PtO2nzDB3BiakxLPYzfHexC81Wh7cVWJqoBb?=
 =?us-ascii?Q?NocKXvq0TgD/+hA0cjbeJu1n0M4Cm5nafdP8JGxtMpsAvWzLqTViySJYbY10?=
 =?us-ascii?Q?4gmVsO8lfnKL3G20+lBXbKoRJBpS/kBZn4WTJj572M6zBlKbjRO9FaBjIbnB?=
 =?us-ascii?Q?I0uQ+ls+mFND9zXtQrj4FEbx0HiM9CPs+an4tuZgMy/LWSZFZintRoJ5UUQf?=
 =?us-ascii?Q?7yqf2lGnBhN77+5clPpw5Y5oDWjruiNvmybpeSX6spQaXyxJVqHvcW+M75sp?=
 =?us-ascii?Q?iYIq7JQ0Goo7kHN8sxoO6gxV46IZa66t8B6XUmuYApwikQyn7NL5hVlOsipq?=
 =?us-ascii?Q?RXqel8KEW7Z3dJKsCCD7dVwBh1oAg6mJyiWefKTBmUo82krCdDoSXkYorSiM?=
 =?us-ascii?Q?F9Dm8Fms5oYueVSBaWQrYspcLgEGgjkiwffUerNl3hTuCuX9+nsX+Wf83im5?=
 =?us-ascii?Q?Qe20BRkHOjdHek83N3wSAODTqXe7eXB94PoyC24gwlZJhwIwo478xsEZYSgR?=
 =?us-ascii?Q?LRa2BerfRVQCNpPEiWHjJJzl2iYxjGKowyYTzY2PNa1FpnfxcaXwN9xs1Dzp?=
 =?us-ascii?Q?yquxXBn+rsGLUM05QgOcAMjZMWMPPJQMydZAK5tcLNywKxYfKT180FC4HPKy?=
 =?us-ascii?Q?A5LKZC1R2hiOBCoXm8wKxmqYb1hbma7CJa+krCepVyor0XoLMVzdq9z9qlrt?=
 =?us-ascii?Q?+uD/w1ZwwWCpDi3jG+OiFrxvFksjY0VoaLNnJGn+xm6/5smd0ew0DTcX6Od3?=
 =?us-ascii?Q?1kjyZABfSD3vtJqrY6/ioWX/vdb/NsnyhC+B3Nzz6HknyzpVeUKLHgc8mtQT?=
 =?us-ascii?Q?NJhN9KQg/dUHOLS63R8bmW47XpPGcfbNQE6o/aXDz6ChiILZxkj9E/mSB+fx?=
 =?us-ascii?Q?dWtsj5g1XFZn3xmOVdUKWQa/9UaetADh2PyJts4DTZaN/UKIMbkh0M2LpQxv?=
 =?us-ascii?Q?Jo4nPHdBxaOf1oKdp3pibFhCrxi2cmjnwCTI+NFBcSXozgGr8l4PCvUWwNRH?=
 =?us-ascii?Q?fq8f7hLf/IO4vH3DitdGaOq+lzjnWhjm7vBUtQ43b5CfjBeB41vbGQ8EQopD?=
 =?us-ascii?Q?6DvKN+dWINSsFNfmwJcFIH77YBNNfZzaZHykNLVDrBkFoxws5ijzj3tJ8pp8?=
 =?us-ascii?Q?SMLYzcPGSPRudUg5gHhzmoTA9r3BuMzPVAiqW4UIQ9qcuFSzs5wbx53WaQGi?=
 =?us-ascii?Q?YCvyYclNN8KneuQ4NbkDRnyjadm2qbrqbazCBOfb3VnxShWsOKj43Yc79IW7?=
 =?us-ascii?Q?bwQdQRUoU9aewERPg9N66/ALFPsGPkstHc+mXYJVv/tG+MpuR+SH3tKSxviL?=
 =?us-ascii?Q?Jg4V7TKJtR1Ia60Io7g8xJpbZwSWltb0SWqrFcQtzCk8/ECXLnMiQMUjcUXg?=
 =?us-ascii?Q?BVbn4ljBGd4obheN7xGH+eGX58xvpsV+4Pt3KSW6Azpr1yCK7F8InXAod/gG?=
 =?us-ascii?Q?1DRj6cUtzBokqxU7kGxkAhcsfMTXmEOCSkiNAHcmP6bkUl+yqhBTUMrptfFf?=
 =?us-ascii?Q?H0Y0H4UFEkd2UfxsRHv1/KK5LnJNmpjHB2Y1TiTfz2pgDY5uLcgwr4xjcn/p?=
 =?us-ascii?Q?jQdwESIQHBGnjlVMO/t+nwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95947549-baeb-4b49-6d3b-08db556cf51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 17:51:05.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROsMDWljsjlCphPUOgRxG6wj95lUMoHux5nVhVHFYh2anUNDV9IaxVp2wR6S3CigYfBRNPsP0OqCSIQfu+qH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 15, 2023 1:45 PM
>=20
> On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> > All legacy interface via AQ.
> > All modern interface access via PCI or its own transport between driver=
 and
> device.
>=20
> I am wondering however about the hypervisor notifications.  Generally the=
se
> are the most problematic aspect here I feel.  For example, how does it in=
teract
> with VIRTIO_F_NOTIF_CONFIG_DATA?  And generally, having both guest and
> host be allowed to access device's BAR seems problematic.
> Can we reserve a PF BAR region for these things or is that too expensive?

VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.
For modern device, guest driver will access the device own BAR directly wit=
h its own config_data anyway.
Should we reserve a region in the PF BAR for SF/SIOV device?, should device=
 report which BAR/area to use for the given SF/SIOV device?
May be yes, those are different discussions with tradeoff to consider durin=
g SIOV discussions. It is not related to VFs.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

