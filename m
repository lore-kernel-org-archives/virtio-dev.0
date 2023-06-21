Return-Path: <virtio-dev-return-13009-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C41C0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:01:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 854B823D60
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:01:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7698C9866DE
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:01:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 692709865BA; Wed, 21 Jun 2023 16:01:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F9959865BD;
	Wed, 21 Jun 2023 16:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwiSy0GBGrHaXa6e08YpKF8uGZ0TWcdz3zi9DFBe5cRJnfNh3h6IdUXY183TPQhTCgOXb7qd+W/flxDReRIKmzRvTuKiNsC+/bUrPUa/G2NoEmiLLG/arl2gu5x22rlXKUuzorsKDas9PwTEYwttxBKaBbapzvJOE3zLakWB9tg4RXpg8q+p54H+kBNF5V/n1i/qVXZ9GLYN5qd90mgQXqOyP3xRbKfRfkmw6dr8VMoqaNKmJdxvfzaEXyLK1d9HQkmUbmMTKXjmdgCYZWAv7yu7XAR6PtkEEZc2825H66WUKcq69IZGb564AUezySVotgdqISrHJ0DKaxAoBcyGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt2gRkVf7JUZbFkGx9/FvaqObtqGg6wcj6mfuSGbS2Y=;
 b=j0AhK4M7YQeeqENNKd2novQjfruYBcYMCK9Yn0Xxzmei6V54dfINJG8X012MiWDdCJ/fiKAxnKL2eGoXBDKtSLdt91iejXRDMBxyLKaOTQlFhZAWDf6D3Yl2UMZlTyqF+m0JpT9gOzhKubFZUZTDDS/U8UtGEKhMWOpD/eC9e+b3K9y4rWJ9rrugOJHp60DGeciugJ2tUcLrUdfZSW8gEtgY8pAilsQ7i2d2vYhxF1ea6/wbjK89uAXCgiK2OeZL4ZVPQcEYJHUnJv59aM+Y2RG8EOd6Teq9Ff4SDhnZ4y+D6evEQmQPBufjr9bRE1jdKXmLZxshOF/qOzseWcYrsw==
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
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkIAABE6AgAAA1fCAAVC94IABrvFggAACRgCAAABYYA==
Date: Wed, 21 Jun 2023 16:01:00 +0000
Message-ID:
 <PH0PR12MB5481F5232331A63C138F8754DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621115131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621115131-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6942:EE_
