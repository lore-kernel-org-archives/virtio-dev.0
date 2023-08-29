Return-Path: <virtio-dev-return-13583-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F1CC83F14
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 06:51:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3AFA6370F0
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 06:51:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E89298641B
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 06:51:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 22776983E4A; Tue, 29 Aug 2023 06:51:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FD929863BD;
	Tue, 29 Aug 2023 06:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixIoGniMdA9Hb60QeLqP8PPDztsoxDXk3w09ca8+UBkuAO+qH/xkJgztDPryR4NbocvOJiDIpF3wXvHcoHee7dW3rAueix64ouit4qpP7GNUjSnVhj7pruhG8Lx0sxj1tvCM/SBDd/rfQAg0cWKr+guWjziwGvIq7fh3Sdt7hTOAkViCESYO/4TetmqE5UI8TN0U7dblVOB70255FOa7GBbSYeATCOtbUHBpS2Kiyx7mYkyDj40B4+dWISue2VAK3BwiQFVWtUZ7d3iAQTNVumZfF/57w8j6nRHbDSMa7eoJTq4//ZG8uJoqazpFlt8p1wEfeF77pYIjZgLeM80ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGTpOllwAPwQrYu2T6ouw41vZi/eQ/auqWlytQ9bm/c=;
 b=iZgDEWcSIRy+RAaEY4DdZOebXcLYdtOsm6oafebEZiB0bz9xxkn3L+nYiA4VfYySKnSHARRfKvRtp2tYLYMI+0sbSYXD89j+T9NuSGYP5jqBn1jSO6lPaIOnNdnpj9DRKdfDqaFZL1EQ2R2GeicOIh2xOLKvw63n39ag7WskLIS/h7LYaxI6Le3K/W2yEVqryjxa06kevq5TR7YRFZfuloXAiGoDvY604I4HYULhLmpdvHyUPyakJztBFQ+XWt5hZk8LwVg9tKt/EAuMAHBYNnZz4/8Ac0+gqZJLuyYx3Vlxqkg/RXiHIG+TX2OGoIpW7WMtZModDTpc1mxo+E71ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: [PATCH v15] virtio-net: support device stats
Thread-Index: AQHZ0/q8Fy6v7smapEyK75bFcU4pP6/5UWQAgAdYuYCAADZqAA==
Date: Tue, 29 Aug 2023 06:51:20 +0000
Message-ID:
 <PH0PR12MB548154BAE90B3F4A24175060DCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230821064258.20608-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814174FC713CF5640B7B10DC1DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693279777.37882-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693279777.37882-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6289:EE_
