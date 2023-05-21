Return-Path: <virtio-dev-return-12768-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03483C7EE23
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:25:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6DF9BF3EAC
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:25:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F5879863D9
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 13:25:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 537819859EA; Sun, 21 May 2023 13:25:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F9709859E6;
	Sun, 21 May 2023 13:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFyaP3TzLqQPnQJayfdDYgwu6DWQ1R00fSfeFccPyGPAoYCwp2NPZs/BJqsyyWwpszEbxZjU/TqnlegWWP+6Xce5XE0P2l08x3ODtgvFiSd5DtLbeQ17ahGkNy37rW09zen3MbvPjg0SB0f1exMz+GZOigyF21ynWTSKS422ayDJigMdcN9qLW1OKW5P6Hl/xkMAvsbbicTS7JCG9GDbhmW5V0Cds8QCbzpckqfvQit/C9IITrmcR5lVAxMCWIh6205TXIwdP7v1K7atU5dvuIZ1y9iJBDkBo+y7p52J2MM0MZIPRNOQ9HHO7/TMIUuRprJqTH4sbYrv9FkQRWtcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XApFwUKJkgqPSsoWelRMFk5cSFg2vp0xlG7XCGEcUkc=;
 b=emmNvkr06vf8Abg0J9gvSI3creC0jbifUDGc8bwr7SCwI5z/d8lCpKQN2VZGSmRch9CGg8gol5aPV5QBlAwVhJc1yqB8r7I/e5LQnJ5FMafdcaj2j/oFWZHvafdYURnemG9XuIULaOwnMm48RmU+j7yop1OVNk235OqPP/+3L2ebiikm0eZogSg+rAxl70Q+AO53e7Y4xbPkO+fObIE9GX+5fIv4x2HkJAwR8Dddt0ir+ygKAZBbGn/8ZIHADwAkanpNiP0pIEcl8QySCsf2NCE10jGtPG3SaxAsIxb4QSyJDu0SeIjp5GsIB5y1ftxO7MGxRAmkOCgZlNi+rUDylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 08/11] transport-pci: Introduce virtio extended
 capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra9hanaAgADvnFCAAjGHAIAAfAqw
Date: Sun, 21 May 2023 13:24:55 +0000
Message-ID:
 <PH0PR12MB5481905220D7C38DE46F1FE7DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230519020737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E912A8CDE621DF4344DEDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521015236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230521015236-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7995:EE_
