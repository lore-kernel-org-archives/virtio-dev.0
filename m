Return-Path: <virtio-dev-return-11779-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B54C7619A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:41:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 603C267048
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:41:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B2339863BF
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 13:41:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5040198628D; Mon, 27 Mar 2023 13:41:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D980986260;
	Mon, 27 Mar 2023 13:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5GIeypboaqBs587akSDDbiyugrFPN1NYlBrMPl4MjD8UljxROY5m2R1U7p+95ZgDTTcLtydQVLYjvtOtBEpkGXIlOBENNJoqpNr/9ZysSqjuxtkPLZiUWc4fI2neUm+WcDui8QAdB3EHuMnYzaFzwrxhb7NLgwyszfk6+hbWQ8HMtC3ec9hmVBw47AnhtfBEG5/Uw511a0MMqiymYXfdg4iM2ImLwhCO2RAIklLqGV5No/01KM1oMQaPOx6UnRSvypCs7TTRWJcJ7wrIhLAZ9qv7wPmoWr2RjhfrMb5QWxGgDwDmUHG47dHpIEDLF8BJX3gLR+4RpDTWixsGRmiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNv+7qDDQctoYTagdHPvhE/9By+dHQddQ72szPXaIIY=;
 b=PwNDPwoK/CntQ+PdczxGHwq6fUQ+V5aYNdcKn0BLsd0J2wGgOfIptBYPidKF99dJjiTin2hD0vdfo3s/20z4ZhWsNaM2QDPeBjFxDU3HdJKBIDiaUl6CUtoxPu+RB60h4XJhzWWHTW6HhDSQNgTuXvj2/XC3D6CFKWVk/4mkQ2KdaBRHwmBGDzQB9TSJ1UHhxFS5sKKLQzYxi3+oBui70q49Aga2xl2UCKxZN/4kj9ACwGy7zlO/+Hlzsz7fsy68iWas0SX/WJd3NSXNzv5eSeBkMlJ8k2kBB7+oJiGpXWwE/oYINWaBwFMl9GmQzs3GhTdqwPmH8w4eVWl2jRJlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v6 4/8] transport-mmio: Refer to the vq
 by its number
Thread-Index: AQHZXeyrsZzk1iLx+E26bRPpm1k/E68OawWAgAA8MsA=
Date: Mon, 27 Mar 2023 13:41:33 +0000
Message-ID:
 <PH0PR12MB5481E49E7F5C8E4634EB2D00DC8B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230324010432.280330-1-parav@nvidia.com>
 <20230324010432.280330-5-parav@nvidia.com>
 <sfu7ficnxkfnjrpbl4mnc3lwanrcocxxnoegk7smwy5a4g3jtf@hgh3e3ex4hxv>
