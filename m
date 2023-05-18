Return-Path: <virtio-dev-return-12757-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE91C77B7A
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 20:51:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A67B060050
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 20:51:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98B0F986728
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 20:51:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C7AA986383; Thu, 18 May 2023 20:51:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 738C498671E;
	Thu, 18 May 2023 20:51:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUwavfOgazS0rk5ZU4sDKh/wtc2l2daKAFQWFSJaDGobI5IIqm1tffz9Rg/gYRXPWi7RWsvoD3/GDl4d88qCOLZDbs6pgPhRSs8p4/+u4HbtU48WXNThmFjsQj4kiurHZnpIMnQeDjTlz5rOMzHSK71yRm/49a64x2bJ8BJIpOaYdVYPe03WXW/sl7uZ/aORprnnMcIIPvqOqTueWMm1mLoh0lKxI16LwzWu8O9hh2rNoWqW+eQ8TbXfwC/OXFqTaQ/r1Y3A3TfRQJZPvSF79fYKvgg5fFxzVh+JAokuzAJK49nO098/kVFOLvVDhJFszc/MSdTQ25vX5ecYf7/7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iDsfB9TTbyos/i0hIplaYJtaqwrIbEov4BJErV3nHE=;
 b=MDOz3oBrnxFxPXuqyYB5zbbWZ0lxxt+hORiIA3ILYzt5YU76jKF0BN9THzgzdNC8lVxJj9PDM1TODfm/DNBgVecqO0/PZs3GFKkzzNTjq3P7WA3UItyM/PpIlJu7mj6g+emGR5zZvIwdIy1J+8NKGvHyvgKpX9gAGIKDualF7GCNB8GrMBkpMFKSVnFpFUkcvpkQsPhxDZZ2slNPWbdOGqymQQvGOIlrTSzUZGf35BHBFbf1bWXjxugRSSPrS01JHcV7QlQsOXYt8my4qao3us4VZjfJZswJ7NDzARhqmUVAAI4QDTbSuxBwOtCad8eI8DKCHT+3cqfPGgtdckXU8g==
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
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index: AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAAEdyA
Date: Thu, 18 May 2023 20:51:40 +0000
Message-ID:
 <PH0PR12MB548189A2FCC266713779FDB6DC7F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230518153640-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6576:EE_
