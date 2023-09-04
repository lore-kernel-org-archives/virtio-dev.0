Return-Path: <virtio-dev-return-13607-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B1C83F2C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:00:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 35EF842A6E
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:00:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B4CB9865ED
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:00:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1EB3E986412; Mon,  4 Sep 2023 08:00:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D0709863B7;
	Mon,  4 Sep 2023 08:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMgvLxRkYmlA03e+FIdzU933ea4xNNY95ieKH8W0l4e800VH4lCSGu7Ur6rXgf0m/UFu7CUPxdQc2Gb6czUsbx3EHxv9RwluIvrG6topNoRcJ+Z7E0t/992j80e4x8pOBLaOjU7PWaXi4P1X2B/4M3fS34rQ5qtp42G441HTjt7yTCnFwsJeoFjScwzCUn64qpBzFYfGUT/yir1+8d/r/mHiG7VVOW1WK2/9OHvExlAEFfPxVDEoNiUqtmRCp8iu8f2ZzSXynoLa9b38vdF8FRN+W4aPsMVy22r99AqCqknT32w2l/gwB7MQLFnZPw8rs5PiQOcZDdDwCZCy+H89sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNJY3+k6WGwdZ9/5YD5a6NHIAnPuet8QNYNjKESJzsw=;
 b=Fv7KppQ0eWoLqryWbsQQG2YxpeqWgfDUCzqceRGiSaobe8jCrwtGIGVIFUBqcJDs6tTPHtYIXuKn3iBSass8miosTUHTGhuBbzLiczq+uBs42oBGRm8iPCNR3T68oCMyZcAXc4ct0Tx9oGBFDNVruih2jHF/N02J6YwK9k2Ie5j8F80v/7W/Gv/llgHxP11468Nx4S4yMkzpnfG1iF5VZc6DJGXDrnQcmKrbg5uGT3JNsXEoVUk9DP9U79ETJ+4wjlCXPAu5lsIVman/VeR4QtjUlNwAWkD+iYHnvuE8BCl3ygc6ax3LQqG2Sn9Y2cVUq/a0jmxW72XwhgxTQbaqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: [PATCH v16] virtio-net: support device stats
