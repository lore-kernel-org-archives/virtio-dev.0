Return-Path: <virtio-dev-return-12659-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE2C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:47:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4E25D5B9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:47:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B54249866F4
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:47:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A2BBA9860A7; Thu, 11 May 2023 20:47:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C5619866D7;
	Thu, 11 May 2023 20:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRNE67uIqazXqFnLVILPUP9Yrgb2uMu7wpOsf9rRU6SBNZQrSVzslVRLuMJA5OBP0EpOr1qO72jZ5tC1gglWBxNzcwVcS9sVIQNmjAowGW93YDtJWm8NUcf838knByMQyXhi7CKCOWXyxxsnlz1y6IPvYzECqqKozyQE5OU+ue7/WR+x1hFWdhPolQbrIg48CYTOLbNOOopj7Mf09P/cl0qnuh57bStPNt86fdaTOwdyHlOeKKxmdNptcs3R+rjpCsmQWbwVUKc2LkZmdg9hOIYZM6STZma9mmaFayEFATIUCMY4/aTcG9rjujeaWaTIC9G2zNHSpqlGN2WcoSNSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjJgylly4QEwwJG8tPhDb+X7Hy4176Zn4t2Q5jbYXRU=;
 b=UxlJyVQAK4au5q+h0wZG9gJ4k+tPthpvBVUErwRowbLYxLidflvG1EA3VBnN0GN3FEfx65Ys0CrbYInCnGPeIS2bDErlX//LNtfdOUvoY+yRDdquqGwuvOO0KMaCFPryerTuqKsrnxkhX9EQNVCScnmKyjD1u0ZG2sUvMmfD3bUt22Z64s0ciUWksBQc39Kohwe8NCCsjeoqF0LfgkPuFxo7WFLMw5N6eEvpk8obPHr+SV+8pkDawOhyNowgCj2olg4q/iVleLcuz+u48hL4F9Zv9UJnZIO9hra2kdJPiIFOGJ5A19CpL3nEEQoG2O0WL+lx1yup6Znxu1OU6dZ1fw==
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
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAAGRoCAAHWGAA==
Date: Thu, 11 May 2023 20:47:04 +0000
Message-ID:
 <PH0PR12MB548187706D06D135D3C4FF03DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511093309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230511093309-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5045:EE_
