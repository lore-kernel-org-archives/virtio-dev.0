Return-Path: <virtio-dev-return-13598-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC28CA0FE8
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:58:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 659BE780EE
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:58:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 472229865A7
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:58:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3809D98658C; Fri,  1 Sep 2023 13:58:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 248F998658E;
	Fri,  1 Sep 2023 13:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYyYSXEi78FqJj7sY+6sYNST+Zvwcz5c+LPgTEXqKYXxhQCFhhN5TNOrHcHT/X/SirTjBrqRrim6CBs6ARD7Bv7OSIqbqiCssqkDYtyYF+4aRrWmgB78zzOe2kStjK4ofwV8Ee+OqNRGpqYYkFqjcRy4UxLSWrhQbhBgRBTOUjufzXkfKDLDASi9NUU6Ms+ZPs7ts/52BDAzV/qe7KQdFiV5xPNlxjWTH0AB3nLID74+PDDyZmWDoi+/yCTndxPlMbApzO1CGUrriIPsfqLQDcImo9pNt3EFKDtCQ0KlSwPV8FaKOch8X9DPQ6QbJSMUSyWyjaAtFovrjWaowulbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk3NRE9/WGDKST7ERuhyhu0I1ScZn0mwxMQvXso+Uqk=;
 b=Im9GSVXzwRjXhclq2osoxY8B1HWGFAHzej+CRMJAlOgLxrT98N+cHrdYuOXS3mZux9Xr19K28qJ5UVW7WGd/QB6DCdQhqGpzKfaPblAT1CdtRAO/koyIYa84KeBtgFBp91M6MeaVA89BLm4BXWWP6RpJ1/svyJ9OsYX8vgi7PF3IbEKEFQrLtNX8+WOJUajuv957tDXglf4WISNcm9BSYXgYcA55C9LCnARrp0nOZ5/TL1GJRhX3EDgAXr3dz90mgBLf9bDsFJY/c1LNxIcaVGKVABul4wdqhyn75ZM+X2YeOHE6rAJZDOHSCf44Sylfbh2rpSfLBgJjTn29ILRn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [PATCH v16] virtio-net: support device stats
