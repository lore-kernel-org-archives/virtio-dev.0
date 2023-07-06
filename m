Return-Path: <virtio-dev-return-13287-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0AAEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:28:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4AB1137116
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:28:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A80F98680B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:28:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B2F9983B4A; Thu,  6 Jul 2023 20:28:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 186CC9867EB;
	Thu,  6 Jul 2023 20:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMRZvPPb5vYUMsY9Ny6nycCIQJo5AdPgGnjp0PfQPyxlUwUKWwWvJpUzaipPzknEbaY2pEUcBdnqy9Wr5ak8SWOtZsP6PFUTU22hI9S3LZ+8G6v/uVRy9KHXIAr4b5C0Tc/SaJLxpk1vxkIdA9RvcIqfTMHW54e+oktK/WWCvB9ujn/RTFtEiIUjIPTVM/etDw1/tW20vikg0ULSSOVaMc0y+pq93r+t88KE31q9F1wNCPAiLust/7ZlDYjxoUeCbt7eMMH2uGhZ8lYEelp2ayHBOYgPIisyS8+ErmyLO387+gundimIiukrLUBtsTuHHMThwxufEnTf0R9zXCsUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGmA9qqAlGc32ka6WsP3Qt8+TV1u0Nj1cBIoqbc+lfk=;
 b=BYBgZdDbM0OV0FrNXjlxlUT4KMFq2bCdt4KUtlHbIAGMobeCvZe4p5PnXmLe0pN3xg/HhoP0i65fXImcJh0gUzqHrSjfGuMUa+h8H08vv0k9mM0begztEsFZzi3ylYwJ7Jfc2g42zw8ziG964COmAbRCOW6lYpnSNripB8xNQj/dGmy99YvOhsgRTHwgvT1nvAPfgjxl8C/a57Bn9b90HtLR5hTj56AKQKAnX0n0EskoAsojEFKFOTdctUsgwfRR0GBWo8d2rC8Ri6bzUIlt12rLmCc9UGmx0kMA9S7RcDwiODtFwrQyiW/z1Bpo+/Mnn8Y3tfGUPiPLw6KXwzAWJw==
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
Thread-Topic: [virtio-comment] Re: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+tGNOAgAAAu8CAAA+ggIAABwNQ
Date: Thu, 6 Jul 2023 20:28:42 +0000
Message-ID:
 <PH0PR12MB5481DD8A82A7EADD5E90E872DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <20230706145646-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481071FC01163C48E4CA674DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706154426-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8172:EE_
