Return-Path: <virtio-dev-return-13270-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B9AEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:54:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D649C8DEE
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:54:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49EA2986826
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:54:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 382F0986728; Thu,  6 Jul 2023 16:54:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24CC4986729;
	Thu,  6 Jul 2023 16:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD4tdh9YShU5q0TFb00lbKtQUa+fkfwxpsTEYQc/rLNn+SJiFK26buei7q+rloGaJMaXcsY//5OoGT/AYgFLPFXStfcs9buW4XJ8gSU57oalQJrCgOf+gtghgzM0hN5gyIwR3IL0vHdGWUisaruYSz7eRqa0E1C+Em531kMhRXe67fbjhAQgiiUY0IBMCE+poF057YLtCLvU0C859LE/2Qag5mUgipIGWbhkSv/Gm8DW8zdahpH7msRo8TMv/MuNyaNttRlqVM0gFE5Z3nPQHfEi7ujkHvMZ8PFfx//DST5FGVEE77e1obHRF7NvA7mivT2/vc/h+Rv0x6iiDD1m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNVnJNkDNLLfGJDu+Gv2dtnkM5gUncsp0VXCbfRqdtw=;
 b=CZ/k4ylciQfOvfvA+4zC1uk+1n8RhB9YbhWYWPeGE8zeKOmDtuQjBtnFZC+I7kej/CLLejIUN5xGaXOdprAEj3JXSKmQH7TAHMSGa5X5NJgr8cQ4gNRgws9zIQQ6m42B0y93/hzMZfJGIbVYAdSCtnPTFyfUOwx1UYoNC678zvIevGJvP22GVVmbp1z+ib1v0N1nspGgwCJvEcIV8ndgQ3oopKPXkPzyGIamAliM1TzGdUuy0uP5bxqXJqtD3KIG7Gb6nJo4fhWAPnMz/iGjuqj+KuWXtt2Qrk4Ba4HEngBqphhJtoK/P//5Q9JtTy6xLnmB8s9/HblpaxstFUxDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAADCYCAAAC9EIAAAo2AgAAAyJA=
Date: Thu, 6 Jul 2023 16:54:44 +0000
Message-ID:
 <PH0PR12MB54815BA6271671294F2185C0DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <20230706123220-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FC84712B83663691BB5FDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706125001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706125001-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6238:EE_
