Return-Path: <virtio-dev-return-13278-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B55EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:54:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 308823309C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:54:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A52A98681C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:54:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1CD9798672D; Thu,  6 Jul 2023 18:54:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 071A398672E;
	Thu,  6 Jul 2023 18:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkvmIby+RetdCTsyHdUmtA5mHxM5m0a8dF0KUR5zsTW7FfSyTaV5vILeJlXwlpuWuvf5tawZtSZsiH0JwI0V7qjdqvE8FoOd4rKHlNuSosmGPduyHSjGUHOkR+yddOj96OSSlvWc+c9fFT2i4RRixpmXh/qnNq43+8J3RhtuoObw8xTo6vjwk7LGv/fTzf3Lk3puLIUEKY/6imDEWJL5MIsTQu/tvS1uPUxzCgzPC+HTxdlSsUBI5DWeBHw2sT/ZqZWPSBPMk6kOp+Mn2WjCXjnbs5RwAtzWyhGyNTmEBbjvk1l4ARkg3NUFSMsgka1SKDbGXMCg6/cz4Knl/2NJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O300edKL5/cmhramOyKSgIo4DfbxhnsEXd1hYKGqYI=;
 b=kBN03K3O1viHeXMaiHkjAQl4sZmBbd7XSxVfRthzviOgrasrjV0qEGNp6mf9NvCsTVO/0JZ9ljDevBYpA9n4QfPhBTQ4OA8LMIFtJwgMwmTlHdIrGBWtXwg5oZ3+TifmfU6lesstdyg5mjylHahLDcFFutPRTD9A75KDgO4J9xxSMiy5m1DPP8R5vk86kA1/M13789IJTix7Y5TM8pOIdDS1hrr0aZkJrBIaJSXzbIXaWGJ42TvPmq0TeyRfHtcZhKrkWeLKasXVZF+2euOYwIuyhuOlrdweaESKFzq9PdvSmAOBiDv2lSdMRIMRWEdEmfsN3dKKm5mMZuKRdt708Q==
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
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimCAAAs8AIAAAGiw
Date: Thu, 6 Jul 2023 18:53:55 +0000
Message-ID:
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706144427-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8453:EE_
x-ms-office365-filtering-correlation-id: d76607d3-8abf-46ae-faec-08db7e525982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VEqFqR5wD+nmUV0JgZfjn7mOskMEHAaN4FIcQSPO4bYkKbh2K3xSrr1PtasLS3zMQ9lx+32W8lLuHN66CRT8qq0smukx8LyqezMU50tZOgqK7rb29xmbU0kxeHzOw7x1xRk3NBs2BYZFTLJRohvDKr1iH3P5LhQj8y+o+IgzPt+g3lf73iL5fsQTbSuluSDPmSF+Rjc6qZcuujQxpL3e11MEDA5AM1aYa3tlPU/EK6lbbMwkPa01qK+KVvCoN6fQaHnrX9WDPi5CRr0OmFz5SKgZTSdo6uTguALDws9roY7DCbdSeqq++vGz1pTxVv8VVsZvE/9faBg9pdL025layL1eGRsN1M57ZhQx9YdfcF9jQQTLlj7T8JLsGspR7/mNwgmFmfrdp+IT/j/uo1FhfQVeeNv79CEMA8hhnUGG3CvO8vgISXypFQwOOOi8icd+ilPl7JfWZTSsqVp5aP6hQIQlj/hgOF2zC9AUMkB7ldWb791FWyoJFh6+LsEB8HKwh+HgT7nA548h5FRoKAuYVfzb4PGR2+ZUURyljFoz4qqsRSybqtOa3+bDKN6W/gBo7LjpF58WY7EWYVqA8jv4+/3R6+wFgp0tKsPIVn0D+lteBtdDjadiY9CDzSbbpnLq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(2906002)(41300700001)(5660300002)(38070700005)(8936002)(8676002)(55016003)(33656002)(52536014)(86362001)(71200400001)(478600001)(6506007)(9686003)(107886003)(186003)(7696005)(64756008)(66446008)(4326008)(6916009)(76116006)(66476007)(66946007)(122000001)(66556008)(316002)(54906003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HtcZwRahyfFYtWdgEFZC0R1DEJoz9TS004PUShn3tG5HWKCR3d3qD2dzsdT0?=
 =?us-ascii?Q?SLGICCIt5tSt6yfH+AtCLM09UrQHwB3/kvuYEIUvN/lmTlMhiN7IRDoIZ1mf?=
 =?us-ascii?Q?1yan4Sp+BQm5WnGRzUloQ5ZyTJ4xpyv/yojQD0qVMbOCQWKVHFHuWOSCbiCI?=
 =?us-ascii?Q?rNWUjntFGRzgxKgCnx2W5IFY3OX7a5dCN8ctb5BELeiWX1VITLB3/0eZ1Jl1?=
 =?us-ascii?Q?v68qE5+0ZC89wLdaCN2k7npBL62zevR1MHkFA54th32OZbDpzlr9dk3tG4T+?=
 =?us-ascii?Q?IZ68PdsTwE+uak49oe0GAR2044EH5Ha0NF/w9wj80/RR2q9bhYPEBUc+GGrl?=
 =?us-ascii?Q?RO1tIG8DyscgNilihmWv71J0hq07BVlba/mxH0lFaMdyK09znQVrtJ9IDbC1?=
 =?us-ascii?Q?LsYxxTAnE2dw1E0Lj4PD2rdlOg31VDNFP4eGrX5ADSEqcOQzkvMNxYqI1Rgz?=
 =?us-ascii?Q?1wRhGF1sPgsr8eXhxMa3WR8WCq/SLX1bOCMDkXBq1GpshdZLGvyaZuBsLx5T?=
 =?us-ascii?Q?BoWXNAYD+kqcQW/TnP0QmchJvx2hAann4VaJole4TQjQ4x+X6vMa2nzKaBJ7?=
 =?us-ascii?Q?MErnc2bYUla6NRV8MXbEO4Z/jHB9toRfwQqM6eYrYJs7ma1tfbQNPI0oBNcg?=
 =?us-ascii?Q?4QIPm3mxeavfIL+uEUxg7GdOJPt/nn7J0RSZoeyEMPCVHZ+5X9zTYAJto9gG?=
 =?us-ascii?Q?gTkBLpRnFjIJPOOzC5cCU5LtHdCxbsyut8EIDMQ4AkinuHn3Lk/sZttF0YM0?=
 =?us-ascii?Q?BRNiA1scAP1wW7ZTTXLhWxdGXUsTycvooJabaT1eeX6cJB0kkM2JGgn5wbf5?=
 =?us-ascii?Q?N7AIHMZDi/xgcjTp0ulBzBlYZvz3PyTdL3FzcCth4B6mHSz6bf2Q0g4krpne?=
 =?us-ascii?Q?XlaOVguMe2FgKcPCHJVZi3bJ4IX7yXks2AkC9Pv407j5dy0pCxzeUpXKYnT4?=
 =?us-ascii?Q?tX2trA1q7Voo704YMRLq86c0SSoTsnRhmA1x96cfcZLhUy0XRlXr8bkodNGD?=
 =?us-ascii?Q?SAVM1J3S4HhzEAmIVdVJChPWLBu/ROx6Xu9tH/+pEGNTfzLozB5wppnNiliC?=
 =?us-ascii?Q?8VgtKLPbsglBJhsSX/c6ck0ZpPs9BM3rmtcXbk+/jKERdoSyxD1uBAYRDAci?=
 =?us-ascii?Q?84LwtOBAc2zgPLLQ1aktXhPWzusvDWetLwXlsyV3vnjfV495CMXOThWxWZea?=
 =?us-ascii?Q?eAKCv08RUou1AmvmQBvx08mU6nSj4IW+hWRXOGJ8G/4ukV9vH6NL47ItSpN0?=
 =?us-ascii?Q?vBq17zdRMl9reefmN1GYBuz0I80QrMSPKexUnGAmZXEIHM0iT6rZ2G0WUMgq?=
 =?us-ascii?Q?0pEYsng9whm6e09nW30DsniV74nq58IPHAMtUaP8RBp/fU4WjbqvWHwoO2I7?=
 =?us-ascii?Q?H0GZN5D53vq8YOSZIq4IZNmqj7Lbgl5EoGg15acC3V957dFCiPOTLgzoa8od?=
 =?us-ascii?Q?kuFVA+mdCo5dTJ1G4W/eou4tEHW05100mcyEJK7s817MKa6scFiljTKB2pqh?=
 =?us-ascii?Q?1NjbW1gX9XsaIi1J2Qh3WxHGx9wlcwb03pwmZQyMq/2kuoHCQFs9nNzRqvdI?=
 =?us-ascii?Q?+UrRbZvg8i+hLtCRfUaGKFbW+qyqSlH0DuUNwOham/SMrSy7mODaxKY5PNH+?=
 =?us-ascii?Q?vqZKzWxOwAs18fzts/iB2Ps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76607d3-8abf-46ae-faec-08db7e525982
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 18:53:55.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIjVsXzJ889gvla2dIbN2V4bAX7PUqdRMG7lncAyzCXlIYEJwIo5mS2/du+tUh5qtjQ5nwro0BvtelaBaeTh8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 2:48 PM


> > The driver of the owner device can send a driver notification to the
> > member device by executing
> VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > with the \field{offset} matching \field{Queue Notify} and the
> > \field{data} containing the virtqueue index to be notified or by
> > performing memory or I/O write in
>=20
> split to two sentences please. E.g.
> Alternatively, the driver ...
>
Ack.
Moving to it dedicated para, as in this first para the notification region =
and command is not yet introduced.
=20
> > the any of the notification region at offset 0 supplied by the device
> > in
>=20
> the any is agrammatical
>=20
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO result.
> >
> > > Please also call out the unusual configuration where the type is
> > > "member" and then you have the owner driver access the memory of the
> member device.
> > > People might be confused.
> > >
> > > I also think we should explain that order of entries is a hint to
> > > driver: use the 1st entry that you can.
> >
> > Driver really can choose any valid entry out of the 4 that driver likes=
.
> > I really don't see a need for overwriting this area as I fail to see wh=
y one will
> expose multiple entries from the device side in reality.
>=20
> I do: one for owner one for member.
Yes, I am aware of choice or multi-entry. :)

> which is best for device is device specific.
>=20
> I don't know what do you mean by "overwriting". Explaining in detail?
:) being too verbose than needed.

> You feel like this because you spent a lot of time thinking about the are=
a and
> there is a specific solution is very clear in your head.
> First readers are not like this and second they might have a different so=
lution.

I am just saying to keep things simple. Let driver choose any entry it want=
s to use instead of device deciding on priority and hints etc.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

