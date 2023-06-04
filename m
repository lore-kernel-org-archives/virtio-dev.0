Return-Path: <virtio-dev-return-12843-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB26AC77B73
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:51:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 195AC44548
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:51:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 113E3986339
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:51:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04CBA9862CE; Sun,  4 Jun 2023 13:51:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E32BC9862D0;
	Sun,  4 Jun 2023 13:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5UmG4+BsEq//rW/nC92aCHLK9drgL2QCpTeRaH4bozXXeOS5R5sev8QJYd8wBRmLDVNfe2KirFwX03G+uPX+tSH42P3aM3N6H+6yaZjo4yCJb8N+JY+6xx5oe+Wux4MBjyFtZTvj74ec6Vcrdzs8ckv9FPbDo8KYbA3xPL3bKncQh9zBXdJBg+Z8kcRrSHeB8myJeWMbR2k+wRYjJcx9R/2Yjpr+Tuo/8VgwlKPDoYZnviGyunWhwoOViC6TbmfQ+ZI7dezSB5z3cFcb+0vzbzY+cvGYyQ90SWTFweMrpK7MdziC4AeBBPH4pYT5z/Tu8dQvYbwlOuDCwwe1GBMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZtKmtZ65BQim37E4BykuoSpY+lHRi14YEfo12ZolpE=;
 b=TLdBLQHszGwLgcfytleX0L8J+pHTr02CLYFQcp9ptZ3tKjPFOI78TWvMkT8wxJlKk0NKdtYDeF1E4ut/brnoq5/EpOQl9lBDIXBZLa1MfInrIwIO3FGXtYpd7X3Mwj6bNZ5TBY5G59QI9jtg1b32GGtvtlAqjYm8oLiFXFJzOSkGjP9c33GshZnBJ12qwm1slj1E08KPmX1EHsZgZ33yP8n0Lak3gcCG6Xr6j1YPy1C0seGsXcMItmq8aUtEl32CG9ncWDrjwch2TrU5zWB2jwDrOHL+si+lDZ5eDQc8hAEwFj+6+3hmjT1hyXi0yEOEb3qZ/j9686TGuWV+putrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ696o/kAgAAGnPA=
