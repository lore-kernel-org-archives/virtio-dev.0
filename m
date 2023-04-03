Return-Path: <virtio-dev-return-11931-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33BC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:25:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EC9AB2AC49
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:25:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA6909863ED
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:25:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CDB809863E5; Mon,  3 Apr 2023 20:25:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B877A9863E4;
	Mon,  3 Apr 2023 20:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqyPoi12Ol4ooDQRK3k7nGQWU27AHbufUhRQXZyjRxB2jyc+pWC8ZnN6yz9DkX1lGtNKaxyvanBqSyp73K5jmVtkMUm0prurd29AtFfDxv5fUOdNeszt/dEGkcGA4P4DuDTK4wNHE/9xSQc59ykBOCwoL4vps7ctbCDybMkxuTqHOD36Q4OVPmwSwMCEZ6B63O0CaGvfRxRK3Zk/05SnH1hKSH7KrCan7J3Q3LnoGd7T+hiCg8oN8xvFc5+04GvoHH6kLR+DnZDScQCqz2B6DgrtPNgnzYBR366aXGhGjCC2aUDAxfmsUIPc+jURXsZQG2shjqmMKGF6iHQxGC0i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBYfN/eJhNnVOnezwA59VV2PEcL8gEX9HBnHd27xw2k=;
 b=Up6LiwWLQeAJTHIxmhQFhL1RZvZYQ/XN2DEmDQi2ZSyskqZWH3stolF2/Qndh/vK3BaQfZHtg+GTJZFWmfJjk+FtRv6pJuSDb55iiX6An54D5PajUhPabO8BQG8afCmgn3VKQNSK0h/bkHtZLbL4W/sekUa/mBQhyRm/LG/K4BLEkR0dOrJbAILFGqA8Vx/cYEDlXoui9+ICBtnGG+h091OWtZkSWJnkmTLzG2298y71oWnsYQASJBktyYxJyLtKCmw+KH9RYStxhIiRxRT3kb1hRxh9XNAY1M4PV4DAOlUKA1Ay6R/cZr/UR+hvmmSwBS9RfylYfzap4aWeImEbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index:
 AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8UdveAgAD15oCABER6gIAAAE0wgAADeYCAAAA9cIAABE+AgAAAS7CAAB9nAIAAA6IAgAAJMICAAB3xwA==
Date: Mon, 3 Apr 2023 20:25:02 +0000
Message-ID:
 <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org>
 <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
 <20230403135446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403135446-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6779:EE_
