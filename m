Return-Path: <virtio-dev-return-12661-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8464C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 21:03:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EAE001CA24F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 21:03:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCA9F9866F8
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 21:03:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D1BD19866D9; Thu, 11 May 2023 21:03:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA2A69866D7;
	Thu, 11 May 2023 21:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEIqrTnTvKb4dQtfLqa5o+VyrTkNLvqxyuCkq3VGWvO60Z7a5Kw7jq8oTA77LuQKcyZfZMLhXByJ1V7M4xSK7Vn4n/2eLM5OyxWi5bisXmnpXTjzCH4iMMyoMUZRihcMrBcGfwZh8XT3ChzqwVPjs3AcfmRDGEV5iYCFEQxha/0vJ4MdeYJnUELAPOmrFQXVFCZck5KuZkDuDPqi1O6N2rpJl6ZQ/aIvH00HQ+FJs1qMwBZufwRdVLkIrG3tHY6JUR3CEuHuFHkWb9qzSszqy9H5WhWi89X6ytUOfvR57aw8En776Go/IEFgj48UQQhbP7BSILOR92b1T5ggx4ZoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXa7p4ef7wONA4MoggXkD+1kUP8qpRUPkByaI3vxGHY=;
 b=EKE9qiQQdnhkyNJr+iH5hk/ej0VEyVRyFUFQRxmZuu7Udq4o2A1Ic7+90Gj+EBWd3WgfnD78CromlP01pzBf0IHvOToIZRbOUI1ssNCbkQfsCziaJzrJ8fuCPKfQ4ctRyclVzw9PQHyKiZ2CTSJRJFFRME9bfBnLsDiYwL28Hqrcy/9vBEhEGw9Rsc7wYjOO50D1+rNxISXZtO/YaDSkGnpjIu523IcWn2jZXMIoJjaIZPNLnVzJvDIRZIA7HpZa6M0hcbrRN7LYCJ8ztBM/YazTJPuwFM65KEUFE/rbrzqTCOG0QYmF1V4+CIXRjOEm7sRC8LXF1/xnIMLJNN5pMg==
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
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAAGRoCAAHWGAIAABVgAgAABGsA=
Date: Thu, 11 May 2023 21:03:16 +0000
Message-ID:
 <PH0PR12MB548140424015DAEF13246042DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511093309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548187706D06D135D3C4FF03DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511165529-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230511165529-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB9163:EE_
