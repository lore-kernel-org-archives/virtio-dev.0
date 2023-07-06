Return-Path: <virtio-dev-return-13271-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014DDEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:58:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 459771CA25C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:58:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 363B198672B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:58:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27F01986728; Thu,  6 Jul 2023 16:58:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11EDE986729;
	Thu,  6 Jul 2023 16:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+WglzWJgzV2S+ONAYJ2e50id49u8dVbMAEPUoBTLgEOb2wIbQq4wY4yqIPbwothKS66GTzfxAZmUcb5YW/RjBsgbQZZeERHdHf9OtFW6xcZVaL9StybzguvDJuRM9kJCKA8ZCgafNgeyxb8b7AWK6zME0cAnqnSKgEerPXO7gxZjJ0qPKNY2oo1z0ta4V5Lw5YalaTGL3zwHgRTysGBMXf4F2nfz+9ObuLZP+Gtv+HuUvfuFcq37YZGaTHdyZYiO/YlUgK485n8aMkty+BlnXI6IgQwiO1vxPP0OSM77br6RVuEoRrY2FKzgIX7a/qjAFg9nzAB4V9eFBxyYL9O+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTALYzMrarpn2N/EArV1/XX2/T+0yuwvoPuk60rUDFk=;
 b=CHx1hacmrsGYz26f2Kfsjv3Tnzwbqg+WwvSXwicMhesTSB933GbkGlzuFeF3Wrr9q3DOqxgKN6Pe2NYWsK3LG6kPNFzGqyslwvxRVBL0e1+KCgeILCTvBfQZ0j8kR/zM7ZSRZenu6M0k+S4AJo+3OSuBXrg6GhSxrYaKeaNhlnPXw5bOTjH8e2ovtsaTo7i8QaRHWzCdTJFF3U5wxRoyHp+p31jv7fZFjxvmBUrI4WXpA+OBrsyuFIO4QEYzSnrNkKo86Jp/nS1gW/iQyLRiv2PZtALO31Dkgjm6HaSl0LZ+6ejz+btA6kAaZlqh7gywoo94RZ1xKNYM1A/LwVnsjw==
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
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7Aw
Date: Thu, 6 Jul 2023 16:58:51 +0000
Message-ID:
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706123954-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7432:EE_
x-ms-office365-filtering-correlation-id: a5e671ef-9ee8-47ec-a13d-08db7e42460a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BVY5dF6wtWX4iux2rP6E3UF3qJS9oeeqVxORe300IVxEYTFC4gseQJ43G+2R1v/moODK39zJz+YvceOB9/dvjAIQPKNQ/1O2uD7+EObTmoXR0CAOM6FZtYFCbVPln9MKOW0yJUolmpVg1dxH4UDRntPaEeuu3FXe0gVkX5LjFGIKjTR7qYFsUZSorqIRQ1cPNeEcywgb5ehNerfHcp9r2WGMH4IQkFqcdLC0sqBUEv+UU0QctEcD2pCuDHMWy0L+lSYAE+L7AfdGOJssMdDUrM4A98psRe9JzZyOcbUb4I0jRpBqzENIOembxfjEbxp8TjT1hRXhLPmeKV7aj3wXmkEN8EHvGSsMe2elRQ8DOdnI/I2itsJX06E6jfjYswUTik0YqBa55JHpmLejxU2Pp1x++Vqz1bfIFfIGwOTkhQ1idA7D7pRd7eFKOa19WMuYt2zApPEKp5g0or27HvYFDKhYUZJwshEqBmBhduUx2xlMB2yMD/i2gMFb+OHO/6gezI2h3exiKsabRHzRPddngwBnyWAqgwVG2gWzjfl/3w0OosBSPwpjh74EFPo2sYNwxqdFEr5kCpBIzQ408W0yP5kEmtzw/hdaAti5PMrIOFwkSMRCPpOlgICsu9G2MP58
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(83380400001)(38070700005)(2906002)(122000001)(38100700002)(55016003)(8676002)(52536014)(8936002)(107886003)(86362001)(5660300002)(66476007)(71200400001)(316002)(66446008)(6916009)(7696005)(64756008)(66556008)(76116006)(66946007)(4326008)(41300700001)(54906003)(9686003)(478600001)(33656002)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gqfm2aIJxB2urQA7cdBGFZn5iQ7qj6MSWtbx4+0nobYTpRTt4UT7FqhMlnio?=
 =?us-ascii?Q?OZgFaoUjNPp78+hdJIGG73RySLullTg3ViAdF695B2ntagmvj/GVI7kwmXvo?=
 =?us-ascii?Q?vLvl96kIp0cKc3ff/gO+LrEztzr3eBimXLF9nrKd0yDfA9JZ2PqTC9xwPG1S?=
 =?us-ascii?Q?JTFXh8WN/0I68RTEidfhjVaagOb+GiDMXUCCALshFqbli+G93LMgK0mwsON3?=
 =?us-ascii?Q?/e7fPavKCY2J+zCN0BJJ8m7lzZiCc9DS/TCcM9JcrYAzHWIQ10MUJxQDH7L5?=
 =?us-ascii?Q?aTBAIuFwEpZ1AB1bvKYytVlGdxgBmkYql56EiBPea6nzxL3JqQHx0LCGsogg?=
 =?us-ascii?Q?kihGYbhyvSUQVqia+LPgcMe505K701lDyVEs1jEpsY70kA2eiSrxsVgDHxbD?=
 =?us-ascii?Q?dzhtf6DXxGQtOX2sGahp/1+bxsUcDzG7xtcjgvr4QCsrmoo3ZsWZ3rv00Mg3?=
 =?us-ascii?Q?doDGIe4rkMam38XylZp0Yz5moK5NwPyqx3oHCf6g0LaWjklriUc56U2YXOTS?=
 =?us-ascii?Q?Nc7nZc5po3PW6/idRnNzpPuxPn7V3e+dS/xehd6/FQMUTUjvBOHRoyTmgA78?=
 =?us-ascii?Q?h6q/GdFhnVS7o61jPWtB4XZpLclnQrztD20Ha1Pay1SpJ0LkPtkfChE8bv0B?=
 =?us-ascii?Q?rybrH/9NNjxPJOT7ViXAnYGpbKHAafHY4PIOYnJM6Bi7gcB+T6jJMq3em8I2?=
 =?us-ascii?Q?Lx8VJ5PQPDQiypUCvF9bRAFzLdr5ofSssrXVnn6KgZlj/amMiEBbxY2qNRm/?=
 =?us-ascii?Q?eMP4MRg+jZpvpqxIKfofRwcUjCguCAvQxMBnaxxHlq16Vg2h/weRBUyu8B0T?=
 =?us-ascii?Q?W065E6s0VSiz4oIzA+UTfL8IGaVkWkBcj/KtIGfSy1pX77cFxkUEoQ50V0ZY?=
 =?us-ascii?Q?b2R83IOcCw46k0551mfLbiDJ4zhlb45lDQQvZt0bTEaxUsvobVE4kTRcKcdk?=
 =?us-ascii?Q?+Y38NX2+8HZCNL6LMEtFShyCDQypyZslQAsAXo1rKr0kurgD/A8o8m57NY7P?=
 =?us-ascii?Q?0c308kGTGwYRlJT7FXNIGxcNSkdjr/OImgyWQ4RwHNAAZRrghzbnhRXWTsad?=
 =?us-ascii?Q?VRlBFwlISF9/kVHC2cqiOqYWXALuNygae2Y35sbbyA2QmN9NPyw3PliD+r6k?=
 =?us-ascii?Q?pXjHpB7j7u1gWne1SlQ5JXQvcQ98geF7MO3uaje6EDwOrUzSWq4gDlNiZG03?=
 =?us-ascii?Q?Ru7bhof8584s8Ina6TkRK7oW9xUStdKSx34VPBA7OXPgkCS8kbGO2NcPqFR7?=
 =?us-ascii?Q?E6+9igLdH0ZlfnELcTBkr2iIm6mg+Usi0iCKj0Ob87Is7n8uQ3jZVp+NDay8?=
 =?us-ascii?Q?KMjEPDwQQnEe3t9DmJvlDEr8lrbyRljIRs2b6wf8h+E9QhsbJ1oDkTpe8G4Z?=
 =?us-ascii?Q?hWoyN9HEFEUepfwfDCHFqNHakeCy0flTpURsNW2V8pthJlSsVsfnXFSd1TJX?=
 =?us-ascii?Q?VTsZo7nSn46H8CYaYWjp8vy3pxfvuZCo5XNe3NkOSwKlbcV9+pXpe7YfenLf?=
 =?us-ascii?Q?bVmwM+4R6I1HWfrMi3ltrU6U7sEp/xYbw+gRUfH4CHCoQvQH0LaZBwCIwB3v?=
 =?us-ascii?Q?Y11kc8ObvCbPK7AJOO+20OGzInQIgtMH4A5MiRwvydfXhMLfk0r4G2cvBPzd?=
 =?us-ascii?Q?LOKV5o0HZ1twshW+xVknhDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e671ef-9ee8-47ec-a13d-08db7e42460a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:58:51.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khJq7CE9Bt9rVqoWSo46kF3S3bwx0MOiFeBM072A02EsEzqskGXzQDG0Ub1AzLt28FghcJyg9RGC9BObyxqaIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 12:42 PM
