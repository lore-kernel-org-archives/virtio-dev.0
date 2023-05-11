Return-Path: <virtio-dev-return-12655-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7DEC7EE23
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:00:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8A63A29FC5
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:00:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 737B89866F3
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 16:00:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 65F149865F7; Thu, 11 May 2023 16:00:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51E119865E9;
	Thu, 11 May 2023 16:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvelP4IFPCyvEcsloI+eZam/w81Mt6o26binSGPRxDiniysEoVn7zNLn8kUxn3n7YNPyS5xsGw3h0fi6LzRR+9z0mV/3zdNyQHuC+NBURaoLlG4AkxTq/LQHEEGaMMo2ZC8X9lq6i1N/WTpSyAwLVxN7AH73ZRkKiEjMrydZ6AjbaHTOu/1ek0E4qZk5EFpByC1NMfI5OU0GXWA30v3l5J+asmUp8iwVsbZhUMZ9pXTZqVhvEEJ6ICh+J6poESkHyGbg0GtB9eqaYA2eTS2o04erfjKrK6TwPRHD6z3P4dWzcu9WiillxDtrQDBXnjG17cR1FQIyPRa1CP6Lo2qnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YpxZVNSMnNDi5rOeumRK7OpAIvw40djywo6KLF9l38=;
 b=GhVm3MaP0Tj5SpQgf+B9o7s8YvMvzOQ5gRUjdf0FmH5murfninQG6oaBNsQUu8fi/iqEqpM4TMXmxuHtJD8Yvu1qBYQF09y6xgya4XxG4wdzmeTXO3eTT8WuXhClCc+fGsmN9mx6pIBP/tR6VQr2MUPrC8JQk5M+6tiLQyqseC8yBhaX8pJ6O5a//TWNU+Y3kyz0c42k4BjZH8Hg3LQRObSq1JfOXRiHg80XCYF3yoVz9HBKBjqMe4N10XiuTQ3MaKMT3b04MsKu6+kAJR6Rho7dwY8EjxJFFKcsnqM7RN+7JS6hTG1a3t9qLTucYr1diBYzBbGtFFJepfR7xW4GnQ==
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
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAAGRoCAACXg4A==
Date: Thu, 11 May 2023 16:00:22 +0000
Message-ID:
 <PH0PR12MB5481F9DE030A10D20CFF3D83DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8647:EE_
