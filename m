Return-Path: <virtio-dev-return-12123-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0FC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:39:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BFB9571CBB
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:39:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF46C9865A6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:39:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9E87998636D; Tue, 11 Apr 2023 13:39:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8965598636E;
	Tue, 11 Apr 2023 13:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNNzMWaImhiThK+G33ARUK19TRWXuenwc3j7ljiQUM4Z0vDZkQp5lMM3FksNXOFAWwMNC1YfrwrRmMbbFC01uiriAp0X4PAHjXKGWrTIBsdGL02kQbLYTvLYEMndlDzdEXIrBmK+4dju0PR6L1GEtGGqlwfnfEilPhk9/yn1ZCtyJl2/740ljYyYuM15RtlpZEFP3r0+/wZo/CrDJ1R+eKwsOBJVLRyezSle3DglU+xaR7HDt8umRcod6rzSdoWWfmB1k0Sgcexy+3HyzvLEuSrOvLdRIXCfyNLaziLfxqHI5Sg9EYQrsg5pm6Z+G9O9CZv6aT0S1H8d60A7ob/DPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSIY3HKlPGALlX8m3kCMs5rrzI5vuXSHf6e6WcbTeLY=;
 b=hDxYEWgHijE50H7WQLbUWVI0bDiwnAWhY+gAm7SKwl6vXI6dCTHBB+lh++Nvol9R2EKbYYqKyEc8u7n6UXMCTNcxu6m7u1blGqU/9I9B1ojIrQaUm4nigzvjvxvZxsNZgkMtEiNQlRsf1J1S4T9aNh+2dBDJ9pANfXZv3nmKyqWIZVEiSmNDX0W6hf5bOog3/fID4CNuz2asZWr7vH8kakrqh7DUjOi/ZueGnjgpODqHofVbo6qVd5UBvfW8fbaqUUauyn+GIDUC9IYTI4RJrC/+whSREnp9LKEE8jtieI3IEHGX7D+WAm8FoSiA8QG95hKZfwBHydd5wq3ZxUkmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v11 04/10] admin: introduce virtio admin virtqueues
Thread-Index: AQHZZj13Sh975GzMPkylhblJLNg33q8eCnyAgAaIG4CAAA69IIAAYYiAgAEltvA=
Date: Tue, 11 Apr 2023 13:39:32 +0000
Message-ID:
 <PH0PR12MB5481E78E40F84BBF68687F7ADC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
 <20230410092104-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410160357-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410160357-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5199:EE_
