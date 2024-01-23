Return-Path: <virtio-dev-return-14262-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B235AC47258
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 05:55:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1690733583
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 05:55:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F03409867D3
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 05:55:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DCF2F9866D8; Tue, 23 Jan 2024 05:55:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB211986689;
	Tue, 23 Jan 2024 05:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4KMPj1tYoK5mXtbBd/Wj/epUPfnSqug2ONMxIjgbEUprAXqD9fD6TlDrBJkJK7+j0POuhBqABiRA8IhvWwcUsxiKzeL2MVylzpH2PivdJVyZyswCHW5Se3mj+k68YmdnWIOEBFR8dgTnejz4oSUwcg927gmVbxz915GYv3UcHTeu77FcTkav6uoKgmsJZU1a8gANpnIAEs66BydrpI5gIYBjvBs/Otvp9Kh8np7ydC85FvY/NHmrSQ4jODn4tjCxVZqrFFt6Np4N3MP/C/4hcw+DdYAFAOAOc7wM9KHnfczaTOOB7zYdN8wU4CPdFO2NGH3JAveEobeE9pSKXEs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbRDahWLUlBp1sYDZTSURUYiohEmG3+xBoqvysrpQWo=;
 b=mw8k9fX5fgFkz0Gl+MXvJQjZAPb7JPK0RrzFYO2EDyGYp4s6PWHmMtki76cjxQTePfYhl9bv4lFxHw47M+o81LLG4qI7G5dMaBM1RjYWoSCb4XyNSiz8Kl3rPxFb3WCwHCZxhXgUFGNPJtBvtEQOnKQf1A78p3Tb/r7UAmnhBjMMwn6uwXPZ+CWy93o16cA5jkux4vBLGL/MW8FoNHlAyzst4A/CCtb/x1kw0SSOM6ST6hY1RLvOV70IryQuMUTa2lgm0jPOQZrweGBhiVyTnB4VQpDg8mMZWUENFTzLUJsDUszzwTCObS5w5oN/uZNiAgwvaVlYbBeht7NlSqSAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH
 v2] virtio-net: support setting coalescing params for multiple vqs
Thread-Index:
 AQHaR7Oe9QgTrn5GM0iGz2gHNb3tkrDa2d1ggAKYiwCABQnskIACsaqAgAAdlFCAADBngIABdEKA
Date: Tue, 23 Jan 2024 05:55:02 +0000
Message-ID:
 <PH0PR12MB5481AB6AAB87DEDC345B1A0EDC742@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240122022002-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240122022002-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB9122:EE_
