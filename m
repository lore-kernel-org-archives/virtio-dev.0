Return-Path: <virtio-dev-return-11494-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C2C678DB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:31:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 15CB82CAD6
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:31:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FA83986706
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:31:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 037659866E8; Tue,  7 Mar 2023 19:31:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E15CC9866DB;
	Tue,  7 Mar 2023 19:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlM1P0/qkoLgFIMCE/jO6sXycZbLAOBzqOwKeQDykqdDVReVBHXuZ3PEgXFzXpO+h2xrhsT7J/O8DoU/m/plnV20+ByOMf/5/jy9rGCK6YXlzlUC9gKkuNadLEAwq33IpWuWu1rbEHvWmtsF4/pSSbVVan3+BgvX1NDAm7ZSbTci8c5L0+PbX9j9UmJuNtU0s6quuqQWOaB4AqX31uxNbJVKz49GCQnVnKvdf5BoWPtBhUpe8y3X64Zl6XyiplBLukB5z44GmqZBBf9xtjDNsfnMMMy0Sw5S0LiKdXGOxSZXIqoHxFHuEf5La/sxBl8e73fPblh6+jqZIo/IYlFR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsHioAn77qGVys/qyASr6LPwwsjb2sLX7S1ZOmMS1rA=;
 b=M/CgjI312lbARKDJc7uIU4XuuRXAD4cNWSG2WbVGqjcWDe0wpEw8v6eSfX8InAGKPuJwEH0bAkgCGwJMXlw1OgR2dDEY/jvUhlDizJ0kK9IpYm4zql+fP0NCXTAeWRs/j0QSTTxfi3rb0jI6VCyCMKMq7DIrFPRtNkyluF49f+w52HCPQB71o9rNGTX9iZ6qhkl5V2HrDM1bWP0rGa4BOqq81A8IQwHQIlVaVIOi5FlzO93P1dmJQoSG21JO7xFKfKOftO4QpEqKy1qfBgUO9EXJnNEc/7sDdIq7Tjuhu2TXhJuBYG0aUVXP1tqzzZRGXi471sMpDurPf/KwivayMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management
Thread-Index: AQHZTQeXLBm9R+Y8XE6rxgHYaBOlxa7ttIkAgACusoCAAI2yAIAApx+AgAAgzaA=
Date: Tue, 7 Mar 2023 19:31:32 +0000
Message-ID:
 <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho> <20230306175020-mutt-send-email-mst@kernel.org>
 <ZAbmEmwsMMxKJqeB@nanopsycho> <20230307121529-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230307121529-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6449:EE_
