Return-Path: <virtio-dev-return-11376-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973F1C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:40:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3D3026A35
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:40:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA8999866A7
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:40:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF3CD986679; Thu,  2 Mar 2023 13:40:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB62B986674;
	Thu,  2 Mar 2023 13:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA/XyUtFa6bzbAOpCAaHPGW0Rf6hc0uaFT4kBVRa2+KWjiQgErr6nkXi9ilaga9IiTNQGYOyK6v4XvOAlzyoTYLMdo4uWw3GqayoQ8ZHLYq8JZ78WOWXjmd+CqN3CojLiwIg/lxccxtxsmytevplOBlMr5kausS+3rq2z+eXERqzp1VxmIkNtqqPrhZEbSYS4wNG/jJ5C+9YJlxwGAwtiDP9Wzuq09PYn2SKYBCKUyDEf2piiv0H0+CCFbJnxcBehMMvlAPH28beouuO1xI+nvcHLavaU/mvV9Gv53q8u/ZsUZ2DEK0R00rpnsm8KcwcEPnP6j9ZcfeBokWQiOAm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhhfkXAdYH6x3xvuAfw7fug1in2k9XyRgihDbeAEaXs=;
 b=Izv6tYmk3yR6bHKWg9DPV8Ln4s8J1yPNmnbFJTSyPxYdrgvJq2Y6cAsEXmQTcEqZkxWePoxlC+68cKbLotMfC/k340hscFNbjW8cxrlSx7RKY8imW2xU94bTXMW4eXAnKzuUNGtU8n6E7lKUsRHrPR8hnPGlf+eUKq58QwsaynjfqjidLg3ZKAduRZwnvdrVX+NwGDGDZOwvQEC8BAY39ZJbwipUwDsw7jJoXvILtNS8odS1DOsA9jQfJweWc3RC7SJ+1rBb2mWAENkzf4AK1EfoWtF0/JQD2BLf17mxtXcO3k52WHvQvvPePWD+eP73Uru2LZOnorjKHb0hWhzSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
Thread-Topic: [virtio] [PATCH] makediff: make it work for fresh checkout
Thread-Index: AQHZTPfqhGNNNLIR6kit/03mV3shI67nfwVw
Date: Thu, 2 Mar 2023 13:40:28 +0000
Message-ID:
 <PH0PR12MB5481CA9CC6E842F0B2A6BD7DDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230302111232.837604-1-mst@redhat.com>