Thread-Index: AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYA==
Date: Mon, 4 Sep 2023 08:00:36 +0000
Message-ID:
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7372:EE_
x-ms-office365-filtering-correlation-id: 7757405b-629f-4569-a839-08dbad1d0582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 P6tzbk3gOeAxI74jDhFDfd9mBwQBRdSedYbM6pFghPvKZy/g7ZMIZHa7z2HHlhjpAUcgidy0IWWzI8eqqt/nyfCKrK/4hMLCyyBnVmy3HtNGszBZ1PbNGn013ltY39y0hwzoHQTd2fH+grfHnrKI0FymG167mg6j+rsJsPT2EoTcX5Ee2ZUN1ZZBgIptKpkbGELY6w2bOkN7Hm3IIu7/P2iWGHlLxRnyc1g5BSfdMgkP0Z20Dc1tR3O2V4tkoQEngoMNhVEg3FLTQf81cYSD/fAN1weQ7OZ/V5z+gECKnuPfZF0lqGtUz+azIUM3Uqq8lwk9NHFYWSilYQKHaHYASxU8W7Z8+5pgAiROzhOLrVvUwKJf8uFvqobYGK362pfjuB56ZacXAkFvRMUwIGP73GmTV1gyTt6OHe3dmCZVeWzmuiZhF91wt86PkJvqZpKbuaHTzasjiPwd1/i95cw8dKXaMHS31SEtE7jtxvfKBSG1kCVOEUlb58RhKNBeVTkIzxfYc11PoNjAxXruq0dpog1eWyixjOnAvjX5WDBFlaNMuzKnmg4VVK9nrx2cZoWkR4luZiVhlqVJy+w73RUkU5xMx3UvqKTa8nQvfYQfFKWKrM8goImG4T7CMax6tc8T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199024)(1800799009)(186009)(9686003)(55236004)(6506007)(478600001)(7696005)(71200400001)(26005)(83380400001)(5660300002)(52536014)(2906002)(66556008)(64756008)(6916009)(66946007)(76116006)(66446008)(66476007)(4326008)(8936002)(316002)(8676002)(41300700001)(54906003)(55016003)(33656002)(38070700005)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TqUTJyHTk/Lz5ockGMJRGPKYn5fLg1VeDpJNhpvmCvXLxTC4yZ2CSXJPf9sB?=
 =?us-ascii?Q?H+cIv+TNlWo0k//XGs2JlABcvIkQF7sYNrPzhKzo4qZhFO/X/Tc/EzGBg862?=
 =?us-ascii?Q?BddVj9z32SxWk0RsPRppCIQjGgPmiZL3xTcBbL4Qsfy4H+MSBmrNXESjYjRQ?=
 =?us-ascii?Q?IeSptSMxgCViSIAkltcF+P4C4hpGM2dE3Z8EvaAwFOe2BloOBAHtobFoTcjL?=
 =?us-ascii?Q?7C/rFh1WeiHbGIUpmd+7bluNICWNHcPc8xt4m2uFiY7vVIWWLnk691Pc7P6P?=
 =?us-ascii?Q?DOGTCgTSQkY1pcFoS7on4T4lNh3rYcoWp/TxzWgEnP/W2k+bwDPZazz0jegm?=
 =?us-ascii?Q?FkAW+BwQDZzKT5fmXAseRYU7Vtttuc0UTCJcU0aJyxmtTxVJWXXCCDlnkxPT?=
 =?us-ascii?Q?t6TRsh9rMINcDWOnEpMxt+WVJqnyLR8mv3QGxyH36ZYSZXN15ymREYf1rJq2?=
 =?us-ascii?Q?xsQGzX05Zq23kQImNwzE44srIx+WC8yd4uDSnwL8pg35jX0RFL1qfW6Nr6RS?=
 =?us-ascii?Q?dt8HhDXmLSKug2J+Dm4fjMLyFYKkwtDvgl2pM1Dm3RaXrbb4XUowTUvqguHD?=
 =?us-ascii?Q?WGJapie7GphYiNlu65mKGI+yDWE6TIGOHSf6XZr/m5XD6CAQ/3leRlrahEnk?=
 =?us-ascii?Q?tZ+yUeo58uEkLUIjVF0x6piT05f4x5GLXY5rj1qn1X7Fngb3ScxplQkCkbCN?=
 =?us-ascii?Q?fWP+dD6AnkCFpu54nCTEGSvfmzsuENMTh00mhCHB5aWQrrPTUWYlxFUSmlHI?=
 =?us-ascii?Q?J1xp6HLACEe+DXoVal/y/kYZ9ZYnjpbqQLE+mAjT2q9VuPxbnh7JemxyBa+N?=
 =?us-ascii?Q?jqjVdNoNSgjNCxbez0dveE3gTap93nDGpa/UqU1i4FuIQ0WDLjsvB4YPakiD?=
 =?us-ascii?Q?Th5zF1z/e8qH3r8YnOVyl/yYGVNb05TSocnu+FpzFI3c5/TllnBb5mr6MmQn?=
 =?us-ascii?Q?vPtN/BbHQ4jF0gXQgXZGmIqGkx8Cv5pIyFMTodNNmYNifLaFWV9zTyuhzC1E?=
 =?us-ascii?Q?L5jgf94KyEiQlh2zyGgE1/RIATmAx76K7irpNRw7etduZuGpNeD6heaNCLsS?=
 =?us-ascii?Q?sqGDSnnDbVxiSzatYxqgGbDF/ayXEgcszBayyYvFOX0Zugm0/j99dLy+xOQo?=
 =?us-ascii?Q?UMY4iMoO8XDbjAfMPXYlBa+j7DW6pUOHd/x2X8zVFbssFzxQ+LnBZ+Qo2N0k?=
 =?us-ascii?Q?n/HLcX6zIfLvIQclET+A9u8m3fxLlnkNWrRiAzTtjrPH3AVGW3NoVnTglhE7?=
 =?us-ascii?Q?Tl+YDHiRWTVzeCtG6asKChojGoOy3fhJAl2uZu9C6veW5ZIhdcMSSj+UEATf?=
 =?us-ascii?Q?1423n72dEftfO498YCUXzTWvqFz+E+YnKpOKoyDDusIbqfQ2xPwOHGeXGvrS?=
 =?us-ascii?Q?xsTRV5ywjMc9iMUlcGJ7v5M5DQbuKOanZA20W7tnQPL7qGrwskg9ViRaVNtL?=
 =?us-ascii?Q?4GOn9mSa8hyctoPlSwMN4hVfqj3U3rPQ6l5PLmbe892xZtvCBk0P+2NqLCAc?=
 =?us-ascii?Q?QQXGdN9LTdxQzip5OGX+x4G4N0UuNXd66Icah/HDcE3ANufPWuN+VRJUYPmG?=
 =?us-ascii?Q?5L7VRK07XCglhRNggbM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7757405b-629f-4569-a839-08dbad1d0582
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 08:00:36.0829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm0FeuaJ7Olfnjjv0QR6QFpjhwL9YHky/vnHkknRpIEmrllf8heKMsNy7SeuycjyZuAYqu7f2qFvo3yJCAhkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
Subject: [virtio-dev] RE: RE: [PATCH v16] virtio-net: support device stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, September 4, 2023 1:04 PM

