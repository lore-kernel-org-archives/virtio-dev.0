Return-Path: <virtio-dev-return-13240-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A58EEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:35:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4FC3E7607B
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:35:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8208986885
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:35:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B423986722; Wed,  5 Jul 2023 16:35:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC085986721;
	Wed,  5 Jul 2023 16:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsksOem/OaYNk9ao29qduXnLTKohAXBdjzGO3olI+ynOm2GSXnpPNAtduCU8Ml/EnizC109E8hc/LG1h3tri5nir0SYITJjCRr192kCG7txiZmdq/o3jEaGwl25WfIrHDcBvm322DvHI4t7HzDHiTh+s17Ed//74dnvjOt77OHq5I2H0THdeoPX+qT008mK+KXec7UnptTLQ0gMrjd1yQrocXTL8X7zkVj7iJMo+7i5cIGMzrnUAW3l5uJ5Uv/LwOulBgtkhZtfuLm6ew9T9UGQzXb5e/NkxiwUmZEG3hVe7WB15Vsu/ftVYfLaFI44AL0DbrylGfRCsi/104OTJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+3c8OD5Ornu5fZlnUd5es+3NEjCAsKVuDXugN65hYM=;
 b=JDpUcuqMD9HGHNPjBAfGGyrnFKkWJ/khbGRa+sCG9tmEXId/dahu6VcmaPIZObcKcaTnc7qVq/2YUq/OTs7pM7ihafbMfdX2QO4MQhg/ZrbJOY15k/L23K8FdZmdqD1cAS3PbeC5B4r4noIj021/eT3g6zExTrIYB/hBEYBb0A2hIlqCUZBfrhy8rpSgBf95egx2floXSJMWhQ7H6j6tUC1gNugUw0CIiIwj3kmhGjFN5jnkCsludKva7pjlXxaHNoUbiD8YJfGYylkWzTnbICkFIz95uxAe6ofrYk3jAeprkP3p+D8vuuKqYehmfHty5PInySS9gCT2nd3/A4xvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v9 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZrtCPgh0YjplyXkiMVqx0qNPzCK+q+BGAgABme1A=
Date: Wed, 5 Jul 2023 16:34:02 +0000
Message-ID:
 <PH0PR12MB54816B8F00A8D403B9035B7BDC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-4-parav@nvidia.com> <87fs623bcg.fsf@redhat.com>