x-ms-office365-filtering-correlation-id: 0ceb8f7b-1fea-46e1-f85d-08db34818159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 99l+eSVPDWMOd8ca0cS6SdVuJFpUTQKmrN5MC+MYhXcJ10Dk+NOLmWbZi2PVtqmOZm4fkfvBnk62BxpY6ZruDhIGx5+MwyC6weTAKndGKQdI0ThvaCrW65JLL7aaX+UraUzIJaCPU56YrOHYh9vKHX9EXifLGRE4gAfGz0liK7AXy+zEdfE2tuk2SteXZbs4ICZIV52DAsN57ukgZLS3s9Puvd7sQfHH4aSWUtRpQwNb+SrG2gpkK2z5cQTE/EAx74O+MMIM9Zpbh/Ff+vEmWta/ZhGrAXdvnoq8Fwi9iEZEMBT2h5hi1mdxP/vIuEGVaZH4nK3wihtDIfuV4YDNrkePUe8o0EG8GEjpb81Q1qVfTpyMXYlalpXmZZ80gsmhrrGbNhALCvoJ35bz+oZUj3srOJPeFWCBFeBK+f8yNLuld/Y87VA2GNLErXqUlsTRfFL6pkc03vMhjYjmNO71vdH9BU/JnXYmC+SzwugGidF+fRAbhyDTUClr9oKFJthGXu4H3fEde5d65yA8rokAhPNntFTwhNBNStgzRKCgVo8hsDwW3yFrtDgWIzjJn+R8HK8PSCQ+pxWq8pBwVObWXQ4l+to9WJTHrEDnLVjNGjxNVDaADkzvthOiEMpkZJ2P
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(66476007)(8676002)(316002)(8936002)(41300700001)(2906002)(66556008)(52536014)(5660300002)(54906003)(76116006)(66946007)(6916009)(66446008)(64756008)(4326008)(478600001)(71200400001)(83380400001)(7696005)(107886003)(9686003)(6506007)(26005)(55016003)(186003)(122000001)(33656002)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AOtl+kSMqgvbL4YsMz0sjIAXs0lDAiqIug430kuyiSpMQ+harn1XLu5uYynY?=
 =?us-ascii?Q?OTHG+kSJGpYy+31emhF+Gn6GLfFn/e4k/6r20sMBlBb1Np5qMBHq+0FPlQuU?=
 =?us-ascii?Q?8vGKHqoLpdtix9XO8uQyuodOKbXplyL/1IWl48pjes6yPxPRHHAfAQFGQ7CX?=
 =?us-ascii?Q?IAKV16HJZ7Bvm8QiJjC4zTEyCEmxbj6iuzN3trKjFeNZgrYJ6rW2P89LiJqG?=
 =?us-ascii?Q?lXzJVs6m70etpj2R/3xVGGTLQa4Npu1UJf6g3cazjHkqG5WWU0ALTz34WBde?=
 =?us-ascii?Q?TZvqwKHZHfPggWqJxLKM0jr8YovN5D7LbZu4/c0EtTzOlRsOpLhcfoBrhsY9?=
 =?us-ascii?Q?9K6V9BtBJ5KbQNcZ0D3Lv2qnw45nrkl9vZtDOfylzUZAb6ohTd0qeouXuwqb?=
 =?us-ascii?Q?whl8Keyprvc5VdLo4Vug7sIIwTcE4mMhLhLs4y9wc5Rk/6mS5/X94ogsz0gx?=
 =?us-ascii?Q?Edh9QFwsZOt5ZsAzGaGCWuWrmVA5MicF12L47CWauidfIHkd+ZWMTa4ZXstL?=
 =?us-ascii?Q?QroqeaP4iPPtDrW3rLIIkR69/vgM10Vl93NeOIoAXwfdjkCa3vF4j5+c+xtI?=
 =?us-ascii?Q?550VZ/RmN2twe8OZCYAlWXblYgO4AfJEb0a/1MzjN+7/7FLJ8+enohEPxgA/?=
 =?us-ascii?Q?wHq/5xHVKZ0Ev7eK4a4TZmg60nVgJhbxJ4B7N/LbLL++MfYsAAkPnlRscPZH?=
 =?us-ascii?Q?sg6hsb109YoHN6ZgMNRqbCWVdCOSQJLXEAKXf9qijBDOq0+CQTvx9YMk4hWW?=
 =?us-ascii?Q?hhYvn9HzUeK9khbX5Y1JljAlhsH64JJ2Z/Vpko5Z/ytP2yzUbTuL1ts4m9AX?=
 =?us-ascii?Q?JtpuNo2zvX0wfdkdxzjRgvf39P3LHuL8O8D9KRs5NVcAB8V4kL6D67JA4IoY?=
 =?us-ascii?Q?1YWwz4baVPkzMqBa9p3LxyDRAvwnvUR8oPHJ9z5+VC5sNshmUSp6s3lN9RiK?=
 =?us-ascii?Q?4rDcYN6d4lKjvZFpljUzqSMotcZBds+w4u9g7EwT2Po+/wO44ZF1wu3tH9uf?=
 =?us-ascii?Q?PST+CJw02dCvROKuGl6KI5+fz9VXRfnx2gNEoeczM64Jk46Ck8eU830UR301?=
 =?us-ascii?Q?wsJYDo2KtXoUQytWNC+7xtl508dByirhzgZ/QSjCm9YdkQeMDkgYFOGv4Lfy?=
 =?us-ascii?Q?Z8RQM6WMx+KYUaBkIzBwhIdozknOJ1ZcwiwRcKaC64lLC8X4kAhj1teO/DsJ?=
 =?us-ascii?Q?dtkdHC5Sr/jFwvZlytSBOLMK1DRVn6n5BO4BSOr09HM8pA7x/nX+efVDR+Yo?=
 =?us-ascii?Q?8gTRtPqyaQkzdU2edoakOEwwomAE0EddlsKBSZBiNwb3g/L0/K38gtICal4v?=
 =?us-ascii?Q?whXHs1STSFje5G1V59F7QCl12yDbhsxe6+ijB6N0Z3jkJ1k0cYpc1tJ/dp5v?=
 =?us-ascii?Q?bf3BJVG3X7vgzDYcC/W/IdmHEeRYy9d2COwB3sxApweh3tq9Mv4lWl000PaG?=
 =?us-ascii?Q?sCX7LNo8dqf/7lZ9IfN1wQkixf/NnxhzQCKf8uruRQjrnMKH0iNYNjRXn4lo?=
 =?us-ascii?Q?bYIR7eK23xf9poxlgzCwkCu0ofKO95WL5ihH/bsgabBXYrhvip+y8oLRiaBM?=
 =?us-ascii?Q?eHAbD1gTR2GVIJ5JCII=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceb8f7b-1fea-46e1-f85d-08db34818159
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 20:25:02.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IG+0icIJ56BzcfKJrc3tWl931V8XvcwS1IOAVGX9Y2EGZ9+sMiUEXzL2BfSDF1AcPIrpLr5GaztJNjnpqQctSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 2:02 PM

