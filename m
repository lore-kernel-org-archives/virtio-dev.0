Return-Path: <virtio-dev-return-12896-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F6AC7EE29
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:11:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AEC92B01B
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:11:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FEEC9866AC
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:11:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 642FA986681; Thu,  8 Jun 2023 18:11:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48D3098667E;
	Thu,  8 Jun 2023 18:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYHFX3K2BX82jVMRy8Lb1Ha96iXZkniPJFtLWwVRRhJ3Wdq36xbgJ3+jTp77wmbEiH7dSX+QYBykLTY+toYqtOKT6JVPoFkHg0HhOTLg5+wzCGj0hRHUxvekCZhr7jVXrb/A4lHpZwdfq+3rGFs1/hFTmjzZPxzlZY56N0sdvf4x1ZWXP+5mwiBr0ybJV6puaa93YqHMyw7gMv1Aq4ohQFqeK2H9yUn5IcnRI3Ppar2P/YQFxjqnSRPXvEpMvnhqEuPA9eEuylPLnroudkmWrjeqIFK02OUjYjPxUm4nt4lA6j8+BDilbTI7nXBrnIOGggjiUS+Wtlgo7XZSb8auAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR4ugTB/Kncsrj3pOknyjYCsJBvtdWhejO+2Q8KSvUE=;
 b=iqvY7LhAXQRbZNx2sjvC8qd2GGlRpHgl6JgQoCE4RkAkpGJQCRT9KRqBcyPWr1NWst825Q18TeNQzruHc3149185EyOxom/fxpokosnx7Wdi/dQEOUKd4TaiiI0NK5q+y2XWb7v89XDSB6PYB0QAwPnvDgml1VyLyc6+d8d16BExX26W84droZARwhfLpLLmQxrL7LlvgDNskA2J83oPzk8hIxS0DLUbrILEALT7ZQ7EjAbaEU/x2OdC5dkpeoE/OqPiNcc1qoyFdXRpz6hZHax5knlT2e8L8spEAaZTzMhZn4jwNKkp23rMPUR6gCRdHliShL93A8uVReupM49BSw==
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
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAAwqAgAAAcVCAAAT9gIAAAt+QgAAvMICAAABd4A==
Date: Thu, 8 Jun 2023 18:11:29 +0000
Message-ID:
 <PH0PR12MB5481331BD21A024A3505E953DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <20230608140013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608140013-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5128:EE_
