Return-Path: <virtio-dev-return-11568-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A9C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:36:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2368E3250
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:36:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D76D9867BB
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:36:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 12E0B9866F4; Thu,  9 Mar 2023 12:36:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0F6F986700;
	Thu,  9 Mar 2023 12:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKupvhGXvYQ7IPF+xyMSjoPdAYjdfm4jJvn1RuDn/TD7HuOheJJXXa1/jcOvq+mqz3HfbNzDxNAxCta/UrRUX/CCuuHnpXVM/SsHWNfnIAJWPhUqPpbRQzTsCdjXIGjyLzuNVzkS+WsO70FX+Ommh/IRSp6PN8QRd4i/heHwnJQ/0gNaRcMJoIstvLusO1q1AAnjL+LsiLmZSfEpo5hR96IJ1mmHJ20GmFKMnM0fmF6eux/Nq4FWs0QuUfS0iIKBrXkEj5/mT5/cPQMR77sWCbmzUnGz/OrAFYtBgZ3+k8UUzLZev+nNXbAPBSk68tIcbQUvkvVEAENIIaKGpDPXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+ty3xqqtxUwzD98qmze0CJK/DhoqpHccCCPpDCmH8=;
 b=aAASqqDo8wV0llqixl1zynQQZHYrFAMPnPmZ9/upWuVmsFZpWRdtzxUDHxCBSmfJ/cC8OqPqsQW//q/bmYOz9HH3FLbb3QIsQPaIoTGHJrkBFEK+bPdRTDenIXOdUKpbZl8pfAp48AAywDGrdsK3M/hZAxkjazZ93a6voX7jRnvHeV2AcLcAkcgAkywLbxASlcOHLvLJ94mksYFyATfor5swfTuZGL2W1ug6p1Yh2qnZhmp/XsjbfQ+uPsjQuAYlMPQ/R2g6quQfarp/st/Mv7pCFs+qiIAOVTlmQUsU0tkptnscQ5IMz8SkKd+SXBHGOvSHrxbbVrlM/mqcX4ZrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index: AQHZUaV1hq+swD5r7EeFCHM9rP6wha7xaNIQgACnzoCAAFMaYA==
Date: Thu, 9 Mar 2023 12:36:00 +0000
Message-ID:
 <PH0PR12MB5481450730C442429F3D98C7DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho> <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho> <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <PH0PR12MB5481E320D33B4594F050B3C8DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmMp3W4CwL9xpD2@nanopsycho>
