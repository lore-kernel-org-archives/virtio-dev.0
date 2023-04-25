Return-Path: <virtio-dev-return-12405-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6B4C77B71
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:25:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2C5D571C96
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:25:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20AE9986642
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:25:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 143C8986447; Tue, 25 Apr 2023 13:25:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02348986449;
	Tue, 25 Apr 2023 13:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI7dsVEZy4JymsS2PV+eN10gLMFQm7QV/56l77bGHsncOEwJlqSbg6mRmFihAYfXXsKO/1JOU6sxIfcVslu5qeQA2nVlBY6nJmF5n67HFp2etAAgzX4oRBVBmlAlF4PrRSPGSl0Q1ggDFmFVFvBrKssOBRUaqr7cos6Jn9obBhkVJhPQFWlj5riy1sOghKHTYan0svJinttm+sa2no8W1m1fqul+gZbxlNiDu64UEHT2BIO1IAtf8DzSqGWl9VQxD2YWGAUbQkJLN8YcWzapaK3iDpKq9azeI+ddd25j6cvnlA17I7GpL202tvyPhrig0MVGPk0VAxnbgMJLtMyKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcbbf1sKzi8RHN/2ZTYXc39qN0CJ6FRxArUFosI4sT4=;
 b=Wy2ZDwWVpVs7Pphz9EcRF06Gfi6K0QSq0S8fn2YcJehfiXxL1gFmexcDUFRn6TllHxCEu6MeYGp/iBqFPwhv84YYtjm0z/d8b4aQFbQeLfopP5YTgU2+QLXeiWOw2J/ej4CwYy8B3yD1ocya9sdKXxE8Pga6qruFpE2Tm9WQ9knC74XZTETL/Y/uhWXaK1pjl57fE1/QNLX4d4nwfhSxFDGtqiEdM/TvkSlcbfx6EYEh1tsrbYOt9YzWwFtFiA5gaqRdPbwcQVx6cioZPX/uO79MwMbEw+kmzAgo9wOxbWMYj+5lrW7tQ7kYNYd+fU+bIWJSucQ0o4vcil+LahCxow==
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
Thread-Topic: [PATCH v12 03/10] admin: introduce group administration commands
Thread-Index: AQHZdswMuKG6jk+9I0m5FI6AWEnz/687YNgAgAAtfwCAAHQjIA==
Date: Tue, 25 Apr 2023 13:25:24 +0000
Message-ID:
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425020925-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5253:EE_
x-ms-office365-filtering-correlation-id: 4e2b8df2-4594-4d5a-b62a-08db459086d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lsKdelwTOoOGkirlZd/+Bwh+Rb/Yocc4a3UQl88lnr0jU2zebBHqZZXnl6Q+lZv5h0li8ZxbF30vI7eIxIKKyU/mHrTjUfcgS03MXqwfnBXXpCM2kuEmA/Cf2th0QxAHmc2nv8D4R5Ky/aP79yDwPOD4Dkev2g7tyPHplfgaDUkE6NCwcBsQ0qncWIeBobCmuWyxc0qvaq01wPcJHt6HaDX9Sd1Gpx2guBBFRJktT7cjgbRxaa8IiVpQmaEsW11hOtMd+g7SYvgYN7qCtUwi0vzAKEUU91vYIRy0Iuv3Ga4e7vNk5Wf02wuaex3nOdnh1MT+dMSPk7RFX0E6H5ZQlwTVPHpRr7m5LN7oGSKjhsm7JO2zWH0T7z3y9N3cwR7xyvmUEa4PN8iz/KOGcyLTELztM41TqlyRvd2cEFpX/mW6JMF7sPcwP6iZxEjqsiqNSsfQeQMN8jsx5sUBbW7XsEzSaXGWXqKvA9IP+1fppYZbNbD3voqdiJn1INPGZmLcFRH2KLlQDUuFudppMEMEbDRNpoWwLWcybdEPDeZOmpWMHQxrMTXTqU4XAM3nq7+H8PvYcTM0LFEsgcDMPelWvCiUSdpEqGZH0F+gxEdgIiqtq+DxIJV0Cx0pBMFnGYVPoiOrlzLdNqazV6L37YP62x+qBu1neHHRGlrABFiAh5M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(54906003)(38070700005)(66899021)(33656002)(86362001)(478600001)(38100700002)(41300700001)(122000001)(8936002)(8676002)(7416002)(2906002)(6916009)(4326008)(64756008)(66446008)(66476007)(55016003)(66556008)(316002)(52536014)(76116006)(66946007)(5660300002)(107886003)(186003)(6506007)(26005)(9686003)(966005)(83380400001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?juXn7i74bN/OcHtdUHx6fFuUltTCl4vpmwDFuoMzA2EItSQNDGQEbGgoFmzQ?=
 =?us-ascii?Q?L8hsnfE3edomJoMj1RGQ1QakhxcxGerOA0wZAlkdM1Js2KkIO5KcuvcL9rCq?=
 =?us-ascii?Q?lFkm6yCZnUHbl4cwRkmT/94qOpd5zgpBwFaYVeFE+A17VT1hB4FxvH2QkuWj?=
 =?us-ascii?Q?uyLAOGHeOh6qqFdWXpYTTjChuCC0PD7NCmDalF33pAVsVPCBZoDta90ps8C0?=
 =?us-ascii?Q?0MTjPst/XhW5u8q+z21Dcoyixua8X0mNj0rh0W1DrvqNY7IRlGpvkaUYQYnn?=
 =?us-ascii?Q?Fy4FkolA3XKrOKYfzz9Eph+MquH7qzni3THZzNYKfl02PJ0Va6gBgbZICsBV?=
 =?us-ascii?Q?FL3SWiG6goRHf28M5QO+XzwII8TJMpPMN4ErZScv2akfWul32S0SzgEz4Mbg?=
 =?us-ascii?Q?kRdarNH2UdI/hWJmfiR3uPLXFcrPAgPgiMxIr/3e66k7B15Y/j9Ir44BBNQS?=
 =?us-ascii?Q?y6loeoJsYgbg2x5bvqnO7DeMKWARclN1ta0AMX/mKyIl+Lk9XsHdk4K1yljt?=
 =?us-ascii?Q?/3sxPapVNUm5qe/QpqzHrGN6tfULCJvcsjMpVTR/chrZq6y5zNgwSrBu6zno?=
 =?us-ascii?Q?v0Gi7gDBUHEOsEIRCCSIR02j+p2soc7TwWFrFcLvkPsSvjMyjqUHNlOhBYq2?=
 =?us-ascii?Q?oyGXxM36qjrwm76DzZpAb+mthoXha+foun0R/EWGF/L20zLFLssqukRVOePu?=
 =?us-ascii?Q?S23+aoDPKXJzONYTdokE7vxgcZFBqbqhiVv4mTyTB2tkW9q29ThEi+TywuMr?=
 =?us-ascii?Q?qod1eVpqRYxBgNJVW/LC493jGi+JK7OGNzq/VB8+3wmFheEZGeh6S/ho8zcc?=
 =?us-ascii?Q?L1tQm1ipMW/46hsQ9S99DPyFHqWTqOL6xO1M4ucJzVARScFuCBkQbcOdVl+M?=
 =?us-ascii?Q?ejkESv1689fj7K5324iAPpKx3UfP9rveVlYJJDaOsWHye77PfZ56z2dUmBx+?=
 =?us-ascii?Q?Iwb9hRGcuep3mm+d0JhX3yn2ZlmglsT89cQ3+Mq8S+4mLiAwD1NY+QCcp/qp?=
 =?us-ascii?Q?m4C6v77fmVD1jAbz/Ywr+WOsPcyW/mS5e+ijW9JglG5kgiPQ77kj9MUeRCsa?=
 =?us-ascii?Q?raRPY+1opONcqqFAGZleqh8/QH29PgBkxiglB/bpUEtUZOMYhQ488LrdM2o5?=
 =?us-ascii?Q?WsS4E8FxkBJKQnTHL7V9rFJBaUJsKpqTsyk0g7FB8ybPJW7KW+wRuNYP/Gy0?=
 =?us-ascii?Q?urkYtrkBKkx2HE3gOHPPnorOQM0V6CICbLOfxvZ63xDPw4fXsEa4GgAujgpS?=
 =?us-ascii?Q?5G0CFtVaFdbYJPV5dKxeS3vXzAAg2Y74qpmo+JGZihfonDPwebJp3OHEOKCH?=
 =?us-ascii?Q?+rf5u7nB4iLWUp/UVuGCTlMUKaNSs2gjRFeSAe9J8xZNufa5xJWEcWyzvcKO?=
 =?us-ascii?Q?KPZDtxb+v0460xOF/5Lh9X0pLgauK3bX/3TiaFh3PoyREo4jIpFhL+hv699V?=
 =?us-ascii?Q?xz6nSnpZ1tUUIeSIJRef9o5OWgB8mpKyDtvHsNE132ZUDrrnaHJNX6GvCMbW?=
 =?us-ascii?Q?iaheQa2n6FpAY+hOn2iikhjGXw7Vp3uJbW9H9luWGqD5RaLsZelzDHhEzrN3?=
 =?us-ascii?Q?KODjE8MtSnUcDxKnE9c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2b8df2-4594-4d5a-b62a-08db459086d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 13:25:24.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFY65ONKFCNOnkaVu/tBqzVw2ROnLXxZ+ciLIYT4mS53Jk7UFjdBWWnbwXrd/qA/59lBfZYx+3/88IIlLrwSFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Subject: [virtio-dev] RE: [PATCH v12 03/10] admin: introduce group administration commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 25, 2023 2:20 AM

> > Below paragraph is no longer applies as we already discussed more use
> > cases of the AQ such as accessing the PCI VF's legacy config space regi=
sters.
> > Please drop below paragraph.
>=20
> Look - at one point you want commit log to record design process, an anot=
her
> you turn around and ask me to drop it.
> I feel like keeping this around frankly. Maybe I will add a sentence or t=
wo along
> the lines of "Note that nothing limits us from extending this down the ro=
ad
> though - but let's focus on what we already know for now".
>=20
I am requesting to drop the commit point that limits the usage of the AQ.
Do you agree that AQ can be extended for use beyond VF and SIOV group manag=
ement commands?
Or one should create a new VQ type?
If it is the later, I don't see the need of multiple AQ.

> This extreme focus on commit log is poinless anyway - it makes much more
> sense for code since commit log describes the change in english. Here the
> whole change is english anyway.
>=20
> > > Without this the admin vq would become a "whatever" vq which does
> > > not do anything specific at all, just a general transport like thing.
> > > I feel going this way opens the design space to the point where we
> > > no longer know what belongs in e.g. config space what in the control
> > > q and what in the admin q.
> > > As it is, whatever deals with groups is in the admin q; other things
> > > not in the admin q.
> > >
> >
> > A PF can use same or different AQ with a new struct
> > virtio_legacy_register_access with a different opcode range.
>=20
> We'll get to that bridge and we'll cross it, the proposal is not on list =
even yet.=20
It is at [1].
[1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html
I cannot draft the legacy command using AQ because AQ patch-5 in v12 fails =
to merge.

Before I draft it, I sent [1] on the design way forward.

> I
> actually think that yes, you need it in a separate function. If PF is pas=
sed
> through to guest then PF can not also safely DMA into host memory.
That is fine. Only some user tests would pass the PF and VF to the VMs.
One can create N combinations to make it not work.
In all practical purposes, PF is owned by the hypervisor, trusted sw as lis=
ted in the PCI spec.

> Alternatively, we could use an MMIO based mechanism for admin commands.
> And maybe that would be a good fit.
We discussed that MMIO is not a good fit for the VFs at scale as listed in =
[1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