x-ms-office365-filtering-correlation-id: e71d8b86-77a7-4751-9634-08db5238d371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wb4w7ZTxOVXp7ACTLrEBfbT+d/5w5C9/nVNA+E5ZhThh2ZumrMy0mcFd7SoZ7+mgYukdDXdC5S4tIJX7uJmKpokoegEzx830CfJCcb1p84d65qLTT6sO5QNCytBmmxj3yrxShBjk0W4durVWT6T5OAIDmSIc63enrQinhna5dxOqRXaUdM6/IC70VS/4ea0AXNfH42kY6ZoknZb7rDsyEjAjKA9rcvhIZ+GlFU6dtnLmhCsQ89H6ODga2rxRe/1ov8Q+QifyFNMZYwoxZezmk1kb3MU+V0l0hXJCSeQ2oo5WmRlc/ElMXKr3/EK5TIp+x1Di78rd7Z+qWk2hGiZciCTWhNiboNVcmraNg2oX1A5oRj8boxvGMlPXoLAZCNRZ0neF9p5rVQ/ZLf3WdGXVsLc9mtqAOkfV4gIhwZxqaw5203VHIe/Zu+/Wvy3utF8iJ5q5LFEWbby/bQa74IGjhABA8MnokeDEYIMFZWzERvSnQo8k4fTecml8JwQLepVpq2t458ECJMcF+rb9Wtw+bSy3PhEaOpk/r2Iv3njwQ7OIJJxh7+iqQyulNcFDAxKMPay2q/HbYoG5zRTSqcFWzX9Mi6ZYeY7sgTaX8rWWPNRw9x0Rw/M2zcjKI1d4qWkF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(122000001)(33656002)(41300700001)(26005)(186003)(2906002)(71200400001)(107886003)(9686003)(6506007)(5660300002)(52536014)(38070700005)(38100700002)(8936002)(55016003)(54906003)(316002)(6916009)(478600001)(8676002)(86362001)(7696005)(66476007)(64756008)(66556008)(66946007)(76116006)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?etn1xxchp+w/2MQvA8/PL+UC/Vb5Z2f+yXPyaSs2JgGOjHfgEq/8RKba98eG?=
 =?us-ascii?Q?bqV6P6D3gqN2m99jiKlGIs97ACoQpzCeJE9jC3qlvye9ZWelacSEiQT+0iXT?=
 =?us-ascii?Q?2SNGUfz6yGXDJEzHNUSpJm28xc8iIgjRSMj8puF3eN+B2HQeM4a3B75oyb6u?=
 =?us-ascii?Q?UM70PvRcYgIN6q/hhZIGnj7uBQNOPmy1/ldp1nIW3+K2kfUFalhuGyhvqNKH?=
 =?us-ascii?Q?hGHQ+iUcnb3sZoCrzyHC4Sw7sx5y0CavKjM75B888qXUPvBqfSgP1ccJ8mYb?=
 =?us-ascii?Q?Scjpjf5KXWKpTbFWg1jAEW42XPE1YfrH0kSt9lGtFW/VmUK4omI5b/7+Z1P4?=
 =?us-ascii?Q?4Z66uFPQNzv67KQn+VN/a9NERKyZdM4Ex2RrSgkTMJ5Nc9w3JCCp1eDWM1t/?=
 =?us-ascii?Q?1GfemRwDCeR6WYq9JlzQWPAyv2p130CBOYUFxySw4NZnKISjmAJ4T8+yImyG?=
 =?us-ascii?Q?NeBey33CWavVGCbd9ExK4umMz9LlpVDy2Izeb9+dpYuhKjx6MqkDlk06pY5D?=
 =?us-ascii?Q?EYbjVa9U+lwYW0VGANqxB/k4yRS4BmJYB02Ch2ccN25MTU9qNl2OYiVlaWTt?=
 =?us-ascii?Q?oxSeKEVgJwk7WYsV0dNJG6gtOiVCJQCNpUJTYzftOy02+9Nzr9qsL40xvilI?=
 =?us-ascii?Q?r4nhx8/ZJOuA508tNtOjEgARbRy4QyXy0B0lCixoSnZyzRoMVpsgawUIYrQR?=
 =?us-ascii?Q?Cmgv1h3wnsd/2XGnxWRUzEPf/Bn4QYKAnrjh/t52ftI59ks90kOSr+aDh2St?=
 =?us-ascii?Q?j4AOehyxdXgXXfGAZOFV0QuH1AthuDV5x6Z2mrZUCIyjkbKaBFvR4sJdI47z?=
 =?us-ascii?Q?m5YwckPY+k/1CEeTLQ4GxArsDuxOuAUPSrSenVcooq/uW2qK5vPQT4WjyoZK?=
 =?us-ascii?Q?5hexA+rxeYABLlr4JiLgGEBZpevnZtvZevt78v+mKfXWJeQnWF9Gx0PjGwo2?=
 =?us-ascii?Q?iSBFXsz1IjLzQ1JJzPnDOQZ1ucEBGyt4AVqjMT6O3eeyi33IRNS2VtUKg9Or?=
 =?us-ascii?Q?/4PwcwLZXuLWs2KGYYk8IhX3aEFOUjhqagd+5VdyNzw6ite769w3hLWEVO96?=
 =?us-ascii?Q?VEcXZzQQDKi/fGxiI2jy89KHx213l9SOhR/pG/NStTyJ6/QT1mx/ds10ujJb?=
 =?us-ascii?Q?NmoIPZHhvCOvn7Le63HKpWgA7pYayRx2mf7JxbexPuPolHM2FHisf3DZGdag?=
 =?us-ascii?Q?ITVMmaR3eBGd0xw+UZ0aCAp1yPyNQ5+VeBhditTmoMUNWEnWjbh7dNjDfC4L?=
 =?us-ascii?Q?6creRnXOHEgiiKvd0DShJ6HJGM+GgXSe3LJKYzQTWiI1OvkN6cgKp47uJz6E?=
 =?us-ascii?Q?1SDCpLQvXndm6bmVHtRyD96unSm259BnENsx/8N/t3BWrrnBOJwiRGKb/52R?=
 =?us-ascii?Q?QUsgbc4YIIvngSiB1Gzxb1zI+O7Moh3sZmbzwOnQpbZFtswVYR5JQspUa0Pf?=
 =?us-ascii?Q?znOJAq7ic8aT/l3jXjoViqZI8ldkQCRsyR1SF1rb/SUKW3eh39HipsLrOkiq?=
 =?us-ascii?Q?O7zaloBqLmT5vipUa/KP98CxTgaKS94aBu54Yle75RWTv+UL6ktL4npBtG8P?=
 =?us-ascii?Q?IC0K9jPYeya/coabh3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71d8b86-77a7-4751-9634-08db5238d371
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 16:00:22.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuNPGTDd4u8qYVOeyhD7CJS0Fr3lSC8uoQUhhdj0W9/qncJdXHNOYY7gMEcr4yPApSlY26yW/1XEAUXU92/iiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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

Not sure I understand, if you are asking for SF/SIOV virtio device, it shou=
ld have its own communication path from driver to device without going thro=
ugh the PF AQ.
Because it has no backward compatibility baggage.
There is no need for PF based AQ for it.

PF based AQ is only needed for exposing a backward compatible guest VM faci=
ng PCI or MMIO virtio device whose backend is either PCI VF or SF/SIOV virt=
io passthrough device.
Such backward compatible composition requirement and above SIOV device are =
two very different requirements.

> We don't save much code there by reusing the same register layout of lega=
cy
> pci.
> But let's at least make this feature complete, and then we'll see whether=
 it is
> cleaner to reuse legacy layout or build a new one.
>=20
> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

