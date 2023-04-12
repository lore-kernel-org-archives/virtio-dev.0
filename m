Return-Path: <virtio-dev-return-12169-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528FBC7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:37:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9DD9E42BCC
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:37:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97F9298660F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:37:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CF9F986514; Wed, 12 Apr 2023 04:37:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 778E0986509;
	Wed, 12 Apr 2023 04:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt/rv1hkahdtSreYC9ewY0Qpuagz/tZEyC2ocxrkz5AVdeTcP+g6TOsqAWeA0R3QpQ4jE+WWxKO6BNxY1hls+VM1BVLrcJeUl0hdM3GPBwJKR3caiZPMn8ABXQO+/OlUpAZT+rd5P1lIrWspeluWHR8N9yiL2Gbdu/blTxIzWTQWqcztPbtX7hlR81KgimH6JjZ1XN1Z1yiaC8YcuOJOeJd8y1BsQ1+1OCgE9NeJ8eGAsZtuN9ns/0Nz59aXJkbmrwd5sruwGrmfdsBIhFVIAqdK9vU4a5wNouq6+aIjMEXFvBxUZSIZthZqjfOYKuABl6g+0fT67bbUAkk8dMm33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TYClMDR4Hlb1T8ataV3UjJDL0B+u8x6i1M+x0nFSm4=;
 b=EWSf6q8/Acp9lCYSIqgVMfRLdGWHWoYc5kf4K6VIFpgVpMDAtdurOXeXF43dUUHwelryRuJduJ4IK2FitwbmehRmi/geXW7//YDyT7sIr/GMh09BOX4frnjMwM2AIsmkBlGZcoZxxDS208zJvnkWa3Efh/dHy0xpEESZgb9aUU00Dt6UsKX0aNo6UsSukUKThm4WsTbHrA7NKfWh96h3PWVzLpb4A4V1kX89wPE6X6ToCoR5UDHZPmCdUUQsCUema5yeFNGQ3s5HASCTO/uia8imvNnuhOMdd26JiF/Fb7DEfeA9cnEYHUd9Bow4/jHBmnQtsZcRsHdBX+WhoV+SDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability
