Return-Path: <virtio-dev-return-12900-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDEBC7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:00:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ECA4944347
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:00:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5313986692
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:00:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DA107986681; Thu,  8 Jun 2023 19:00:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1B00986682;
	Thu,  8 Jun 2023 19:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmFcpqRast0Vu0O3fFOGjI5cy8R4hkks71RaIib9TY36qan+91hDiyKIzbJAucBKcjwLutsiSviSzVVLTexd9EJPHZ0FkTpbBxjtrtU8/44QsO+2bh4B3QPDKx5lJPZzknAO9ycULBlliBJXeVivwWuGQkmQzD+WxhgEB6yk8RUUR5/ULnuNelPox7RNhGKtvosVn9f+ePcmsLl0Hjj26BgD9IaFilAE26PAIauFg1u/1kAJLXJHxS48/Ja3OIPJJ6QQq4lvnHykqKtyalPlYAYnqwHE0pX4Uu7++N384MbSL6uByE7QPkv04DfOaDRKZny0MQg1C0VHR+H7Nq+GSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SoUfS0G8cNoO8zOeH2nUKydpGmwCKItY223sf8xdHM=;
 b=PPcGrMieZ8Tcdt1Luvrtj6JBpJgF2a/7+Dr3slkoMjiKdrJn09cJjHeAQ+ELHqbUA6xbRHqDR4/lpplCrhZkpAEA9vrtO3+C0HiU+3p8lZzMjQzGmODm24qMJS3q7HAgwORlzKRU5f5BGRddGv3Cakk41xfF4iarSF4r+OJ0+luW+iVhQ/t+n7z6cwX3u1m77yoOLJkmiBVKoLvAsSHp8ie652lj0/kaYflv7S+wSbkEYicIiPMK/XOHRVcwVaj9UD+TlqIPiJwtG5x8WlmXt0sl2rpgugqwtlDZyrtmHzfzdUz34PHieaMj7GBs8T+iX+yBR5XL03fgbp2DiWkaZQ==
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
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAAwqAgAAAcVCAAAT9gIAAAt+QgAA3HYCAAAbroA==
Date: Thu, 8 Jun 2023 19:00:32 +0000
Message-ID:
 <PH0PR12MB548124D3E867D25B5DB65610DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608105640-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608142527-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608142527-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV3PR12MB9235:EE_