Date: Sun, 4 Jun 2023 13:51:20 +0000
Message-ID:
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604091651-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4035:EE_
x-ms-office365-filtering-correlation-id: 880cc6a6-e587-4ddd-84b3-08db6502c6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7z4PcsJV8OjL6Wu8D88u/fviqXbDrwARNB22/B9LM5ToXyt1RSumZDOJVYXZfpxSYG3ts7KfXiPhGnOpNMSD1tjLgyMXTFLRIL7srYj3Os+k2PimKEcA27MsJsKgK8orSh7DdsuSkotKkbUjTYWXUfxWMiiqglNewfR3u2UA4pHEuiTqtTNbRK3h+U4DZNPI2r9xOTGPpDKu6M/SrAV5QlWuFqrtbTmUiaddiyKTSL/+Js+EtWN3OtdAIu7LFTQ/lDl/wMp2Ihkt7MEWGbjXR+r5HdpMIFdlRQCT5SG6epudZsMN1y31SGZS5Q9yV4dnvWrI92N4HnCU731xTSAHtFpTOBdpe8s1Qs2Uv1UMwYCbmvBZwdvRU4kqiO6WGpGP5UVKh4sqtDw7bXizywJ/2jtqaWSgh/HKgIipxpumTgV6MGjGLtCoduC7KnPW8irgfwEoBz8YbjrFqK1nJv+LyVCcKib7FZJ861N+Q8kDH4UcRdJVF6FOgnkghnzs/0DHyBGAc9vN82WrmqQI3mQLeKOpAShJ3+MrvV0hiPduu8nVMaITcLmWzXk/zz1TnMBofn3oTnKo5yar6XUBKGLDvBpPJ6pf1GfbvqATxBXFffDoB4AewG9TFBhmy2n/5I1E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(451199021)(9686003)(26005)(6506007)(316002)(83380400001)(4326008)(6916009)(66556008)(66946007)(66476007)(64756008)(122000001)(76116006)(66446008)(7696005)(107886003)(186003)(38070700005)(478600001)(33656002)(71200400001)(54906003)(2906002)(5660300002)(8936002)(8676002)(55016003)(86362001)(52536014)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aG67AW6DP118H5NH2cSOGgS/Z5UXH4q5QT1REFiV3utlD3lasWhB+7D1AtKL?=
 =?us-ascii?Q?0RgQOFtXa0DtYBjWiDXsUPHMW2yvbiRG7ExrHkE6eCU3pQcKHihhDTdVDeTH?=
 =?us-ascii?Q?8TaIKbT07HH7nIIS+RIgD1FYfzHKjCvvLrB7xYU/2o3k58X+kEltMjztJHd3?=
 =?us-ascii?Q?vZpJLNZtJpT3QIbMq+RTLM4vyYE3dgNLQkFWgHTkoyM+Wq4RRCHA9bBU3Kaq?=
 =?us-ascii?Q?eb9Mb+p1IbDYEmmmkN/m0rMQDd58sv51H5IpNiI0kpQT2FXo26hb5/Sqc21i?=
 =?us-ascii?Q?IB3U35tgdxOox/8PIkQbS2TATi66+C0zJlIcK/aj2qlNiJAORhMDSDVz8Emu?=
 =?us-ascii?Q?IJPsyGE47csVXxUdEda6My+aGtcxd52uKLtEcgC4N5wWqEOOFkAr0zxSgjdc?=
 =?us-ascii?Q?oxMluMX+SW/+8zQqsdLRMtW2XPriiXLfK9qZZWrwuztpj6xC8mfSrelnr4pa?=
 =?us-ascii?Q?LYomZ6+cnUOwBuJjSnkXDVc/pi+VTuC9VGLRl3q4fBKn/lxG26C6i28/vuv3?=
 =?us-ascii?Q?Df0qLz1ppkzNFB2k3pMrg/5qI7SM8rLLPJty7NhQTHv4z6fjCZ1iwQSCcxC9?=
 =?us-ascii?Q?9sSb3/b0SsIGlykP0+6qdp96PRxlYunGQ6OLC2ZRmx6Oke0Lbq2UWuzejVjL?=
 =?us-ascii?Q?JSSGmM4ZsjGpse+NU3dr+5qDWntaFd3QAEtFBcEK6qDxXArUGXgsiUSvhTup?=
 =?us-ascii?Q?SnVew3TfrFWTNanAMlgwEHyHgJLEvD1X+z2A2RWZsnx1yjUxwfi7SiaoRvHc?=
 =?us-ascii?Q?y5nLqNh+NR7bgzAz0HjNJELHJGFxIQ5tO5z2XPkY2oUzjVG9LLvHLfs6Uq+C?=
 =?us-ascii?Q?QtPxV0VZ85cZBcU62GsnwEvVH80xYyfam2n4RMD7gCFpmfDKRxxW+d+1IuIb?=
 =?us-ascii?Q?YSWN6i5mt1haFc6FYtEl6qLY2xtZzKMJJuo1moQbXbb9wWqphxT61HoJuhT2?=
 =?us-ascii?Q?6nJOMeRekY/I1fc/dRcmwEUqXopBTpMAgh/7aX+K9An41M4ewzJaI+NzTF38?=
 =?us-ascii?Q?8uXnmOnViReWq9s0doCqAEbtupJznzeQNCSkP2X1rIP0RGsclyhSMEwm7r5s?=
 =?us-ascii?Q?wZeTbP3rRoJ1F8eRHs1HDbiCVJjHGG3XkW/eMj/XekCr+YlnQ2gaSnlzpFT3?=
 =?us-ascii?Q?C7qGCQqiJfE9PxipquzOk9kx/tt5NHCUNlroh0fOllKtJcvOi8HtFEMfQN3u?=
 =?us-ascii?Q?y+YSzvw4x9dHEcDYLrdLKbdRwkzUvbgLaD1BTopsuzf2tAbuYohuaeXO+3y0?=
 =?us-ascii?Q?FUIaMb6X5dEd/FNqqmPnPEblnKX5UVLA5Ja9qJKUdZdsNlLYHv72n1XSxYAh?=
 =?us-ascii?Q?Khx+ZMwXgBbHS7kjpq9lH2IC2o0ry0MnJWxMWusAOpvAThd7AjzVAgWGNgNE?=
 =?us-ascii?Q?igOjzDz9NWcup7Bl7NrMsMWaK3niKjX+yT46FR9VDkG6KzFqSOfZ9/Gzu1k2?=
 =?us-ascii?Q?GXV/o3wWrF2PnGOZ5KWtRc9MCdJDmDZExdK9yptKLfbY5tOXwuu85XEVOsl8?=
 =?us-ascii?Q?PcYNW46WykwfjzCBHgpwKFz3T8FnaW/vd3ncbOM7oj00ZKN200d/4yPzGnuU?=
 =?us-ascii?Q?R/95wdkQtnFfIQaAPS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880cc6a6-e587-4ddd-84b3-08db6502c6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 13:51:20.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNnqLuEzM66FXLBCWBrCZm/oxBP+Nl0FY7OQXMbxv07VuGdTws/UyAckLfI+EalX9d4dFzivgaNst7T2yKWzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 9:22 AM

> > +The driver that may use the driver notifications region of the VF
> > +device returned in this result likely attain higher performance or
> > +the drier may use the VIRTIO_ADMIN_CMD_LREG_WRITE command.
>=20
> Obtain I guess ... but how? There's no explanation.
>
Do you suggest to rewrite, above as below?

The driver that MAY use the driver notifications region of the VF likely ob=
tain higher performance.
The driver may use VIRTIO_ADMIN_CMD_LCC_REG_WRITE command for doorbell noti=
fications.

> > +\begin{note}
> > +The PCI VF device should not use PCI BAR 0 when it prefers to support
> > +legacy interface registers access using its group owner PF. This
> > +enables hypervisor software to operate with least complexities to
> > +compose a legacy interface I/O space BAR and passthrough other PCI
> > +BARs and PCI device capabilities to the guest virtual machine without =
any
> translation.
> > +\end{note}
>=20
> Is this related to this last command somehow? what does it mean for PCI V=
F
> device to use a BAR? not use a BAR? Prefer what to what?

This is no different than v2, not sure why to discuss this in v3.
But ok.

No. It is not related to last command.
What does a PCI Device use BAR for?
As described in the spec, it uses the BAR in struct virtio_pci_cap for expo=
sing various things.

So it means that PCI VF should use other than PCI BAR 0 for various Virtio =
Structure PCI Capabilities that it exposes.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

