Return-Path: <virtio-dev-return-13002-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB849EB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 01:09:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1EB7F2ACF7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 01:09:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1552D9865F9
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 01:09:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 05C629864EE; Wed, 21 Jun 2023 01:09:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC8B6986509;
	Wed, 21 Jun 2023 01:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm2+OO8Xji2ub5UGNBz5bjuFWRztbRIQw3RJjL2xcImYO/7a45enLhaOXCTkhE26f2d2/wdDjKv3tFrEMNPH6H80t8JLLBDVpSmHzAmf9Hdh+ayrOKQ4jWGhbPTN5ITbv3DoIRxBKx/c8O187RMbaYIKu3v6a0exuNW7znbpdgnDTNaXzLUhdKF+tbBWxN5VFjYPkfqYpoOrpM8SD8L5qjgYelMmtccSE2VB2nyosb4fDTbF5i2/zYIPyO2YYRn5lMWL0qaOK3Yvyzqbu85LfQx8u3e9Vqzm0ljziGpAELX2ttWtZTdu15jCW9e43siCQnBcNbfS5ZKyxP7GWVwPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86HWsgcmx6Es4k8BtxG2J7lBABAx6IjjxcAgitdnm1Q=;
 b=Rbl0Is4Vf+AY+YM94if5gbc5F49fLFmbQI0GIcH3Qtj07R9urMOhWKnNgxqciOb/RWUz139QaJnPHiN8LOK47ucO3tFm6W6VnFrpbpZDpN9AEQeqQ3Q0b9RFO75I0izCARx9KQU83EIaiKRJTcLT4JLTMRzeL4h5k7C+Sqh7tyq3n84FiJeIzA+D0RwvsVHa28wqAMMXR8X6rdM/+Su9VGSJjCmR2OM1m5H1IfboGQ/yMDvdQmUS4MgvLhCIqLBmD5GxuBO4SutKo2giDQegh2MRyOJkpbp10IoFLqPcnQb87ydbUntHv8cUtXRLKjSzN+MqeIl9lISut2XCDLtCMA==
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
Thread-Topic: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SY/mAgAAAj+CAAAV7AIAAAUBggAAEYwCAAGkckIAArQcAgAD3EgA=
Date: Wed, 21 Jun 2023 01:09:40 +0000
Message-ID:
 <PH0PR12MB548183AC0E47AA8BFE76C042DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132018-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7DD7654CF3B18939956DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133754-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155EE749082B769487988DC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230620060110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230620060110-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB5022:EE_