>=20
> We will need to detail how notifications work though. The reason is that =
the
> legacy notifications are received by owner driver (which is not legacy!) =
and
> forwarded to device.
> We need to explain exactly how this is done for people who don't read min=
ds
> and did not follow 3 months of mailing list debates, and explain how this=
 has the
> same effect as triggering driver notification through the legacy interfac=
e.
>
I am not going to write driver implementation in the spec here.
But I agree some high-level text is needed.
With your suggestions
1. to merge pci and generic in one section,
2. add description to notification,
3. past rewrites provided in v9,

The draft of v11, looks like below. Please see how much more verbose to mak=
e it, if at all.

\paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a Virt=
io Device / Device groups / Group administration commands / Legacy Interfac=
e / Legacy Driver Notifications}

If the group owner device or the group member device support driver
notifications via a memory-mapped operation or I/O operation, these
notifications are sent to the device via accessing such a notification regi=
on
using a memory or I/O operation instead of sending the notifications throug=
h
the administration command.

The driver of the owner device can send a driver notification to the member
device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
\field{offset} matching \field{Queue Notify} and the \field{data} containin=
g
the virtqueue index to be notified.

However, as many administration commands are used for slow path configurati=
on,
a separate fast path mechanism for such notifications is desired. For the
SR-IOV group type, the optional command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
addresses this need by returning to the driver one or more addresses which =
to
be used to send such driver notifications.

In one example, the driver in the hypervisor which intercepts I/O BAR acces=
ses
for the \field{Queue Notify} can access the notification area directly as m=
emory
or I/O access (depending on what the device reported) instead of slow
administration command.

For the command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO the driver sets
\field{opcode} to 0x6.
The driver sets \field{group_member_id} which refers to the member device t=
o be
accessed. This command does not use \field{command_specific_data}.

This command is currently only defined for the SR-IOV group type. When the
device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command, the group owne=
r
device hardwires VF BAR0 to zero in the SR-IOV Extended capability and the
group member device does not use PCI BAR0 in all the Virtio PCI capabilitie=
s
listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus /=
 Virtio Structure PCI Capabilities}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