x-ms-office365-filtering-correlation-id: 96578dff-1903-4732-78f3-08db7e5f96e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 59VE4tkjlJffvBm9fvV8CmxN/BH7FnBcUGOHub+Of/ehmCkwbP2UA4wZMOw7C2/PFGV6dFF+D3PO+WNPFYYovTKu3AFmK7A7o0Dx3JEiqq0mPL2mTprGzGuSzwEDL4B/tU/bbCuNHhaK6g8dhOCc+OCBIYWLzgiau/Fh60VwUMKFlghZmTPrXVXeTpNzlZaGxABjBTeXHZQICoaBVup0Dep0icCHGWlHeZLI+eZ6ycDLum2JFU8Wccw3djt9qkci7wYinPiJNPCufrKJi8RhnbTgEi9ccz+BRWj3ST/Oq+0/aotVc6O89jNMt05AVVGXcS5o1JNnKxcPgDYjFkPDC+seTAfR+YH89XKYZQB1ocWMEk34+xxaaePnLgKQXoKParSJR+o1ZPKaR/txJ5JjVmE7DGbTKoA2H+fIJxxz46BTN8Kzf2pAn3dGYtedJmsXIdXdVhW+ze1BTQUyplHXpfu0VOJOriKL3QE2eT7C9r492yI8NBUMACpSBql6jQCB/ykubWF811pwzy2DhYHHlPO1ErNIhYg3PeOMHQ9gB1Iwb/jBvYKPfNccPljyplMkp5n8hMBiN2TX23LFYdi0UlefhUTExhmVmdbf7g5JWP4F2XToRQhBnx8IWtgo23av
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(33656002)(38100700002)(122000001)(38070700005)(478600001)(64756008)(66446008)(66946007)(66476007)(6916009)(7696005)(66556008)(86362001)(54906003)(316002)(76116006)(4326008)(8936002)(41300700001)(52536014)(107886003)(8676002)(186003)(5660300002)(6506007)(9686003)(2906002)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nNfmAnI4fVUJz0r/UDvGCvK6D1i/MY7/kNGC5DMISNyawgkJX4etwv4/lp1S?=
 =?us-ascii?Q?a9m4PBnrMJb83jahdGPKq3BAWc01i04h04e6+TgrI3P4J51f8el7zNI/hxdv?=
 =?us-ascii?Q?YQD2zJ1uEJed6yFGTZmzGLzeOUBaYaZ2x+ERkm4iHi92o9olA0INTt/pU7ij?=
 =?us-ascii?Q?XtRDS2+TG86uNaJ4lzxm362XcNWq70quxXNg8KMOizDkTkoRUaD40iBKUnYU?=
 =?us-ascii?Q?HEms6QJhcWnJKu/hUewu3XiKQPmnEzIKoYVgK5eb3NaeJJvG6zkR1+QmOmCs?=
 =?us-ascii?Q?dKTmL9DiUVnftzOkSHzJnW12W07CWP63oy+Yw+wRZE7oJfBSkcmsCPFOVKUZ?=
 =?us-ascii?Q?Wgt2P14pCR2biGNfR7+eQTPLXbRGNx9Y7XT1TLbXPkQweP6diy3fveEjLY+E?=
 =?us-ascii?Q?F/tOWIZyV1EQh9+o9tePJwsDqYAXyOOm84KP8KP1lKerg2TCzkneCIRCL4uT?=
 =?us-ascii?Q?UqizJC6StdNq1Rtpw7C+9pPM6T10Wvgxj/vnwk27C5v/Cc05W+Tw3VWCNVfn?=
 =?us-ascii?Q?gJT1sOw7etxd2UY33f3wmCk1NqtFC8xraffc3bxWsvxZiYSGgILUTYUbLyXv?=
 =?us-ascii?Q?Ki+sHKjb3HPfHK7DNohzV1Y2P00s0fQEjfnzrFpoHoa71XW15CKzxbrFQm+L?=
 =?us-ascii?Q?TDXI9FNBfBoFXlmOR9p9+TO1jCaU915LEvsnVJHHOdm8HxuJrZe9wuT93Koj?=
 =?us-ascii?Q?XLH8AlGDutdPv0FtTI7vDQ0xLCCKh9MA6ipbjGaBfLRYfurR3PQ25FLIUUgT?=
 =?us-ascii?Q?bxnlOiZKdNs2yso4Eqo/TdXX4mA/wM+a0SN84AwTG3N5JVrplhaUvH2F3guZ?=
 =?us-ascii?Q?o1AFRoMu5yC78xuh42XiZSDfX997aDB5vdjCNSqtBs62Sq5O2mNH/xlCznnD?=
 =?us-ascii?Q?txg2N7Wdu1YvIYE8TF/zDibMQihH5XVr+nQVSEqW4344dtoZ7H8rQ9eLzuJX?=
 =?us-ascii?Q?vSeO3fEe2ouEfDWNfWyAVJRCfsFnTilcDTND9HQ1cu/ZagO/GW2stoo9UAaQ?=
 =?us-ascii?Q?9h9S1Rgi1lHXAZHi06jb1GkSZeyb1HmcKxFQdzUjTbwVqK4axM4VttUsho2I?=
 =?us-ascii?Q?tj2t+XcIpTXFsaJcXFASVTswg/IiNVZLImRKXH+BETvdXPZlGPrdxJM5836Q?=
 =?us-ascii?Q?BIdxg1YB+uyI1IZfA0BcAExsiVtrJ4/cLU4xjgRECwLNjhV8B2omlMa3BTBg?=
 =?us-ascii?Q?U1T+g0Gd1gXA2K//rwgH0jqnoZK7umBVvHR5wm48QoE43RXdGuitJ+nbYSck?=
 =?us-ascii?Q?+AukDosruZeuqKhbqQ0sL4o7iaxbksdKhmyMsz2Z19cG7itLzXby86cXNoZy?=
 =?us-ascii?Q?EpnryTHFAVswIEWt2qfpue8GOnr0AKVixt06SO6f1YlHMpdrSjJgjptjimzl?=
 =?us-ascii?Q?tUMDlMXrDwCFFQdOYft4wC9f4XokvhN9m85Urzso0CeE99Kp2ZNWsAezZzz0?=
 =?us-ascii?Q?1/IAVhJe21uMwq1/W1aFHPnlMYwA2F/tHO2kDS/wnKJpjZST7HbaFXme3JLV?=
 =?us-ascii?Q?h2s3Ifc4R3hssXg8N6JUpxRt+yXHhDpiLv52BZQnaCUKQSW71F6glxTY/66G?=
 =?us-ascii?Q?Y8FNK/HT2AuCib3jLFtSKkWyd/T+ym5GhQR8JYDBh/hrqwuZtYfeNgWYounl?=
 =?us-ascii?Q?xq2Eh40Ykb8rP8CmjNy9ZOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96578dff-1903-4732-78f3-08db7e5f96e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 20:28:42.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlaDrNUqTM0Eq1Pil/fkD+HX5YRa5G3oYn+U4H87LKHG2eoruxeYawGNW9sYfyU+RQbRW/6LXMLST7JzyiOZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 3:59 PM

> > Hardwaring BAR0 is in BAR area of the VF.
> > But virtio pci capabilities without this can still report bar 0 and vir=
tio
> capabilities.
>=20
> How do they do this?
>
 Device must not do it, but a broken device can report pci capabilities as =
garbage.
I will skip writing about it.

> > Ofcourse, it is a broken device.
> > But skipping this line imply that "because VF BAR0 is hardwired", this
> metadata in pci capability must not expose it.
> >
> > Why not write it extra thing instead of implying it?
> > We already wrote few duplicate things to make reader life easier.
>=20
> If you really want to go ahead, but prefix it with "In consequence" and d=
o not
> start a new paragraph, so reader knows it's not an extra requirement.
>=20
> So I started writing it using correct grammar and spec terminology:
>=20
> 	In consequence, non of the group member devices has BAR0, and
> 	in particular none of the virtio structure capabilities
> 	of a member device has \field{bar} with the value of 0.
>=20
>=20
> However, this actually is kind of wrong (and so is your text).  Not all c=
aps have a
> RO bar value.  virtio_pci_cfg_cap has bar that is RW by driver.  So if we=
 are going
> this route we also need to explain that it's true for all caps except
> virtio_pci_cfg_cap.  And for virtio_pci_cfg_cap driver is not allowed to =
write 0
> there.
>=20
> Frankly too much trouble but if you want to, keep trying.

What I wrote still holds true because device wont have BAR0 and driver writ=
ing there is ignored.
But it is some weird broken device who expose PCI capabilities, so I am goi=
ng to skip writing this.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