Thread-Index: AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaA
Date: Fri, 1 Sep 2023 13:58:32 +0000
Message-ID:
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5285:EE_
x-ms-office365-filtering-correlation-id: a207f763-4103-456f-f1ff-08dbaaf38746
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mu+IPLm2wdwfG0m8BS2C/QnDwAwLIMjZa0FwbOsKe7XS6wPBV8huMW5rfFjri1aHNLDdXJPjAnbgweD/SnLVCsDtJkwkwoBqsLTEhR6fTuubtQj0CoEvfQ27KA7WqCHejdelhzAtsnRLwOCf5pfT/upCty6BtneGv9r56MvlMLp0VCRqob9n0Gipnq4ov4yJ9xZReDHRYoHS4L/csMvgXrhc8wBXJSAVhowZYP8AOAXjDnroGA23lbDIIYMXkVsaHi4LteuTqoY19epJQK99UC4bTuw6rFxrV58WBvI4eWxaHFNneFFq4eJaHsvc2olvlWG4gYiJbmP98jkJjGjRUR6/hbKTZmALwK4ttC/Z7tD52lERi+s2xqftnH1+Os2ofSD4nN6h6YJCtpXr5PAG01vuAhVeZxQu6PrFgNU1N+4BRXppopRbw1cez+P6HALdMMqw03KX3YuRYgvsp1MgdCh6h8rBeLo3c4B5irknJQlIqfkM/P5a6aHqRlOhpHxORZUYOyFty7fCf4qp11PLSyJH6rWWG1nC+uC3iJEYGcij1xJNsvGW/KtlFX4teWog2qhoXUQ85ZOdXiO7KZpd0aRIuvMCDqbiYpRjX9/CitNuXUVkT7F5TXlELPuJXJN0aAhiKsP3eem82j/aX09M5LfJQKSVwGGipV8KwBv/Zpo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(71200400001)(6506007)(9686003)(7696005)(16799955002)(33656002)(86362001)(122000001)(38070700005)(38100700002)(55016003)(30864003)(2906002)(26005)(966005)(53546011)(83380400001)(478600001)(110136005)(52536014)(76116006)(66946007)(8676002)(8936002)(4326008)(5660300002)(41300700001)(316002)(66476007)(66446008)(54906003)(66556008)(64756008)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DBwPR62awwqgvSdR5jLDdVaFAycjCfEiXfREnBbgH1di5OellKMeNqiJatX9?=
 =?us-ascii?Q?eSXbpAeAB1oiQVpa5TZBdjy6BS6bI9KQ97fnkQHxVDOPTujZWFi1ybIEkYGw?=
 =?us-ascii?Q?V4zqNiP5E4D0Wj0MlxQhKx8y40FeT+MTHcoxkgiaQipHrfXSe5WjcTaCEr1A?=
 =?us-ascii?Q?E3RmUIBIBLPVDgIgWC+RH/upBr0faWS5T45oEuhlQ5Fpw7Vdw0+gxAotjEsR?=
 =?us-ascii?Q?HxtyC4YxNJeQqAPurNWdluZR2DnLegAVNtYHlaOKg4a02SSDsusXMJ7NGCSR?=
 =?us-ascii?Q?cF8hgk6tX9HvdzZd+0gWAq/2Md6H+Y0kPL89Mu/LOyP7N9ErdoeAmLOo0UNa?=
 =?us-ascii?Q?SEoU6QMKlRoeGI7aEFmt7oc71Mu5UhX51YB/8zj9D8EYILQaThpxnOOnu+Z8?=
 =?us-ascii?Q?y8uCXr/PLhOuGzr3i2ZCUgVTMsv+wjeLKuFqzKEjhM2KM6kwWUJP/Nare/oi?=
 =?us-ascii?Q?KDN4y72xOD5o/5UpcQaLF3b588uqo6sRRHf3ycskulLvQ6GKmzKVRWsMXer4?=
 =?us-ascii?Q?JJbiNiHqKwofYp2Gj/ZweGJx3ByRbM5pldHSYbPvDT6tlQkuR+CVYxlkbTvV?=
 =?us-ascii?Q?E3DZE3ZDQz5jnL7MBa5IrZRhby1O9th8cCJns3eURPojAUrxgIXpCMVOjZ0/?=
 =?us-ascii?Q?G7dYpqGJbAuWCOnbaGaKgD/L0BHJwPk7gw30y87Byqkxa8PudKc1ElORePF4?=
 =?us-ascii?Q?pJYOvXTfeh6/h1hd40zWTotKYJesiwMHtIQLRw70HtN7WkFM16J5zpMwGAs+?=
 =?us-ascii?Q?IAtoXl393meeuS2d+uEULgWdMCUIxylYLUglJg8+wXrs6CMhlASxCw+BY3pt?=
 =?us-ascii?Q?vpQxsek8AJXIIlr5CAuwQZyT+IkgVcIGl4zIs6A+3Cm+UL0diCRyMZ1lOCDO?=
 =?us-ascii?Q?VVGXQjE4h2pK1bfyr7NytcW9iIUhbypWX1QtHQU+phIh4cFo85LwBBElApo7?=
 =?us-ascii?Q?NOqS9apiTrc1qyi6MOPcGF5qZnn0qitLKGgG3P2VyEvOtHifVLV226ZStYxV?=
 =?us-ascii?Q?4inIWSKk16mCd6No0z1Q4MZtTGK7yGwH1oNfEtt0LQiLdUF2LFa1IXQFXabe?=
 =?us-ascii?Q?nQUt3H8b4CZfwVO5bVaghSKYeWP8Ocj7DQkTgrmY/lEfS0dM3+bEY4qtj7cK?=
 =?us-ascii?Q?cJGYS5ylxwmV/lOMz4cfUGdXeT3FO3J19p1TYAYf0jPAUV6j1VGwOj+6oz0B?=
 =?us-ascii?Q?6gTrWLPg2VL1RoatTXUzvf0ivXudLyhpsRcQkr5JhpaxC63/Lja3D3sOvoen?=
 =?us-ascii?Q?Lzuxr1oneExuMtk1jieFk4CJSk01urdRpjEsaE2nUm8Sx82ODA+ee1lso7UP?=
 =?us-ascii?Q?H97KI0AiU1Dyvjy5leU6NJLOXQmq1/8Wvi8O6UtP8XE9O9iDzwN8fO/IuMJc?=
 =?us-ascii?Q?rnn4GrcdM/MU/LGcfwcmbYq/lya2xaqa/Jo6LWFeNIzp1vSughIi59J4gOIa?=
 =?us-ascii?Q?rVwqDk/PK2hfQuE89Q8FoF+JMCzmzLtwvc7fOPzSQI9NZxC2zsw49YzEep0W?=
 =?us-ascii?Q?+RvT1Ziv1CAnm5NM6RB6YzjIhc2rITEQ9iGZq2RT+jsqHxrUlMUdcxmKzmf1?=
 =?us-ascii?Q?0VGiLTy9XRrTSBTdMAE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a207f763-4103-456f-f1ff-08dbaaf38746
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 13:58:32.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ne1cXfLoODUcTgb92NJYFI4LL7gsdCXL/GLV5snMcQJwVPGILOz25eZFkQNslvgs2wA/ZNiU+l8BUGSGHL9bXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Subject: [virtio-dev] RE: [PATCH v16] virtio-net: support device stats



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Wednesday, August 30, 2023 11:23 AM
> To: virtio-dev@lists.oasis-open.org
> Cc: jasowang@redhat.com; Michael S. Tsirkin <mst@redhat.com>; Parav Pandi=
t
> <parav@nvidia.com>; David Edmondson <david.edmondson@oracle.com>;
> virtio-comment@lists.oasis-open.org

