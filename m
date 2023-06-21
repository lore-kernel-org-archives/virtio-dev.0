Return-Path: <virtio-dev-return-13029-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FCFEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:43:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9249223D58
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:43:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82BC89865DB
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:43:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 77C43983DDB; Wed, 21 Jun 2023 20:43:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60D589865CE;
	Wed, 21 Jun 2023 20:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeAaSQl1pck+6vmUUkfqy1LT2Iler/f/d0a8Xl5LyArvhLPJ0Qzcy0XkIzHPD5zSAq3yq/Kk2wrBAcVlT8KENgmko7/hdumvwfY1gvVVRy+6AByBq8CKwWs/ndmpn70WYIO6zuCGNWwZnHnR+431mWspehLqUwn0kWSr3Zgh0gw9SlEa04JVBs+4slaSPIsCSUDp4WBNUvXfSGv2+CCQkNu6e2zB+LmGvfS9s/8+ibAqnGib0Agk7F5J9GqY+dl5GPkX0Ai8MtYw5dvSwKCjmzRZKxOO/t+xgAYwU94Uk+HFTKBorOdNZTFERGN7ZXM9yZYkJSN6vQFHUQ7eGAuP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htje2lHCnmHKnih5Y697+iiYGK8WwrADri1t4q44SKU=;
 b=Iu6zEoKVQVn9p+kDzoQRrRCram3CmOP9sm79J1ouDPoVRk1OHSh1m3JARytznMpcj4vcAToUlTRUmzO2uic8gUtHJRyPpxeDqMhUoqbqNCOD60yCqICvZKLUkwBjtd6nDNWOImRa72DOUFJOzDgTyaYe1tql6IH037MYMt7q65eXPE2cSa9lXWCsMoAXrO9/rXSMKV0jTHYVNUU4HALF9SmR1LlYz47+cZS987PvOKiQ/NM/zc0cgE8mJYTSND3HXMrsewfm6mt4Atci8ROHdmmpZ9Hu1v33B5XqPYfWHXxnG980xZcUmIoMUN2fQZLjZ+FQ0fEBdGvFQPRia+Giyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SVpeAgAAEMcCAA2BzAIAAAXvAgAAFpQCAAADcAA==
Date: Wed, 21 Jun 2023 20:43:35 +0000
Message-ID:
 <PH0PR12MB5481824968904CE745CBCDE7DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619112050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621154832-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815544B2D409AC9BBDAAC6DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621162636-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621162636-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6617:EE_