x-ms-office365-filtering-correlation-id: f1da4a8b-a6e1-4693-a0b8-08dba85c59fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u9K06YScNX+PvpCY5DBav3TEG9/z5KSKNDAuVBTn9w2w737DzeEzkZgEK79Zy0WAwazFNa9pzkPi2PFGJ06S5go0BcLksqVGuWFj78tn7IQRlo6xtUME9RMRzYnqHG9LSRTYyxbvSJicUxLczSgXxCgElawEujbEF+a1L+j69yNqzNhDLw87jBKASAuSsaA2HieBX+waxPUdk1EWKryqQYAvQyCzhWspfHj4g+j2fptj3sm4XzPDCTCJustdLb31WkPd7xJAwppfGFkPJbKcYhlk6z/LuV6MnMQWCYJKljj5yBw57mtbTcNkALun0pCEm2xaix2G9Mp/uX5Kx4K3HB91E7jqHgWQrURwgm5BAC0XHslRzZPfkj60t+mIa7OxE+bp3R5raG3R6gBMbqBNn5N9Fb5woHtzSIr8zUeaOHVtzyL0V/p/bbC7XRtZvw2O64AZYZPSZm6u+BUVmfeB3uSb7inCVuJ4VeDtvJYBffRkhwSyErnTa14d5T0Z4hyZrNx/isdQkoihFetJ68iPrJ+W9SnefVZTb0kKYY6LvIh0Lue7S6IX1QctagxuXQGyDPY+nTdROcBtdYplWew9Vbx/c+BNE8Qrr5KGOEnNEejQepkRNjcezZF/YiysIIDupsb7AA1puqvJm+iWZIrFjK4fGfXVGoT+4u4blb+vlFc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(186009)(1800799009)(451199024)(71200400001)(55016003)(7696005)(6506007)(86362001)(33656002)(26005)(55236004)(9686003)(38070700005)(316002)(6916009)(5660300002)(66446008)(76116006)(66946007)(66556008)(38100700002)(66476007)(54906003)(64756008)(52536014)(41300700001)(966005)(2906002)(122000001)(478600001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hmSbRPcVIz8Izj80CQrS6xSL5mbYJiWrSbAG5lVuQWHBZlTgbyft2cPwnxUV?=
 =?us-ascii?Q?l+KywHfZbIqwSGSDfLOPt43IC8AvRCJbyvAyN8MOc/rDXMBjwFrPxoOOptsD?=
 =?us-ascii?Q?allh26vuBqtsz5o3MSUogBSlLvxLS09ziMFbBe+5fNS9KIDSfXXBV2HjxzNq?=
 =?us-ascii?Q?/TNs8vTIAb9liM2xhIvpZzgwJztvOW/CvTlTSbYrb8TU6mOEosW4cPquJHy7?=
 =?us-ascii?Q?WCFPf8EKPiunaltjpVas3rZEEcJEDvAaZSQ/L7Mv9d2ZDEERsUEeGrt8cNoN?=
 =?us-ascii?Q?bXTpiCGltPfmkbPqyPSuuxsUwQwAybEjCORNjDdS/J0tLfzlWgiaGvmOwfQR?=
 =?us-ascii?Q?hD0w289I+C+mEyfS+0ED/WP3Ii15F3Luzvrsf277T3nWuKrjh4Uck8qA3eaD?=
 =?us-ascii?Q?1Bt9I+aXtr+7pt1Fzs2k9D2ywQn0phcGiYt9bnJKsHmH72NSCzY18AxPo5VD?=
 =?us-ascii?Q?Rrkz2LFSDpfOUsjTW+Qjek/HGr3FszKjBTm5jfwDFSScCNh+Fy2I7isZ9aK5?=
 =?us-ascii?Q?LiEKeViuQD9ngjvslICUSszCfcVTEq/Yi0iTOkEREuTpksQ2USK+6p2fjxQb?=
 =?us-ascii?Q?8YsGGYxcY32FmK/t6SHyTPFE1F7cPtTvCmjNKueL8t6hqJMHYceiHjPqpVmw?=
 =?us-ascii?Q?0ootuJ297sdSJEkeEybJOKRz9y5E8dtRCn3h3pf/U6c7W0JXgvWubhVE9uwc?=
 =?us-ascii?Q?EjiSN0fnoz519KB0v1Dog8CG2rODHNw96PEg6qJ59ZXo5mY30jblxluhrzVw?=
 =?us-ascii?Q?DRR0rj38aTbM24P7aVrXYq/i9l5ePi1VcylAne6xIluZbjtezTSFZ4TcvSKe?=
 =?us-ascii?Q?7kR3OCOiHNhQYmByQhdBYvuDBDKSAAiISm+XcYciIPq2/X01Q8ikqZrE+5iD?=
 =?us-ascii?Q?v2ZlWMqo7wJomDFWlsPC5FPXGeskE6PObZqbAd5opAnsUSX/GCmn8fwud1sq?=
 =?us-ascii?Q?V93FIpkox7ZYfzkN0WcqrYFRme4x2wBMQ6DoPYMZWK87/JW/OrE4aOjtzWvR?=
 =?us-ascii?Q?h8P5Fdl9dWNL5I0CEOiZLaeBr5SU6Soln8BrXwYqfrA15T2z3A8Srv6itx/6?=
 =?us-ascii?Q?jvx85AbaNMwuXe2bDsPp76VRcJMx2zoC0XZnLdcfH0mxYJcbEjBmBkzwW0AK?=
 =?us-ascii?Q?6CmiDqvlzhunWcaiGJXhupDJze8FCvU6ROg3KNtEb6MqK+635SJnFMrca/Eb?=
 =?us-ascii?Q?3I/pg1iS0QMnWty4JBKU4JQ09b1SjeACzsjH4L3owK+Rgs5PHEm6ly5jvWUN?=
 =?us-ascii?Q?N7N/blHCSHzFxrgLhxodEgJk67xDf288hR7huYGMICu5qr9BMygK6W5IPny0?=
 =?us-ascii?Q?SDia28vGTA7MaqR8ePoJu+gUyLVcWGpY66jKOrToG7mZOz77tS8EXMSPbVAL?=
 =?us-ascii?Q?zP5Wqk3HpxD+FBeK0Dnmn7aM1GKw4+FOuvflfnF4wOt0kZdiVWiRIUs4gLMh?=
 =?us-ascii?Q?ljZinFXjKAY9AMWyAAC1LVKCW4vHgg+xux5vLfq9zuXvR/C0RrVolgN7980Q?=
 =?us-ascii?Q?eU9Mrp8CrgDItcyiFv8D+6wt3XKB2UKMSePjzlIhY1/xvYpGdSBrnyDYd82R?=
 =?us-ascii?Q?rhiZ7akN+4ehfKrN5/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1da4a8b-a6e1-4693-a0b8-08dba85c59fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 06:51:20.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/YXpwz48vCXWySqdw5i1UOTk2rrOGMxhwdtcVjo2Tc1gk094fW6M9uEt6jRoi6HUVUCVmyKhtK+dbFC7LBRRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Subject: [virtio-dev] RE: RE: [PATCH v15] virtio-net: support device stats



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 29, 2023 9:00 AM

> > Its over cvq, so lets do,
> >
> > s/channel/virtqueue
> >
> > Please rename
> > s/command-specific-data-reply/command_specific_result
>=20
>=20
> I agree.
>=20
> But it will be "command-specific-result" for alignment with 'command-spec=
ific-
> data'.
>
Right.
=20
> > > There is little the driver can do
> > > +except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > +
> > May be driver can retry the command, put to error state, issue diagnost=
ics,
> ignore the error.
> > So There is no need to mention what driver can/cannot do, so please jus=
t
> drop the last line.
>=20
> This is not new. It turns out that there is this line.
>=20
:(
I see it now.

> I think, if you want to remove this, you should post a new patch.
>
It will be separate patch.
=20
> >
> > > +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-
> > > specific-data-reply}.
> > >
> > >  \paragraph{Packet Receive Filtering}\label{sec:Device Types /
> > > Network Device / Device Operation / Control Virtqueue / Packet
> > > Receive Filtering} \label{sec:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Setting Promiscuous Mode}%old label
> > > for latexdiff @@ -1805,6
> > > +1811,424 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > > +Types /
> > > Network Device / Devi
> > >
> > >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> > >
> > > +\paragraph{Device Statistic}\label{sec:Device Types / Network
> > > +Device / Device Operation / Control Virtqueue / Device Statistic}
> > > +
> > > +If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver
> > > +can obtain device stats from the device by using the following comma=
nd.
> > > +
> > s/device stats/device statistics at above and throughout many places be=
low.
> > in the spec wording, better to not shorten them.
> >

> > > +Different types of virtqueues have different stats. The stats of
> > > +the receiveq are different from those of the transmitq.
> > > +
> > > +The stats of a certain type of virtqueue are also divided into
> > > +multiple types because different types require different features.
> > > +This enables the expansion of new stats.
> > > +
> > > +At one time, the driver can obtain the stats of one or multiple virt=
queues.
> > May be
> > s/At one time/In one command
> > This is to be more accurate, otherwise in one time we miss the notion o=
f
> command.

> >
> > > +Additionally, the driver can obtain multiple type stats of each virt=
queue.
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_CTRL_STATS         7
> > > +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> > > +#define VIRTIO_NET_CTRL_STATS_GET     1
> > > +\end{lstlisting}
> > > +
> > > +To obtain device stats, use the VIRTIO_NET_CTRL_STATS_GET command
> > > +with the \field{command-specific-data} containing the
> > > +virtio_net_ctrl_queue_stats structure. The result is returned in
> > > +the
> > > \field{command-specific-data-reply}.
> > > +
> > We opted for slightly different wording for describing command specific=
 data
> and results in aq.
> > So lets align it here.
> > Please reword above as,
> > The \field{command-specific-data} is in the format of \field{ struct
> virtio_net_ctrl_queue_stats}.
> >
> > When the command completes successfully, \field{command_specific_result=
}
> is in the format of \field{struct virtio_net_stats_capabilites}.
> >
> > > +The following structure is used in \field{command-specific-data}:
> > > +\begin{lstlisting}
> > > +struct virtio_net_ctrl_queue_stats {
> > > +       struct {
> > > +           le16 vq_index;
> > > +           le16 padding[3];
> > > +           le64 types[1];
> > > +       } stats[];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The following structures are used in \field{command-specific-data-re=
ply}:
> > > +\begin{lstlisting}
> > > +struct virtio_net_stats_capabilites {
> > > +
> > > +#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 0)
> > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 1)
> > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 2)
> > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 3)
> > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 4)
> > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 5)
> > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 6)
> > > +    le64 supported_stats_types[1];
> > > +}
> > > +
> > It would be best to split the command and description into two. One for=
 the