x-ms-office365-filtering-correlation-id: 84cdc625-9adc-4f0b-199c-08db7270b4fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 frIAe8DqckLy43GXdNA68wq0paDf1+p/bRWa788eTZEsiCo98F/f/mvq9Mzxq8C4MUlwr+REuzQBZB7OqwV2QTx/OdCb5vqBZc7v7Fi08lMUWyoNUxqFI0B1fTh9pTl36R6ycg1WSYqcxSkdgS3JkQR00SyiFRz8V5zFygf4C0EKDouxkJuDAFpGSrJ5jlBz++HVZNUBhgYOwVYeGYH/LyM5QYrRQSImeIaV/ric8FUaazaRCXu6NvAwmXIJtSk37zBR97O97EWQ4xwG3o0ezn0DijeZs61aHMs8DYWMqlk/WTrHIVNQNI6zUbgG3vm4Iq5ueDritN0HXs0YJp1PEcObFXShrAoJ8QHxKGvLSJYYfThSd0wBVFCjaFo4MotNtRr6L4VgxlZ9BBRF/QHyLSbUARUiJBAPD/nV0buZFAjsx6nGpYRlDs9gv2SE/YykkDuYTEO6VWvcY8HTgW9l26xJ13ffmPT8sYz3+jhxreUfOsnJ0iSf8ptFiRUFAaFj98n1BLIdib7mZG8Ruq+7l38UHAQlFySHOHKw/vjJ5IqUv5OZZOtzAN8vdk50HjKcrkYs7S8OWX2BZtpO0ujDxW/7Vv9j4OrYN0SFYEdZsdlRR4LbVwHckzAHuIy8JQMh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(71200400001)(7696005)(478600001)(33656002)(6506007)(186003)(9686003)(83380400001)(38100700002)(86362001)(38070700005)(107886003)(122000001)(55016003)(52536014)(5660300002)(8676002)(8936002)(316002)(41300700001)(4326008)(4744005)(2906002)(66476007)(66946007)(6916009)(66556008)(76116006)(66446008)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tee7UHulH9P8S9QITQPXtP3TpyUUhKbxhdNxhPICZEszu1LtJBqwmsoZ3MJW?=
 =?us-ascii?Q?U0eYK+9dhjJAMgC62/P9cUDX5ZYAEfRpjwEApXUn839/HzIhT4zZAjP6B/Ng?=
 =?us-ascii?Q?hxseozxHRyp61acPcXDd2RYJPoQIKO6XWVcrugAdd2VNf89YEazkivX2pNDm?=
 =?us-ascii?Q?2W4Fp3/hE+CfV/GigO9xNGhibUSXB6AvRBVUkYmpo8WBvhorwi0jpvUN3TXX?=
 =?us-ascii?Q?zakkwrgrz6MDktahzZh7Yjo1fr6IWogQkFQAFvBfV3yrmr1yDAOpGZbOc/ag?=
 =?us-ascii?Q?iXZYdT+i/ozkvAXEwlPfOiZb/yM/2Nqru1jved2APIqTovQm+CtB2xXPIPlb?=
 =?us-ascii?Q?4/q+529KiGW71bZid9VVEJ1dHxZYVbV1DQsQ9kcOz6jtuJB490cxR2coyEDh?=
 =?us-ascii?Q?xs2BPH3FS3+G6C6IHKINh1kIU9E/ccZvB2xbftTY9ezM5fD7YgH+e3Q6J172?=
 =?us-ascii?Q?jKnSLFazFIV5qWneQBjMnLtP8vryr54C/B/4XUObnmuliNhrVPRxzcEBm5yb?=
 =?us-ascii?Q?vBlWXdQ9R0nIG9w+98f+zec9ajr5Y+B0rrpYc7am3gTlzzLEqblOU3+uAdZR?=
 =?us-ascii?Q?6iAKPIqVc09Cxzn/YkWwUsWzUpT4qNVcGJHxVGdbj8HUnG3PQJhMx70poHqL?=
 =?us-ascii?Q?0ffNA1KtN9pV+owPrdIfaiOF4QUD2g9qyjvtDltQfWZyVj+U85wwYoHcy6HW?=
 =?us-ascii?Q?cX4ufFdS2wLG4BbWgCuW+Gqg/Gl26XUEc6v0MrvB4tdVAv76+E3BYzopFXUC?=
 =?us-ascii?Q?NDrXW+bVZgcZ2YLItEqkywUCtyyHpBC2Wh2ZJ3NNEmsnvakDfG6e+qXkQfuF?=
 =?us-ascii?Q?exT533P8exaMMuFcVjV3h6nuSQaOteknnJSYVYerJiaZ1mEPaip040m9Iyaj?=
 =?us-ascii?Q?ATLxuG6Q5j0C8qU/C7NC27b451wEADh9G07O3rbZ7BXx+/jQvEk1cGbzKZ3L?=
 =?us-ascii?Q?8+i1503uhHRYGEpW13+fDVVbcQScYtEu9VfYYRizfKJBHGRyFGYWX4jP+jaD?=
 =?us-ascii?Q?eYJo5zKTG5u6IMKU+MMqTBPUrlmbj1is93+T66Tc/FOF8EladVebmg4U3vMJ?=
 =?us-ascii?Q?3udMJld4MVFww0HOq/F/qL6wKpPJih31OmjXd4jEmmcPepEBy3nu4XBZAvUU?=
 =?us-ascii?Q?xF2EwRe3dyfOnVWpFo0D12fVELRb/nw10RATNQ3DZV+/U1nuvyeD+ijs1CXe?=
 =?us-ascii?Q?rmywzOnvgmJCStutElGEYnXdfC4+E/lliF9wF8j0XqX+Jdpj1cnX8M3pIx7n?=
 =?us-ascii?Q?SbiSNGAEUqBiZqASjfy/wqfchzqzF8PXT+MHnF2azchOY1/ZenV8qCKEaOYM?=
 =?us-ascii?Q?B445fzdNXo63Zli2jibCs+bULlvHfM5u8yHo7Drqx29/LXEmS20DKZU085hU?=
 =?us-ascii?Q?WkRK+MHW4zUrG9lC9KwE7knSyh32+XKh/VY8Vd8ERhRPYx3m1XIFsoKz8V5i?=
 =?us-ascii?Q?lsMbMYP2mPj7rgIEQ0CyVG49kwS8W5hhxPEScTQ1CTS3GAdOG3Q6i3w7V6Lt?=
 =?us-ascii?Q?Cxp7kmGGOHF+Owp6hCK8LUdbyYeXlW9xzMg14K72+G00QCJfQ0kJlgJGErwb?=
 =?us-ascii?Q?BsMdIwDfDLclwhTF7BFgOD6aMqN5IpO1wedTp96db+l4DFfRm6CQwH/1Mxr4?=
 =?us-ascii?Q?Jrowdu5XW9X431xnxvbmIWU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cdc625-9adc-4f0b-199c-08db7270b4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 16:01:00.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOBArIcctk71+jzEeHuSNj/lBe8uwg0UJfpCN4VB/NPiWVZDruNvIfFhuzQEL92nIihE7Tweb/eunrs6HHrbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 11:56 AM

> Not like v3 please. If you want to re-open this:
>=20
>=20
> First I think we need multiple offsets just like notification capaiblity,=
 sorted by
> priority. Second I think we need ability to report offset within owner no=
t
> member.
>
> So please add ability to report multiple offsets, and add e.g.
> a flags field, with bits for owner, member.

What are these multiple offsets for?
Do you mean two offsets? One for owner and one for member?
Both bits are optional. Do you agree?=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