Thread-Index: AQHZY1tLBn6tX00VoEql9uT0hRsw3K8nKIQAgAAAVNA=
Date: Wed, 12 Apr 2023 04:37:05 +0000
Message-ID:
 <PH0PR12MB5481394D07C5CFBB2347B5F0DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
 <20230412003006-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412003006-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: ca2f3d10-0654-4c92-6c4d-08db3b0f91ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 swd7vxp35pZG9lY9xlLtDkmpa9wsHtyzsWKJKSltMRgdQvkJyEMmzOSUCiD+KN95sjKs6vNX/XzI2yDWNALQkds9/PrpDhk1oEfXTZ9v8ZVpWgvwI+5D5Ob6ImT//GE3Yui/59c0I7IurQvKvqLvXDkA5iO5v5rktInBhQsy0yJ/OOT9ttdcgYxPubsf/STJa8VK15o5ylrO//ir1WKUfl3IdkRlBe2vNJ8DEHgSMUAUq5oItUzE9/dbfFefHW+GiSITz3XItVs+976/D0Ifueq6lDAfkz5SpDP+zwkrS0rkh62CVbYYOc+AyUWRfvLj2YzkWq9gG2jKCZzXgNkJA2lpMZUpkZ5HMRezqZ3FDovBlZgmPVreveAYK+uwFIa/1dFrhshG7B/vcAhzJjR/pnrCZwpug1RGY3aiPjeTmtsRKLc/TgXD66/LO8D+9CFYh/WtL/EVR5jJ2NthPJiNusMsrIXYbauEFBKkUGa50oka+oFb74nNuyfn40tzbQnCLiqpv5QXn9jtBFme3dEHH5R18ZcLCSXIwF/2PXMoPgxxCecC9x018LXARvmKCoo8Mk/O5JftvuJRM2N+5Ib7JxnOAsbv4jXefRhA4yKXAeJtI8ojxHwxZ+EZmG6vlBrJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(83380400001)(15650500001)(122000001)(41300700001)(5660300002)(52536014)(2906002)(38070700005)(38100700002)(8676002)(8936002)(186003)(9686003)(6506007)(66899021)(66556008)(66476007)(66446008)(64756008)(4326008)(6916009)(71200400001)(7696005)(54906003)(66946007)(86362001)(76116006)(55016003)(316002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jmOY7AvR+y8pulV4X4JETD3diskyYldi6NPfS58CL9c/jA3dDTYqg1ukdYM4?=
 =?us-ascii?Q?EQ/fA4ti0WLqnke8kY3cIGP6L4WQLmHTFizzSdHzTru7llui8DaP8U02r7wK?=
 =?us-ascii?Q?NmD938lX5T2czGlNCIBXI6PXMRcmxNSu1UYx+UxGc6nnkTtSewwBtR6MSQ0g?=
 =?us-ascii?Q?ZC5SVp/cwXqeqoWRE5mKsXMioJz+4aVKYy9HfIXaT6xmISKXSmRsoC+pWxiv?=
 =?us-ascii?Q?kQjPJf/K3WZNWepE57XY3ykrTypjO59C4gH8yqcPFSrXuhuE0gafLrrrW1P+?=
 =?us-ascii?Q?44gdkJsQKICUe8TGcSDzzJksvzmgQjevkIHqexJxepiFBV2Fn+0dcdlF+2d0?=
 =?us-ascii?Q?7hPfQQ9a2VyqOdTNwWAsdOq2lhIXSE/EJGlQMIfC48B6EFpy0pyPPnsM3ywD?=
 =?us-ascii?Q?m5NRvuo1AekaeCIC+Mp1ExtrIXsOu+CO0muNFuNHnrFu79Yc825Lxdt2e/dI?=
 =?us-ascii?Q?u2Z/dEmX79SRxyFTlEJ5uYtOjsWIA1ySgrC83CleJNnU4aoxdWBuLWsynbSR?=
 =?us-ascii?Q?csi8H7kHm+YD9XGiOfNW19cHPtZBdzfyc5sEPTly/P541pdL0BkjrU9RjngF?=
 =?us-ascii?Q?K2ZPzcOCtXpys+KuzbALDEOYhYyYHJoixc1TOY8JckQihy5WCMVbYG5vGJzG?=
 =?us-ascii?Q?2v0MJfJV5srEDGV40t10Hwu4+mqlvnXQl/HlU3InWyItZwsYqtqu9Y6t3In5?=
 =?us-ascii?Q?/1FQ1yot0aHRy3s52g/XcGneoz7KBS2x6ME5UyHoXTU0qRf3W3fgzACtce5Q?=
 =?us-ascii?Q?8y5qoV7xvs8ULjnzS1NDL/JnxXqpIdPEqYfuT7Ne8rUHVNhAADPuiG/W7TzP?=
 =?us-ascii?Q?sN12w7gvNLc0AcwVVrRgKWPqhTKvKf0/72nF/knwqGyQlSmVi225q7vssqOB?=
 =?us-ascii?Q?PzrKb3U2KZBtkHrN4WTnUyZNUK6HH7x1Ab8fZUMcyUDpjBulIgBfWQSyINjp?=
 =?us-ascii?Q?XK1gJ/GOS1rSQUZ7k+/UsywTQJDCmUhMg5x1+ZiDTNlCM9xTwg9d03jlIix0?=
 =?us-ascii?Q?QDpOxjcJgqsrfuH/+Sz+tLhBzmO5O0qw4MpJbNeOQ56RfvSEMvgcgdHvfdO5?=
 =?us-ascii?Q?zMz83SqZVETXKDmUYCf/o/l3twZS5gHy2aQL36RZwNBY7NdCZBoxsbAdQegv?=
 =?us-ascii?Q?iShbKaFqra/XqD6wSnTymnLV3naMx223Qe58VCv0kxFsBIW8Ak3mts2+ErWX?=
 =?us-ascii?Q?J8i88UpNYo9rHsrHFvY9GzfdeznJPik11ZQUhJsSm6ifZZs3Onq6a5N3oo0L?=
 =?us-ascii?Q?YxJsQIaeiD0mXjukgEVPukVeliZpm6GQRVkYm54PVs/NPTGwZ0z/O8T3NTEj?=
 =?us-ascii?Q?KWzooFE0cTvte3HsGR0VfIp8DIAJ6xmAsSdTvn2UlCMsaI7r7AdWtR1G1pLB?=
 =?us-ascii?Q?u55Fyq49b/xSmnnDib018xcRvmH8ulFCFQCdHGeaol4Etp1Eu8DgTAADFEcp?=
 =?us-ascii?Q?A8tkzd7kQKV7DxDuxnC/c4f1BG0lOtV9dR44LmghIavh/F3H+Jwh3X4BfY6c?=
 =?us-ascii?Q?41cbEzDE5jsKrisKCqaD823MFo9ecvccZ0P7xtW+pb48Eg1LgFRsbsmIViQ4?=
 =?us-ascii?Q?QOh6IFDLxChFRM6pglYM6VyisdYm/c7CV8WDSw24g5JVLzIvgyYG/Ij8bMKW?=
 =?us-ascii?Q?PZcEl29UOtg122TwVma45GQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2f3d10-0654-4c92-6c4d-08db3b0f91ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 04:37:05.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T20RXmXR3dKfhjh40Ikqcijm7vVKvMXAepFmVsG8YEqv8oyv81Re2un3hwUIeXJClOjQsDwQtJImuvGBJCR2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
