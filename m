Return-Path: <virtio-dev-return-13274-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AADEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 17:47:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 237B4157EEF
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 17:47:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ABFA98680E
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 17:47:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0D51F986729; Thu,  6 Jul 2023 17:47:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8F6598672A;
	Thu,  6 Jul 2023 17:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHY0s8Qxn6ZWY8ShARx2iUhq195xVHeiFl53isO3bH7jWtm5bUWLD6kiuH36mxmoXdlzTHFEIvNpJhGjoGbBI1BYRvNMUXlPmdXUqhQ9VTlmlXc12tUfj0qZ+BKLtCotdQKb2DofF5LlLiZJhnN3y/9URzAdxikiDBq7OmhcZFmzLy/RAFDUOC0qSvI2/GriGHVF2JIhq0pcAy6M+X7UO+uHPcXeUniNiIcfLMlVvHynweYsrfTohl1I6XdDbWF1DKNFEov2ZlZKPcv3WNv8i5WEfjvYjskdQbsryLjkuiVJcnXcWxikhcNr6Y2lNWdZlRSdJjQZf0tSFNMMnnHmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAsrRF36PNNVPQS+tFrkU3RrZWIMP+KpRiMAGtPSzx4=;
 b=dgnVIzvulFH043bmDpHSYQo2U5B574yxSaZ+EgLlBjAi9blPGGPJsww/sWoXSjI6+LufIW+F+gzRdkR8e+j2Prx0F/wOiEJxQdyjk3+t5AEZNbL3Tb9Rrc4ERtjZ4eo6yt8bWUUEuLT9eibcCHFxGypdBWZAFk5s4EGUBABnSVmHojRCrr+NaT4Pgk0/OW9eN6noYoZxwmpvQAVW/OHs4NIOiTPSA26oH3GIV4lPraVK4ENh3DyD54/WIxMG7zCXkNe8LNZxJqXDWRVQLgHAvJ/EHZ7VOJ0d9c98iqSHvTVRe7kRsKbM2W1Cp36UTCl2o0Tf46dcYscstDtHXmYAKg==
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
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYA==
Date: Thu, 6 Jul 2023 17:47:08 +0000
Message-ID:
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706132638-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5025:EE_
x-ms-office365-filtering-correlation-id: b34f452e-a2fb-44de-7ba7-08db7e4904ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nXG1F8tAtDaQ+hIribxUEMvUlLNVMusgPbTSe30oSBhOHIL6vLdKn1tFtTovYMXQ7CV5QszxTq/wzsSh2u8Vou2KWmbzm53LhXyCaIwrxz5a3Wwvk139XNr5A7/qBElp/BbirWNw/r9jAJG0bhy70Un7CBaV9VS8448GZn6sCOIwaZZzGDasjfSc+4sNSAJUuSiv5V0A/vOEWFBPhfIv/ejMZedfoKkSqpU9B0GrhkKl7Lp9LFGWn1DSL2JcsgW2+xTuUlkXoVOVvRKYMnjzdmtHtV5qw/so8ZYJwkdZOUrLHp7K0jT0GMhhSOL84OxfQRjg92VP264pyE6L0Uxukh92P4QPBL8XIo+3vkT4vYqyW8y6B5OrK1mruZ7xej6Dqvblh4inGeZStHehrn22KMfuCHM9Rqocm2eEherWGH/adBuH8k74q2zz+WQy0qcaz5VhIrTMX5eOAT6lOCf3krQsLCuNOv+dfw4HkF0BGT7Zdv1OU7xs6T54EckpRju3SNyHgyMu5PSYsGLcuRUULuSKfaxBPZqtMUowAoizSGmVC9yS36XTbc/mwRZI96i+JVqKLWjKbw/r86xVWsU7ErVxrX/ORAlLZBd5XcX2U38bS3EgenoTStdEcvmMYwDA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(478600001)(186003)(107886003)(6506007)(9686003)(86362001)(71200400001)(316002)(83380400001)(54906003)(38100700002)(7696005)(6916009)(76116006)(64756008)(122000001)(66556008)(66946007)(66446008)(4326008)(66476007)(52536014)(5660300002)(8676002)(8936002)(38070700005)(2906002)(41300700001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5tfmByBqrIN4RCJ4V0Mg/ld0BSBcg2XXZmgWIpRS0MIg6/0YoLOdCoF93XEF?=
 =?us-ascii?Q?JEDWSG/ksFtGOBeipoqW1NOWnqb/gQ9pwbsVfh8ccKbyVPf5hQOh3Hyu5rcq?=
 =?us-ascii?Q?Vuv6SrHYWARp410iIfpj5f7WYUTl9aTuOwDX4TBDUn8KWR5/2oHINhdVbXIj?=
 =?us-ascii?Q?q/X+W5scPabc5TNlCzblwdXJcEcqYzbjqID08yY3pWy54db4w/Scn57eXQ20?=
 =?us-ascii?Q?w8WuupXsk1m6/KAwKMLAMAbjCik9itd/sKGAE+2Ez1ukzUqi+mwZrNGcD75y?=
 =?us-ascii?Q?oucfYoAi75DZRLzX4DbHEuLPLjjLkO4toDEHJy3kz/pe88Noh1HRy6ZUYSLM?=
 =?us-ascii?Q?puvIRWyP80E8payNfDxGWtv4uKYZvnJw2KyAD+RxfEcLXxmEwYXkHyBUKepY?=
 =?us-ascii?Q?kZHk6RmHfbBnflFA1mQenfh0MMmw88rYGhmnRDscG0Knt57LwRX35O7wDzIk?=
 =?us-ascii?Q?1xjff/Bng2ZsZ48uS1DCfTAuInBNTxXjxCIuRpeDrETrwM/v2QTq3H/aDKvR?=
 =?us-ascii?Q?FbYM3sbNPPuOqWBuMD6xeMWHhE3RSxgqitGQ0fXzgnQgPAyf2jh3rB83CTU1?=
 =?us-ascii?Q?uktnqd1yDx+Vt/+ZjB1nNqJq2QYjMfpDB/JU53fUSCuBxqacn9ccqoDOERMY?=
 =?us-ascii?Q?Vh91LtAdWFOZDZ/tPbKqoonts0MevBeZfBJQoPRpEehBOgbQa4uLXOiFKfCQ?=
 =?us-ascii?Q?AI95mvLOAbfSa9ALwEUB1C3H/VzfFh+t4v2iqzScbiw2E6l7qUsosUBKwGJ5?=
 =?us-ascii?Q?xkAcwfFqwBj9/fAw4g6+L7hT7t9iFBM0XV5D7UwQKk+D8KTUqxiGFPztlaCS?=
 =?us-ascii?Q?nYgrI4V9db0exEvWp8OMxn8TIiZl1EoV2FrfoBYX6fmoN1IIRF2m9ZaVE55m?=
 =?us-ascii?Q?Ex/mteWUIkBZ+vWweeWvfrY03eCJ/GvbI2YzQ6vFDfhcxQOVvU/BhKQFxGMs?=
 =?us-ascii?Q?JKI16WIC5N6WSNEDgvbXnsrktpGzt8Tm/A5gAdpjImRj/l9VgKIVuEcH4aJl?=
 =?us-ascii?Q?BUiaeXpTCasRcqOi8fKjcpbhhozIjSXQzBtRCZayl6tBbcwWs+PxZENSoy/+?=
 =?us-ascii?Q?ggWBNzlU4yrdlS/shlFr/1DSG5z7yqN1FH/HND8c/4UbRqBCZl4aiYm9/qHX?=
 =?us-ascii?Q?G+hPMC1O21YwuzuEC2s7+NrfEbcs2Y46/qyeZ3rjI6sRbrty4CNKcpIdy2ff?=
 =?us-ascii?Q?jKvTAon7fI1EGINcYK3QjH5yy6K4R4k5LhThA9qm8RUK6ARc+dFEKCPyEP6E?=
 =?us-ascii?Q?YJyUjHu45VUmCgV7pfbh0C7Pfp0gt/iLp7abhJCiIh5P1wihygElyqoktVna?=
 =?us-ascii?Q?wdNEVeQjLyzNM7+nUMUiaVs2SKzFFSvQuYe2yjJyTNAQ3Mbxb7WAP7fY9iDj?=
 =?us-ascii?Q?wa2YzIw3RxBf/pIzhBztj0nYFWBv4UZVGU9M6yEhOR07VXheoZh405iV7IJu?=
 =?us-ascii?Q?fjT0ryG91qr/Yz97eORtWFDoxybEgFtBAzaM0IsPbrlWt0ZJBU1d4gByxkkq?=
 =?us-ascii?Q?yUK1IO3Tlxz7HM5TH9aJ5Eaq72UUh9RH0itdEJxqJcRXVJaWaAamrS5niV/h?=
 =?us-ascii?Q?c8Kv42+TrMB0TBfODqpJNDdS1XzmsmsuBcC7zdlTcl79NQUzDT+leilfLs0Z?=
 =?us-ascii?Q?IfX6uzARO8Hhc1hNs/EatyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34f452e-a2fb-44de-7ba7-08db7e4904ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 17:47:08.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXtvb3XH7mWePoQ0bPx+c18ZgKc0LzscAecDSgcECmp4Rj7U5edoQR3wPckVu7FAFjhusQeNJmpd+1si/PCUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 1:34 PM
>=20
> On Thu, Jul 06, 2023 at 04:58:51PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, July 6, 2023 12:42 PM
> > >
> > > We will need to detail how notifications work though. The reason is
> > > that the legacy notifications are received by owner driver (which is
> > > not legacy!) and forwarded to device.
> > > We need to explain exactly how this is done for people who don't
> > > read minds and did not follow 3 months of mailing list debates, and
> > > explain how this has the same effect as triggering driver notificatio=
n through
> the legacy interface.
> > >
> > I am not going to write driver implementation in the spec here.
> > But I agree some high-level text is needed.
> > With your suggestions
> > 1. to merge pci and generic in one section, 2. add description to
> > notification, 3. past rewrites provided in v9,
> >
> > The draft of v11, looks like below. Please see how much more verbose to=
 make
> it, if at all.
> >
> > \paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a
> > Virtio Device / Device groups / Group administration commands / Legacy
> > Interface / Legacy Driver Notifications}
> >
> > If the group owner device or the group member device support driver
> > notifications via a memory-mapped operation or I/O operation, these
> > notifications are sent to the device via accessing such a notification
> > region using a memory or I/O operation instead of sending the
> > notifications through the administration command.
>=20
> This paragraph adds very little information - just some vague hints at ho=
w things
> work.
>=20
A hunk added this paragraph back.
Going to remove it as description is duplicate of what is written below.