x-ms-office365-filtering-correlation-id: 0a273a06-692d-4cbb-680e-08db71f430f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OVlFd1H3BBvZlVZINVgKI3N5vHd62IyQRKORymKdmW86Pi6N36/llSQpIFGb7itYyTD/KVyGe/u/iJsRtIZvN/RyFpDF2UaMr61dla+ZJrKM5m3DiBM+W04dwkukQpSXufcHg2YB5M3+1F0tpMf9StTHwzhMgiDU/Ut2m4sqOENHGa7cRahwXqEJ8p+qe8jjevnL0XPjOgtsyjgkrFfTe1Cn8I1Kfw6CiZmYPxJVEJadbiN3KWSgds1MivXKsFJFSp8TziXFp6iF3LT4ANB7PZrlM6mX2tP3YucBS8jvt9utOovh6kFW7qZBCtrGFh4FoaBT9oK2InXQ2Vxd0RfCjeiauQS3eWesaaL3V5t/G0Hmfmq3SruDvOuGEM3zh0opIJBh+gMsSKZiRQt/9wTGALZHlAw5NOzZsB4yjXxqmyZCY2U+hhSdt0M0f0L5HsI/jCHX4Hl4chOxRxyyeY/ssBkRUCNnHqVdG1zOM/ElNeKN+oLQvpLar9yKjkMHBhAfEnDssxGZvyJxYYLelGFdDLlwiR6cJzbPB79k4Y12kWX6iOHNuICQEl3bF+yn/XbiX/AfvwTG9nsqAPoeXZDgdYr5xpXCBCpalq7Uesnz23z2WCadh4v4INLx11Vg+Pqk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(64756008)(66946007)(66556008)(8676002)(8936002)(76116006)(66476007)(107886003)(38070700005)(186003)(6506007)(9686003)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(52536014)(6916009)(316002)(54906003)(7696005)(55016003)(2906002)(33656002)(478600001)(122000001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JHXdcSH1TK0cvgNoXvrWhixu5a2fRkFAW0j8D+UulYfsxOAHJzHzGcmUQjVe?=
 =?us-ascii?Q?jCXX0v+nKGndKIf4g+wBe4I8oWf2jNfawY6ANUtOWn4kVunNt2V6nGfZm+Lx?=
 =?us-ascii?Q?AjFSauGZG1Xmqn+npfgqhTMUeRB22yWB7vLuyiUlotOpucSWH6CQgKx7vnvO?=
 =?us-ascii?Q?ZKxHB8RDSjg0Xuv2dORw9a63Y1azYQR8VtbVmjo6/cDiDF7+Oo71p2wSWouD?=
 =?us-ascii?Q?0sP9WQsJ+W4edhRC44q6hmFXrsROamHNDsmH5flvrZNEsT3WzpO9IRrhQQxg?=
 =?us-ascii?Q?MjdPv/nYbQJw7OUIfgDDB60q5m9YPrqQCinNyhqbcA+UAKIX3Ons785kkSUz?=
 =?us-ascii?Q?+lZvREmoTQ3TGb+7KZbJnRmIqPdnvXK1KFggLh746RhamxBw9foi8R6V9iUL?=
 =?us-ascii?Q?1oGWZvAVgeCg4KpuvpuAPepHQMa7B8jMlS+MxwYAKrYSeJDMtj25F/La2LU9?=
 =?us-ascii?Q?ilBksDJgO2P1NlTF7ujKz/HG+qW7MqFrcK4J5aliNYlAgmhjDzCba+x8/gL2?=
 =?us-ascii?Q?OrHzVimuR47A/vCL50Shi9m/HWCfWH6SmuVwdCML/Bo1L6ESKuU6yCcP4mln?=
 =?us-ascii?Q?20x3PjIG/5X43F76ZqlX6ieSEENWLTU/zIBf95Ls94lShBLYoDYRY65NhWHj?=
 =?us-ascii?Q?dL0aAxKybFZ9w/uVsp/Zm5EKcVh18xK9Ex5VgVZAt0LeEyF7x2IPZ1d77Pw5?=
 =?us-ascii?Q?edNNDWHOANKLyIPijWbjHuJiY3UGFU/Z3Bsvu8OEoLrPeYj1Ga275Aqn/7yU?=
 =?us-ascii?Q?3uTKsVgEVjhgZdq0ImWVlrVI+p0VZMZmKTJPA0yKuriD3LMwdjLCUw8Fqh0v?=
 =?us-ascii?Q?HDhbWL/uMP4moPFw5JJDrzcWBv0jzc1T2krlftrkZGO6iV3vYKfTK5vqieJw?=
 =?us-ascii?Q?sS39AHgR8iJXMW8HLY2c/DVOo+GO28/6fOV8+EN2340sAhJdNw2voSQ8LGRi?=
 =?us-ascii?Q?u6iLVIqyDc/t8OQfP1k7RzLDUOYETATyXLcS/aCR58t/PU+6OgE4t45IBF8v?=
 =?us-ascii?Q?Bcb8xgB4JMcKWSliXeyezSsBzueDqHr2iQxEtV26uac+UBQ6WPsE1RnRaytS?=
 =?us-ascii?Q?1QmyJdlDS3YvecUHaVJuu18jMjA4OUQayKsay8H0ImazF5MpCwo9ixoAs9mI?=
 =?us-ascii?Q?K30NvZwi/sX6ZK6fbzmpSotK+4l+o+3hAnLtrdSxw/MYEGH1a6jZDzZimbhy?=
 =?us-ascii?Q?bRgUrrrgYwxGtrO5XMSH0r7fs92bvC3tC0E36MfX5aI675vCllD7YGQ76JtM?=
 =?us-ascii?Q?SKiGVJn8pNfMEgO1qBb3QWb05RXuru+/Qq7crqEm4hGpMUu4gSKhzBQPFO5N?=
 =?us-ascii?Q?HOKdomyCvEJMsPnR7+TQlO3tbrF8L/TrRHnlzBDXVFz6+9tsMsq5d1H63WSd?=
 =?us-ascii?Q?6Hn/J9Wpr5aYwma2NcxbQXnHNDXORR2EgiJcS7+GrfZD6v0SwBvuUOJjIVZr?=
 =?us-ascii?Q?SjTtwQR4vBdOm/CZ3QSoTgFgCtRRvacVYuu2w+zESiGa58/OgseT7xV+/Y9w?=
 =?us-ascii?Q?dCst8bnVDW/4CeaoRRVJ0i/QmWijWOqkVcDg0rDnu5nxf9l9zoOToHwC4BaT?=
 =?us-ascii?Q?NIs5XKmZpAbAM4+f3qWcugwlw9Ia790GHD2WYZZ91r2AHY1WShKRfPhtV7J3?=
 =?us-ascii?Q?+hRRM69VMHkNnXlt6h2w3J4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a273a06-692d-4cbb-680e-08db71f430f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 01:09:41.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StH4VLDx3m3mGxRnQ9gdOYCe/o/eMengSt1PhKyxkNJW3R66LKqyKUnm2tL+ou5+E/o9jO8x2rC/jqQilw/ymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
Subject: RE: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, June 20, 2023 6:22 AM
>=20
> On Tue, Jun 20, 2023 at 12:14:16AM +0000, Parav Pandit wrote:
> >
> >
> > > From: virtio-dev@lists.oasis-open.org
> > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > Sent: Monday, June 19, 2023 1:46 PM
> >
> > > These devices have a legacy interface yes?
> > Yes. partially.
> >
> > > So they should be transitional to avoid breaking assumption.
> > >
> > >
> > > But they are not *exactly*
> > > in that they don't have a transitional device ID.
> > >
> > Right. They do not have transitional device ID.
>=20
> I was trying to think whether we need a conformance statement stating so.=
 I
> guess this is up to the device?
> Then let's make it clear. Something like:
> 	For the SR-IOV group type,
> 	the owner device supporting legacy configuration access commands
> 	[assuming this is the term - do we define it somewhere? or just
> 	list the commands]
This term is largely defined as section name currently.

> 	MAY follow the rules for the PCI Device ID, Revision ID
> 	and Subsystem Device ID for the non-transitional devices
> 	documented in
> 	{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>=20
> or do you want to make it a SHOULD?
>
SHOULD seems fine to me as one cannot build PCI VF hw practically with IOBA=
R anyway.
So better to extended above line as,

For the SR-IOV group type, the owner device ... and member device SHOULD fl=
low the rules for...
=20
>=20
> > > At least the device id section needs extra text then to explain this?
> > >
> > We don't modify any of the transitional device attributes.
> > In respective conformance section, it is described what requirements of
> legacy interface to follow.
> > > Or do you just want to make them have transitional ID?
> > Don't want to do that.
> > Non transitional device id with the extension is just fine.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