x-ms-office365-filtering-correlation-id: ef3639a0-fede-4db6-ee90-08db72982eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xghATcHjt/HL97l0JKIHvQMYM4MwVDtqW17TVeUFgzvJ3sQNSzwCC4u8o5foTtWYpIf/bpZKTH4vjpUlDyMHYOilDvKj2zueQpoZ8InehI4zfbH4RO/BYO04oNu6xH2R+DHqJCJq/kolG50wyf3GtdZ4xUqYmWjqezWjq2nVpGG7MglDUf8+IJVZX0abo+K5SABbqBIVTOKhwBBmJn8J7Fs2oasnNwg+U1UMh4J27a6b882qYgg59AYmj9TkpNfzDv4wJMEErWGEhSs9SuYMAUwVZVAFmCoOQ5lsWvJltLtQn81w+ORF9VJ0JXhYfguM+1u2AJhqtXuLSE/tSa03mk7xQdbMgoE19FK9gcawHOicU7NnmhSGW25mkHBhgWnRqzC4Nd9nWsHFcQr7RHlhnVhsiTdxyt9wdpoJk18b4mysGwYEuhQcKpV1rMINY3BudNbkLjveUuFYYl69H2YFIQDCQVq/HyrhgpNDN5lqg4wsDrFzgcWO61syN/nC2juIq0URHZaMEgh5hVp+hXkDqY6q0vVddYiVNYE078xJuITYrulTX9iHh+3hE5Ho6fwrzgZmGsM9oJBVgzOTgIRcGolBs6EpU67X0awtABlZW+Vd8tX7nvoB//oi0bU8C3k0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(71200400001)(122000001)(86362001)(7696005)(316002)(55016003)(4326008)(478600001)(6916009)(33656002)(52536014)(54906003)(64756008)(76116006)(66946007)(66556008)(66476007)(5660300002)(66446008)(38100700002)(8676002)(83380400001)(8936002)(41300700001)(9686003)(107886003)(6506007)(2906002)(186003)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uvmmvVsC5Dr96pGekUrWpnDfnN7u8XbwjBiQIVsRk+KqeNRSdeZRq50liUaZ?=
 =?us-ascii?Q?bYtNnGIznMALFpiRLaRZ2owp41Mz31Bi0bxmOTYGgJ8lT9Fy/nWezjPVLXCJ?=
 =?us-ascii?Q?Wm6QcH2aLIDRXcjXhOF5/8aSE8uz/GFfhEDGUVd1Qz7DFTYkyHeX9lr3/VBg?=
 =?us-ascii?Q?rqO2bNlzgvNK7dbVi93KUbBE/kz3xWTDwgC1hbB2eneqKl4MjV3anYYMQAj6?=
 =?us-ascii?Q?7o4z+vKNWRkXxTbE2n5y7mZAPxOhW3YH8A1rNk9lO39yEWhmu8F1wEqepX8J?=
 =?us-ascii?Q?sOBEl31RuruStEXh0jWx+/sx7s5wk50dy9YJoqm4Y3NilJrtWFIz+Dj0/GN6?=
 =?us-ascii?Q?hTYZfrcaO2tk0WcCklhxJHvFYgKX0+6gS4/SaTrV19WUFV9jqZdQO0L36b/R?=
 =?us-ascii?Q?jK4ondjtTdGzYLgwFs64SoLsCp1Nys/A75jmtq37VMQvplquXA/wANhCNnTO?=
 =?us-ascii?Q?bIHSDbKCu45gOUa/PcxaCpelguT77JuNkw6DpOk7CnxAS5VyTpsN8hwZCsz0?=
 =?us-ascii?Q?teGkr6/MHH0/870nC53BGGnSIKbHfHHQ85sqrtULMp4MIlG88n0EgPeN3m54?=
 =?us-ascii?Q?MChuViSa9ogIVUlmh1NZpBPKhMRtPlpyPIqoxrKQ+/gTkp8kdPul9uTEGVht?=
 =?us-ascii?Q?dm8RGBlZOzQyb5P6PeL7vByLG3eaniUT2EwUE5ZXgNFy0ITkrsQJR1DFP9u+?=
 =?us-ascii?Q?c/l8fnXiUwRIus5cgpv2PgEakySbbxFCCyq0gMmjbg2wLFIIRAF7vsd9oD/4?=
 =?us-ascii?Q?zxm3PTaCwrHrB9plqw8yoZmB5hp+1sb2bf20hlZSdle0hgwG1RZj0cTszNBf?=
 =?us-ascii?Q?UOYYODIjHd6ZqdB6DZxwauUlrVC7coxwMbYKAgaQ8mU/pPfvMe+ynSdpvSMV?=
 =?us-ascii?Q?ldBP8EA9TMYLAExjbbzSaKZ/03tNvTd8oYwLrbogysev657MYfPDj+1vjIG5?=
 =?us-ascii?Q?w4K5CBwemqnbFsKKyLDuoUfdrg6yNWxMAtBl6wJCq4E/F8gWVCYBPKSc7amK?=
 =?us-ascii?Q?mQgde/pP8crdPNu9gIJ9RqfUlh4rZtCYKFoyYAv8qkSlXXwXJ6pR7ZwvH/i6?=
 =?us-ascii?Q?jc5zMxV4dXrsH46MM60Hv7naM2bCCCm94OTWs9b8oJ3lOmM5RbPnghtL3KIJ?=
 =?us-ascii?Q?Bk+0Dd9NyBlb4fXNQRje0hTVwgsSVM5y1ZrzwZVuauJIvo1qpWabQqN6JueY?=
 =?us-ascii?Q?v2dSLRQeg1bgV8JWIIo3qQIpzj2Gly29GQGAE06VapvQgSfmmE4d4fJznZwn?=
 =?us-ascii?Q?qMN/wv5lkexEQOoRL+6G4U3U4W4A4WgrH0rbM/hXs1OhwjKJ3MFPj3Fl5FYR?=
 =?us-ascii?Q?TIOZTAQSjn4xGHMF0VnoIxQoK5iE3skmPp3T5QbKDLtiOfYhLgnXBG5pe+7k?=
 =?us-ascii?Q?k8RCWJc/wAEXdRXaOZqLMK2ntD8LyAIqmhiL2xLK08mg8dYDbs4K4qxshsju?=
 =?us-ascii?Q?jLAIIgf2sl/OYrr3AIsuTjJBAf0MYky0sWfX0n/Uv4OILBrgf/MfT+EUkN1F?=
 =?us-ascii?Q?GZRnujEh3pihWUcH95iHqTOYvKNiZejIzj0f/fydI/p7AxPU0GFUffkN/oPo?=
 =?us-ascii?Q?0jDlQ0Ojo/ztVq2wSrmauuYcYcmNhMC/FTJZdnJLWtwtRD21gv6dsKa3xIKk?=
 =?us-ascii?Q?NMEJxqgu8yNhf+eag+q8BaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3639a0-fede-4db6-ee90-08db72982eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:43:35.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQWn029FBcORSfytrnDPIFr9JO+fwNWMSO4LE2Nhgn8eYw/dtFbKcuD3G4Sf/+ghvhTOZgit8mHHbah+gmv1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 4:31 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: virtio-comment@lists.oasis-open.org; cohuck@redhat.com;