x-ms-office365-filtering-correlation-id: 2e08b5b9-8d96-4c06-5f3e-08db59fec4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c+uzSm2yRIXWFxah7CNRMI3aKHvxC5yLljhyOz3xdKcnRU+V1D19Tn/yuQu11Sahi1OPy8gRbhc+HWK37XOUHZuEBfWMwgscPVMnuCVBwyYKJCXvKXIHxUELEJCrai9hrPwVNAEO83kMm8kw0VkOjEIxC2/5ND8F/49Wb735S+iqAJDMk38QyM6SmE2jFM/UbkX/cQ8lC07XacVav4PkjX5ysImnuJiqmP6K/Fz29C0rPVd2zSFpc7SF2rkM5GHfPZcxkT0ghDfU1tfpn/fcZ+ctL73h0+dd1D7qSEFOwYqySUA/34EVQN5VEy5ZYXUACEdj7cUbNP6rhUBaRQ33xF123bN5IfOsxYpHqHOWx9YbK4jW7SG9LyaRo4/oiDTlEPQl+vHTGjKxwi8A/eRs8E492i+wSHWS02GTJECQnBnSUxVVefgFNY1fsQ1lKfjiaD6Io2230vNl+VItl9+vZnA/X4Sl7GSP9gyO4fDtzGZ9nhEbTzoAfVEbusSZESr3X6S1EJuJizVEHxuRtUYTlgVrnS3dI7yytr+rjEiWaWbHu7QfEQREOFdzfoG4P7ssLHjqXUQmeL/k3wJJAWnbp/uVP9x8Zm+Stac7ic/JWvX+VsEFryri7H6reaJcW8If
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(52536014)(5660300002)(83380400001)(186003)(26005)(9686003)(6506007)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(71200400001)(33656002)(55016003)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(316002)(6916009)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IKhW1KUjLFWdwbkAgRDf14+NmtaxefqJoAt66dxdp0MIl3kCNND/u6CioPwn?=
 =?us-ascii?Q?BPW8UAqdXLGNhM98NOnaAoNjoEJEC8CpHdKO/vSz1nmdxcJljSyp620jzI3W?=
 =?us-ascii?Q?0kWNz9cpmGgeIRbIiiIJJOG216YP8Q+l7ewaBAcvEAUwSxO+/Y+SKKD03qpw?=
 =?us-ascii?Q?qicxOYRBHXCHYrRHYMcUy1o7YOI4zZNMuFcGY4nhhKEpQiXPdoJFcyNW69+b?=
 =?us-ascii?Q?xHt+fyS3DaMyjV+r1Oa422AEMKwNQVv2gSNS3t4wZclm5N+TYEJTurh3lRMC?=
 =?us-ascii?Q?Lr935x8oVcwWVWqdbB+nxAxyf2RTkrjjeEsz08MI5+CMC4CDumV3rkWPSeiS?=
 =?us-ascii?Q?/rZO/oizBvRz6te2WmKmFLtUh+kPXPcPWvQ5Jvz9efLHo7rkMF50s/RHCmlT?=
 =?us-ascii?Q?+a2cmMKNN5xGwFU/kWeSu/fGWuuazSIUmca7N8Dl07dW9eHGrn/a+DnputLg?=
 =?us-ascii?Q?naa4psfvVk7twBZr2/zxoTKnVS4Y4N2UfvhzYTIqpmBUIEWqYtGcssAA2fJF?=
 =?us-ascii?Q?4mzp3tLlwl+XsLl5/Rklr/IGBLmFq0zfzLXF0zH8fsKYghOggkyojjIa1XRZ?=
 =?us-ascii?Q?NZYt2n2yBrz9d9l4M44080AFuZdnH1KNUAfKWVXGNZuxMufQJTBUdr0EnCgu?=
 =?us-ascii?Q?TZP0wo1Il6sJcKZv3wxPBYt/6lsW5jHrHGn0JkKQhnUW20TuefZ+k0RHN+Om?=
 =?us-ascii?Q?0/f7QM/WyjfqcKnl/+2nVc0oUPNKe6FSKRUCJtVvdcHT17E3YjrnVX3Ojw+F?=
 =?us-ascii?Q?c8g+lQIDh/Z2KzRA3B0vgeDb2Nhcn9jA63zoyQbO6QYp+5iQ52CqwN/A5oob?=
 =?us-ascii?Q?l+T07EyMA4Sjz2MxQ7h2oFAVOlIT06vjMcYeQowA3o9fGk+RbcxNyAFZ+iQ5?=
 =?us-ascii?Q?9m3k5fIvfd4dE8f+VzDXNl/MAn0seYqq0h3Z9FQqH0aNeKIa6yJCa8R00RLf?=
 =?us-ascii?Q?6pOQzqNa9o4X5d91wZzpwniwYFgH0o25J8pztmnyG5ZOqZbBKx2+qgvdZauO?=
 =?us-ascii?Q?AwXkqlfaiCjld9EYNHNguBSHEo0z28W3ZSc/hWW3426aoR0zN4EONkazAsbK?=
 =?us-ascii?Q?XJFtt+cTtYPTp6NskxJ/0mMrsDnzEiQnqv7tt9HRkjMtrEn0YhkGyAN+MwGj?=
 =?us-ascii?Q?Lkf5TQXdVV3LGcxr3M5AMLHFHoEs23RgczEuZQhPq+qGJG8SyC7IB+MxxAD8?=
 =?us-ascii?Q?OEst5F+ynHDf/M74d/ISEaEUdMM6vemznKVub8C0eCF3ctOilj0ioJzHoyG1?=
 =?us-ascii?Q?ugZHXv4NJH3uEvajqiidRHyNRBsjQd8v2r949WHjjdFPJQs9pqdF95Wnc5ti?=
 =?us-ascii?Q?vmVs0EyKLa5sVCj7meuVeDYNOjUnBdI/H7m65CaNDTFjsoFG/3t43DZ55vVK?=
 =?us-ascii?Q?v1IOQTpaQkV2/sBSNnI14OwDqjKaIdInnS9vpqIo98/cfcSnkdYaPBrf/0gX?=
 =?us-ascii?Q?z038Gu5lE+SQ0oZsigOcf+5VYg5p69mhK01cT92+qYQaACHBPWknWrtlAJoq?=
 =?us-ascii?Q?uCiA2gveHislGpJDGNz7yDNDLF0DOIK42btfBQFABcvP1NJQhm3vOuJPpWh4?=
 =?us-ascii?Q?E/Dpob0/9Cx6hVI6/TU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e08b5b9-8d96-4c06-5f3e-08db59fec4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2023 13:24:55.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKr8PQu+CexQnPHRFuQ2kl775ckWuNswk1llGnEHHC18VLaRPHeSjhZAYS0FpIegsEmYsIY11IWFHLafNCAAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
Subject: [virtio-dev] RE: [PATCH 08/11] transport-pci: Introduce virtio extended capability

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, May 21, 2023 1:58 AM

> Yes but neither can it support new devices because it does not look for t=
he new
> device id. So it's fine - I was talking about new devices using extended
> capability.
>=20
> We shouldn't just laser-focus on existing software and devices, there's p=
robably
> more to come.
>
Sure, new devices can use new capability.
I will roll this as separate patch and github issue.
As we discussed, legacy register access over AQ does not need this capabili=
ty anyway.

So not related to v2 discussion.
I am in middle of splitting this as separate patch unrelated to the v2 for =
legacy access.

>=20
> > But that is the case with any existing software, not just seabios.
> >
> > New capability is in addition to the existing one.
> > And code already exists to refer to the old one, so I am not seeing any=
 gain to
> create them now.
> > Any new capability that one creates in the future can be in the extende=
d area.
>=20
> Question is about MCFG in general.  Is adding capability to access MCFG t=
o
> seabios for pci accesses practical? hard?
>
What is MCFG?
=20
> > You mentioned a perf angle that it takes half the time, but I don't
> > see how as the only change between legacy and ext is: offset.
>=20
> For a variety of reasons Linux does not use memory mapped accesses for le=
gacy
> config space, it uses cf8/cfc for that.
And does it use memory mapped accesses for non-legacy config space?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