In-Reply-To: <87fs623bcg.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5455:EE_
x-ms-office365-filtering-correlation-id: 29582f2a-0eb8-446b-c6d6-08db7d75a44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nKWB2pgUO4Qtc2SpfTeL6rEsbcP72Xxwqye4Jw1VJNq+z7pvhCADapwuYZPj0ikPmj1rnR9bt9qPZX554De10L1AmYLCYhtvwp/U96vy/rsD0YfMHvbKMRNGZZ3V0qvO2EIvEVYNVrrTBlxQe3Z9HxNmbAzF5GyPVa97w8SVsuZO0tWEQH+zSdEhRMuhRNsSUA40gauNevl3ij5lt4+sVokYsFYhiNet3O+N28NRTE+AlzR364JFjCCNuFvsGe09btSJkrFipmyQt5JoQmGci/AStSPG7iCwIPruVEs+UE9KH3m2brKHwoyyjNrPlT0sM7pBwoWsy/f/rp5f3U4xA/uyqRILe02FKWd2yTJ3RzVLAYgb/hIYLcR9G7SqGZAZVkrhISLAQ/31/yF/fy53gYs+TIXTK/d0Xd9QmaoOEsRpVgAYZu32erLAj/MCMVxVXsq+f8KAgwm3h24dAi/i3sRMN97iKa9YNaLpvtjKiaIHZwTzBdLsiCzYKAIXbGG5MA+a1msaKJJ3IxS+TLiFWqCCvD9sa7U/VQi/9Q0JceDG6baMWKwu/tWZrjsJ8Us1A3pO+lReYpJ1OVUGu3v7ycWr3dIVqEKUL4V83rMJfnlu3JgnD9xbiyEMQVQ6IX8L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(55016003)(110136005)(54906003)(122000001)(7696005)(4326008)(478600001)(71200400001)(41300700001)(8936002)(8676002)(38100700002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(186003)(83380400001)(107886003)(9686003)(6506007)(26005)(33656002)(86362001)(5660300002)(52536014)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tMNStbko17Khqn3zejhq5Zn9y2/cqCcLr9jJ+TJLfotaQJgmu/ZxVp07WCio?=
 =?us-ascii?Q?/vz2wBrqQC2S4fO/jpfvr7/coKQ6HeY7TKSpdXesJGznEx7XVMMwb+3LqhnK?=
 =?us-ascii?Q?NNiEHLRWktvKl5JpQ3BQy8u3IbFZ3j4argOIDPykC8b8paKpgjYY5eg1hAeQ?=
 =?us-ascii?Q?DMS/4nhwXHzhTOmopzdBa8anerYpgzCjnVYb/t4ePC1a5GlUpNXIfZBxW7cH?=
 =?us-ascii?Q?WpiXdXvB0CGxy54fiB89/EAY3ubdmfaRhSo6DKKmD5kxJDmCttqll+U+0t2A?=
 =?us-ascii?Q?vlmLpyPt0JGvriUB72j+uaukkPCOI4obBBGYmjludoImye1u+kEwD0b5gw4r?=
 =?us-ascii?Q?PoayEDnZsAPwyWB/koES7ObTo4XBAruuFQJ3OjY1nuCTsW2lg5G7XLbH9Iw3?=
 =?us-ascii?Q?ga8IyJUjAyhW+4oFfsamQovevzu2LS9hkezFL+PbYzaj1//089ExcxHnqFfb?=
 =?us-ascii?Q?wM/J2HbdQ9RefLWK2vagR3tCWsvOGYysmpiii/Mu6l/c+t8M8XMr1yw3rz0P?=
 =?us-ascii?Q?Uf9rhqmd0kPjFze5HIHA7gpnolYDOwZncOMRNOA6KRKCGl9Bd6aHQZNVlTt1?=
 =?us-ascii?Q?FXFqXmbGUw/76wAw+QH/cP36we7HVPZj1ni7BXL53M68DwZdkQUG8ckH+VaL?=
 =?us-ascii?Q?7iTGkwZ1nxFsx1om8jLeufhOkIUNjqA3zC6FRGgfqXwtLe4bWRLVilT7qHNJ?=
 =?us-ascii?Q?fCWGgtxS5ahIgH32D9uIfs6viwtutZ5mYnLf3cmOZN/S1Sbs3P5n9llLfXOH?=
 =?us-ascii?Q?vKk8qGA/bXdwBih3AGgj1hh3QAUQ7tp6GPgI8FVwiLD/04/LnMq4MyQT/l85?=
 =?us-ascii?Q?0/jxJp/LnmeSRyAgLJy9sabrVXpvRh08ltIO5HM4HFQMVIBd0LEqM26C58EX?=
 =?us-ascii?Q?MvVXCi2tjKafrk+aK+WdFb0jiE5Uf4LmzsQhXhwkavVj0Yi9nueGN1NFSTji?=
 =?us-ascii?Q?j2MR6nMlm/GMOdlAhmuvFoYBlYees7xqJwQvPdBq3HzZOx/rPyOpZAhIxWDU?=
 =?us-ascii?Q?LjuzyxkRywHvULepWhY81AG8v+CpJ22oBAO+gQjX7G8pBRjw6YJcsrHFUkSS?=
 =?us-ascii?Q?j+OZLblQbnA99UMgSPMurOWpPyls3OARUYeM76/oCUsosNGqtVmFlMaTX0Va?=
 =?us-ascii?Q?HdAoiQM8KMY5U/1e6+rIdUfs+hk3dbU20/YSX2ngPwq6zM2pLWdG80n9lI3p?=
 =?us-ascii?Q?qH8RerzldZIOZZeUrvpRpcZnL5JKs/TCT5gUH7OpHHcZbNbljoKl2QG70nY7?=
 =?us-ascii?Q?28zRhwZUUg84+esDv5vnt75FIyNRfR7rrJxsxLEd54F0PCezNEOxQSk9wQlN?=
 =?us-ascii?Q?vjVdVlJA5dHy3yKaX/tpaEX2qqALEmmLnuGvhLmEpfYDbtdd6ISYmW/diIaT?=
 =?us-ascii?Q?NY7cJlRJzyQLz5a7VJ+kdVYJgYc2oqFSz/UXGmYN/yPWoxq5bDvjJ4teugkE?=
 =?us-ascii?Q?lTFqdNWScFL/68FAuvyT5XC9t/fiFfj/4yU5awDpIgQDN21LYOZMKqWdmAvr?=
 =?us-ascii?Q?orQnuGiuGNpbpv85ui9/9NVhIndorgFfjuYyKbkVX6zY7a8q2pDqPy4lqRFu?=
 =?us-ascii?Q?t0KuAm0svuYSSRu8JvE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29582f2a-0eb8-446b-c6d6-08db7d75a44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 16:34:02.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+fO3uqnm0gKh9wHkPN0scV4a8Vaz5iar2TAIIaGrz2i4xleZHD/S74JJd9a9vSCheL3vsj9k8eMLKPFmR4cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
Subject: [virtio-dev] RE: [PATCH v9 3/4] admin: Add group member legacy register access
 commands



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, July 5, 2023 6:24 AM
> > +
> > +In some systems, there is a need to support utilizing the legacy
> > +driver with the device that do not directly support the legacy
> > +interface. In such scenarios,
>=20
> Maybe better:
>=20
> "In some systems, there is a need to support utilizing legacy drivers wit=
h devices
> that do not directly support the legacy interface."
>=20
> ?
>
Can you please explain how plural is better if it is?
I see this a lot intermixed in the spec.
Why cannot we describe things using single object "the driver" and "the dev=
ice"?
I prefer to describe things without plurality as done in many parts of the =
spec.
Please let me know.
=20
> > +a group owner device can provide the legacy interface functionality
> > +for the group member devices. The driver of an owner device can then
> > +access the legacy interface of a member device on behalf of the legacy
> member device driver.
>=20
> (...)
>=20
> > +\paragraph{Legacy Driver Notification Query}\label{par:Basic
> > +Facilities of a Virtio Device / Device groups / Group administration
> > +commands / Legacy Interface / Legacy Driver Notifications Query}
> > +
> > +Even though the driver notifications can be communicated through the
> > +administration command, if the group owner device or group member
> > +device supports such notifications using a memory-mapped operation or
> > +I/O operation, they are sent to the device by accessing such a
> > +notification region using a memory or an I/O operation.
>=20
> I find this sentence confusing, probably because it is too complex... wha=
t about
>=20
> "If the group owner device or the group member device support driver
> notifications via a memory-mapped operation or I/O operation, these
> notifications are sent to the device via accessing such a notification re=
gion using
> a memory or I/O operation {in addition to|instead of} communicating the
> notifications through the admistration command."
>=20
With instead of, it reads simpler. Will change it.

> (I'm not sure whether it is either or both.)
>=20
> > +
> > +A group owner device optionally support querying driver notifications
> > +region
>=20
> "can optionally support" ?
>
Ack.
=20
> > +using VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY command.
> > +
> > +The driver sets command \field{opcode} to
> VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY.
> > +This command does not use \field{command_specific_data}.
> > +
> > +When command completes successfully, \field{command_specific_result}
>=20
> "the command"
>=20
Ack

> > +uses following structure:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