x-ms-office365-filtering-correlation-id: 8476438b-6f41-4ed2-6353-08dc1bd7d71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ln4L4J75aU07OcFbUOySoGXUksBRPEGjdeGskP5nBXIowZqVc3nal/FzxLk7JLybGjmZrbvsClqh8Ktm2+3dQEnTBLav2i8uy1HSrrCMr7stNKaCAmvohHkcPedKXhT7uqub74VOjicbkQoVAJuhksVIMqYLYtR718CWKZiTtAn1v5ar+yyIwMEeBjkYaALktpL2glNhFxyHWt77LWHS+WLwF4miZslIWDYJ48SQ+EeoGvpL80JaiP6DlUmgBwdRD7Ykxbe4pZk66bXwbFIMwjbxdNavrwG5t47W1d+0g1GKcp9TnE1HKa91KVSm0AFBfwj0VpDAL8LRvtKEBoslS+vJkS8hLDND4uQJ4TqsgGSNHSdq8xBVDM4ILnaMu1GgJxixO4aY38/d7sA/RSb9RDfzjj8ALFKZJW4m3fL+JQmYT01MWXpTh8D8k7yJvftAXYfOE0OLknjUmdhKPmOJDc7fltPd3MwduPLKwRRf9/m71LeaBMMHrMPcD5ezcBfqBClsrM6za1yXyj1L0fJLVNgMs8a2LDwpyFTw8Png/rf21zMh0ELHRpa9YBbXLrdb/d8MWVKxn7xLeJnDz45oRAD++zP9bpoN3oa9eldoXlvnbG3Age2rADFSdFRWP0Wc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(38070700009)(55016003)(52536014)(64756008)(66446008)(66476007)(54906003)(66556008)(6916009)(66946007)(316002)(76116006)(7696005)(6506007)(5660300002)(33656002)(71200400001)(83380400001)(2906002)(122000001)(8936002)(8676002)(478600001)(4326008)(9686003)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fJtSDSdkNJTH1Lu7Eczxqhz4yqna5aLJi6F1jlEzE26OBaW+V/GuTqWcKBns?=
 =?us-ascii?Q?wc4j7vXiSFZYO0/paf96+DIXlR9FCN9ezyPdhosZS7rgMeTZTE70hUFcUVhy?=
 =?us-ascii?Q?Vq8lWaLRBCSQ1SH/CIWYzNRQcNmTX7ETHMngSuJAZhVNzkYJstDQD3/KAQez?=
 =?us-ascii?Q?WHaxrQEn8G0mbLkqIqere3wDe8HoQd6aJH6v1aRRSYgsyJGYVigAkg9p6s7i?=
 =?us-ascii?Q?pTJ1c9vnwdzuFAhvyMKGmyfSsX/bVQCmzNXzcrTR6JvGADzKhACfYc75vylw?=
 =?us-ascii?Q?b6uDC52yoIuK62f1P2vGc5cglvvZSzEIq5QRtnE0yb/z/yC2BOtPY73p7MfR?=
 =?us-ascii?Q?D7NnE0sr0d0AJzPmHDwd/N35ia8h7ZOtGvvC6Em/HvYyc/OaPO920Nk35B85?=
 =?us-ascii?Q?kB68TcilprEg3WU0+5DA0FNQJWvyUYvy4+nODsfhhwi8ojH/Q/VeJbbBb1Gd?=
 =?us-ascii?Q?fn6nwF29KB9IwHG5nApm5hWVij8veD/WgcC0oyjL9t9jCedm1WYlxNYLu61F?=
 =?us-ascii?Q?mbjSImdCiOj3CupdTYcDvCi4nlbQVpZiMK6BQQjGveVomIt8wqPNIvyVem9O?=
 =?us-ascii?Q?P5gWNozJiMi1VFj2Rdd4ZGLt9aSwIky85MV+zSEVZoDSPGxQu8svycV/FNvH?=
 =?us-ascii?Q?9xhMREJSbHIPZkXCd9YKOR3HdtMZaW9FrHUQlD/Jq9NTHBRXKqAqBoE1fmQ6?=
 =?us-ascii?Q?IbnJarNjWRVmv+++0tEYHnHAey7o6ajChCd/B6oIge5pKI0Cfs38ul+kWlqO?=
 =?us-ascii?Q?jOxA8nNykadYe3u0td2dy/4KSMRwz06fjFIm+UDA59DmFDx+L+52+e3cKMqq?=
 =?us-ascii?Q?tYcqmuajRmv2G6/edBXnh4l/hU52aFZcIs7+TW5cdJb7oPnBkCvEHsFR4a9g?=
 =?us-ascii?Q?/ynApQooh5nDEizyLLoTh2dh9wWDcbBpQlMWpQZD0GBg7Nv16PJF8S8kUmV4?=
 =?us-ascii?Q?u78V5r4EFIJHRNXw0/oqvReG94luGoCck5O0j+3K7FAMatTDwTJz3vt67Wdo?=
 =?us-ascii?Q?vBI4DcBgC101oUqkr70XZ0YH1jEYuiIdOZdWM1fk0V9i8SerHSycj8PRkcEY?=
 =?us-ascii?Q?M/fgLVtlua9S6bxqKkTTD4jxfd+OOK00/suTsmEFwobyGhVVm7U7AEphJe0p?=
 =?us-ascii?Q?skAJlnpHk64n+Vrz0ZXkQoQ5uCb/GAsVHNxD5O3Aus4ngKlMvMJNbqz1aFYk?=
 =?us-ascii?Q?BYoMszhVWgDF3f/yO7D7bS72OJ7l89aRtJ5Mz6aKA9Z+zqqR+5S1O0op4Z0q?=
 =?us-ascii?Q?EhvmF3lDC5zOpw94TaQ3d1sKbfb79uioS2uM1AwU46qpFCW+Mnn9fHYao7ol?=
 =?us-ascii?Q?v7E0gjRMT4V2wff6kntl806phOp10L3OXEjSNrg2FBD5qSugNEnrauEFtkXX?=
 =?us-ascii?Q?E9vyBGZVqEKRcUUU7fVwJkVMxrVUFNHgwQiosGURdk3thYhGBf/2tpxFivAa?=
 =?us-ascii?Q?Lq7OEGrFznb5Z1XlxhCWtH4I86dP2VQYNxxmPQ0YL086nXLdOa495dVKaYAs?=
 =?us-ascii?Q?3mK0J+rwpnF3C1VaQqBvaVgH+urDcxuhYS1Q7b4io3fAB04uOIh3sQ4gv2Rb?=
 =?us-ascii?Q?z3NK59iZzQxCq+rybzY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8476438b-6f41-4ed2-6353-08dc1bd7d71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 05:55:02.0402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzAhLTnKpv1Z9inQ8CVbuFQZusx7/SqIQ83GTBAerA/jEShBaPczFH8Z4dc4Ongt7ccFaGecDjeGUIJQ+xfp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