x-ms-office365-filtering-correlation-id: 8556bf2b-f440-4e3f-9760-08db5260e09b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TBYnYUmLvJHporJCK44n/9XN5H2y88bjhp3xLqbeygDvYLAfzJJ8VF861tnbWAWYl303GQYLUMDdG3dkygv7Fenin0qP/Us3zllxwWoqG/c1ONcH5EkTVP5zXGUl1ZIaxVM1tXj+CX9zKjY0khqph4WnjhGPSEiW3sNQooBPPUpCDn2KruEW0nqb0FtEPnxqvuPEM640L9Ui8tynmpa19PAq9r9Ue5RumI2NMqOW2Nie/VOfUfJ3cvuuM6onJKpHz4mUsCh47H/NM/LwacEa0t1a3axagrUw7UuckvHnTJ8QmSRubQ7CsMPr+R/87ty4BNTAFuSXI7RmfL4oIgck4xWyId5bL13/S7EmZwBGGoqL03dZZjT2RVswiPJREP/TMJcl8mBjDi9G1V3siQ8HgsUhKZ1uJdeAYzQ1Van4rGNF8iJX+15//pUvDVX9NcMt0nFxwOkJQAumVAOYDLkLfy0jSEslNDHaEQKkbldTo7rsi8ZM+HxjcH5eQRlZPFhPv2H9VmlFB6bV7dI0NhEuPw7ofcAskdzTB+jeME9PgjanXaP8TuvA6s+NC6hWXBGYoHyQQkh4iltNHZiBiza3h0j1Y1bO2NVR+bv1ejt31mQooWBlYUZgpchGhd/9bV3k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(6916009)(4326008)(66946007)(66476007)(66446008)(66556008)(64756008)(122000001)(478600001)(76116006)(54906003)(38070700005)(2906002)(5660300002)(4744005)(8676002)(8936002)(316002)(52536014)(41300700001)(38100700002)(55016003)(86362001)(26005)(7696005)(9686003)(33656002)(6506007)(107886003)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vrqfiZRD4fY1Q6/AaFEvAvHNEwr2gPCT/7E6guthUHkK+RsX8A+Xm8wtQRfS?=
 =?us-ascii?Q?nwhQU77+FhRFNLTWeYHFi9P9Oy0hLnjnLpKyGySDuDy4/fcXmGJYUioI0Cnr?=
 =?us-ascii?Q?uybhFgKTGozeahJg6dQUac2e4SYolHkyAN3tehfX9nv3bd8cJZtJKl/qnfEC?=
 =?us-ascii?Q?6QpAva5h7frlBYYnea7M7cJOGztzXzYtK7yjG7SMyYtZTUKzIL+5WHg8xAER?=
 =?us-ascii?Q?udz/M9Vgp6Xcu5LQKANOZuI6+ShWxb8CXZEviRBp3RiO+CmJYhps2S7aPpyj?=
 =?us-ascii?Q?wPGRMHv0cS96mey/JuuH7lAdQlpLAaH/dzUE8OZmi7AGi+YZfiKwKQViBgvy?=
 =?us-ascii?Q?LF0zmo5HpkO3htQl6Uz5zSNi4GVte1CaNt81/HOPjKdGPa1liJpgxD9SnOyr?=
 =?us-ascii?Q?SmqpsW+p9fONp8MMhEJdTouT4OROL3Fupm2k31K8IVxkA8EQCLII9m2T6xMO?=
 =?us-ascii?Q?bXpG9Mr6O7DXpI1Waa8e9QjdFT9ymOWjE9GCWKzOqjnN21yBrb7dMpwx1Oou?=
 =?us-ascii?Q?FIO0Iuax0w3VGa25tdHsyjs+gDxBu3OnSAbl5OmQaOx9a9n6OHuKTrBIqMxq?=
 =?us-ascii?Q?DcJCmQY11gJpMyS4YZ0x/n/aEbAD4KMPnR8tnrniP+Uiewy1Cnj0RepCcM7S?=
 =?us-ascii?Q?eloqQuIS4k8tefS7QCeBilmS8sAevAGEoV5/VrBi277gAyg9hdGQKk7iPMX6?=
 =?us-ascii?Q?kr9/AzYFoRmYtp+j5+M0nW5kAp+2aAShX1wYuiGT5moWBrxCDdyrC8T4own7?=
 =?us-ascii?Q?fUp5hxJWnUJehDVuKp9qAXIrrf7s2522dVT29ZYbvVX00G75s1EkJyod8pWc?=
 =?us-ascii?Q?dQvYuQbrlsQNKIc+uSYxUDGCVt47jTcRI0rXDVYPILJle/smpyRwqzt/KqCR?=
 =?us-ascii?Q?mWE+Y11LSm3XJqouIiP7LheMZeGHKV/R5ZaOW4lIIsuLciREl+zm3yAzUit3?=
 =?us-ascii?Q?Juuxtd8mreF04FU/C4grrzQZPy/uhKnjFJo50cwui4pDHg6bsGAu5gmVtxUk?=
 =?us-ascii?Q?RJZnh16/dPG5KolYp+DCS/Ug8oAjThYP79akZJ5M8a7KnrAQXjtptQ92u/JY?=
 =?us-ascii?Q?J7kmrqmPsBdF5RLfUuiOElhgFHxY2xRN7Wyqvk2TlWza7x3zxBo9NAY0toL5?=
 =?us-ascii?Q?eiuKydL4Pmyvsg5AG/HwiXSbTuj0pqVp88mTkbGUB9sA33Gqp0xrJ7riCgDw?=
 =?us-ascii?Q?sSx6jIhzVJFR8dCF15Fq14OdekC00RVw3pnC4b45xd5AD+RGYBq2RTL2c8dk?=
 =?us-ascii?Q?M8ZTXUf9rqOlMNZvR9jNOiQyMBZgRU3arMHV5i+CPIX20DCQ6tD7Fc1n13vk?=
 =?us-ascii?Q?HUITVG7GmyyK526zFQFToP/e2kwUcGUu0WcfFPfJ8885x8FFiLREInsnlNVh?=
 =?us-ascii?Q?AnntwijSKXuq8uaqykkeEzTDUxl8tFcbtlenR/A63ilPP/+iU+6HbF5U7x19?=
 =?us-ascii?Q?yDOMAHEGSu8oNL0DuYfbxu2305ixKI9t7OCida324VZBpopUii++f15jboIy?=
 =?us-ascii?Q?hcc7wVqoEbMdP+DRrZRyafdqmUbFPlUKoCFNaF6ug5K94z3DFcyFxdZCclC3?=
 =?us-ascii?Q?f7sh495nbO7gaHR5nkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8556bf2b-f440-4e3f-9760-08db5260e09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 20:47:04.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEJ+IExaEU5/Z61aS5KsUHBYa/ayBOYl0U1sFAhmG9dIzh1N1YnMDe55zd8fKGZSN83EwKUbhQyxHO/MC2vcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 11, 2023 9:39 AM
>=20
> On Thu, May 11, 2023 at 01:28:40PM +0000, Parav Pandit wrote:
> > This is not the objective to transport all PCI virtio fields over AQ.
> > Transport VQ commands proposal commands and commands in this proposal
> are just fine the way there without quoting it as "transport".
>=20
> I mean, it's a transport in a sense of where it will reside in e.g.
> linux virtio stack - below virtio core.
> We don't save much code there by reusing the same register layout of lega=
cy
> pci.
> But let's at least make this feature complete, and then we'll see whether=
 it is
> cleaner to reuse legacy layout or build a new one.

I don't follow your comment about "this feature complete".
When you say _this_, it means the feature proposed in this patch of support=
ing legacy over PCI VFs?

If so, anything missing in this proposal?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

