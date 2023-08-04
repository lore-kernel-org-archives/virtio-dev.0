Return-Path: <virtio-dev-return-13465-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710FDC04A6A
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:37:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D601629FCC
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:37:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC776986809
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:37:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1F269843C5; Fri,  4 Aug 2023 06:37:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB8D09866DE;
	Fri,  4 Aug 2023 06:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/IS1Q4YWhGiwzNoSAbPMql6siqTrtry0xZLITs/+K2PGjwZgMgUwgAN6/+BEuEQo25O5KHNgHwZfT+5cGbmUExnv2FXn06jY6WsYNEZkitibsK0aLM0hFgDN0OY/a7Z2fa9VgzaK7njzmVSVibxt4lbJAMVq9eRy36YoNEnSMh45ZmiYKsID8AWyJPi9x35omtCOcPUA+7PUJsGyKCIxYOJsqQ54AudxawzloI62HBclN8mpAZ5YjgmD0zu/GCL7mXL0/KvsLFbV9BXQ7wncpMz8UKTE8RCsqG9nMKgs7pleIAyGF6pztXrVZ7dJ92EAXymePbK2ZrRCpObMlfgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBV8I+/GztGeOWMaMGZo3V+LhAyEQqcvBsXzIcrd7u8=;
 b=TA4O9PDGWjqZSbWyyLY7Z4wfcfAabyLtbqnhj2gFgaknDU3RMQzdhZ9sptF+iM5B4qrwX9B5g+MFv4ZD/Lct4EYkJxNbWfjdjMXo5EzlWbFuTugPLrrxxBmobE0DkWlc2LNkfe3y9Y3va8/SBBAPsD4iBPoV5UqUgUSh5IcabGpBMFBeoqWKM0UA9mGu8Sp/IGedYLVFJ35DreIW8+0sh/TNp2s2ANaC0ZUp97QD0hwL4TsK7Uvew+PhBvd9PoZgJ/E/uyaIWX9g4rVedGmpKlrUZk97jpGiM//NVj7wlj92cUU4t2Iog699meG18OjB/F593uHzZZi19c2H2Ha7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support
 access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAA
Date: Fri, 4 Aug 2023 06:37:37 +0000
Message-ID:
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB8051:EE_
x-ms-office365-filtering-correlation-id: ab9a48a3-7f45-4d66-af40-08db94b54b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I6o/VwxMFvwAtpOJJjXSlq7MNXJBsNTsFrRFtBAZ201H/cTJAa9y9842CjIAzw9PKP45rQD/vgNYantY6fosjK1nXFBhpC4nXpUPBdrlx7PfDwx8qp8Ow2Ptu0uwtvQ5GXx7x160YnlcysjuDUqbQWxBvmk2qRIKeV/5HJKxnyR5Sh6vz7bbiZxM5BDPu911ReD5PP6rmptwt/PtCW+BLkH9m/0PJFRykyvTsnaR/gvo9VSO8AuZV2bNogIGArnZy95j33W06T6HH9391eLj3mFwJrg5Fo1hr7VHIy7L0/YU6NWTGoOf1sIzqpW8aXPuYDF2ux3sEPO8WZZc4YmLvLQAb6LX3hDsvaSEwXef++uFxjkW5P1keFtmPjqNcED8I/7Z+OzD+Ddw8QeejtqnxQmdxXgs7Hf/Xqtt8SceEveQaPSHUMfozYRKyGQxUYrvRYJ88Ull7y2014Nzl5KtnPJYT7fpDoUXqDbETos1gzXYGm5J5KxnwGi2HW+XDiaNO7s1ECqNaS3GAJgHPuVyse33xG3VgXBLfQqAW08hi2Ki11UtFeCK0PTtUUm74ihRA5QhP53PuQ2uyHNikEVRDqMbZRgZ3ntc6HDMp0zU9cDnvYoy3Nz3PvgBXe8IjRcj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(1800799003)(186006)(451199021)(2906002)(52536014)(38070700005)(33656002)(55016003)(83380400001)(26005)(6506007)(86362001)(66476007)(66446008)(64756008)(6916009)(66556008)(66946007)(76116006)(4326008)(38100700002)(316002)(41300700001)(7696005)(9686003)(54906003)(478600001)(122000001)(71200400001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2wXv+oFY04Dt5SzBN1uX2MDVJnzpMsFT+Oj6cEPvPiRLu4xd8u0GmdkSH1HX?=
 =?us-ascii?Q?c76hEg7ieC83DatoVYQQRiv/952/GmSL8pSPKhwqVZZQyFOQeLoKInUyM9kr?=
 =?us-ascii?Q?iHAcZ0O4tkevDRFXQYsXMnMXgrNrTeK4/m/0fNY/KFwcR+Hxq7TmS2DKO5xm?=
 =?us-ascii?Q?DRg40VgbsfIoMDYFs4gAhPYKsE2/1J6CAM6qPlcGP+YaSfKQd0ML65L4wZSg?=
 =?us-ascii?Q?tL7UTWbLeYaG3jDRj+FelAL6JpRuoiV3j5YIWG54hLS5JtlBSKdnJDdDUda0?=
 =?us-ascii?Q?/+bb5LiF8wsXqI11dZO1Mt0+gLUGIZN7gUwaPywq8Rgy1bfkWsFEKFpJtLfJ?=
 =?us-ascii?Q?mkKvj7sfMsYl7rEJsanmvMyLpOhLAfxa4kIQqyoGuDq8efU1tg1PXsxKDov9?=
 =?us-ascii?Q?+yA8yGMjDPykjVlOhk885bPYzf3hGZPjt/Z56fSXXZP6rVFkhV5MtIIe5e/M?=
 =?us-ascii?Q?o8xRBSuyRIgwwvXjd8rXza552wfSMjEn8dIJ5TvHM6AocrGzexMOni5gzseH?=
 =?us-ascii?Q?nFqEQxcUEIaHG9yqqmW3aoY8yZdwRlXB1coWTr61Nvexgd46HujGR48OSpQS?=
 =?us-ascii?Q?hOy22Z4zEHFiuFkUMjpvJSuMvtYQuXkyAED/LcG4ppdrjL999XoRMWHdAUnA?=
 =?us-ascii?Q?PKxMRnRi3vQii7XNWal2eYlxc250s4iBch86JDOpkDQz+ZCXzsAnwp8m+5YX?=
 =?us-ascii?Q?J3cXBmeIGRLsBwgnOJRikHfxPM1xcTqWz+WB6D5VaGEVnC5h74V8zo8nkHMZ?=
 =?us-ascii?Q?pXXFS+OgAq1aqz6OcXexvHyUwUb5UnmQDFsHYD6ppl4f2rAQUmRcSq+DoIzh?=
 =?us-ascii?Q?wOe56pTK3OlinxDziXtu4AW+NuwAXd/dnotGFKf4n8yoFLJsh+M1qiMKUSRt?=
 =?us-ascii?Q?4k9LD8xroT6qRDEl+dHBgWI75xXaKjWzNOq+7nZto/KsNN03O3ElN+MKtlVo?=
 =?us-ascii?Q?gNYWC4Y1CS8VLyVaxSzzkL03P6GFuxygKuXE7Qrdt5B8vCF72JWtjEf205uC?=
 =?us-ascii?Q?CESHX+lMvi4Sr8Ede33vMpbB+8PAUNte2+lhNSrOiXnuwfShdcxSDt6Xm9R+?=
 =?us-ascii?Q?KaTYne9aQcDrglv83P9cwXP2dCGtzHvacv6R3oWT2e6fUcSiaY0oKAj9kNaE?=
 =?us-ascii?Q?jnHOxZVktbbwizXnsqhGBBz1xxDTDdXyPm822CjwHCaWqrNe+hsQP/krlezz?=
 =?us-ascii?Q?hhxZYqdM9mOXYHHSy7IZpLYtE5kfEk52xRYMd4lwjANCUH9bCiI4L+2OIQWo?=
 =?us-ascii?Q?wZCE9YloBwfYaAG6Uc02XwkkUQ9kQ/653a8vFIb81a7ptoi794X2Zy5qtFN0?=
 =?us-ascii?Q?M7QNCwAuC4jiSsmjI9xX4dRSZyweagFIOLL4PfQLORPDqTS4B3RjxZgoELcP?=
 =?us-ascii?Q?5CEE5D3q6qTB1RGUjUcKwsWpznoiISnyQb9ojeNfdf6nmw08N7ezDPmLClva?=
 =?us-ascii?Q?oLYh14UX8weAaD0kcAEzGd5bvCIU3b+ulHDFq7kR3bGRXR24S4Ys2ukOrhae?=
 =?us-ascii?Q?lTTJfD+p17UObXmjlb4tfMfFKRA5Fii9MRJV6CJETvKkUgAc02TpiQFLbpuK?=
 =?us-ascii?Q?GpNtPXKVVsrT81YR1Bc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9a48a3-7f45-4d66-af40-08db94b54b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 06:37:37.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMyXHcTPJqQTzrQjHHLILiE8mPEgL9BLcQkcb5Jx2RvBgcXvgdUTyDixxeFIBBMCFSS8NrXpXIrlfFsRA+lhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
Subject: [virtio-dev] RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support
 access and control the member devices



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Friday, August 4, 2023 11:49 AM

> So, you mean we will have many commands like:
>=20
> VIRTIO_ADMIN_CMD_NET_MAC_SET
> VIRTIO_ADMIN_CMD_NET_MTU_SET
> VIRTIO_ADMIN_CMD_NET_SPEED_SET
> VIRTIO_ADMIN_CMD_BLK_XXX1
> VIRTIO_ADMIN_CMD_BLK_XXX2
> .....
>=20
> Or a generic command with the offset and size of the field of the config =
space?
>
Mix of both. One command per field is too much.
Going forward we may not have single boxed config space as many of the conf=
ig is coming through the cvq logically separate per functionality.

Hence, command should be one per device type, that can set one or more attr=
ibutes of the device.
Attribute may be residing in the config space or otherwise.

VIRTIO_ADMIN_CMD_NET_SET
Input: bitmap (bit per field of config space or otherwise)
Input: field matches to bitmap

VIRTIO_ADMIN_CMD_BLK_SET

> > It should be through the flow filter queue so that it can be performant=
 like nic
> tx/rxq which has dedicated role.
>=20
> Why flow filter queue? I think the cvq is ok.
>
For any sensible use of the switch, beyond few filter commands needs a high=
 perf queue.
=20
> In our case, the ip of the port is configured by the admin on the setup o=
f the
> device.
>=20
> And that is configured to the switch. I think the flow filter is working =
inside the
> deivce.
>=20
I lost you on your last two points in terminology of admin, device etc.

We have
1. owner device
2. member device
3. Switch is typically on a owner device, having switch port for each membe=
r device.

a. Owner device programs switch rules for ports.
b. Owner device also may program flow filter rules of its own for RQ for RS=
S etc.
c. Member device programs follow filter rules of rss and more.

Flow filters are generic framework applies to all 3 use cases.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