x-ms-office365-filtering-correlation-id: 9515644e-aefb-4b43-ace8-08db57e1ae6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 drQaXv86LJJgvRoDuQrNGFqFVSWb2ULCnTk/Plz0i0adXsRj3IjL/r7hd18gJOQQWDRG8uqh/RNdNwE9o6jebKfGSc5btsDd71CAbi9wchos8EiyzgaY2eI1Db693ukLXsTk5pRID5w/qPRyrMBn1yBiSQtrZAZkOlyvCyWtyQdc8IVywnxD42tr2weRBW5mMmsHZHRHKCSEphQdncGVYb+AUhvlKHeoGA0oIMq/ACAZNs+G8FKUFB1UYdmb39MxiyUUlgU74xYz5NJ3vJkkjwsmxWzzVu4xmqYj0zU+aj4chObtiGCS3+P+NhvBmMKqw9G1eQDM+CKj5/MvQocPRXlmmSmdOJ/DSsQW/rdoP6v7RZKYYl7Ywn3tvSdSMOlHi93Fwy4efGCj9D9eaM2kpPI+qPLNR+2h8QZ5qGmzTde7YYLug3A3qBRRTpAZOk4/wB5o3yXHRvl+W2M8zSM9C9rQrgLWqlIIDg/u8+S0zLNb+0Tvr6cIbSugf1cFoVjbApxSXJ82dKXZqWuKBdUAnTwPp0MXn01kv9H/xSBO0o8aPeXacuX5r2EA6fm7p66J20tSyeBOPPqJKzXT1zSk4vyfjPPhpfug48strG2T7tf7dR77tPcQlLG6t4ej9lX3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(26005)(9686003)(6506007)(107886003)(7696005)(83380400001)(86362001)(33656002)(38070700005)(38100700002)(55016003)(122000001)(186003)(54906003)(5660300002)(478600001)(2906002)(316002)(6916009)(4326008)(8676002)(8936002)(41300700001)(52536014)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NKEPfdEOeivqD1Lky9hmKRkNwKCSvqq/s35eWX4tX5CMV1h7m4jg5EiYzt0E?=
 =?us-ascii?Q?HgY1hrpoO3CqL5iepgd0I5g7Mu8d/zfzyNKJT4cF2hJNuoJh5PZ/9+LQ0Bxp?=
 =?us-ascii?Q?Tdk6y9UGf97Lm2V3C2Vsb3pPZyGiBG/yW3Y6bZoOx2HH444u6zGsVF1frCJV?=
 =?us-ascii?Q?C54lyGfWWMql6B2vQNZhm6LrThJ0I7TahKEtqcjBLrVcOT2LKe19c7Xu5izW?=
 =?us-ascii?Q?rqFfypuUe4E9s1yTnSE4ynXrdvG6L9/PG0Eqpbf+0yvD4R/d72ec7/CyDU5w?=
 =?us-ascii?Q?A1INBqGlvQjeMAsrfHZHNoihhLsfCN1ETlWHHCMgC8fTiwK5JONh4uoB5M7M?=
 =?us-ascii?Q?LnfZmqA9W4dreHpf6Kz1FWGLYg03Psiy16qcnyCFKOeotaPorEUMF2WlGVXD?=
 =?us-ascii?Q?dF8GBdp35aSjYDZPxef5i7ia/871uljLhPW6ok3hxzXhE8q4xdBUtjph84kx?=
 =?us-ascii?Q?pdtcpS5ZILYzD42ZZqT0CYAAh1sEb1PXKrrh7jFpaTX5N/9E5f0OB59tjc5Z?=
 =?us-ascii?Q?lkJ10VzYrikLtwkB16HDlhaSbJ/TSlEY9dHP7lPJFc4IfDn5Q4XAB6If4Qpj?=
 =?us-ascii?Q?kICtMqkznzJeFKqwqnRayJKC3UlnBoqgMB+vMogjHB1eq0TUCIEGyGVwpDBz?=
 =?us-ascii?Q?dyq2VCUH13jDmofxKx58ONq3eTAU+FM8+loqz+04JBRdxZsxZk80UCxUmCP0?=
 =?us-ascii?Q?d5CrEAnLbz8Q6XHHrkV/WzjXqw75URNu1BHMytidTCMzNmqe/nQAY+RoZtoD?=
 =?us-ascii?Q?JZup652lpDs9PJ/j0OPY5c+8A3igPdsDnsHnnLkTiNsPblfVyUia6NLB+6ld?=
 =?us-ascii?Q?tEBcWPZ+EVYkcCSj8IHlHXXQCoPmnWKPrtMHvuxl5porqZaFSql8JRT4I49P?=
 =?us-ascii?Q?l3MsOXq47VT2Rdk8XAinl/yJybxrzqG1q9A5icAEq8dV2Iwnax/OotasqHeV?=
 =?us-ascii?Q?YAFFIXYoNjo/n2MfEQwZFuVd8m90z1ul0EkRi6Wlia0IqjLayZGDYdPUZZkl?=
 =?us-ascii?Q?A1l63yCxFMCkeOZldjmVg523A+XbcQCAp4s+tjdUTwPCa3TmuRGIYBs3Djo1?=
 =?us-ascii?Q?rKWzaDUgD/mKRUlL7OqfzS+Ak5Eyq4E97WPkLkseY+fntMJjQQSySmr4lXSd?=
 =?us-ascii?Q?+2H+B1Z8V3+kqv8z6/Yp8PRzfZUWpqYiOmVz1AjwyTL7vHHAoUTbkbGmnFhK?=
 =?us-ascii?Q?08UX7fuu62Pb0FE8Y5/fOfPEnfyOKdBApZRwiyGqhqOZeLT2bvIm5Qd3HF9B?=
 =?us-ascii?Q?g14MANlAWlbTe3pdexqDeEF0pDdUQPVHDT4fYFbcq3CiKxQ+Pr4zGmcVNoA6?=
 =?us-ascii?Q?kNOqLEj6oe/juVY44aVQkabMzMPlcGeK+fPUWWv2BkBbn6yBcaSkz+N/ajdT?=
 =?us-ascii?Q?j5BgCYIo/A2wjTNuf1a+XkAJavivI3S4rcSilVdkjs+GZiFbwqG/IcDN/sis?=
 =?us-ascii?Q?JVOMVOFrP5e9Nc8tCJCOv0y7jE9+5TllTv4m/UoZui1fOejAMhs27+S1CBiE?=
 =?us-ascii?Q?054H9emLaIZPArok2n812z2tQtIgBltLHHNern1nIawPMuxmg8VgD2XSZ0A+?=
 =?us-ascii?Q?ePiiq5J1jccVSFnutbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515644e-aefb-4b43-ace8-08db57e1ae6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 20:51:40.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKrbLYPkcIyzN6+0VakgEwaBoSaXvOHFX3FVNdCOHtXvOfoXqYsqtnTXeM2uOTRsu8pta/EAwj0Bu4VVcQSCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 18, 2023 3:42 PM
