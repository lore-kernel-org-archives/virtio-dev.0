Return-Path: <virtio-dev-return-12771-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3226CC7EE23
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:44:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C3E526A31
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:44:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77347986197
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:44:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B1DC9859E5; Sun, 21 May 2023 14:44:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 555ED9859E6;
	Sun, 21 May 2023 14:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7pBo/PHyjswnWoD2/GlWrnOe1aAm/jX5LovyOsn0w2cXPP0ERsf/tc+eqChJClP9hac4n0ydRvaTybo2dmG1uGeK/oFt+WqW/6QhPvk3SPBkJwCMEckHJRyj/ATNiLIjIBxN41vZQVpx53B6XZCRpUDBYyevTLFRK03EgzRa4rL4G68LEDetO77vH3PwW+C28TtPSed5MIg1Mjlb/mL85VSyLLcpivQaFzZXkQ8HaiBVND0EL9rR547WX/jHB2VQKS/o0ZroEuVCfO6yy02YUOg1d4FgeHEtZKJH9VFP9S+a+xyQjHDYL1FGFlP8SccAXHYhurytwUDawASU5FFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JtslWpnGEz7NWnEz5OQGeVuij0T1HkfyT0xoQjHTGo=;
 b=OYUpMRC8yUeBZYAru6BjGUD0NdjTRLyjo1b5zYhzumGbxga5LGuV3BtfjaXftcrJQj+wfVjPRJPr9iuxAZga+APOhWQ5jR3ZEq2J37EoU5DpGp//45LJOxcr9avt7vvFwiaXBsISMR669xIU8iWBUEhQb7MT+twGo5hpgYq5JAOzFkwjmQzOaV64YB9HaiDrsRpwQlu4PaTblqCLlzJRryj0poBv/BkYZJWk7X2e9O0rzQTkixo0tVh3w7n+K3BWyvp4scMnk5p4uiTHcywUROxgoMUBp9MAmh0/z0YIpy0cUXHpZVw7zSRoDsyZ0YNTPV/54Oc8uEzYlztltgQoEQ==
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
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8A==
Date: Sun, 21 May 2023 14:44:03 +0000
Message-ID:
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230521102050-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CYYPR12MB8869:EE_
x-ms-office365-filtering-correlation-id: afbba93e-d9fe-40bb-553b-08db5a09d296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ymZ0+wYiMjZ3Tkzu6oOeZYCIxf7Sbx8r1T5dazHwwQnV475dRBg7UCxLB38TKkBKBs4ImaWT/3WJTBYuwhB93nyYonHXCKE2nwQhveravnwZjWvmlwpRojgbRlvYtk5ttQc3hAmQaZ89T5pouO09OFRd3gc4+n2k8Xck+iPPcUwtWUAiwuHNGIypve7jzYe/aeA89fxF57G3iJveMduOVfJ3r3PQoskar6LmbGBsabMk4cMLtoQ93VH9ovuR5H51B/+mBJwgQYOppkXdQ5ykJCJL4Z5zpMreJZlizAsOKS7QRjgnPgEH6MlcjU51rlrnmnkaMd88wlNIqjexztLEnV4OMUma/ij6Dcid+v0q+Tn3Sev/1WT1ryu+jXxr0tLcVuuLNQjABFNQeKjvp3JO6p7c+UEbZT5Ql+VU2dm5jlKYzMk9PVnn0IUvephZ6+iWgHY9DBBR36ookZCnwADBThWnfbHj4L9vrFC/QxzfQl+0AMLJLJ9ntBv9DpIePYCddvuJBpveQjB7z9MwHjg/HwA0m1J7+5Jvl9YjONULBxSaf6tkqOao2T4xNBSGP5c0JwZNf6/r3hlnukwHrX9Fr1+fRrP+1FMAFTSkdrZzvBX5Z+0wdZG2ARgpXNeUOAqN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(38100700002)(122000001)(38070700005)(33656002)(86362001)(55016003)(8676002)(8936002)(52536014)(107886003)(5660300002)(26005)(6506007)(9686003)(2906002)(186003)(83380400001)(41300700001)(7696005)(316002)(66476007)(76116006)(66946007)(66556008)(66446008)(54906003)(478600001)(71200400001)(64756008)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fkOuSZSkb0z0UanJjPUIcXUtGEcIBXzlQsyiWO/k/6xBbaZIDmQP2nyOOnzB?=
 =?us-ascii?Q?h0nNpeUQmwQZTzqToiSp4FkcAu9t4wzYijJNN3V5xff3pgddchi6ByupIMV8?=
 =?us-ascii?Q?MpcFYXdB2acCjZVUYoT7j2xPN2Ra43Rnh8OfHKtpYT9/ODGeeCFdsbXnLICX?=
 =?us-ascii?Q?WpmaFeKH7qcfOXZdH2FIftes5vDXDvEhEV30vChWje5pyFj/BtVEllW4SMwx?=
 =?us-ascii?Q?PkekZVcsiFuB/x87PgHGDGwU5DhxOnQqRnNFGOsv+P6n2HPffyCmJ5IxGInU?=
 =?us-ascii?Q?HPGQzbUspW+6nDAGGvfhICfW4i1bozj9fU0ifI17KNHrVpehGrP7ajfn/NGf?=
 =?us-ascii?Q?iibbZFVXCFhc5wtorM1DKqM8ZG2h1iUKjksHGZE6f5agtrU0V0clmmuW/HxX?=
 =?us-ascii?Q?GBSiOx0toxTotLVBxHtZG3IngGoD8IsVaxvT/y90AC48/tqyb7H1921Yre8n?=
 =?us-ascii?Q?pC+w/CK6JuSfsmPGa7KlLnI1Qah9gmnh1/G0AtZ3b+naAO1SEJHRyw+Od7PD?=
 =?us-ascii?Q?JAIzN2CdoBajtuIQ7bTrOgWt5xpjyn1n0SkOKMmxplgDggQeuz4+W0e2Vml+?=
 =?us-ascii?Q?RpLMh+nUyuCAkQKA6OU5N7eCE29Fk2UN4wbPyXNECvj0yWpUt3WqWEwH2lBW?=
 =?us-ascii?Q?h1M9HquerNufXZN9uVxkiFQsOx+ap8Yx1lIAVUslXKewa0rSzXp7n79+9PCM?=
 =?us-ascii?Q?tEeV02GsKixFFsrtllmHmBFdaZ4iHKzsz4ZyJEgHLCm5trAk2lyRZmL/Yr1I?=
 =?us-ascii?Q?iOaq2OQRIafbfsHPFpQVsM461sxo5hnlmrhoNLad+08G1oIOgixlKnp5GpHn?=
 =?us-ascii?Q?8rQx9WrgFFxxdzPMq7I5S6iavC+fEC4FeDSPg3omz5zD6GSsoGkvtiOuDFJu?=
 =?us-ascii?Q?I+NvCkuH4UzhI9DGQgyo64riy0lvxSgU0s3r26ZT/3L6CD39wCj8iXK/ivcm?=
 =?us-ascii?Q?AyyGjUGMqIbJZha0z0hxqy3CRw9aJS5Rj9vSthag8nEfI1TBWgxfhHK5T0ke?=
 =?us-ascii?Q?Io3zLDI0QUYSoOrCF8wsoq+1tU3fbzqfGqG6WofBg6kqfMm+5ZgkaZ+qnDap?=
 =?us-ascii?Q?HNs2/pTN/BIFuZZsVcB/tOf3S4LV3DUhmAjIXONaEYbg5x9bA5xFq7alpsuV?=
 =?us-ascii?Q?F3HZvJ+EtS5FG5AnnMMCu48ha6DJmctOCQT8NTahpVWXkdfd9tK9koOiuzB9?=
 =?us-ascii?Q?Tba9ejx0PdH4yHKLSfvKzAQzxKxfEfwCNGbn5bzgAcg9HardL0M+E82MTWoa?=
 =?us-ascii?Q?XsieHG09S1+dxCCW3kQE/lE43rxEvw0qAWn9EeFfA9yhJHQ0oY+T3JWBshVK?=
 =?us-ascii?Q?rHbniiCSVE6KLZ4jYMEY3NsgSwbGkDQzrnUoVz44hv5aApuj2bUaNsKJ3m1I?=
 =?us-ascii?Q?JOOuEHzqWX7XsJpPEP8xzF6fRJl7PZ52tdPCyhsEgQyziV98dnGK034arcVv?=
 =?us-ascii?Q?GyM2YTMPVJw5TJGobDIrzO9xjhiJ9jJEhEOg4cvQfKWYpDfB4VcFFFpcABbL?=
 =?us-ascii?Q?HZQZUUgr+Yy4W24Iveh3CtKO56O/CARFHJBWod5CgN07QiR2GaoIukjoRkG5?=
 =?us-ascii?Q?fauheqYPyS0CzHhwmsw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbba93e-d9fe-40bb-553b-08db5a09d296
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2023 14:44:03.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fd3J5xgEOOBY+rqV8KC7AICgwU8KH3tSS03cqHtlT2YwAUkoD0LG6F6iS49uW1ubKoBjQvGxkLhM6qctLCi+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, May 21, 2023 10:33 AM