x-ms-office365-filtering-correlation-id: ed9e0d51-8140-4742-206a-08db3a922e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c6qrKmKi6wuGuBM+oNUt2pI6JZypORF5/i6VewKKliakarCiKMpSQM/B+SMw7yukyNuaIR6p3Xs2G2uM4QPTTY9fc/+QI3EPv1NyhET55gL8ngSIa7vQQxlc1TNi3OwwbwwQG9QBEzoNErn8vQbErBHNC+lLEnmeCqFJnfx0C+R6JspzJhIpTgBYXlVfOR2VBViQ2U67egx3gAFHGQdhT1uDHlnYx5iCPH6C/VOCIeESrgHAqm/668plseN+JcD+m5JytFtv/jHqFTDlMcxIoa8Vg7ma2r8wulRY9O2hbrkVPTWTbhTe7GT/psZ+JQG4W+MFcAJpB52+DukDV/H0wTuUTGTvMwhNVuC19VVFzb63+0z7hWGJ31NLb/53jw9NFDctScAFgMF5beDocPL6EYpQwO6ZWfbyDzvQ77oTqizcn8yHdHqa4/RRx2VdgnBk3BvZxetkJxDMfSWmhngZTurpdSmYqCKwFYh/JNnOgKGS/FOiIUk91I9ufjIE3aXKT3d60Gdt0WbSrS5LEuH+gNU/+eeUThhXmi9n6Qyh254e1LBDuUpFrgb9NJ6NqS1YPscVtrkxl5xu+jMSj8VP0kW16Pnfn6+IFzam6+Xbpq6vta+QyNbAT1rCCvao1KuE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(9686003)(6506007)(186003)(54906003)(4744005)(2906002)(5660300002)(4326008)(66946007)(76116006)(7416002)(107886003)(66446008)(41300700001)(8676002)(6916009)(66476007)(64756008)(52536014)(8936002)(66556008)(122000001)(86362001)(83380400001)(55016003)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pkrsd0AM5esrSAI5Q8d/2Cxjv3GcABX8u3XiF8XM8jFUtqnaPCva9N3zA9+1?=
 =?us-ascii?Q?gnxtxLapurIYPETkK4UqMZLg4bP2x1LFS90D9XQ95boKqu1Lbl6APBzTa7p8?=
 =?us-ascii?Q?0i7BJvtxwJaXi6kSnDT30gyHI9Ymbu+QMfvhuO+9csIMgs6zWkU0gxt10lFu?=
 =?us-ascii?Q?rWu7zho92aU344RIhsIDuXhdLQLVYFmgiPU3XmLmlkN9jsVNzfjFMaSJ7oTo?=
 =?us-ascii?Q?9XDRh4V/1SY8VImNNmjty8hDLZ0luMk0FFp99PHnSqUsQ89s6Ev+qw/NZ6HQ?=
 =?us-ascii?Q?4WOs6YIRQfq6ptC6X9jWNpES7E6CglBJ/90MdHXmPLsOyyd1miBIOy+/hcrM?=
 =?us-ascii?Q?amWhMaXizQ/16ToQRs8NoUEmueIYa4XjKKYK6Y8v9y5VG+3B1CgOj38gkCx1?=
 =?us-ascii?Q?XFKjZhXmNwoY9jCUFhlnF7BS6n5iP6rf2wYEpyQAbZZcCqY7OZOJIeUPUrFC?=
 =?us-ascii?Q?Uu6hxxhA7rtDrTp5PtAdVtHL7jL9mcFrVav43KpxkYeXI/EneoWtK5AbE9Pu?=
 =?us-ascii?Q?TuMaJxlX+zMXt+aDd890HMInlngjPcAYA/TxP4y2Nik0B/AXtR5xEkvEvq0I?=
 =?us-ascii?Q?oTWshNSZ6Mn3JV0AMDqx6f0QzoLCA2Yc/4xpmJR1NRh0EFOhXx+6GToR+OuN?=
 =?us-ascii?Q?fwXUoYVfNlBq3+9IWhCV/9K7nGiAwCOHew6oFB9KxMAdCZ6jr3vKTiJaXjH+?=
 =?us-ascii?Q?HvJLOlahQOe7uD7Sn25bMEqarwbVWqpoMAF+/YSnjqptgojPX2dZZXvUDtqX?=
 =?us-ascii?Q?4zbyCnp5QXaDIg8OwEppBxNS1Qt8dzxRh6uiNGyvmrTb9zzVYUvUqqkLQTQO?=
 =?us-ascii?Q?U6YlGcRiETZ9kynpGm87IfuchvGKYzP8baN18L/OWR8JG7wgO7kVajnOyzGD?=
 =?us-ascii?Q?libxIJ8OXR2KFnd29OYbh07c/fl+ihh5hlDVWaINHTVUtXg3sOnZwaPF62gj?=
 =?us-ascii?Q?gyVd+u9F6nGBNYnYdgYMF8Lsknxd4u/fjWx1blGu+zQMUdFzUKHL5M/irxOu?=
 =?us-ascii?Q?h7lNNFNDWjz4rxt0U0C3M0ls9388F3IQsZa6AjqIeN5Qmv9uKDYGKlneVYPj?=
 =?us-ascii?Q?v/5CzRz2SMC2lEcDEqfow83zEaH4u2dqgkGyjoQTBoj+jrxFwnhll0WoptGV?=
 =?us-ascii?Q?+ZWkmpEw1Z6SAT/rhC1elUoA3jEXyWWAX12aH+vcPRs+4OCOlKGakcA2URMy?=
 =?us-ascii?Q?jlX3q0oPSA/+c8xXeBdTPDt1vmzZV78eQUSxPKAuAkZHJzNqI/Le8laZaRIH?=
 =?us-ascii?Q?7LDpMrHbxEPKFaP6zWcwoyFD1yKz4zDVbE43OHiioXEB4kIms6zzn5AN5gOm?=
 =?us-ascii?Q?1ilOGABDP6cY/DLgIoaYey+hJudg9+iZaAVC5S7pK2ywxT9Z4VDgN8FYe8m3?=
 =?us-ascii?Q?xaHsQW/cMJH3klDBmVwLE6ks9QKQaLXR8iBaf7KIyCu+bEQh2CSZpANKgfPW?=
 =?us-ascii?Q?8ayjoeET4LPqpTvUMuDka2ZhTpl0hPNQ9D6hOW/ikBlaXzMlzji8BzUAC1lB?=
 =?us-ascii?Q?Xn2F9VLr5BkkfzIfmLtURMYkOeXiR/a7e5VoO9HPCfXW5ziSKPCp8PTIv1k8?=
 =?us-ascii?Q?d3YuQ/DU7qIeluiBZxhFeRmfgO7H9M34PRjnwIg/kujiB9sg+qEoV+2qWtFR?=
 =?us-ascii?Q?BmBlP73BUEBZ7WLGkSsZrnI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9e0d51-8140-4742-206a-08db3a922e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:39:32.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXhSKLWh2TS8VO+Qjmug+1RXy1qExDl/YOzyHKKFPoMadRGrpA7Mdkw+Ln6opymXLVW2QO7QJ4PepzEgHjtdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
Subject: [virtio-dev] RE: [PATCH v11 04/10] admin: introduce virtio admin virtqueues

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 10, 2023 4:05 PM
> > >
> > With my limited knowledge, when written for third person doing the addi=
ng
> entries to the queue, "enqueue" is suitable.
>=20
> Look it up in a dictionary.

Queue is verb and noun both.
As opposed to that enqueue is not ambiguous being only verb.

When "driver queues" is read, it needs tiny more efforts to realize that qu=
eues here is verb and not plural driver queues.

So, without strong opinion, enqueue is preferred but it's up to you.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