> capabilities bit map.
> > And second for the actual stats header.
> > This avoids the mix up between the two.
> >
> > > +struct virtio_net_stats_reply_hdr {
> > > +    le16 size;
> > > +    le16 vq_index;
> > > +
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       0
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  1
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   2
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    3
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  4
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   5
> > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    6
> > > +    u8 type;
> > If the query command input has it, we likely don't need it in the respo=
nse.
>=20
> YES.
>=20
> But the driver may need to handle multiple reply stats. I think that will=
 be easy
> for the driver to handle so many stats with the vq_index and type.
>
Do you mean one command result returns multiple stats in one response?
And if so, and the types in the _data is bitmap, better to rename it as typ=
es_bmap or types_bitmap.

> > > +    \item [rx_drop_busy]
> > > +        This is the number of packets dropped by the device when the=
 device
> is
> > > +        busy.
> > > +
> > I feel this is bit abstract counter and qualify the device as busy is t=
ricky. Lets
> move it out of the basic counter.
>=20
> I will rethink about this.
>
Ok.

> > We need to add the capabilities and query them from the AQ too.
> > If the reply header structure and actual stats are split properly, it w=
ill be easy
> to add the query by the owner device.
>=20
> YES. I agree.
>=20
> But I would to know is there some specific requirements?
>
Not sure I understand the question.
We have this requirement in the requirements document of 1.4 at [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202308/msg00260.ht=
ml



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