We should be following [1].
Virtio list for conducting technical committee work, which is this patch.
And to get feedback from community virtio-comment list, which you already C=
Ced.

So virtio-dev should be replaced with virtio list because this patch is abo=
ut developing the virtio spec itself, (not implementing the spec in device/=
driver etc).

[1] https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#fe=
edback

> Subject: [PATCH v16] virtio-net: support device stats
>=20
> This patch allows the driver to obtain some statistics from the device.
>=20
> In the device implementation, we can count a lot of such information, whi=
ch
> can be used for debugging and judging the running status of the device. W=
e
> hope to directly display it to the user through ethtool.
>=20
> To get stats atomically, try to get stats for all/multiple queue pairs in=
 one
> command.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

> +
> +If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver can
> +obtain device statistics from the device by using the following command.
> +
> +Different types of virtqueues have different statistics. The statistics
> +of the receiveq are different from those of the transmitq.
> +
> +The statistics of a certain type of virtqueue are also divided into
> +multiple types because different types require different features. This
> +enables the expansion of new statistics.
> +
> +In one command, the driver can obtain the statistics of one or multiple
> virtqueues.
> +Additionally, the driver can obtain multiple type statistics of each vir=
tqueue.
> +
> +\subparagraph{Query Statistic Capabilities}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Query Statistic Capabilities}
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS         7
> +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> +#define VIRTIO_NET_CTRL_STATS_GET     1
> +
> +struct virtio_net_stats_capabilities {
> +
> +#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 32)
> +
> +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1 << 3)
> +
> +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 16)
> +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 17)
> +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 18)
> +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1 << 19)
> +
> +    le64 supported_stats_types[1];
> +}
> +\end{lstlisting}
> +
> +To obtain device statistic capability, use the
> +VIRTIO_NET_CTRL_STATS_QUERY command. When the command completes
> +successfully, \field{command-specific-result} is in the format of \field=
{struct
> virtio_net_stats_capabilities}.
> +
> +\subparagraph{Get Statistics}\label{sec:Device Types / Network Device /
> +Device Operation / Control Virtqueue / Device Statistic / Get
> +Statistic}
> +
s/Device Statistic/Device Statistics

s/Get Statistic/Get Statistics