x-ms-office365-filtering-correlation-id: c06f24da-a5c0-4e43-8d07-08db6852a22e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O56VIbU4Fb8HNS1MOjByxckxwM3FAYle8z0o8tujFgT83oHsA3noT9WlK4YjGw0JuJ4yc18zgLNs7RZ3zSd28VF/y1hJT+qx5tmaktIB35Mz3taLtlsCAXnPXSrBiE46T8jKvJUFNR+fu4oFQSUHazchy2d6CLkhyIkhACjJ5PO/vZyisayo0n9HjyDnCq81DXuSLE06JCe4qlUqYSykE+FBpkQZSDBTkNlVKrd0LgodLypHxe04GGdZNijgSNbCW2Up4zyDiiXgWQ6HxcOwvwXvU5VBjFJ77kF2IRbkRtK8MMh/sA0HCgpaYB4CWOHR+MqbkmjDYQSiD915ilrn9fMWj8hDNGpctEQw2YmfVnBmOWynW6RwmrpHmmrXfe+Et8+VjrxZZ/mv2q0zfMt9YPP/tpKXJX6MRXHzNWOCZaiHN44Zv+YWgVziHW66cGW+oYa7/rFKSzJNXiVwxIrAARcFnYRwzWnNr1/WIFrxBl8b3eoiuPiZcKfucKjkHzKcPyt1hV9DaYxAaNx7dt0e/g8bJ26Y0RvEdRRcvXxYbjOdjYNe3f0wkBkijpXDKldJJlmBlVQZQwiJWs8RWNccTYcoEE+LACy6ErBwVVSdIARF2Hoy+hGXJlVxKGWdi4R6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(2906002)(38070700005)(7696005)(71200400001)(9686003)(26005)(55016003)(107886003)(83380400001)(6506007)(33656002)(86362001)(186003)(38100700002)(122000001)(54906003)(5660300002)(52536014)(478600001)(316002)(41300700001)(4326008)(8936002)(66476007)(76116006)(64756008)(6916009)(8676002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vq+q1FMXn9/mDGkSy2GdCzdHFhQ7tBI/gdmBDgpZSBCyMayo23gvJP+6Pa3u?=
 =?us-ascii?Q?dKDmrW76tnX7Um8cxXlGOJIW/P6x3opLLkp18kVXC+WSxWmItphjFEaAuiod?=
 =?us-ascii?Q?KMyrRR1m9o39WvxTaMwWNqWEZbuiCzRdfngLw/M8sXMB4h5viAxdbfjA+Iam?=
 =?us-ascii?Q?netQk1M26rMTcWSOnCq0fmYjXs7lU32JURrjaTU0bcGFcqF674te32JNYpfQ?=
 =?us-ascii?Q?3poLU3bQNsfGsBeS6H/EB5No22SweiOWnurKIOFvIAQIJmOqlcPNEq9RSJBr?=
 =?us-ascii?Q?YCOXVj4j9dhDOMuVKMST85DZUOlxBF1L1BprDIPHZUEm0j26G5T4CqJg6dwZ?=
 =?us-ascii?Q?EO9txjWH2Qg4LDgwoOJc3B6DDKJCeGh2WjlEtQULHfWDdv3pNNCtq07Lri2D?=
 =?us-ascii?Q?WMF/cOpBY9IG0ZcmkzvIQTXkFOMmJO0sAQdSYSZV1mCDEk2U/fwYryuADC3L?=
 =?us-ascii?Q?kNc7OIRWkzoYIl3XBylduadrWmW0vsMgJXmayedXVjDXFTD74/MVjVIDXcCF?=
 =?us-ascii?Q?j9d1I+GXbuR9ZT2GhVHSnHlWKb2W0tU1dzAijO8XPC+KHEawppzvfoxYksvL?=
 =?us-ascii?Q?ZxE6RePeOB4arTLlF26KPJ28Fz4I580MEPftFJnFk1Tg1I3aH2+oysL2U/Oo?=
 =?us-ascii?Q?Txhx+e13KJBEm0sdAvcHp5DqCJEwmQt9CyejtgUBqU1C52loSg38hEEYKF8p?=
 =?us-ascii?Q?XE1EH6F7gRoXJjKwCFmmvV/1LJpHUWrCmeR8oNDcd1Xvgt3iSR4K1iT3bYZg?=
 =?us-ascii?Q?BBIKAtvGDBRaV3TBJ5XjEUoZJTuQrW4FXjmAyeAcEnI8u1FZLUea0+zTK9C/?=
 =?us-ascii?Q?6vcmscVF/DUDgpJkuwKL68FuMtZTz3ZucIvdBoJ4vMxTlBLik5iJ6pcRLOYy?=
 =?us-ascii?Q?DMoi764s7vFLNmkqeSRmRcbdwkZVcCzexWhj8Knlbj9077pJEy55FuI/9qhs?=
 =?us-ascii?Q?DCK01R9y3eVCchx2mABL7GA0/hkuv4lhn+mRst9Az8Yej6yvDK5ITaG8OzpL?=
 =?us-ascii?Q?GHqtWW1XRndIyC/S6JHZaq/m1I6b2L0ZMbx4AWl+wyl/+VGVb8HWDsFkZ3l7?=
 =?us-ascii?Q?EiTDhjeaT6OM8IWzIdQ5wcoZrntj9OgFYS0t7cry+1nlfwR7L0SHM1EwA/UW?=
 =?us-ascii?Q?Pt4wr3xKPZy0X+aIR6sSGG74GtbSTRnOX6s4z7Q/ja7zEehON9IE72/iWiBl?=
 =?us-ascii?Q?0N81YGPLsiRy2te3dl0ycXfloKGAUI9YevMpQVHsL4nlCIrScT7FVfP128kv?=
 =?us-ascii?Q?0uCY9qaJPJNb/QwiG/ZZsYgRu7LH0vixGgt6c4VrJFaAyaAzD0TmLd5COTAG?=
 =?us-ascii?Q?989t3QoiRyKOvXuxAGYeclbiCOG3qCA0j7Y9iaT35EMqcF4u0bUvmsm/tt0m?=
 =?us-ascii?Q?W0WgT+lMo1aNPXibD+veldID0PAtqouTBmecn9hMnqDpfiG7b/WK7fa6Xopn?=
 =?us-ascii?Q?n+R9GPBGzMCfKTi1VEZQgveGSCxCEKwHhHwb2n+TWOaaQCcMrP4VUR08M89E?=
 =?us-ascii?Q?QdIyN6Q0oTtRMHP7oha6R6DtvIBOx/FTOaGo1Pq+uHWUVi9CbCayOfRRu7XF?=
 =?us-ascii?Q?WyJketa+0ozBSKOqIVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06f24da-a5c0-4e43-8d07-08db6852a22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 19:00:32.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyUpWtOQlz3onho0NDWlMAUtm8S+MgFYMc7ytjKiLa26+lO1KiX8gLpbOfBwPF+S5tCS3P4kg0uNvgnH1YjQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 2:31 PM

> > > I'll do a proper review after the forum. Generally lots of small
> > > things. Went looking just to give you a couple of
> > > examples:
> > > 	  too many mentions of VFs and PFs.
> > > 	  text should talk about owner and member. Minimise
> > > 	  mention of VFs to make it easier to extend to
> > > 	  different group types.
> > >
> > True but most additions are in PCI transport chapter.
> > But will change to member and owner.
>=20
> Another thing that bothers me is that it references admin commands that a=
re
> defined later in the spec. I don't like it that we are making the reader =
jump back
> and forth ...
> Maybe it's better to put this in the admin command chapter.
>=20
I considered that before.
In its current form, there is very less back-n-forth jump.
This is because admin chapter mostly enumerates the opcode.

And PCI legacy chapter talks about rest of the theory and command details.

When/if we have more transports for this, probably a generic place will be =
suitable.

Moving now to admin will surely have more back-n-forth as it needs to talk =
about PCI part and that PCI part will reside in PCI section.

> > > another example:
> > > 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to
> > > support
> > >
> > > VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.
> > >
> > Yes, it is exposed by PF, the wording of "PCI VF device exposing" is no=
t right.
> > I will reword it.
>=20
> So here's an example wording, I don't insist on it exactly but the point =
is to show
> how we should use spec terminology whereever
> possible:
>=20
> If an owner of an SRIOV group supports all of
> VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
> VIRTIO_ADMIN_CMD_LCC_REG_READ .... then it SHOULD NOT expose VF BAR0
> (of non 0 size) as part of its SRIOV capability; this is to facilitate em=
ulating IO
> BAR0 for the legacy interface in software.
>=20
Yes good one. Will use.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

