Return-Path: <virtio-dev-return-12129-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC36BC77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1012C9EED2
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 042B29865F7
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:07:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC48498636D; Tue, 11 Apr 2023 14:07:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DACCD98636E;
	Tue, 11 Apr 2023 14:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRNOwjk9CXIcGkh1qzVVZoX+csfQMrtmJ1psj9j94MZGici+Jr5HVHMYxOQucA4s2Re3TSfS1s8b2OfFalapaLiq1s741f8TCh2V0q9bIEB8YG3Lrj+NTF/jshYeqmU00/8+5GwfZ8TLJ35GqSrcrv039BctUktRQljpx9S1NtLojmTgmlcLDxDcSVnR7C4wly9JsE9n2ub4Ob6rz85sjXRchDFPyQDl3fZu7Jgi2eQDWXp1vFibFletZN6PaZSVIdYwSwpzir0kby7JoO287z1nhibe2G8tA3dYnPDo/9OByBll7n8PBkoU067luB4eAHIJRK6Xf4/HIZw57s8Geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neffoKFff56+M8V5//OacLiSdFelXjXXABk9Dz2RRa8=;
 b=hQ3JSyfDIXASeFKs/s3z5UVpo9LD3qOcaQO5lz9g8QiDRt8Lq9FxXxVOi4LaMwaSE1468fAKZc14pn5g0WpnwKoIKvigZlWZaDl3kGoiyroeQCJ0NEQxyRta6EE2q4EKZIdi5FdsNWx4ZK8RpnwDD6viPplECJHa5MF7XkiPWVVYYHkVFvfzH2dn9xQibGZXGtDjV3ZFqBR+3I7MNpG/SGwT7pZiucu1WAt9B5kuuIXiAV06uR6MlvBs57hA+3ZNRwvn0vl12LE+8An6TztbPtNsxQ8KEnr9bY39Z9LEiJKxZ+y0NeaclYvKCz0a3S8yeDU0QIyuu2Afhd8bQ/Dh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgABQjgCAAA6TAIAALr4AgAEQlICAAE50gIAAcdIAgAAEJICAAABX4A==