> +\begin{lstlisting}
> +struct virtio_net_ctrl_queue_stats {
> +       struct {
> +           le16 vq_index;
> +           le16 padding[3];
> +           le64 types_bitmap[1];
> +       } stats[];
> +};
> +
> +struct virtio_net_stats_reply_hdr {
> +    le32 size;
> +    le16 vq_index;
> +
> +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
> +
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
> +
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
> +    u8 type;
> +    u8 padding;
s/padding/reserved so that we can use the reserved for something else in fu=
ture.

I think arranging it as,
u8 type
u8 reserved
le16 vq_index
le32 size
reads better, to look at the type first and demultiplex from it.
Schema as TLV (type length value) reads obvious.

> +}
> +\end{lstlisting}
> +
> +To obtain device statistics, use the VIRTIO_NET_CTRL_STATS_GET command
> +with the \field{command-specific-data} which is in the format of \field{=
struct
> virtio_net_ctrl_queue_stats}.
> +When the command completes successfully,
> +\field{command-specific-result} contains multiple statistic results,
> +each statistic result has the \field{struct virtio_net_stats_reply_hdr} =
as the
> header.
> +
> +The fields of the \field{struct virtio_net_ctrl_queue_stats}:
> +\begin{description}
> +    \item [vq_index]
> +        The index of the virtqueue to obtain the statistics.
> +
> +    \item [types_bitmap]
> +        This is a bitmask of the types of statistics to be obtained. The=
refore, a
> +        \field{struct stats} inside virtio_net_ctrl_queue_stats may indi=
cate
> +        multiple statistic replies for the virtqueue.
> +\end{description}
> +
> +The fields of the \field{struct virtio_net_stats_reply_hdr}:
> +\begin{description}
> +    \item [vq_index]
> +        The virtqueue index of the reply statistic.
> +
> +    \item [size]
> +        The size of bytes of the reply statistic.
> +
> +    \item [type]
> +        The type of the reply statistic.
> +
> +\end{description}
> +
> +\subparagraph{Controlq Statistic}\label{sec:Device Types / Network
> +Device / Device Operation / Control Virtqueue / Device Statistic /
> +Controlq Statistic}
> +
> +The structure corresponding to the controlq statistics is virtio_net_sta=
ts_cvq.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_CVQ. This is for the
> controlq.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_cvq {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 command_num;
> +    le64 ok_num;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item [command_num]
> +        The number of commands received by the device including the curr=
ent
> command.
> +
> +    \item [ok_num]
> +        The number of commands completed successfully by the device incl=
uding
> the current command.
> +\end{description}
> +
> +
> +\subparagraph{Receiveq Basic Statistic}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Receiveq Basic Statistic}
> +
> +The structure corresponding to the receiveq basic statistics is
> virtio_net_stats_rx_basic.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_BASIC. This is for
> +the receiveq.
> +
> +Receiveq basic statistics does not require any feature. As long as the
> +device supports VIRTIO_NET_F_DEVICE_STATS, the following are the receive=
q
> basic statistics.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_rx_basic {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 rx_notifications;
> +
> +    le64 rx_packets;
> +    le64 rx_bytes;
> +
> +    le64 rx_interrupts;
> +
> +    le64 rx_drops;
> +    le64 rx_drop_overruns;
> +    le64 rx_drop_busy;
> +};
> +\end{lstlisting}
> +
> +The packets described below were all presented on the specified virtqueu=
e.
> +\begin{description}
> +    \item [rx_notifications]
> +        The number of driver notifications received by device for this r=
eceiveq.
> +
> +    \item [rx_packets]
> +        This is the number of packets received by the device (not the pa=
ckets
> +        passed to the guest). The count includes the packets dropped by =
the
> +        device.
> +
> +    \item [rx_bytes]
> +        This is the bytes of packets received by the device (not the pac=
kets
> +        passed to the guest). The count includes the packets dropped by =
the
> +        device.
> +
s/not the packets passed to the guest/not the bytes copied to the guest

> +    \item [rx_interrupts]
> +        The number of interrupts generated by the device for this receiv=
eq.
> +
> +    \item [rx_drops]
> +        This is the number of packets dropped by the device. The count i=
ncludes
> +        all types of packets dropped by the device.
> +
> +    \item [rx_drop_overruns]
> +        This is the number of packets dropped by the device when no more
> +        descriptors were available.
> +
> +    \item [rx_drop_busy]
> +        This is the number of packets dropped by the device when the dev=
ice is
> +        busy.
> +
I think the busy counter does not belong to busy category as it is slightly=
 difficult to define.
Lets please move to different category.

> +\end{description}
> +
> +\subparagraph{Transmitq Basic Statistic}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Transmitq Basic Statistic}
> +
> +The structure corresponding to the transmitq basic statistics is
> virtio_net_stats_tx_basic.
s/virtio_net_stats_tx_basic/ \field{struct virtio_net_stats_tx_basic}