Subject: [virtio-dev] RE: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH v2]
 virtio-net: support setting coalescing params for multiple vqs

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, January 22, 2024 1:06 PM
>=20
> On Mon, Jan 22, 2024 at 05:03:38AM +0000, Parav Pandit wrote:
> > > >>> The right test on Linux to do without rtnl lock which is anyway
> > > >>> ugly and
> > > >> wrong semantic to use blocking the whole netdev stack.
> > > >>> (in case if you used that).
> > > >> Do you have any good directions and attempts to remove rtnl_lock?
> > > >>
> > > > I think per device lock instead of rtnl is first step that we can s=
tart with.
> > >
> > Wil check internally who if someone already started working on it.
>=20
> I feel the issue is at the conceptual level.=20
Not for requests which are initiated by the kernel stack (non user initiate=
d).

> Yes some drivers will take a command
> and just queue it for execution later, but this means that errors can not=
 be
> propagated back at all. Imagine device with mac
> 0x123 in promisc mode. Now commands:
>=20
> 1- program MAC 0xabcdef
> 2- disable promisc mode
>=20
User initiated commands error can be propagated when the command completes.
Enqueuing command is at the different bottom level in the driver.

> If command 1 fails but 2 proceeds then packets with MAC 0xabc will be
> dropped.
>=20
> Any attempts to batch arbitrary commands will have this issue - be it at =
driver
> or device level.
>=20
There is no suggestion to batch arbitrary commands from the driver side.
The suggestion is to batch VQs notification coalescing from the driver side=
.

> So, here's my question: what exactly is the guest behaviour that is drivi=
ng this
> work? Is it with a linux guest?=20
At least looks to me yes based on the partial patches which are taking rtnl=
 lock on netdim's worker callbacks.

> which commands does userspace issue that we
> need to send multiple vq coalescing commands?
None.

>  If all you want is to send
> same config to all VQs then why not just use
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as opposed to
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET ?
Only kernel stack initiated VQ notification coalescing changes.
Since every VQ has different values, VIRTIO_NET_CTRL_NOTF_COAL_RX_SET is no=
t sufficient.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