>=20
> On Wed, May 17, 2023 at 07:32:33PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, May 17, 2023 1:45 AM
> > >
> > > On Sat, May 06, 2023 at 03:01:34AM +0300, Parav Pandit wrote:
> > > > +\begin{lstlisting}
> > > > +struct virtio_admin_cmd_lreg_wr_data {
> > > > +	u8 offset; /* Starting byte offset of the register(s) to write */
> > > > +	u8 register[];
> > > > +};
> > > > +\end{lstlisting}
> > >
> > > So to summarize, I think the main comment here was to have separate
> > > commands for access to common versus device config. Just today I
> > > thought some more and came up with another reason why this is a good
> > > idea: if we ever want legacy MMIO emulation, we can reuse the device
> config command.
> > >
> > MMIO is actually simpler than PCI because all the registers are contigu=
ous
> regardless of msix.
> > So single command with offset can service just fine.
>=20
> yes but then you need to implement both MMIO and PCI in hardware.
> with a flag you can implement legacy MMIO in software on top of legacy PC=
I in
> hardware.
>=20
> > More below.
> >
> > > Jason also feels the common config command can be shared with vq
> > > transport effort. We can discuss this, for sure, I guess its putting
> > > code in hardware versus in hypervisor, but if there are hardware
> > > vendors who strictly want this code in hardware I don't have a big pr=
oblem
> with this even if I don't exactly get why.
> > >
> > > With this idea all hypervisor has to do is subtract the offset from
> > > device config access, sounds like a small price to pay.
> > It is more than the subtraction cost.
> >
> > Hypervisor needs to inspect MSI-X enable/disable settings to decide whe=
n to
> issue command #1 vs #3 for the requested offset.
>=20
> I thought that for now you wanted to ignore MSI-X disable case?
> Because if you do care then we need INTx emulation.
>=20
Right. But the ignorance falls under should category.
So when INTX is enabled/disabled, AQ commands etc can be anchored there.

As opposed to that, config register access needs to decide what to do based=
 on MSIX state.
So hypervisor now must trap MSIX capability access.

With single command, it is not the case in hypervisor.

But it is likely not a big problem given both are in the control path.

>=20
> > > Does this sound like a reasonable
> > > compromize to you?
> >
> > Splitting proposed one command to two commands, 1. one for accessing
> > legacy common config 2. second for accessing legacy device specific
> > config
> >
> > seems fine to me as below.
> >
> > So we will have total 5 commands (instead of 3).
> >
> > 1. legacy common config read
> > 2. legacy common config write
> >
> > 3. legacy device config read
> > 4. legacy device config write
> > 5. query device notification area
> >
> > #1 and #3 same cmd signature but different opcode.
> > #2 and #4 same cmd signature but different opcode.
> >
>=20
> Sounds reasonable. Jason?
>=20
> notification thing needs more thought I feel though.
> It feels weirdly bolted on, but I can't put my finger on what's wrong exa=
ctly yet.
> Will think it over.
>=20
Ok. I considered alternative to get that from the VF itself, but it was not=
 elegant with little value in future.
Will wait if you have better idea, else will proceed to v3.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