> +The corresponding type is VIRTIO_NET_STATS_TYPE_TX_BASIC. This is for
> +the transmitq.
> +
> +Transmitq basic statistics does not require any feature. As long as the
> +device supports VIRTIO_NET_F_DEVICE_STATS, the following are the transmi=
tq
> basic statistics.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_tx_basic {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 tx_notifications;
> +
> +    le64 tx_packets;
> +    le64 tx_bytes;
> +
> +    le64 tx_interrupts;
> +
> +    le64 tx_drops;
> +    le64 tx_drop_malformed;
> +
> +    le64 tx_drop_busy;
Same as rx.

> +};
> +\end{lstlisting}
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_notifications]
> +        The number of driver notifications received by device for this t=
ransmitq.
> +
> +    \item [tx_packets]
> +        This is the number of packets sent by the device (not the packet=
s
> +        got from the driver).
> +
> +    \item [tx_bytes]
> +        This is the bytes of packets sent by the device (not the packets
> +        got from the driver).
> +
This is the number of bytes sent by the device for all the sent packets (no=
t the bytes sent by the driver).
> +    \item [tx_interrupts]
> +        The number of interrupts generated by the device for this transm=
itq.
> +
> +    \item [tx_drops]
> +        The number of packets dropped by the device. The count includes =
all
> +        types of packets dropped by the device.
> +
> +    \item [tx_drop_malformed]
> +        The number of packets dropped by the device, when the descriptor=
s are
> +        malformed. For example, the buffer is too short.
> +
> +    \item [tx_drop_busy]
> +        The number of packets dropped by the device, when the device is =
busy.
> +
Same as rx.

> +\end{description}
> +
> +\subparagraph{Receiveq CSUM Statistic}\label{sec:Device Types / Network
> +Device / Device Operation / Control Virtqueue / Device Statistic /
> +Receiveq CSUM Statistic}
> +
> +The structure corresponding to the receiveq csum statistics is
> virtio_net_stats_rx_csum.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_CSUM. This is for
> +the receiveq.
> +
> +Only after the VIRTIO_NET_F_GUEST_CSUM is negotiated, the receiveq csum
> +statistics can be obtained.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_rx_csum {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 rx_csum_valid;
> +    le64 rx_needs_csum;
> +    le64 rx_csum_none;
> +    le64 rx_csum_bad;
> +};
> +\end{lstlisting}
> +
> +The packets described below were all presented on the specified virtqueu=
e.
> +\begin{description}
> +    \item [rx_csum_valid]
> +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> +
> +    \item [rx_needs_csum]
> +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> +
> +    \item [rx_csum_none]
> +        The number of packets without hardware csum. The packet here ref=
ers to
> +        the non-TCP/UDP packet that the backend cannot recognize.
> +
s/backend/device

> +    \item [rx_csum_bad]
> +        The number of packets with abnormal csum.
s/abnormal/wrong

no strong opinion though.

> +
> +\end{description}
> +
> +\subparagraph{Transmitq CSUM Statistic}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Transmitq CSUM Statistic}
> +
> +The structure corresponding to the transmitq csum statistics is
> virtio_net_stats_tx_csum.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_TX_CSUM. This is for the
> transmitq.
> +
> +Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum
> +statistics can be obtained.
> +
> +The following are the transmitq csum statistics:
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_tx_csum {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 tx_csum_none;
> +    le64 tx_needs_csum;
> +};
> +\end{lstlisting}
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_csum_none]
> +        The number of packets which didn't require hardware csum.
> +
The number of packets which requires checksum calculation by the device.

> +    \item [tx_needs_csum]
> +        The number of packets which required hardware csum.
> +
Similar to above.

> +\end{description}
> +
> +\subparagraph{Receiveq GSO Statistic}\label{sec:Device Types / Network
> +Device / Device Operation / Control Virtqueue / Device Statistic /
> +Receiveq GSO Statistic}
> +
> +The structure corresponding to the receivq GSO statistics is
> virtio_net_stats_rx_gso.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_GSO. This is for the
> +receiveq.
> +
> +If one or more of the VIRTIO_NET_F_GUEST_TSO4,
> VIRTIO_NET_F_GUEST_TSO6,
> +or VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO
> +statistics can be obtained.
> +
UFO is deprecated feature in the OS that supported it.
And unlikely to be used in any new OS.
So I think one should drop the UFO for now from above.

> +GSO packets refer to packets passed by the device to the driver where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_rx_gso {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 rx_gso_packets;
> +    le64 rx_gso_bytes;
> +    le64 rx_gso_packets_coalesced;
> +    le64 rx_gso_bytes_coalesced;
> +    le64 rx_gso_segments;
> +    le64 rx_gso_segments_bytes;
> +};
> +\end{lstlisting}
> +
> +The packets described below were all presented on the specified virtqueu=
e.
> +\begin{description}
> +    \item [rx_gso_packets]
> +        The number of the GSO packets received by device.
> +
s/by device/by the device