> david.edmondson@oracle.com; virtio-dev@lists.oasis-open.org;
> sburla@marvell.com; jasowang@redhat.com; Yishai Hadas
> <yishaih@nvidia.com>; Maor Gottlieb <maorg@nvidia.com>; Shahaf Shuler
> <shahafs@nvidia.com>
> Subject: Re: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce=
 group
> legacy group member config region access
>=20
> On Wed, Jun 21, 2023 at 08:22:58PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, June 21, 2023 4:06 PM
> >
> > [..]
> > > > > To put it in our terms, something like this:
> > > > > 	when a legacy driver accesses a member device of
> > > > > 	a group using the
> > > > > 	legacy interface, a modern driver can intercept
> > > > > 	the access and forward it to the owner device.
> > > > >
> > > > I will not mention "modern driver" as it has zero reference in
> > > > spec and don't
> > > want to bring Linux terms here.
> > > > "the driver can intercept" is enough.
>=20
> Maybe a (non legacy) driver can intercept? Would that be acceptable?
> Just to clarify the confusion above.
>=20
Non legacy driver wording is fine.

> > >  	when a legacy member device driver accesses a member device of
> > >  	a group using the
> > >  	legacy interface, an owner device driver can intercept
> > >  	the access and forward it to the owner device.
> > >
> > Above is not correct.
> >
> > We have 3 drivers in picture.
> > 1. guest driver
>=20
> this is legacy driver, so easy
>=20
> > 2. hypervisor level member device driver
>=20
> this is just for notifications, optionally, yes?
>=20
For notifications (optionally) and for configuration region access.

>=20
> > 3. group owner device driver
> >
> > Trying to write without introducing guest and hypervisor term,
> >
> > A group owner device driver provides the service to access member devic=
e's
> configuration region.
> > A member device driver avail this service when it wants to access the m=
ember
> device's configuration region.
>=20
>=20
> I agree, it's getting complicated.
>
> >
> > > > I will rewrite it as,
> > > >
> > > > The group owner device should not expose PCI BAR0 in the PCI
> > > > SR-IOV extended capability for the group member PCI VF devices
> > > > when it prefers to
> > > support legacy interface for legacy configuration access using this g=
roup
> owner.
> > >
> > >
> > > This seems to ignore all my comments.
> > >
> > I replied after that, probably missed in exchanges.
> >
> > How about:
> > The group owner device MUST hardwire PCI BAR0 in the PCI SR-IOV extende=
d
> capability for the group member PCI VF devices when it supports legacy
> configuration access commands.
> >
>=20
> better but it's not a PCI BAR0. let's add link to sriov spec, and name it=
 VF BAR0
> same as in that spec.
>
Yes, VF BAR0, will correct it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