> > > +If one or more of the VIRTIO_NET_F_GUEST_TSO4,
> > > VIRTIO_NET_F_GUEST_TSO6,
> > > +or VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO
> > > +statistics can be obtained.
> > > +
> > UFO is deprecated feature in the OS that supported it.
> > And unlikely to be used in any new OS.
> > So I think one should drop the UFO for now from above.
>=20
> But, the virtio spec supports it. So I think we should include it here.
>=20
UFO and receive GSO is bit different.
And UFO has near to zero use.
So if this is really needed, one can implement such counter later when UFO =
is actually implemented and used.

> > > +\begin{description}
> > > +    \item [tx_gso_packets]
> > > +        The number of the GSO packets sent by device that are not cu=
t to
> small
> > > +        packets.
> > > +
> > Above is a strange counter.
> > Do you have an example of it along with _split counter below?
> > I am probably misunderstanding it.
>=20
> On one host, a vm can send a gso packet without cutting to other vm.
>=20
Do you mean some sw entity has sent the GSO packet directly such as 64KB SK=
B without creating segments?
If so, how will the receive device can receive such large packet when the p=
osted buffer is not worth the 64KB size?

> >
> > > +    \item [tx_gso_bytes]
> > > +        The bytes of the GSO packets sent by device that are not cut=
 to small