x-ms-office365-filtering-correlation-id: 30cc7f7b-9890-4bb8-0e34-08db1f428e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BFMg7Z7Rf3sKXsiJCwmCd3OCVuWiqbLACBAnYjn1s9RF9PD2j7xpBP1y2vaCOduu2v1najlAL+zGdz8PjDisFt+Hs1gYeXL/Zg8M2NBjVVrcBH58RkzgDC/jra2wAxC8Ru4aQLHYoV97MewDbMX8soulDbREVRt5L4uzitNUwk8omgyzyJEIhjeYmcl8baXcBY/xj84B1L7+lQxgFmR1ROLJNXHEEiOZLc2ABk0VNGVzKrDKNpWboxVF3iwbbk2NIGfThscLgCsg47hdOkk0/2I/DyprjLhWm5OfrUtFWgeQRYwm6mMj/LQk3ffX95q3pA2wUWrZ5GoY5OtqI/FaQb8Gtn0cIFIpOKBCdbWBz7Xh3EkhtMQm8KuBmPdA5M0MQN3hNNekweoMrwcgRGpNU8tIFxzAWIJkXOvAAIJWzfpmdNMkCLW2vu/RyVCjHQHrVYMpHT2iUaUcAsZz2PFHxMbgTZxD4CxAmT9x5ZV/F52PX4KL4/5Mjjiz8ErEtM6FTto8dEsmvGNAT2m0vrdO8QXLvJK7U2GCk6hu5TYVRE4mWhGjKv+/FucN8GC6XZ5qIyy6mVmomcds94pxI2Uk/uquUezJ9J7ZWalXSOZGoMuT+ZrAYomoMhspt7y2SW5D45Tok8XhLiUU/3afE8jSrc2JE5zVoYLN0Epd2HFSyGPaNbAZ4XFZlzg6ErRFdAfPTV+hdMLOWaBSlLMjqn/rLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(66446008)(186003)(7696005)(9686003)(8936002)(107886003)(122000001)(38100700002)(38070700005)(52536014)(64756008)(41300700001)(71200400001)(66556008)(8676002)(26005)(2906002)(66946007)(4326008)(5660300002)(76116006)(6506007)(478600001)(7416002)(66476007)(316002)(33656002)(54906003)(6636002)(110136005)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DHVJoTazGXfCbmLAT/kN3AVs7EE6Qcw6P7WlV+GRvdCfl/luAzYuaZUrA2ng?=
 =?us-ascii?Q?bZek4wuqotqTAAukQYro49cGYgkKhxW+jbip3PV290UEdp6Pfu6LAAKd0ODo?=
 =?us-ascii?Q?AxiXdohTFGxPrskqyiS04tEuThvYomkqjK/f9wBcYhWE/H0byCT7u0baDvRI?=
 =?us-ascii?Q?3gdD/cmnkCuOkDOmSQhb7uoXLoJ9u1ag9po/mNnJvnKi2TybsqSA3/GwcNmn?=
 =?us-ascii?Q?yfBvnC4RUBB4gThYTW2Ue+VuLzcw+6UnjSX25rmTGx3HikgSRz5sXmMnZs4B?=
 =?us-ascii?Q?/tYYoUi1CqivOyiq2OmQihA635T+vV0cQy4ky00WGp2rD89aja2T0Ka/yOsG?=
 =?us-ascii?Q?/zzzrM/HD3F0NeByE066pk4bG2mVCwNg2zEWHAgenwJ6SP89mWvC8JjegQBb?=
 =?us-ascii?Q?LH0e21Nb2NGnjav5pJUmUWFY56UWMjpK2Xm/I3b8DML23JhPLZVceybpN8gV?=
 =?us-ascii?Q?5iNifzj403+EAGF+bg/2BcEYd8LX4KZAqqryzj0YAvfNIfYQDeXnKiBFC1j/?=
 =?us-ascii?Q?wp9ky09W8wK6GsG0MDgtP4tftNHIhSAyMb+MdA2HEf9RZrmbHSSA9ypDD9sg?=
 =?us-ascii?Q?f69dwgDoXyvMUyTYroMjL4hS3BbiXNi3/hBB4Qg+AuVlFzBFxAwrJRjLzDEd?=
 =?us-ascii?Q?WUx8c+OxKS6vkw2TO2kOAMqGgv4NNt8LufNMj8m9okX7y5Ljmz2oPspfK0lV?=
 =?us-ascii?Q?Wc8zwwIUJT0gHaX/NyAELL4NzEg3yF+dqyOzvnX79h4quzhf5EQhk4TD2RzQ?=
 =?us-ascii?Q?fEEc8nlTyPS2tSNQCOaBY2FWcarnciLBtatn0cteLA9dacBN3XCwNzck/0Bp?=
 =?us-ascii?Q?U6eQnJEU3b0ztp30ZMYhbzptRFxL0xSX8VTDFd5xcNu+kt/ZfhUWNTh3pZM0?=
 =?us-ascii?Q?1hc8f/xKfuLIM6YCn3oo6BZAbtlDGlX9NVpV046MbSPFjISNFxl+FMVtoI7Q?=
 =?us-ascii?Q?EnC3gu5En3cWExTB6t+NrN+ezYPCayplSQwyOaeX5eYR3J10GiLRqL4RJLXO?=
 =?us-ascii?Q?6KUhFHXndp+6HmWIoWkcZIAc6qqE4gfTSTqzx1mLBJNvUUX2GHsKV+FKgwCq?=
 =?us-ascii?Q?8HAl5GjhGWwVa18ECsWeRZx6JvB2Y23JljaL2xVHxgslarU+0E1TloZgCS/N?=
 =?us-ascii?Q?+dVHIv37ez6ZYfgvLRuRqDJsCt8yB4GcM/KULP2KZkyFXdLvRNFjRiYSf32V?=
 =?us-ascii?Q?4T0Sx5f+fN0IIRp+FAfF4TYgWVAOcFdrUf1S94syrIztPSlbpLqzhpYIEIpt?=
 =?us-ascii?Q?JozLweKxL2rgTTx8loPmIKkxIrc0i/KoPL6uWPk4D3Wic2gee5PjY7m6c3h8?=
 =?us-ascii?Q?czebuqGfnOzXfzKmU6xSdEXbbKO7tbNFwWoRZyvIxLq97zxE37FZJ2fcaylM?=
 =?us-ascii?Q?w5DDSe3Q9EjTFSWoJgbPm+ItVXOWRibUax46opUEKQnT4Ll1/Qzx3SXdI5tv?=
 =?us-ascii?Q?+xNu/MOKM3D/hzmR11i+Ih9hbymurJ7YC0x4CDuiF/PBlEKBAkWT5oxDrUzF?=
 =?us-ascii?Q?cP8eBg0QTahAIYoycYAGMl2fqB6OX6rtBwpIPxtmpRyBb3t9e+vHIY/ur8T7?=
 =?us-ascii?Q?9Oy+GN79PacbXRbrDSs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cc7f7b-9890-4bb8-0e34-08db1f428e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 19:31:32.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8E79sYjd0acUl6MubYEu15z/5WlofNDRdmE30kXk3ddRw5Qp3KhluMPCTjMhZNG9VJuXJqUdW9p8qdjSNcxcTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 7, 2023 12:20 PM