Subject: [virtio-dev] RE: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 12, 2023 12:31 AM
>=20
> On Fri, Mar 31, 2023 at 01:58:33AM +0300, Parav Pandit wrote:
> > PCI devices support memory BAR regions for performant driver
> > notifications using the notification capability.
> > Enable transitional MMR devices to use it in simpler manner.
> >
> > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  transport-pci.tex | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/transport-pci.tex b/transport-pci.tex index
> > 55a6aa0..4fd9898 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -763,6 +763,34 @@ \subsubsection{Notification structure
> > layout}\label{sec:Virtio Transport Options  cap.length >=3D
> > queue_notify_off * notify_off_multiplier + 4  \end{lstlisting}
> >
> > +\paragraph{Transitional MMR Interface: A note on Notification
> > +Capability} \label{sec:Virtio Transport Options / Virtio Over PCI Bus
> > +/ Virtio Structure PCI Capabilities / Notification capability /
> > +Transitional MMR Interface}
> > +
> > +The transitional MMR device benefits from receiving driver
> > +notifications at the Queue Notification address offered using the
> > +notification capability, rather than via the memory mapped legacy
> > +QueueNotify configuration register.
> > +
> > +Transitional MMR device uses same Queue Notification address within a
> > +BAR for all virtqueues:
> > +\begin{lstlisting}
> > +cap.offset
> > +\end{lstlisting}
> > +
> > +The transitional MMR device MUST support Queue Notification address
> > +within a BAR for all virtqueues at:
> > +\begin{lstlisting}
> > +cap.offset
> > +\end{lstlisting}
> > +
> > +The transitional MMR driver that wants to use driver notifications
> > +offered using notification capability MUST use same Queue
> > +Notification address within a BAR for all virtqueues at:
> > +
> > +\begin{lstlisting}
> > +cap.offset
> > +\end{lstlisting}
> > +
> Why? What exactly is going on here? legacy drivers will not do this.

Legacy driver does in the q notify register that was sandwitched in between=
 of slow configuration registers.
This is the notification offset for the hypervisor driver to perform the no=
tification on behalf of the guest driver so that the acceleration available=
 for the non-transitional device can be utilized here as well.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