> > Because vqs involve DMA operations.
> > It is left to the device implementation to do it, but a generic wisdom
> > is not implement such slow work in the data path engines.
> > So such register access vqs can/may be through firmware.
> > Hence it can involve a lot higher latency.
>=20
> Then that wisdom is wrong? tens of microseconds is not workable even for
> ethtool operations, you are killing boot time.
>=20
Huh.
What ethtool latencies have you experienced? Number?

> I frankly don't know, if device vendors are going to interpret "DMA" as "=
can
> take insane time" then maybe we need to scrap the whole admin vq idea and
> make it all memory mapped like Jason wanted, so as not to lead them into
> temptation?

DMA happens for all types of devices for control and data path.
Can you point to any existing industry specification and real implementatio=
n that highlights such timing requirements.
This will be useful to understand where these requirements come from.

Multiple device implementors do not see memory mapped registers as way forw=
ard.
Discussed many times.
There is no point in going that dead end.

> Let me try again.
>=20
> Modern host binds to modern interface. It can use the PF normally.
> Legacy guest IOBAR accesses to VF are translated to transport vq accesses=
.
>=20
I understand this part.
Transport VQ is on the PF, right? (Nothing but AQ, right?)

It can work in VF case with trade-off compared to memory mapped registers.
A lightweight hypervisor cannot benefit from this which wants to utilize th=
is for transitional PF too.
So providing both the options is useful.

Again, I want to emphasize that register read/write over tvq has merits wit=
h trade-off.
And so the mmr has merits with trade-off too.

Better to list them and proceed forward.

Method-1: VF's register read/write via PF based transport VQ
Pros:
a. Light weight registers implementation in device for new memory region wi=
ndow

Cons:
a. Higher DMA read/write latency
b. Device requires synchronization between non legacy memory mapped registe=
rs and legacy regs access via tvq
c. Can only work with the VF. Cannot work for thin hypervisor, which can ma=
p transitional PF to bare metal OS
(also listed in cover letter)

Method-2: VF's register read/write via MMR (current proposal)
Pros:
a. Device utilizes the same legacy and non-legacy registers.
b. an order of magnitude lower latency due to avoidance of DMA on register =
accesses
(Important but not critical)

> > No. Interrupt latency is in usec range.
> > The major latency contributors in msec range can arise from the device =
side.
>=20
> So you are saying there are devices out there already with this MMR hack
> baked in, and in hardware not firmware, so it works reasonably?
It is better to not assert a solution a "hack", when you are still trying t=
o understand the trade-offs of multiple solutions and when you are yet to f=
ully review all requirements.
(and when solution is also based on an offline feedback from you!)

No. I didn't say that device is out there.
However, large part of the proposed changes is done based on real devices (=
and not limited to virtio).

Regarding tvq, I have some idea on how to improve the register read/writes =
so that its optimal for devices to implement.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