x-ms-office365-filtering-correlation-id: d543a255-6845-4b59-7504-08db7e41b2d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IX4ajL4dlNjzZDOq7mQVrCl/lB4XbaN3iqrEcXPYCaVe3P5Z+TEgOn2/EuidFi8sOk1t5Uqmv6Z673xO73ur9IlQyyiS5VsOQ2Q019MFmR6rvoMp2wxt0MwLlsRaH6RODd3ORN2aGlFqHKEWbdf6OAZ0o1ZsVsHNGfN6G1hv2TAE88m8PwLoveZc2Y7b+ozAXcit1OCjpTLjZVOH8lMa68+OLSCJBytENbe1+7bV8LEcCpNu8UtX+Fb7qE+8vZWjqUAShqG0l5rdbi0xWF+7cL893W9dc09FWSZ7c0ymb0Xe6/K/iLPgLpeGBQigyYav8e+UX3u2cfwnsOKehb3V2CXq7uanGoLmMslOH01AmzZB0ZMMQPPaAzxLgOm5cpMv3DGj8NuxGb4949gUiTZR9Us13F6zIBpcLITRBgPGbCs0Un+dMAsVyVmOInTWPlcyhww4IV0EciMzQhVb7x/oQDvjqK/oBtWAxUnompk27cC3McbOFtK6w4WLXh1ISx2nxlSSCSeR194EmZGTROUFV1LYez7NGNt27cDN4SLnl77F/ctDFO6w7OI00st71nVyQr/ETSpgBQR0bdoicEvRr1NwWzmMM5gaw0X3W53rMoHCuuRS+InSB+UBk1Uxfxt5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(41300700001)(107886003)(66446008)(66476007)(478600001)(9686003)(54906003)(86362001)(38100700002)(38070700005)(122000001)(7696005)(71200400001)(33656002)(4326008)(83380400001)(316002)(64756008)(6916009)(76116006)(55016003)(5660300002)(8676002)(2906002)(52536014)(8936002)(66556008)(66946007)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2xWeUxBUy5iflkokR7pHaoFgk7A/3gT0fvI3jeGb8x7mlHpOYhJXY4dvzjWC?=
 =?us-ascii?Q?H+1d6/s+K5sDfcauy/+5U8L9elXzfJhj7kwaLvAuw6rYHmmHXEBUBFg9i4H6?=
 =?us-ascii?Q?sx+N7YH0WmvQmCEepuleNjOQHSdF1OCx2pIHvRV8kzMVM32iicUZzylvxUyV?=
 =?us-ascii?Q?dK6pgGJzrT+R/4mzpeHr8YOk8lPV9c9vqdkuUAFEAjBBEEx1rvZtvYd03DWe?=
 =?us-ascii?Q?Gx/PqFeGTQSHc8q8s9PM/TnRwtVegUwOtKpmabu6Dlfo8ZV+O/7VIwu4r52Y?=
 =?us-ascii?Q?Xck7Sfr/FpaiON9jGhGS2rLQQKJl3rax1+0RutRPqWxwfiyfmyCubjCUEhxE?=
 =?us-ascii?Q?RKQWU+m75rkf1RxhtiXHCzfpKZ//n9i139cf/2n8M4FyqGasgUyXI+fwaego?=
 =?us-ascii?Q?nCdBoXpAhP320tpUQ1fzXBmdWFOatAeUTEGS9JukOwzfsR4JfA1aF4bwn9bx?=
 =?us-ascii?Q?Ot9v70T0eM29BL1NI+RRgXcB+QYFSG8bzfcMeHNcvq/emoi5heUqe1+VgtDU?=
 =?us-ascii?Q?BQx7Lc5QCdKWI0pwTjK92X7L60yLQ6JJ9d/8dNh2jq+tn5swMtwCe6UhUw8k?=
 =?us-ascii?Q?Kv09rGYsUWGvdeVuX61Jet3rzKPOT5r8CZtU40keEJTiBtPfOKlcVqVAWysU?=
 =?us-ascii?Q?EqpIQAv5d8/C5YPUNMiPmJ3r5Fm3sCjAFjm8wrkrJsaNUorsTenvdrXI8iz1?=
 =?us-ascii?Q?GF3EN+GMPqvHdOSUoysiHvtB4MfUsuzmcGAyH8QjbkU4f5PBqhW/+/EwcR3O?=
 =?us-ascii?Q?EjSHjGeoYq+zMxeF2LCG97beI9lnwgO+I9s0SbkzP6gvG9n0coK9YuXp70vv?=
 =?us-ascii?Q?arS7wXa+ljSJ69SsnxAsiUuKzizYrViH55plXR48mtE46AQv3MJEuQ2ha1fq?=
 =?us-ascii?Q?jf5CdUZBrDFG1bS6EhdseeGzwuy6sDu7TxqUENPm7Qe2ATDSxQxsmd0p+D7m?=
 =?us-ascii?Q?OSz+C7fgTk6Aa9ZQgMatQjgEMGuIKkfHFF6kTyN4MNFxqICSiEJHnfKkRLcq?=
 =?us-ascii?Q?z/VKO8o61tZEnZTLyvHvbqcKVPQmMCY1pgexl1uh0F2YgwF1i6h+WkOaJnN0?=
 =?us-ascii?Q?nxWNJCqZiX2kZIu9qK7ZjgfRc+lTS7D0rpHpMMFcBK7SoVSTrcDbCiOVQANV?=
 =?us-ascii?Q?cLVcsWZC3U4Zsgprqs/Kxtxs/RQahNdkidfzFVQTurNnDw22g1mwKM8zFOb8?=
 =?us-ascii?Q?BXBNolw5aPWap+WQSmStGAsnarBethO8speU9frSw9cl//sStVOzjOOagPPg?=
 =?us-ascii?Q?yobBZAlk7UVIeP8c4Xa/cKnkMJQJCG4F/4x/ghVsVG6iNKsNAw/a6jfBQS2j?=
 =?us-ascii?Q?tuQ/SapNJ4IkbO42OFQW+d1nOOW16RDBfEBBt/FvRBbCP/ce2Q8DYs0Anwkr?=
 =?us-ascii?Q?l7tCX0fhqgMBBtUNwwy7B/OCsUtSFOWCLc5CGn84dJOHN7rGpmS8P84eQMJV?=
 =?us-ascii?Q?L8MQdlhPOkdqAvcRsxwVKO7WWM3r/ZcbH5Ayazb4ylZ0qgkXLdQajtra1tRE?=
 =?us-ascii?Q?/b302BPXZTuwpM8/A2/LvmTnmDs2tdYJt35BJteGdWRV2Z/KWiAvxwYPtb23?=
 =?us-ascii?Q?u8mOdlyzR8K0wUFrS77f1Sru+ORCPWz7u/kIz8qVzQhAxvrkN3y4sYnhihzl?=
 =?us-ascii?Q?ysOqI9Lu1SSSEQjFN9BVazw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d543a255-6845-4b59-7504-08db7e41b2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:54:44.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDM4869DKV7nCWn8GxkrrVVwJOl2P678+P0gpgeJiHpyKj7P4mmpD8m02tSm+aN4R0tZv60/0J0dzf5GzEy1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 12:51 PM


> I don't see a statement that devices MAY support
> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> with entries returning just owner, just member, or both.
>
Ok. understood.
From the driver notifications wording it didn't imply that it is related to=
 VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
Will rewrite as above.
=20
> > Do you suggest to drop above statement?
>=20
> > >
> > > > > +
> > > > > +For the SR-IOV group type, the owner device supporting
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and
> > > > > +VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> > > > > +commands and its member device SHOULD follow the rules for the
> > > > > +PCI Device ID,
> > >
> > > what does "its" mean here? Of the group?
> > Yes, will change to the member device of the group.
> >
> > > Members of the SR-IOV group type are VFs. They can not follow the
> > > rules for the Device ID: the spec says:
> > > This field in all VFs returns FFFFh when read.
> > >
> > > Even if you somehow refer to the software it's extraneous anyway
> > > since the spec proceeds: VI software should return the Vendor ID
> > > value from the associated PF as the Vendor ID value for the VF.
> > >
> > > We'll need a separate statement for Device ID.
> > >
> > Will split the line for Device ID.
> >
> > > > > +Revision ID and Subsystem Device ID of the non-transitional
> > > > > +devices documented in section \ref{sec:Virtio Transport Options
> > > > > +/ Virtio Over PCI
> > > Bus / PCI Device Discovery}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