> > The driver of the owner device can send a driver notification to the
> > member device by executing
> VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > with the \field{offset} matching \field{Queue Notify} and the
> > \field{data} containing the virtqueue index to be notified.
> >
> > However, as many administration commands are used for slow path
> > configuration, a separate fast path mechanism for such notifications
> > is desired. For the SR-IOV group type, the optional command
> > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> > addresses this need by returning to the driver one or more addresses
> > which to be used to send such driver notifications.
> >
> > In one example, the driver in the hypervisor which intercepts I/O BAR
> > accesses for the \field{Queue Notify} can access the notification area
> > directly as memory or I/O access (depending on what the device
> > reported) instead of slow administration command.
> >
Above paragraph is really more than enough for the reader to implement.
I will merge your text of 16-bit notify vq line here.

> > For the command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO the driver
> sets
> > \field{opcode} to 0x6.
> > The driver sets \field{group_member_id} which refers to the member
> > device to be accessed. This command does not use
> \field{command_specific_data}.
> >
> > This command is currently only defined for the SR-IOV group type. When
> > the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command,
> the
> > group owner device hardwires VF BAR0 to zero in the SR-IOV Extended
> > capability and the group member device does not use PCI BAR0 in all
> > the Virtio PCI capabilities listed in section \ref{sec:Virtio Transport=
 Options /
> Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
>=20
> After reading this I still have no clue at how these notifications work.
> maybe it's in some other patch. Let's see v11.
>
There is only one patch now in v11 other than two fixes.

> Just making a wild guess:
>=20
> it is true that
> 	to supply a driver notification to the device, it is possible for the dr=
iver
> to write the vq index of the vq to be notified, in little endian format, =
using a
> single 16 byte write at the address provided ?
>=20
> and I am guessing that
> 	the write is an IO or a memory write, depending on the
> 	type of the BAR referred to?
>=20
> then why don't we just say this?
All this while I assume that what you wrote above is already written in des=
cription for "queue notify" register in " Legacy Interfaces: A Note on PCI =
Device Layout".
So no need to repeat.

But I realized that base spec is totally silent on it, but still we are sup=
posed to write here.
Ok.
So yes, let me add above line here, without touching existing legacy interf=
ace section.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