In-Reply-To: <sfu7ficnxkfnjrpbl4mnc3lwanrcocxxnoegk7smwy5a4g3jtf@hgh3e3ex4hxv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB8577:EE_
x-ms-office365-filtering-correlation-id: 85cbd520-f837-450a-7ff4-08db2ec8fac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jIBYEKpvkUbOHqhmbMlg6dUq4BFtHhNaFN0eYUcHQCGgDxW55fe8odMemvECX79/Pb6KupCryJ8QlSg40cah/VuI3OpClmjr7A4mPRhqHbZVSc4KQbWmRFYXA/bPXaVvjaOD12wFvuWjizQOG8d8b5XpozCcd6iWDdA6kveaGFB8hpPxwORHIzXhRBEN2r9d0WTmEAwzKl1vjdi4ysBMH0UL83tCLpcVohn49cGLHFQV3lTHyShY7dNpag2zyS3vM49JUcpQc/akm1UNShxLv2KCp1ygs4CE3S1W06O3UXMkKBkJem0sa7Ej/r9SuchGOGQhtZAgNMw2+CN+hjmALFX3gwoEAo0Ik4pu1UYVjxf+yxgGp/GtRRGBeOoeaUanjHJrQek/k3KbXU8ZZBygkUf2osoItomnj8d5x4U9mhSmlakr7eG/WqifUC3f6UtCMiSiKvZH0kfOv0qSGzWGo3Sho+mFyvIeyMhiNdCRoR0h7l9R2pZTaYBIo6P3B6SJYVX6Ai6gHqe1BuK/n9C0hfPrh+PmrKGwRRf/35o+pvqzj62c/uRKzB2ZsW/154eg8ZJ4nhtjoN2B1yfN/EOiB9fOiwd1McaAk3NI62Q8OlwBbpg+QdpqxkpqdG9AYfxY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(33656002)(5660300002)(52536014)(41300700001)(6916009)(6506007)(8936002)(66446008)(186003)(66476007)(55016003)(76116006)(4326008)(66556008)(9686003)(107886003)(66946007)(8676002)(38100700002)(54906003)(38070700005)(122000001)(478600001)(316002)(64756008)(71200400001)(86362001)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1BsKDyKwZ9+5YtdRFFsKL/RDEtBwM2syNn+pDk4pXjLkeWI0b8cZC3OLgit0?=
 =?us-ascii?Q?RIHpG3sEeA3rUiX92g2BDLnN7hfQCTy5lKQpfoUjEIS7kapXHQJWIRz2fgDe?=
 =?us-ascii?Q?1XFym8TZBk59G/NdRbtPO7zMceSJ51j3BTsfqnSkKhqK3qMhKnQ8bnFj/7t0?=
 =?us-ascii?Q?QqINExokjf0UoLsel8dgiA3e/7BMwy5HopvMjyN9rUzkxsQ0MT93u7k0A76n?=
 =?us-ascii?Q?f08KVspYfJG6CcKQbk0nB+oQXq1LF7t9bz7mTheDpCpQBk6OE+OXcY6qj3Zl?=
 =?us-ascii?Q?Z+X1CfZGROKvdvWsCQA9rWUU7oL83jvNwFsV0Y8bnUjnFjOBVLBNi2r0e5Fu?=
 =?us-ascii?Q?V57oUL/Pd0Ows/ymsCu3eMsrMZDy8ppQaDBZjoz2C1Aoz6VyEJ3CpKbL47iT?=
 =?us-ascii?Q?rYqOWbVDPbmiDE+TEc6w+l4gPg5uCadXEURBjypcjj4uTxNfurn+kqlsT6eP?=
 =?us-ascii?Q?px5uWMsOfHg0jNHUIkzITERi0WQU6aDjtHTvw60TCFUrPcVzRaX+j+meQO7M?=
 =?us-ascii?Q?/7sbBbM5MTg7Dc89DhkdWHKA3yq4WeVxMyubaMgHa23hagxa7kCSRE/21GlB?=
 =?us-ascii?Q?RcefZ5oLKmPrkLDqUYW9P8/t8uT9UKQdGTeXFuZmmilhKw8Ou0M0rXn4hyYJ?=
 =?us-ascii?Q?Fhc1EAZHyxwhNs5H6HYLMvjv4tScqPP8wcRy4E0QMCokxNz9aMDq67UxXYW3?=
 =?us-ascii?Q?5mMk6iayttgjlggTPn1s973wdaY7tKKRaXSHvv4TTWsRMFX/qOBKxv0FdTB7?=
 =?us-ascii?Q?FZWBSUPvCHVaXQcwkXP3EKD8/7xqkPNaUWwIkQ+b4lMkTCB+O4VXTxM6v0K9?=
 =?us-ascii?Q?78212zhqIQk6jh2AZilVRcawCcsHwoDL/Icpk0uga+M4n/Ge3Ms8lNVDFewh?=
 =?us-ascii?Q?YIGkWb8axuY9LpvneC0YOrRzIYOnk/bjK8xz+POu/lb/K0PZmMdEaseXEZ5u?=
 =?us-ascii?Q?Z/qfPNOtfHIIAhUlKBGLnCkn1EpKUH4GWU53hJBQPlhbVXx7tt7TzGVzGJ7G?=
 =?us-ascii?Q?SoX2x91apZDEX5aTQ6elR9+pYNZHJr+dbZr5OZKXBNBcuj74ufxaAvCNOxR/?=
 =?us-ascii?Q?JTaVpXrSPiL2EbhEHYPCx7hiUC9efVhYdknuIAyjR7QmxxmcgSjfTVjmO0wa?=
 =?us-ascii?Q?UYmeXW7Y1lhViqAV5topBcOW59OE6d4dvNLshxVTlOUr3B540jJQ2L6qv67L?=
 =?us-ascii?Q?QVe8lvQRKdmwAo8JYSvBmysUViMN9SfIu1HDEGZS19Q/dIYt/zgIOM1N5Yx+?=
 =?us-ascii?Q?Ei3BdoT3akBd88ltShaDb+hVyj6dH/B31eNcsIUEW62MVEmy2GUu7eQkoWwz?=
 =?us-ascii?Q?wNUQL5itqHopIOxjpRne1mcJlXunuKq1A3fpp9HCTq9ZbGFUcXkyJFSghn3M?=
 =?us-ascii?Q?ZQf3wevCS0D7mfHrgfgmSyBWVY2kOIvRcsiSGRciglDNZIfDSyFJG6Yb3WYC?=
 =?us-ascii?Q?2tBx1nnamqBEzwqW4TWCj+DpzgbvEZ7FvykbHdAw38aTFPL/5k32CAdJqf8W?=
 =?us-ascii?Q?A+86uoed8MMl9buL6AbjiKKw1yDKX6pjGa0WHQqmLXRYPLl0czyhXKasG3ri?=
 =?us-ascii?Q?LLlKeH6boNQg7ebMHGHjQY4np9FkdEmj2wH2kUMMZPdEbDyjhAZ4vzWLynZx?=
 =?us-ascii?Q?uFWcv+fXRLmDxxIk2I5jvKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cbd520-f837-450a-7ff4-08db2ec8fac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 13:41:33.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wACp1Dan1t2IQJP6cYfBSgWLK1qwfxclo2qM24UYKMHlF7D60kI2QsjD279oIgVo26RGZZeRoMeoZSs/EwooEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v6 4/8] transport-mmio: Refer to the vq
 by its number

Hi Stefano,

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Monday, March 27, 2023 6:04 AM

> Maybe we can also remove `index` from the last sentence in this section.
> I mean something like this:
>=20
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -113,8 +113,8 @@ \subsection{MMIO Device Register
> Layout}\label{sec:Virtio Transport Options / Vi
>       following operations on \field{QueueSizeMax},
>       \field{QueueSize}, \field{QueueReady},
>       \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow=
},
> \field{QueueDriverHigh},
> -    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueRese=
t}
> apply to. The index
> -    number of the first queue is zero (0x0).
> +    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueRese=
t}
> apply to.
> +    The number of the first queue is zero (0x0).
>     }
>     \hline
>     \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
>=20
> Thanks,
> Stefano
>
With Michael suggestion, the first patch describes the vq number range.
I think we can drop this duplicate text from here all together.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