Date: Tue, 11 Apr 2023 14:07:27 +0000
Message-ID:
 <PH0PR12MB54812D94E60C793734DC8DCBDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
 <c6e986e2-4806-6635-5d8b-0f70c51c6b88@nvidia.com>
 <20230411100209-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411100209-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: 404751e2-60ab-4c18-cdda-08db3a96152f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VgUMxdJmJx1KTvdZYlaLzjkX6wCFlCYMbYRuKvh0EvS4zPVnY+obIBt34vJLQrI+MOvbAZGJR0tvdJMywIPRzalagzUk5ZGtcw7tww0KcoBaD0I0kEmbyejPZgGhYHpFdesmBRP37c21hdzE7gMG9FyIjmWNr9i5BAj1WNsKntxIWdroOqHYxPL8aOwFbdFQVPwawFtpRMN9zmqc301fhMiPMivujdZJlZ4HvRgGWAltePVWB7SGZH0E23pbbpyPqdk1bPpkPRGJt/oMrafUhvEW7dzkVW2iqB8alwNPgeu4fLWhm5+r4XtVsVymnG9WJhuZTD2+hOPrWR5cYlYOR2v2+CAyejZZcVdEObc3GfLdYg4w+hL9vO4OnHZhfbSgZCteO+EM+wPus7ptEKdwG0cXpuqMYtneMqKkqWBmiwu/Pvyao6AMWgwy3JNKIFOMz59tO1XKHfdV79c3Ye8d+2gVawAGZB0HBuQ5eCo/4uyFXL7G2aHWiR3Sg5fZTSfrmrpIH1x7h0GzFIJs6ClhG+VEjCvEsjNpdXfgz2Qb43MrGMizpeY5G+aNq8iysIqJSh4PsAEVsaYjK14prvuNUSGq6jCTpgtMczor2D3FZVo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(33656002)(86362001)(41300700001)(76116006)(316002)(64756008)(478600001)(71200400001)(4326008)(66446008)(66556008)(66946007)(8676002)(6916009)(54906003)(66476007)(7696005)(55016003)(5660300002)(2906002)(8936002)(4744005)(52536014)(38070700005)(38100700002)(122000001)(186003)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DJmVgjyle6vX4BqMDpCvtBXmVuS6Ux6heo9VroyRs+mu3SM7mqC7ITXTCYpl?=
 =?us-ascii?Q?VzsEIlhbm2dWidFkoxSWdLG/2FWParWRLtXeOvibL2fg2x2Kw+xXbpWA1CqZ?=
 =?us-ascii?Q?6Dv5ZWpODD2xNYNNcQjZIFEPNvloens2KMdmefSj8xaNGyRrrMDlenPMvLWY?=
 =?us-ascii?Q?TbNpkGvw6AzvFHCoRyokK9iCvPQumlsY+Tj+wyG9yF5Fd58yTRpP95yZTCm1?=
 =?us-ascii?Q?VupL+ajclbEAtubDqXBwpudJTGRDKNpPLQePsTkuQ28bmnlOBk7IvMlOWrMu?=
 =?us-ascii?Q?MzNHb4SjJ2uMP6wE6EFaBEQlu/tX4/KrsYTpaBAi1oKQpvbzKQFoP2kolXBo?=
 =?us-ascii?Q?hM1up5kZKUrumSkDRt1lbUbwDrkN6vWwV0zowB6Nxyw5sHAC3ZDFgCEqxk7G?=
 =?us-ascii?Q?3He6RW11BURC2gJkyhc1BLG7IbXdhCyPxbw79yGu8JSKce69lK90oxuXPfLE?=
 =?us-ascii?Q?/45gmst5nW21OlkHhF9sQ6qvdmVcP1MDh7eLw73M6ZB5wGKdxZAmPPgZKN2I?=
 =?us-ascii?Q?FjGnfX3LhcNPZKUgfKKzubU1TX5D3j1G/56LFb8lXqcDnFIhMOQEUTtgmpSs?=
 =?us-ascii?Q?JxKcLBWgHQU2aFTsMM3GZo+SaVYJS1VHmbkckEEQH7Xb7FMVmDsLnaXts02h?=
 =?us-ascii?Q?Y8zHTrL2UG5tjd/+kvT/Pv1IwjlAHftmN5rkqcJHk6/SATGQMmbbaQjRjGcA?=
 =?us-ascii?Q?+kBTwLixQJk7/pM5P6EocyvLyu8mE9KTOJfE2CkhB7u+BGk3Q5e6SM1uHAoD?=
 =?us-ascii?Q?i1ZiIrmh5tACDqITTUxxwdPZxTlD01gOk0lixuFl60Rdkn2lAUiV+YbPUdyQ?=
 =?us-ascii?Q?tpDYEwIBGZZV7gIRzXK8vELo4Vv79IerEOUKEL71g6HTRxlqKeaojzjlKEmd?=
 =?us-ascii?Q?4jNw+kRN9+iD4uu3uU0pgPpvgihPWZEp0s4kTU+WFwU/55yBlQAK/PGpuASJ?=
 =?us-ascii?Q?uf+9QPDpud3tYj8YR1UK4F4xS2SQVxP/uBke/rMA6QCVoCSWYRG/lCqKZBeB?=
 =?us-ascii?Q?rsYoukFDVHvZ7/eO42XxOaXieqYHyKk2nDVQKJn2JWK5cLbTiKuB5FNMMDzW?=
 =?us-ascii?Q?2aYNlV3dLpAhQdKKxnO3q/UsjECy1UuGMaEPM7f1VWkenmdFML/DLgokF+aj?=
 =?us-ascii?Q?fsOls+vxq05JrbrBPGkFrRawTCqnH/+cty6n2RoR5pz8QOHGesBT3xYSV71/?=
 =?us-ascii?Q?DE+0zfEkb6I73dEZuPDq+mppheVIWHWDzZFfyNr/bjoVsv8mokuMDvDhs6Va?=
 =?us-ascii?Q?SaFqAPM7xz7LO3evj3SKZf4adtkCiLUIiksq+ySrSAhMi3y/04a5/AlA3B8Y?=
 =?us-ascii?Q?Wo06n1PuhQw4nddxKjwEg7qQKZBfLc+c8YoTINGR5CVjnxN/K77eNJ134hBQ?=
 =?us-ascii?Q?3kKACQX7Hr06IhdqtbEUopkEU8oOlNlTDuK+42sR7xC3NXviZupy+cb8cV07?=
 =?us-ascii?Q?N+kXWMnaiW1rFFqPZvUYCVZkAJux2+ySfuab225h+M/IaawbfxH/x27qj66h?=
 =?us-ascii?Q?Vt0FKDr4DjyTcQ4eQC7EeIFcl3bWHLUEA8/9i6DEixRg2ZTe8/0ltnjmrMlR?=
 =?us-ascii?Q?it08Kc++pRzDtuAhAuwYv7+5Qr8bShPz/33iTE/7SQnHJZDAgPtcsTZLRTNr?=
 =?us-ascii?Q?FKICTOkTlUlkltx8LDZGewI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404751e2-60ab-4c18-cdda-08db3a96152f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 14:07:27.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WpauzOOnBmQWhxwgJ7Ux9LJ8OijUnF5oQKQ/e1hcb/AcvWdAN9t5daocvu7gHvzJD0D5X52/OLNe2nErb72qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> > >
> > > now, imagine someone building a new device. if existing drivers are
> > > not a concern, it is possible to move capabilities all to extended
> > > space. is that possible while keeping the bios working?
> > >
> > unlikely as bios is looking in the legacy section.
>=20
> what do you mean by the legacy section?
>
Existing virtio PCI capabilities which are in the PCI capabilities region i=
n first 256 bytes of the PCI config space.
=20
> > New capabilities like legacy (and pasid) has no backward compat
> > requirement from bios and drivers.
> > so they can start from new.
>=20
> sure.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