> +    \item [rx_gso_bytes]
> +        The bytes of the GSO packets received by device.
s/by device/by the device

> +        This includes the header size of the GSO packet.
> +
> +    \item [rx_gso_packets_coalesced]
> +        The number of the GSO packets coalesced by device.
> +
> +    \item [rx_gso_bytes_coalesced]
> +        The bytes of the GSO packets coalesced by device.
> +        This includes the header size of the GSO packet.
> +
Below two statistics are not making much sense for debug purpose as it chan=
ges a lot.
I guess we should drop them. Above counters are good enough hints for debug=
ging GSO.

> +    \item [rx_gso_segments]
> +        The number of the segments which make up GSO packets.
> +
> +    \item [rx_gso_segments_bytes]
> +        The bytes of the segments which make up GSO packets.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq GSO Statistic}\label{sec:Device Types / Network
> +Device / Device Operation / Control Virtqueue / Device Statistic /
> +Transmitq GSO Statistic}
> +
s/GSO Statistic/GSO Statistics
Please review similar headings.

> +The structure corresponding to the transmitq GSO statistics is
> +virtio_net_stats_tx_gso. The corresponding type is
Use \field{..}.

> VIRTIO_NET_STATS_TYPE_TX_GSO.
> +This is for the
> +transmitq.
> +
> +If one or more of the VIRTIO_NET_F_HOST_TSO4,
> VIRTIO_NET_F_HOST_TSO6,
> +VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have been
> +negotiated, the transmitq GSO statistics can be obtained.
> +
> +GSO packets refer to packets passed by the driver to the device where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +See more \ref{sec:Device Types / Network Device / Device Operation /
> +Packet Transmission}.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_tx_gso {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 tx_gso_packets;
> +    le64 tx_gso_bytes;
> +    le64 tx_gso_packets_split;
> +    le64 tx_gso_bytes_split;
> +    le64 tx_gso_segments;
> +    le64 tx_gso_segments_bytes;
> +};
> +\end{lstlisting}
> +
> +The packets described below are all from a specific virtqueue.
For a specific virtqueue.

> +\begin{description}
> +    \item [tx_gso_packets]
> +        The number of the GSO packets sent by device that are not cut to=
 small
> +        packets.
> +
Above is a strange counter.
Do you have an example of it along with _split counter below?
I am probably misunderstanding it.

> +    \item [tx_gso_bytes]
> +        The bytes of the GSO packets sent by device that are not cut to =
small
> +        packets.
> +
> +    \item [tx_gso_packets_split]
> +        The number of the GSO packets that been cut into small packets.
> +
Which has been cut into small packets.

> +    \item [tx_gso_bytes_split]
> +        The bytes of the GSO packets that been cut into small packets.
> +
> +    \item [tx_gso_segments]
> +        The number of segments separated from the GSO packets.
> +
> +    \item [tx_gso_segments_bytes]
> +        The bytes of segments separated from the GSO packets.
> +\end{description}
> +
> +\subparagraph{Receiveq Speed Statistic}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Receiveq Speed Statistic}
> +
> +The structure corresponding to the receiveq speed statistics is
> virtio_net_stats_rx_speed.
> +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_SPEED. This is for
> +the receiveq.
> +
> +The device has the allowance for the speed. If
> +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get this b=
y
> \field{speed}.
> +When the real speed exceeds the speed allowance, some packets will be
> +dropped by the device.
> +
Above description regarding "real speed" is confusing.
I think you wanted to say,

When the received packets rate exceeds the negotiated speed, some packets m=
ay be dropped by the device.

> +\begin{lstlisting}
> +struct virtio_net_stats_rx_speed {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 rx_packets_allowance_exceeded;
> +    le64 rx_bytes_allowance_exceeded;
> +};
> +\end{lstlisting}
> +
> +The packets described below were all presented on the specified virtqueu=
e.
> +\begin{description}
> +    \item [rx_packets_allowance_exceeded]
> +        The number of the packets dropped by device due to the real spee=
d
> +        exceeding the speed allowance.
> +
Similar rewording like above to drop "real".