x-ms-office365-filtering-correlation-id: fe0731cd-dc38-49d2-cb7f-08db684bc80b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 utcpFgWWhWa1By8l3QndE3yuN2hdghTgTS1VRpEGQbcfi8tZXUvplw8RYhS4o6+TZJYmBv0XsnjR0JjMZpJYtZUHrKD6dvdEHaXC2woDxFm1AyCVyepN5dkZTtyNk4YdvcB4fkcPZcdvFGSf8G33uIlUPJ4NLkCiHYrUbi14TZlur/8M4YpPnYM0xjfJvgLxcGWDnprano8PClvZta/ZziHKuEjI5+zyuTzkV4WaRlW/ZKKYzyj8/8u6arnqLG0hFW5L0P4wZPjA9WMMJLUwvFqDGBFSbpjZokx9bEtDihRn4feRwoIwePaxglcN0AlT+K492E/1hUsvH33lA9KE+6yQda49WgexfIn4LgNQifbbeBXMib6L7En25rvrKorcRRK6txM/7kIAiRuGZTYa/9jwK25X+JRLaeaiyAva9vqi85QAEYVpVHCHgO/sfCz6Pe9UnjzPNVCehwnOxDkaBf6dIbPCw0UQ1nMxVXTJnZ9zVX62Y4QL1fpQbtbUI8jX7LKv4874PODZZAhpEcFgSBbGoE/Zi8ZXb40ko5Zzve2dm3RzsaUEygYv09hH/at1ExJ4/YLE8A7oCzGEMNik4ma8Xyw+0ZTDo4uwVKhs3RQOSbbDG9p4Jft8XDjwhw2w
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(33656002)(38070700005)(55016003)(71200400001)(7696005)(186003)(9686003)(107886003)(26005)(6506007)(122000001)(478600001)(54906003)(64756008)(316002)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(8936002)(41300700001)(76116006)(66446008)(38100700002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4TEzq3eNKOwsk+tGLjlazJgitoTPhrWv5lpHaNnc+4ktwS7QPOK1BypCRbZv?=
 =?us-ascii?Q?wtWBSnpjYfJbjzPSFSwuUB+77TZDyTNohFVwlVg+jM7qCadzYF/NmJfkGsVe?=
 =?us-ascii?Q?+kUrEVIEeGCaJn4zHiByZBySLTgJ1fmGsApNpIsc90vQ+mYJO5m/UZxDuDOL?=
 =?us-ascii?Q?V0pQn9nPtIdjPpKy29mKJlW/uE6vzpLal299XhL3mZjw0FppQuh19z1TsaXj?=
 =?us-ascii?Q?Day7/Z/V/5gBAKwfTGL+wqrJ2UICZBhtn385y7y8Xl88SwG3wbogoCnXcdlA?=
 =?us-ascii?Q?EVLYMsQh7YcZUyjEBbU7vptyrhfOLg5HQPUBoXrV9sNxgu2p+yKbOHJ1Vgku?=
 =?us-ascii?Q?sACngA78UgzuATb0mGj/Q/SGr0i5oWbQ6m7ngM4eLBrDrmk/0ff3vCTewrQE?=
 =?us-ascii?Q?bVPPh00Bz/TcNOUxxoIEBcCuTdX8E9snHIuACrUR24EYu1hxioA0H1JHWXkE?=
 =?us-ascii?Q?GqxOtAOKga+hae1cIjm3snZy99FdovE9CjmTvzyoERE6aE43LeIGrGKyK3us?=
 =?us-ascii?Q?k3T7TumFRjYQctY/nXBe7RR+NXQ4NclddVMc6VsGH7OLuLfgZqbYoV+dlfeP?=
 =?us-ascii?Q?b5YqGieEM+Vo+X9V8JmGJgx+VwwgbxRNpfWkVyxn9TkOPq9eRoUpPeeOyI6n?=
 =?us-ascii?Q?wTnVbxcLWIc1s3Y1gJOv+AQtCBhr/1XGv8LWfstw6FmHI7FDnWjTEFtHhZ+F?=
 =?us-ascii?Q?kWLMgy/n1bAMCypFDHslcFFjrd7asvxBOUHVwNR9VnjlGNQ6Lb+BnMUBaQxW?=
 =?us-ascii?Q?xIh3/uOqsKlDkM8n2aRCXE1m9TOAM2pV+Y0hnw1rmoNKLnCq9mkInbThZ5af?=
 =?us-ascii?Q?3etMLuZGZzQJyIwGcAEYwmdpy9jthW59WPk1QAsSUDVmgv/xHdoRddcXP21s?=
 =?us-ascii?Q?RYiWtBDqfOm0NufPcmxrNneDaSCYnnznV4G1l9X22t+mnpXiCJdUSobQd22Z?=
 =?us-ascii?Q?w+k6FyMbrEjPIfBMTROK939LaXXzL6fo+UL3i3xcCpfjx8epX9yUR86inl3g?=
 =?us-ascii?Q?xE/9znTA68hzvJXuRpiG346szI54gUg8gEe0KIr17LOclA/Y41vZtDxsGLGv?=
 =?us-ascii?Q?pDC0eLdAAPCiBICKJEggrebCeZrGlsfewVcwsvNIL9LqaAOjnJzrnG2BkrBW?=
 =?us-ascii?Q?IpN2awNjub/86Tp2CidxV5985t15nyotX5qA4UoSv4agAeJwe44weuafVEHj?=
 =?us-ascii?Q?aOnuGkz2TrpjvFgB0KqU9W8sttt2uU6U+AooWEdxENNfJFXwXWdehAzTM43c?=
 =?us-ascii?Q?GjY2iRG50ZynnJPj7cxKohYgN1GFnAGJj3ayBUYZVxYBchynU+lqLxAnnInK?=
 =?us-ascii?Q?wTzmhyVzzE5zBOhcrL3aOBbyjKlGFhcPUNWn6V6fNJEwUx2HGwZBWGLGsmNV?=
 =?us-ascii?Q?9LdkNqD7TbpMHFg5Ykv8X35Px9YtBEEvek+Mz+HTMI+ir5Fq56R/UDjPC7PG?=
 =?us-ascii?Q?IyEbPgbR6YbrImFB3F7f9MAuRjjBruYtPOLm2rgGK6XvZ+g8JFeHrsaUAmgB?=
 =?us-ascii?Q?0plU7p1L/ypO3mn++5TE5dIz+HotevgHncveWnPJIYDqil11fDFjGcyc8a+8?=
 =?us-ascii?Q?+UV8TSAamXsjrHZKZcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0731cd-dc38-49d2-cb7f-08db684bc80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 18:11:29.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypxNrPaSfGqUUhOazB4l1UNiUFDao5NxI0ir8Pmyp6BW7ylnYfgHJjidBTMwqYp3keGMj2yhKwdD9u4mfaXzBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 2:03 PM
>=20
> On Thu, Jun 08, 2023 at 03:16:02PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 8, 2023 11:04 AM
> > >
> > > On Thu, Jun 08, 2023 at 02:53:28PM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Thursday, June 8, 2023 10:44 AM
> > > > > > Since this ABI reflects what we agree on, I would want to
> > > > > > raise for vote in coming days to be part of 1.3 in few days as
> > > > > > we have more than 3
> > > > > weeks to sort out non-ABI language part.
> > > > >
> > > > > I think there's a bunch of work to tighten wording in v4, don't
> > > > > believe it is ready for vote yet.
> > > > 3rd patch has the conformance section.
> > > > Rest of the legacy interface semantics are just same as today.
> > > > We are not fixing the legacy interface itself, so not sure what to
> > > > tighten
> > > specifically.
> > >
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
> >
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
> Note that this will then apply to all VFs of this PF, even those without =
legacy
> support. Still not sure why it's SHOULD not a MUST.
It applies to all the VFs, but it doesn't apply without legacy.
For example, if one wants to build a PCI VF device that doesn't want to sup=
port legacy, it can still be on BAR2 or BAR 4.
This is fine.

> So that driver actually checks, but it's ok to fail if the rule is not fo=
llowed
> maybe? In that case add a driver normative statement too.

Yes.
I will add.

Change log and commit log already capture this, but in case you missed it,
v4 extended the struct virtio_pci_notify_cap with a boolean and removed the=
 AQ notify query command as you suggested.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