> > > +        packets.
> > > +
> > > +    \item [tx_gso_packets_split]
> > > +        The number of the GSO packets that been cut into small packe=
ts.
> > > +
> > Which has been cut into small packets.
> >
> > > +    \item [tx_gso_bytes_split]
> > > +        The bytes of the GSO packets that been cut into small packet=
s.
> > > +
> > > +    \item [tx_gso_segments]
> > > +        The number of segments separated from the GSO packets.
> > > +
> > > +    \item [tx_gso_segments_bytes]
> > > +        The bytes of segments separated from the GSO packets.
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq Speed Statistic}\label{sec:Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Device
> > > +Statistic / Receiveq Speed Statistic}
> > > +
> > > +The structure corresponding to the receiveq speed statistics is
> > > virtio_net_stats_rx_speed.
> > > +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_SPEED. This is
> > > +for the receiveq.
> > > +
> > > +The device has the allowance for the speed. If
> > > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get
> > > +this by
> > > \field{speed}.
> > > +When the real speed exceeds the speed allowance, some packets will
> > > +be dropped by the device.
> > > +
> > Above description regarding "real speed" is confusing.
> > I think you wanted to say,
> >
> > When the received packets rate exceeds the negotiated speed, some packe=
ts
> may be dropped by the device.
> >
> > > +\begin{lstlisting}
> > > +struct virtio_net_stats_rx_speed {
> > > +    struct virtio_net_stats_reply_hdr hdr;
> > > +
> > > +    le64 rx_packets_allowance_exceeded;
> > > +    le64 rx_bytes_allowance_exceeded; }; \end{lstlisting}
> > > +
> > > +The packets described below were all presented on the specified virt=
queue.
> > > +\begin{description}
> > > +    \item [rx_packets_allowance_exceeded]
> > > +        The number of the packets dropped by device due to the real =
speed
> > > +        exceeding the speed allowance.
> > > +
> > Similar rewording like above to drop "real".
> >
> > > +    \item [rx_bytes_allowance_exceeded]
> > > +        The bytes of the packets dropped by device due to the real s=
peed
> > > +        exceeding the speed allowance.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq Speed Statistic}\label{sec:Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Device
> > > +Statistic / Transmitq Speed Statistic}
> > > +
> > > +The structure corresponding to the transmitq speed statistics is
> > > +virtio_net_stats_tx_speed. The corresponding type is
> > > +VIRTIO_NET_STATS_TYPE_TX_SPEED. This is for the transmitq.
> > > +
> > > +The device has the allowance for the speed. If
> > > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get
> > > +this by
> > > \field{speed}.
> > > +When the real speed exceeds the speed allowance, some packets will
> > > +be dropped by the device.
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_net_stats_tx_speed {
> > > +    struct virtio_net_stats_reply_hdr hdr;
> > > +
> > > +    le64 tx_packets_allowance_exceeded;
> > > +    le64 tx_bytes_allowance_exceeded; }; \end{lstlisting}
> > > +
> > > +The packets described below were all presented on the specified virt=
queue.
> > > +\begin{description}
> > > +    \item [tx_packets_allowance_exceeded]
> > > +        The number of the packets dropped by device due to the real =
speed
> > > +        exceeding the speed allowance.
> > > +
> > > +    \item [tx_bytes_allowance_exceeded]
> > > +        The bytes of the packets dropped by device due to the real s=
peed
> > > +        exceeding the speed allowance.
> > > +
> > > +\end{description}
> > > +
> > > +\devicenormative{\subparagraph}{Device Statistic}{Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Device
> > > +Statistic} The device MUST replies to the command
> > > +VIRTIO_NET_CTRL_STATS_QUERY with the struct
> virtio_net_stats_capabilities.
> > > \field{supported_stats_types} includes all the statistic types
> > > supported by the device.
> > > +
> > > +If virtio_net_ctrl_queue_stats is incorrect (such as the
> > > +following), the device MUST set \field{ack} to VIRTIO_NET_ERR. Even
> > > +if there is only one error, the device MUST fail the entire command.
> > > +\begin{itemize}
> > > +    \item \field{vq_index} exceeds the queue range.
> > > +    \item \field{types_bitmap} contains unknown types.
> > > +    \item One or more of the bits present in \field{types_bitmap} is=
 not valid
> > > +        for the specified virtqueue.
> > > +    \item The feature corresponding to the specified \field{types_bi=
tmap}
> was
> > > +        not negotiated.
> > > +    \item The size of the buffer allocated by the driver for
> > > +\field{command-
> > > specific-result}
> > > +        is less than the total size of the statistics specialed by
> > > +        \field{virtio_net_ctrl_queue_stats}.
> > > +\end{itemize}
> > > +
> > > +The device MUST write the requested statistic structures in
> > s/statistic/statistics
> >
> > > +\field{command-specific-result} in the order specified by the
> > > +structure virtio_net_ctrl_queue_stats. If the \field{types_bitmap}
> > > +indicates
> > Use \field{..}
> >
> > > +multiple statistics, the replies order by the type value from small =
to large.
> > > +
> > These replies are ordered by the type value from small to large.
> > I am not sure device needs to order them.
>=20
> Now, the hdr of statistics has the type field.
>=20
> We can remove this.
>=20
We still need the type field, just need to remove the ordering need.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