> +    \item [rx_bytes_allowance_exceeded]
> +        The bytes of the packets dropped by device due to the real speed
> +        exceeding the speed allowance.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq Speed Statistic}\label{sec:Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic / Transmitq Speed Statistic}
> +
> +The structure corresponding to the transmitq speed statistics is
> +virtio_net_stats_tx_speed. The corresponding type is
> +VIRTIO_NET_STATS_TYPE_TX_SPEED. This is for the transmitq.
> +
> +The device has the allowance for the speed. If
> +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get this b=
y
> \field{speed}.
> +When the real speed exceeds the speed allowance, some packets will be
> +dropped by the device.
> +
> +\begin{lstlisting}
> +struct virtio_net_stats_tx_speed {
> +    struct virtio_net_stats_reply_hdr hdr;
> +
> +    le64 tx_packets_allowance_exceeded;
> +    le64 tx_bytes_allowance_exceeded;
> +};
> +\end{lstlisting}
> +
> +The packets described below were all presented on the specified virtqueu=
e.
> +\begin{description}
> +    \item [tx_packets_allowance_exceeded]
> +        The number of the packets dropped by device due to the real spee=
d
> +        exceeding the speed allowance.
> +
> +    \item [tx_bytes_allowance_exceeded]
> +        The bytes of the packets dropped by device due to the real speed
> +        exceeding the speed allowance.
> +
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Device Statistic}{Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic} The device MUST replies to the command
> +VIRTIO_NET_CTRL_STATS_QUERY with the struct virtio_net_stats_capabilitie=
s.
> \field{supported_stats_types} includes all the statistic types supported =
by the
> device.
> +
> +If virtio_net_ctrl_queue_stats is incorrect (such as the following),
> +the device MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is
> +only one error, the device MUST fail the entire command.
> +\begin{itemize}
> +    \item \field{vq_index} exceeds the queue range.
> +    \item \field{types_bitmap} contains unknown types.
> +    \item One or more of the bits present in \field{types_bitmap} is not=
 valid
> +        for the specified virtqueue.
> +    \item The feature corresponding to the specified \field{types_bitmap=
} was
> +        not negotiated.
> +    \item The size of the buffer allocated by the driver for \field{comm=
and-
> specific-result}
> +        is less than the total size of the statistics specialed by
> +        \field{virtio_net_ctrl_queue_stats}.
> +\end{itemize}
> +
> +The device MUST write the requested statistic structures in
s/statistic/statistics

> +\field{command-specific-result} in the order specified by the structure
> +virtio_net_ctrl_queue_stats. If the \field{types_bitmap} indicates
Use \field{..}

> +multiple statistics, the replies order by the type value from small to l=
arge.
> +
These replies are ordered by the type value from small to large.
I am not sure device needs to order them.

> +The device MUST set the actual size of the space occupied by the reply
> +to the \field{size} of the \field{hdr}. And the device MUST set the
> +\field{type} and the \field{vq_index} of the statistic header.
> +
> +\drivernormative{\subparagraph}{Device Statistic}{Device Types /
> +Network Device / Device Operation / Control Virtqueue / Device
> +Statistic}
> +
> +The types contained in the \field{types_bitmap} MUST be queried from
> +the device via command VIRTIO_NET_CTRL_STATS_QUERY.
> +
> +\field{types_bitmap} in struct virtio_net_ctrl_queue_stats MUST be
> +valid to the vq specified by \field{vq_index}.
> +
> +The \field{command-specific-result} buffer allocated by the driver MUST
> +be able to hold all the statistics specified by virtio_net_ctrl_queue_st=
ats.
> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> Types / Network Device / Legacy Interface: Framing Requirements}
>=20
> diff --git a/device-types/net/device-conformance.tex b/device-
> types/net/device-conformance.tex
> index f88f48b..8ce58fe 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion
> / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}  \item
> \ref{devicenormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Notifications Coalescing}  \item
> \ref{devicenormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Inner Header Hash}
> +\item \ref{devicenormative:Device Types / Network Device / Device
> +Operation / Control Virtqueue / Device Statistic}
>  \end{itemize}
> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/d=
river-
> conformance.tex
> index 9d853d9..b6636a2 100644
> --- a/device-types/net/driver-conformance.tex
> +++ b/device-types/net/driver-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion /
> Control Virtqueue / Receive-side scaling (RSS) }  \item
> \ref{drivernormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Notifications Coalescing}  \item \ref{drivernormative=
:Device
> Types / Network Device / Device Operation / Control Virtqueue / Inner Hea=
der
> Hash}
> +\item \ref{drivernormative:Device Types / Network Device / Device
> +Operation / Control Virtqueue / Device Statistic}
>  \end{itemize}
> --
> 2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