In-Reply-To: <ZAmMp3W4CwL9xpD2@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6522:EE_
x-ms-office365-filtering-correlation-id: 1bf6717a-36f2-4bd3-8a06-08db209ad6f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BITJO3gq9zSWBCztYEGFewhZd0dV8F1mXDQr8Az4ddltL5ZMp81qVqpxEJ3bjLZumTklCLY9gSdfEKlViBpVQJmyI4F5Oq9Q1Gv4thI8q6hWvkitjf7bDlXNBx3Qqz7uhq+8IBKKXbUSOusWBqTwATrmLDrDnJ2gfD0nTQWEiHY7Z4WiRlrEe85E7dxXQ+Z2k1VOOBICKiPFU7A/Wl3xJdKJ8eQ+++MZ48JCN4mEtX6ViEFXSpKAbmTlecZIXa4deesisXTPmIAx6lJw97rCbMe0ggcSaGTg+YcEEPOXrDn9KCy1qsrRcvmvREo025On0Z0SJyWzpGd9nRTd3QC561oAAiiMAJXJekuzM/akrQJqJXOHigiJ41rfTiTdPGDqnc0oDSprTr/6YquEs0YqiFH+aHtUpR5Fw8Svf4IQyEMv/I5nZmtnaAgFqjLT1KTeRtQ3pBzYs5BfVusIoz44iTHeH1Ok3MPb2E9thb/ivbQL5y3kiyk1nI/8I1lEdG+hUL2qb8VB+zaYKNPbWtxnkHF2HfkOi36de0LYKNJKO4ftjW/vOwrPeDIIAhefNVjxQdP3fMyQhg34cXXFLN4CEFr8NSgGEROG1aZm242Kjtt4KfYdPQNTXQvk25rZecJ8MHQ1MHm3b8itfJ9xSGnnK1+XiYKp8ABzbSiYI86nATEiJjtRoNxVVlLWkSrumlapZH2l3tku97wyHEZIMeYccg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199018)(66476007)(41300700001)(64756008)(66556008)(66446008)(122000001)(76116006)(66946007)(4326008)(8676002)(316002)(6862004)(52536014)(54906003)(6636002)(38100700002)(8936002)(5660300002)(7416002)(478600001)(2906002)(55016003)(86362001)(71200400001)(7696005)(33656002)(6506007)(107886003)(38070700005)(83380400001)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rcCR0FpeCytUYyRQHWMmvKU04PuzzoJ3gwiQ/NwKa/0PMx4ZZKSSXVIlZuHj?=
 =?us-ascii?Q?iQdCHjGD1iPvsM4iwe5/10XPX+PzmjRxaNg1TIsQc8JmbCzxQvGqNgUZ9I3q?=
 =?us-ascii?Q?miaEm15d4GJFXiuC5XU12xh+P98fFRRpK68L/EyhUPWD8vese9AwPb85bDb0?=
 =?us-ascii?Q?gx7vV7jqkR9IfDlo6yIdYLlJY2h3zTI7x4wCi8mZah+tryvFXLYa7QwimLam?=
 =?us-ascii?Q?uq1Nd1Whoq3xHDiao9ImD+hd5g4s6xHmRKZVFrQY2zs3FIJCMtIVh8cYWAFz?=
 =?us-ascii?Q?oLvngBgzr+K/TMg5toSiHXGiqDlxTl6PpWMiJ2MK9ugI/jkXhGrTNWFMZX8+?=
 =?us-ascii?Q?+2+jQ/ZzHM/nOcBSRFJeO3AL4XvCLf7oS8OO+BW+XyZt+eoCXGZr/aGOg3R0?=
 =?us-ascii?Q?RL5pG6HN98pfqX7bywUGB6l/PE6H9a/x0sG56WYTT92dbn0cI/QSYrJtPh5A?=
 =?us-ascii?Q?lDytCQAYTQbQvfhxtv9ndKTJi+smi5gmMORt0UK1TF8UO8dw/u4uodM6IePY?=
 =?us-ascii?Q?2riv67uuK3A8g7k9tEioN1UU2ELobNNtl1dzvpCQjOhb1BtEfcv/KyoXyMDb?=
 =?us-ascii?Q?blhm2YwSHybkmLAgsUlHvRwoBN7znsH7h5oBV6mysZ0iEHDQgaF9rwvtl6LM?=
 =?us-ascii?Q?ZLjh5qhpDqel5XiPLgS/kEMF9be0BHYUFI7gB1nZagBAEqJ+udu3dew/hmFL?=
 =?us-ascii?Q?Lo9STA09l91pf/M/c3prBMm0OT4V/z5Yz/KlLT48m+Jy92KjH1Efx9sPjbcX?=
 =?us-ascii?Q?K9hm7WHGV+6d0svWeH7s5FBo+dCFCbDvCyIKNaJfyM20wSAbgvy+YNOfHbwf?=
 =?us-ascii?Q?SOtrNCbcvLdXq8hj5u0ii9wcb4qrJWoM/gAfz37M+fnY452z4qPLCU0ZAT4Z?=
 =?us-ascii?Q?ys2ySnHM8A77gfRj6MTtuk9gM/2myvPmThKIajYJT6Z8CMTlXpMZtqgVOnnq?=
 =?us-ascii?Q?tw3GwjIje9sqJnHobZ2a5yQ8+StxziSyHZWS8EwE+XNCuoNUXu0G6FDI0dox?=
 =?us-ascii?Q?MRkrVamcmWXTt4/fG8iKAahSJY1cKZFKuIGvyQNZ3AkDEtTaXJLp1JVsE3S7?=
 =?us-ascii?Q?8cGI4auheGJDrurdJX+337NKYAgewlbkYN7L88wzqTc0/YCYfl4HPHnTPc4h?=
 =?us-ascii?Q?SoI+cZiAaX/AproeNH7SjPutTWDozYkI2FCepJzDVLUmkzddp2rHh1XGiZ5F?=
 =?us-ascii?Q?aou9+3m9DRRMo/DrJr8/U71aGc30cj4+cs8w7PeQW2P1D4duEeR0qddGAM32?=
 =?us-ascii?Q?4FaeVAWPK4ZFT/6qUcsl098kx9/dShKHymUNsO3S82zLhiOZn1ZPDeIzSobm?=
 =?us-ascii?Q?TRZdoBAKXNtP6QCnwnckLaOXfam+sv/4FBX8/ovZEg1gQ/l++EUHemhZsJxv?=
 =?us-ascii?Q?yB0lxDMvrhd8NK9t2G/xqBNb9J9FlAsd8TGhTyJQFrkoYElr+NaLXsjdYM9R?=
 =?us-ascii?Q?D/lUb9aOOPo63Er7NecP1jlq6u14YIwKOIz6w+sWoomYCcMaQskAN69I7WZf?=
 =?us-ascii?Q?Np6MLVD1JeB2/gh7+YtlxUj0qATcVSpPgGUOMSho5sR0BNChcjSJnmo0SfA5?=
 =?us-ascii?Q?/iW6+USA7LoWp9rx5bBWDYX8ULUd1yMroGlTs4/AEhkKGmB1fV1xBYUNcTws?=
 =?us-ascii?Q?2DI0cIQ503ZG9SGAT2qfNiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf6717a-36f2-4bd3-8a06-08db209ad6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 12:36:00.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvBXhXJcoJIHldNfVOYm0jeIhN4qAMgll2jVQr/08NKKX17Bu5EfuUz3r0PsgbAz2xublINaypAlLHRIAfMKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues



> From: Jiri Pirko <jiri@nvidia.com>
> Sent: Thursday, March 9, 2023 2:37 AM


> >We want the ability to program/provision the virtio feature bits and vir=
tio
> config space parameters of the VF through PF.
> >These are host-facing parameters that usually migrate from one to anothe=
r
> host when a VF migrates.
>=20
> Here is where we lack to have separate "devlink function" entity, indepen=
dend
> of "devlink port" :/ I mean, for MAC config and irq vectors.
> What other host facing parmeters you have in mind. VLAN of "ip vf" is
> definitelly one of them, I have to emphasize.
>=20
It is not.

Virtio feature bits defined by the virtio spec.
Virtio config space fields present in the each virtio device specific spec.

>=20
> >

> >virtio net doesn't implement it either and I don't see any user asking f=
or it
> either.
> >All users have migrated to using tc mechanism for long time now.
>=20
> Okay, so the bottom line is, we should take care of host facing config of=
 VF, but
> we should not care about network plug of VF - that stays out of the scope=
.
Right.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