> > Yet you initiate same discussion point that we already discussed again =
after
> summarizing.
> > A driver is not attached to two devices.
> > A driver is attached to a single device.
>=20
> And that device is the owner no? to send commands?
>
Not for legacy registers access as discussed before.
=20
> > If (legacy_offset =3D=3D queue_notify_offset)
> >    *db =3D guest_supplied_q_notify_content; else
> >     virtio_net_send_aq_cmd();
> >
> > "simple" is really a subjective term in this context.
>=20
> yes this is qemu. sure.
>
Not limited to QEMU.
A driver will be able to do this as well.

> So we have legacy emulation send commands to VF or to PF.  Okay. But let =
us
> avoid the need for VF driver to send commands to PF to initialize.
> Just get all information it needs from VF itself.
>=20
>=20
> Maybe it's a good idea to reuse existing notification capability, or mayb=
e a new
> one, but let's avoid making VF driver depend on PF commands.
>
We agreed in v1 on Jason's suggestion to have the AQ command and yet you an=
d Jason hinder this in v2 with this exact repeated question.
Lets please avoid this and move forward.

> > We have already these design choices and tradeoff in v0 and v1, it does=
n't fit
> the requirements.
>=20

> So, I am saying one model is small driver for VF and a big one for PF.
> And to keep the VF driver simple, it should get information simply from c=
onfig
> space capability.

VF driver is small that does usual vfio passthrough work.
PF driver implement AQ for variety of use cases that we listed in the AQ co=
ver letter.
VF driver implements 5 AQ commands that you suggested to split from 2 to 4.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