In-Reply-To: <20230302111232.837604-1-mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6479:EE_
x-ms-office365-filtering-correlation-id: f8c71920-c623-4259-936c-08db1b23af94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qwzAR23wcICAqrm5ISoeeYjM9istNajJtxpOoxDv7PiY3nD2cWJdBcVwSiK+BzKr/iYP3fgaJ/UVsYIiu4ldc2nErUAINQgkk88YATyveviL39OgGHq2ZdaY3Nab8fjES5X1tce6tqCoD2adjJ7J6aONvxmsg44zviydh7CY0AAZDYU2TdcPxXTEwrclhRdrjLOKSdyHMxotlCYotJ8X5qKtcMnEObcBEqkAsieQEzFxyfigKT+IZZDFC9Q/9g920kLnr/BifYYJAkOKIdXWWdGKLfHYApOWgjCpKBh5cLgP8Wg8TsJRu9aPBsatizliBCEYrk1JJYFyu/F5N54j/XM2op/D9YdWpotBoRCymgoOzDjh8QhWuNuo4XOAmUokGQoq2UcHX8IfTBXyPrFVUald1jrHBe/g2ERHi5ns8h+/ztkqxlze4qW+cXFoOZZ/y/OIEnqm++Ao3xyM2bIiZrrKgGo5aX34kxU0irSjUgJkAZMElVg2zdCXdwyvDm5MttE0D/8336/BbOc17/IJvW64YSuHKW8+1O3bUenF3KpWBHao9t6+zqRldXaOpoCYVGivi1ufyAOJdLd4XGuK4pyyw6miwgl87V65pGgoZhKwd/NCiDKqvgKF/tthiVZD3EgII4k4XOUKN4cqAR4G5jdrAk5KnW0+iCvA6D40KrVxQLjoSpB/wvZnasoIAYuM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199018)(316002)(71200400001)(4326008)(64756008)(110136005)(4744005)(66446008)(8936002)(83380400001)(2906002)(7696005)(33656002)(38100700002)(122000001)(66476007)(66556008)(52536014)(8676002)(41300700001)(478600001)(5660300002)(55016003)(186003)(86362001)(6506007)(26005)(66946007)(9686003)(38070700005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hZdvnv2KpqxaNrqko5TA5TigOX+HyvZkhl4wExam66eIkwXTKoyWrfkm3wsD?=
 =?us-ascii?Q?gneLd2VmjOWICtsgAGy4zX2z15dKQ/aSGzCFzYjXLN06wCgaz8QdIbda7WHU?=
 =?us-ascii?Q?jI+5/vRA7A2nIgMZPHFJ2WWpxAKpxhDHJEfaQTgyMYAi8J/XkjthLgiWreHv?=
 =?us-ascii?Q?TjsNJnHHBikAHhmrO2zKuLA+nMRwOjUsBEtuBJOyv5EDX2U2PJoEp1qHDral?=
 =?us-ascii?Q?gMgxM0oeE5phuf7TOCJRpbGTltxaGYM6Gav8NEUBFVW9qY56OQhHvkT0A7WR?=
 =?us-ascii?Q?eCvqMEAMRbhm2o9W2vSTWaCUv1kLbLXt7zWW+GQIP/8omeLVMU9yeeooSdSM?=
 =?us-ascii?Q?W/J3UXX01oqT5806ypjZ7zqTZd7+Ybb7v5Y2gZwSJYZqJQl/AEGjLH9koleB?=
 =?us-ascii?Q?kyrf1Dr2EG40CdaSl0d0z0guIsfPkQjkyVVBiPMzePh5DA0ky5V+1tV5d4CV?=
 =?us-ascii?Q?7X9kSQKMxY43S7AbgegK0sMWJ9C6bzLV+bfycErF6uZsqMYK7MA/mZQGkq7L?=
 =?us-ascii?Q?mWzIqLEPYfnQ1hhQTZAq48SKlFkEhj9YQhDdt38MqmjSig6BSJxIpfifxwsB?=
 =?us-ascii?Q?PbYww2nad7/TlbVC3ZvcHq6XNET87O+zIganvRCodDpNLo1qaoI89q+/pjTf?=
 =?us-ascii?Q?FQEN0DOhhWZf2st6eRPggBLRkUQMVfVCbwPf66w/FMmuFHEdbzl0TaBflF5T?=
 =?us-ascii?Q?5fbkvNdJZc8axDgT1UHXXWQo8JLsYbuCx9u687DV9dzMgrZm1nJ0AjDEy2qB?=
 =?us-ascii?Q?ZnnHzhOJhrlXiCpKuFTcWGbaPdhAS3VRSwSCPj0X2qaBgZkXsEcnX6x6Mxk9?=
 =?us-ascii?Q?xpTfuf45OZK084wI5iV/DILFdJ0tfQAW2wZGIWG8ZngPlgexXJHRzHpenoFk?=
 =?us-ascii?Q?BRHeRlt8GdSfli6AP0pyQpL/9UMNPyZt4YdxBqQAjttOqR5r2QfJyP5cd6DE?=
 =?us-ascii?Q?zDXH8+LffUQGtYRh1ujW5tH+LI9w2fwkFYnNFCc17Bq5kQL2zHOCuYF1H82/?=
 =?us-ascii?Q?71tWDhCjw4+WVxdey75y6S0JvGC4WmE34r2yaAqFI4cRn9hBZnGti/ErKhbB?=
 =?us-ascii?Q?/JaHvXSgPtB+DUAAEIMXIqzBlNgn9BYf0iHmH+JczznqutoDUGzTC0KQkZZ8?=
 =?us-ascii?Q?gNejBf3Xrj8KWF+tfp80o7OzMOGbm1HjTi2qzuFpwiL1JfrrfVzAR68byokY?=
 =?us-ascii?Q?1bRJU+JOoD4RCCCFmR2nWX2j8/v/k7WvjYwGR3CT60AiYLm6UOYOnMZbdI0J?=
 =?us-ascii?Q?MEsx1R5ffDbJFGFGAgUZL6eNp6kwfURCvHNk8k3PRn1xWjbZj12WmnYpCH0T?=
 =?us-ascii?Q?dXTCnkDvnLTBqv/5fCascAGRwVvl8xYJw8pCH2aKfYrjetDNBdW5bgWzZ8Ng?=
 =?us-ascii?Q?qQuW1UN0s2Ke8IgztW9b5DcIdQC0g3R6RzMCtiSXsoVjU1/xA1GifKduZWGC?=
 =?us-ascii?Q?ZuYnDUsb/KepHJD/DPragfSiJw/nYvEWpmM0p0KXiWl1laZqKF7d/9byZpI9?=
 =?us-ascii?Q?AWtenok5I+F5/r/7Be4sYUSzVFcU1kvBJKsMmx1blJcL/9aWJvQkaf5b7GcC?=
 =?us-ascii?Q?JAP0cteZehrzD/rChT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c71920-c623-4259-936c-08db1b23af94
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:40:28.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1p6VP6S0706C2juEr7YaqiJd0uXxcQtSLGsSOX0hxidZsblHl3pEBaBy40W5C7ApYfOsuKk5LK9yH7bAIFbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
Subject: [virtio-dev] RE: [virtio] [PATCH] makediff: make it work for fresh checkout



> From: virtio@lists.oasis-open.org <virtio@lists.oasis-open.org> On Behalf=
 Of
> Michael S. Tsirkin
>=20
> 1st time one checks out our repo, latexdiff submodule is not initialized.=
 Pass --
> init to update command to initialize it. It seems to be harmless if alrea=
dy
> initialized.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