x-ms-office365-filtering-correlation-id: 67a04aa8-0fc1-423d-e786-08db526323e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yqcVOV3RXCrr7pclKgu/llcbIraAjugNgTusPjGPtJX179Sn4racJifRKvqLHX0vKN2RhT40JFp9pqRMqSLyuQNumQFAJxm1qtj64V/sway2tc3+Au0gtIue1cN4Qa+YxggPuJxeeqefCA/0IKBVyxH9gdFGj/DyyzuPPOzJmnn/qGYk2JjZ/5DfSJqMUb2QDCU8QSZIUMKzr5n/Y5rUM7SU5Pb3puAlmU+owO84dKtziYZEcgG9+maRDeCL0umOKrhIWQPebaZYppLE72wFWfitsJXJXbFxlyqtNC08u8P+EOcp7tzzpq6HFHRKhe7XfptjzPETmo3kAsyUNUZVJTIllB5MgzZmiBkHTXKVZ/hY7VaTU5nM6Ic4Kc37gd2GMdXreyNVmViDuOoWyqs8vVnpUT1YvdTUoZWgiw4Yx4CY+ih2u731r9d8Ak8/0LUvaSzs+X1cnHoHzOAtJDUlLyA1UlJhiWIRSRnnM7YsaPlmQ2mXiHO3hQ8uvlfHRL51ZqmXaOXlPIMJu1AyE4fChMsVcczMvdHM8AUfXUyXQppaRD4BdbYPYXIU9RETjgChe5ru8lOarTqEizLLfylHHOuYlM1o0OYTCYBBBT59qGa6TW3yzqHB6xPPPzwXWnZZ+W4o0XM43n7/YSgdzpkqsU5AFgNx9mlT4aJy6E4/Lw1IszBPNbRDFuWc85o0yTe31SguolZgx8UL5yXhoRiaRg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(2906002)(26005)(38100700002)(55016003)(107886003)(9686003)(122000001)(6506007)(71200400001)(186003)(38070700005)(86362001)(5660300002)(8936002)(64756008)(66476007)(52536014)(478600001)(33656002)(966005)(54906003)(8676002)(4326008)(316002)(6916009)(7696005)(66556008)(66446008)(76116006)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x3kRPr+Ce1rKhdKqT+PkrDyJkOl+CwAn6ZYlZD3XNXzBkRgIWvr69XPBk/6E?=
 =?us-ascii?Q?ZqfKBChdP8XPEcfHBnUSFl5CqBn4zkT7Xj+vgL/nwkRZwuFc6lkdYaWQUVg5?=
 =?us-ascii?Q?2PVI10GJYRkYuiulOWSzc7nRAcfBtxiJjJwIWFhsp9IfwGK86LRWk8m95LPf?=
 =?us-ascii?Q?G4soTa3SVV0QOFjSp6+HsfHRLfn0waii3dImoZ+9Bxtpn0yLW9dUoapgw/M9?=
 =?us-ascii?Q?MrgTkyMegtjOv/uPTllDI+NHd21lzchJqPe6UVD6jX/Dkxh1OjWomH+8nmEk?=
 =?us-ascii?Q?epWByyjjJrXO3ZH3iYg3s7DUBEvRWoJUBLJSMop4pCauYRMtoUePuQ5CJF3I?=
 =?us-ascii?Q?Ij1fiFXLoxlXh8UPrPtIRubPD5pExPDCtAgApFNxpM9ehPyy5qKPnxgt8FkS?=
 =?us-ascii?Q?giOYGRN9xmSQDVHzN/gUlbs2qsMSxtn8YRTVFyxwXq84jx0RrhdWtW73lDTG?=
 =?us-ascii?Q?++waeDc52TcbHmSZ7mg2ujUiPIGXA1S0BHsSaTbeJjTgQ6ZEw6qgHvsRzujA?=
 =?us-ascii?Q?AnU9hoyc0YO7gbu8BEZ6nLJXR4HiecDkyXUk+9Ts+yRjr0CqBkMBEsXTOh0P?=
 =?us-ascii?Q?7G5cpr9ILG58fLWPYSegmgrdEjfrZpMdfu1MB6r9C2yMIIG7aBPvz7kj0+4v?=
 =?us-ascii?Q?8jNDPZH0BGcfYXrJRlOGzpTownywZ+6Qe2/gtXl2CSzMnQZIyUH6X0aBX+tq?=
 =?us-ascii?Q?vz6EzecCoiBwOa0VyvHmfXcAruzduKQP/LWOCLs5ecO1CmY3uU6dYcwSZVMA?=
 =?us-ascii?Q?EEg50kOijuOtIHolmfcQih9xhucokbrnyAfYwqxSlbIQOHjBSVdBfdSJwC5j?=
 =?us-ascii?Q?pRLHetTN0EgpFWBvpIvyU9LHH7LbzvBrvnSOF3BckvtzI3YOPXQpqnkfesXV?=
 =?us-ascii?Q?bt7CcdgJGQBGokt9pjmta7S+8EnbNAPIB6K08lAE6JlJgD26DR1Kb2q3Q9/q?=
 =?us-ascii?Q?RPvxR/PS2reILdiVC5xmPW17Gjg1EudXK1PxLBuJjTvhE0ixQRMZQkOVsDJH?=
 =?us-ascii?Q?Nnt8pziF4F/y7bXQgrbwrOomFJcXdvnf3u6cxIqWzoZb6H1BrGQBYElPdF6U?=
 =?us-ascii?Q?/JUalI/w9fpo7zXIF8Gcb0ZIJb7aDS84sgaEpt4U6D4GOIkFNViACK+PvRxq?=
 =?us-ascii?Q?nGtJo0NC/oDjRalKTgTUgjGJlFpNOuEeNfoXrdausH81R0VEkCa3Lp/M4Ap1?=
 =?us-ascii?Q?PkRhB9nt1Ay2eHu3M4U0OGAWaNanoVyt9sKxuziSKDJ1rlz8jiW7QBVC/DAq?=
 =?us-ascii?Q?KkY5Rq4kJYwhiVl7Ce1fJm+JoskEWn2jIASvwHqBth0e277q3WZtRtdgo797?=
 =?us-ascii?Q?XT41xP86khAGqkcm9dU82be4ZAWK91CTWYoLo0qMtJaNi6QYmcz32/qPm6fH?=
 =?us-ascii?Q?tt+w732eIZdWnpV3H7q4LQ7mmB4PHyS2cDIa+fF4BIHDnqwbxhfzQx0xYd+a?=
 =?us-ascii?Q?lKbY8/l9VlqL7jMXVVOmfsxABG6w9feTVsR5JrQYt1j132NXK3emec8W8bQi?=
 =?us-ascii?Q?Xl1m+quq466sxs9CPvhx5UlWuBVOMJPG3N7FGK02HplqjqmD9VS8Wztk2H0i?=
 =?us-ascii?Q?cSvcuwmw/Dhre2H7tXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a04aa8-0fc1-423d-e786-08db526323e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 21:03:16.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGzBfFwyanW/nsVwi+JLl0nf30k8/tKDfToAx6b6mnbsldJ/qPGYtbmajQw7o4Yexxao5qaQxqT/qosM4VYE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 11, 2023 4:58 PM
>=20
> On Thu, May 11, 2023 at 08:47:04PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, May 11, 2023 9:39 AM
> > >
> > > On Thu, May 11, 2023 at 01:28:40PM +0000, Parav Pandit wrote:
> > > > This is not the objective to transport all PCI virtio fields over A=
Q.
> > > > Transport VQ commands proposal commands and commands in this
> > > > proposal
> > > are just fine the way there without quoting it as "transport".
> > >
> > > I mean, it's a transport in a sense of where it will reside in e.g.
> > > linux virtio stack - below virtio core.
> > > We don't save much code there by reusing the same register layout of
> > > legacy pci.
> > > But let's at least make this feature complete, and then we'll see
> > > whether it is cleaner to reuse legacy layout or build a new one.
> >
> > I don't follow your comment about "this feature complete".
> > When you say _this_, it means the feature proposed in this patch of
> supporting legacy over PCI VFs?
> >
> > If so, anything missing in this proposal?
>=20
> I think I commented at least on what I see as missing is first of all a n=
eed to
> support INT#x emulation since level interrupts are I think not supported =
for VFs.
> right?

I don't see it mandatory as I responded in [1].
I didn't see your response on [1].

[1] https://lore.kernel.org/virtio-comment/71d65eb3-c025-9287-0157-81e1d055=
74d1@nvidia.com/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