[..]
> > >For SR-IOV, it is not unusual for PFs to excercise control over VFs.
> >
> > I understand the concepts of SR-IOV. Yet I fail to see the need of
> > such concept in virtio world. SR-IOV is very specific solution for PCI
> > functions instantiation, and I believe that it is already considered
> > quite limiting in many aspects. Does not make sense to me to introduce
> > it for virtio. But again, I may be missing something crucial, I just
> > would like to see the motivation, needs, usecases for this crystal
> > clear, which is opposite to the current cover letter I'm afraid :/
>=20
> First people are asking for it because it's out there, however limiting i=
t is. In
> fact Nvidia is - why don't you talk to Parav here and tell him that SR-IO=
V is
> legacy and there's no need to support.
>=20
Jiri and I discussed offline today.
SR-IOV is widely used today and in the coming future up to thousands of dev=
ices.
Many vendors are building it or already built.

SIOV as it stands today is still being crafted at various levels iommu, os,=
 device, pci and more.
Not there yet fully.

Jiri and I built the Linux kernel interfaces for SFs which are equivalent t=
o SIOVs that overcome some of the SR-IOV limitations.
And Jiri's suggestion was to leverage some of the vision and practice from =
there.

In other words, can AQ command be useful tomorrow for doing SIOV device add=
/remove, and provisioning from non-owning PF?
The way AQ is crafted today is not there yet, but in the future, it can be =
extended.
>=20
> >
> > >There is interest in the community to include an interface to allow
> > >this in the virtio spec, when the PF is a virtio device.  This is
> > >what this patch does.
> >
> > Yeah, but why? As I asked before, what are the usecases? The fact
> > there is interest in the community does not mean it makes sense to
> > have it :)
> >
>=20
> If people want to build such hardware it will need some interface.
> Far better to have it standard.
>=20
>=20
> But generally e.g. intel already said they will reuse this same structure=
 with a
> different group type for SIOV support.
> I'll mention this in the cover letter.
>

We have the following already identified use cases of a device agnostic VQ.

1. SR-IOV VF device provisioning at virtio layer (features and config)
2. SR IOV (SR-PCIM interface of the PCI spec) for VF provisioning, for exam=
ple, MSI-X vectors

3. SR-IOV VF Live migration
4. Above #1 to #3 for SIOV devices instead of SRIOV devices

5. cmd q interface for PF/VF/SF/SIOV to transport their own features, confi=
g command over queue interface without any parent device

#1 to #3 are well described in past. So, It is worth covering them in the c=
over letter and things will be clear for new eyes.
#4 is broad use case and like #1 to #3 that will eventually happen.
#5 likely needs more discussion, we can differ to a later point because AQ =
needs to progress in spec 1.3.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

