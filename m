Return-Path: <virtio-dev-return-12931-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F99FC77B7A
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:14:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F190E2A87F
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:14:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDE31986580
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 20:14:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1904986418; Sun, 11 Jun 2023 20:14:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCEB098640B;
	Sun, 11 Jun 2023 20:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHJyHSZcy50AR0SYSyz9cv6iqgJX3yGcOPRzxzFommCxMSwXDaqzZj8ZKxXAXN8XQtBCNrrye1tek+GIPYuJ6mSPLxNT9AvbRRjb3YibYuGtZTevQniW9y7vAy7dTAy7cQJhY7msqxoL/8fCX5vJzWFEJKnd3gG7BRBzwBTtSVhcPHLNr3GN7ItAEsi+5Oxfh7WVKPot/btKdtstWmOUyB5PX+Rp0F1kmkPaKbUTXFJ0PpJQGfWmDHAH4rxg4HSWLpoHDw1kD64m4YFEdEcWEmQq3pWsIgF9Pq7SsidCjq+BlIqXG55KlYOV5wTW4UMLbKeZCAIAzFUSn3fDY77+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EiAayos7lLx64LbcXUP3sVMsCnK/J3wQ+s0SZ4SQ+4=;
 b=ctrzz4Xm8G+jjBPpiEyyZ7T9TCWXX2AUf5nFmEeS/5yvprIkJK0jLCckJO71OjVhsCDbOJMmVSuNPu080epUtOnO5RYEEa9vPctcPurvJE3uB4Yih8IgKYvF/5u2gTYwegGu8zn+Yj29OtO99Jro3UG8q7SqjQ+Lpde3x2TcmMuMUQmBQXCRs8SWaxAVLhTvGLdeu0yMaDn+u854UeVlMw7o8tMjNHWASpBzQ7OWXDmL4x/3UgnxBWmEB82ZPvB9ZPe6X0MldFt35tJ3fObyXMMAZn4r+txxG952PmwTJ+EN8z7btkJS5d2e1u/dpt7TpOaxWXm5rvnkCfgyKvyZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v16] virtio-net: support inner header hash
Thread-Index: AQHZm1GiLSiaNXRdo0+XI8bYPkts96+GB+lg
Date: Sun, 11 Jun 2023 20:13:58 +0000
Message-ID:
 <PH0PR12MB5481B4EFCD76E8189929D825DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230610041123.6204-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230610041123.6204-1-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5279:EE_
x-ms-office365-filtering-correlation-id: ff6457b2-e6f4-40cb-b5c8-08db6ab863a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 B5ow9fIUi0zSlkHs4ufvUmos2FnQ0QiiSPA/tUcAoiSLn6s8gt5x2EzI+4dvPrXx7uGepc10TDkqU8wk1WY6orAnlah86TBOT4KYQC158luEvdXQP7CBXKzd94tjTOzFzuQJZqq4ADklPZUvh3L9AQ25PdbFPyGnhpqS2aaE2m3Ujn3WI5w5apQlcIX32hGy2IDOHOys6kSk2HTWlgsDInnGXnPPMpznPJ51ELcxdnIZMEtjiX8cbRayjb7dDKe1lBOOSC4zBLrGMKHKC/ShJ6//E8FiMmeGN2lscR15UKstwgWMEWGdY9dDFLAZulm5EKTvQbqaqP53W8EeEAO+CCQVxlbwQ2XPc25k6jjj8bdIE3gufL4TYeYuCoe2UEWLUI9k46qkVkCJQyouF4o6XhLK9KBJLQJgwy//M8gRQ5B8RlBdrf/SO4Bzz0TkjnZdnLcMj/8roFBNlL4ZiR9Et+nP7OxCPq1Cb7EgVA88Jrkj78e/TC9LfF31Dow1PrnP8x7+V+jH/X/8Yw5Ayo7rWWbYAEMRly+MAXrOWTrErb6kGDdYAZv+NpxuaUYDEJE7AsYDC4cLQlQW3F491Pu5g1Abs3/JTkCk+mYH0rRKmp+x73qEdenrTmf93HRlZ3/nKcEcMZWk67shBrCISSCTiiQd3Mr3fubqpZFgllHQdovSFjdC0V8zwCSS44tgNYQA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(86362001)(7696005)(316002)(8676002)(41300700001)(38070700005)(83380400001)(5660300002)(26005)(55016003)(38100700002)(9686003)(122000001)(6506007)(52536014)(33656002)(71200400001)(8936002)(66446008)(66476007)(66556008)(64756008)(4326008)(66946007)(76116006)(66574015)(478600001)(186003)(30864003)(2906002)(54906003)(66899021)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6GJMOazftPlKcyKTzCvg9cjGMdo2pPcFPI18F1ofLR/5Ptbm7+MReBS6HIiu?=
 =?us-ascii?Q?lSFuAaK0Lk9190k90EnwzSEnd7xqlrD9tRIIv3OZ3ioKHNzIN51Fsa2e+OPx?=
 =?us-ascii?Q?s5JoPeA8uUmJ2uU7Qissjyf08cYglEQwEZE08BBgonsCH/uITTBrWh6vkEcG?=
 =?us-ascii?Q?8XZzV50X2l5yHYEPcPCczPkr293U5quSxM5movno9K5efDkPpyykyjf23udJ?=
 =?us-ascii?Q?fhZzz9mcLO2m1g5Nn3TrSlcRHMaybbPp0csf8MwbctjQ+Q6Vn8D3ErbEWvoP?=
 =?us-ascii?Q?OJj5J3fIMzUCM3reeHN0vGZAZ6ypQ/GGn81ac+y1VTSdnK9wo2iaznUJraFP?=
 =?us-ascii?Q?IC0zHxlh35TaXXu/QNHehqLaxOoUQHT+zpCFUiNjpU03jT4SIx26x3nnMNqE?=
 =?us-ascii?Q?/UtSw30dgyS5DZk4i4Ib8H+nIDD7d6DimiSQR6pBYdjg2BsjnxiAoMLKxjEd?=
 =?us-ascii?Q?Vozrm/gldowG8fxYC9GB0ndTPTg8M3cVNHA0l7TmG8oHyF6z4AMXEYTUaNBh?=
 =?us-ascii?Q?jJzURzzfjXpOoRJYVU6oEqVyzR9XgsupuQYp1OSmlUxmjo/myg6zs9DDZfvp?=
 =?us-ascii?Q?ivITbUB5zvWDr9jtkWdpkQh3Fu3hIc/wDipO9P622bTckICnmasWqQsaL/y1?=
 =?us-ascii?Q?HDlkSM2HDr9kFuZ4I2rbTjZBpmfmqZ+6gvPC3JYaMF9iIP/uuzef+k0Y1rGH?=
 =?us-ascii?Q?JP9iaC0+/se0fV1viNbLabyleQIIpNkymU5PHgT9HJ7Kg0umm6gYnFd6fzqH?=
 =?us-ascii?Q?xH9Tr7jgYX/+nyeDxYHrgykFw8HSOITQvsGh2smtjFLZxjD9XJu05XMrBRc1?=
 =?us-ascii?Q?Z7Oibg+n09X+HeFJxgg+ns+5uiBjK0TSFZf8E9BTLRf0Qf+wSWlhplh8RwC8?=
 =?us-ascii?Q?zXbK7DFZVqDoSDGMRYCPUsfKZEHpfLqxCsJnB4m71YOeveq4FR0BNsevqjLT?=
 =?us-ascii?Q?OmkImYtqd/QUQ2a4b91417yqzBljWa6wLwRUZ/ZYCzd0Ig4C0rJDM9oElScQ?=
 =?us-ascii?Q?KmzempzY8/OjN4sueLOc6YOzBRHmp2EmiCCd5ez4smufVwDDu/3L6XOWWy7R?=
 =?us-ascii?Q?Ih15kWEENdJ5wM6dOhL1LlNkylf9zT5ZkzUatUrc6G3BVMv33QwznZXaaG7U?=
 =?us-ascii?Q?IsjIiqqF5r0rWPDSl5MApo60t23uN2AgXWX7+zP/tEfY81YaY+m6vFd0dNog?=
 =?us-ascii?Q?SLg9uBhFc+76WcCJUQB4uCMSjNaGUnRpwhZLH7BCfxQgD4G6SroF8qKXWQI3?=
 =?us-ascii?Q?cNwCBWyiGWudPN/SfikUOMZE6zvPSGeLqyi/Oenu0MfP/y8bV2t3EW11bGrz?=
 =?us-ascii?Q?r+srHx+8VCkOmtGCl/QSDYiK/sU/BaHakMO7PbMbbHIgf+Nqeijy2yy14F5J?=
 =?us-ascii?Q?a/mRhMSEyAkyW8oNTwgsZFxGO/yM2wfxHLRXaQPu0xJbLwbs8DJyX894hI0O?=
 =?us-ascii?Q?VEAKD5QlUJCL63ThwD7cvviPzQCGJRD3PCn7poD9y/j8RWKB8FTgrY1va7En?=
 =?us-ascii?Q?20o9VjjcUG2cvVMZLO5Hs8kHNmVKjU2JeLDVE/gydZ8qkO4iMDJRvU8fF1Kf?=
 =?us-ascii?Q?dHKv3jML9J6SNVvdhSk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6457b2-e6f4-40cb-b5c8-08db6ab863a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 20:13:58.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2pmnylm418JXzXx+Q1exS0bmeVz6FwSMbKBYCl8MalQkfqbasXR8kJBQVZ20trcZkQ/vM+5uT5VvZ8xJQvX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
Subject: [virtio-dev] RE: [PATCH v16] virtio-net: support inner header hash


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Saturday, June 10, 2023 12:11 AM

> +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{hash_tunnel_types}
> for the device using the virtnet_hash_tunnel_config_set structure, which =
is
> read-only for the driver.
Driver issues set command so its read + write for driver.
Read-only for the device.

> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{hash_tunnel_types}
> and \field{supported_hash_tunnel_types} from the device using the
> virtnet_hash_tunnel_config_get
> +      structure, which is write-only for the driver.
Device writes it, so=20
s/write-only for the driver/read-only for the driver

> +\end{itemize}
> +
> +\subparagraph{Tunnel/Encapsulated packet} \label{sec:Device Types /
> +Network Device / Device Operation / Processing of Incoming Packets /
> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> +
> +A tunnel packet is encapsulated from the original packet based on the
> +tunneling protocol (only a single level of encapsulation is currently
> +supported). The encapsulated packet contains an outer header and an inne=
r
> header, and the device calculates the hash over either the inner header o=
r the
> outer header.
> +
> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated
> +packet's outer header matches one of the configured
> \field{hash_tunnel_types}, the hash of the inner header is calculated.
> +
> +Supported encapsulated packet types:
> +\begin{itemize}
> +\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is o=
ver
> IPv4 and the inner header is over IPv4. The outer header does not contain=
 the
> transport protocol.
> +\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is o=
ver
> IPv4 and the inner header is over IPv4. The outer header does not contain=
 the
> transport protocol.
> +\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is o=
ver
> IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header does n=
ot
> contain the transport protocol.
> +\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer heade=
r is
> over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header u=
ses
> UDP as the transport protocol.
> +\item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv=
6 and
> the inner header is over IPv4/IPv6. The outer header uses UDP as the tran=
sport
> protocol.
> +\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over
> IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses U=
DP as
> the transport protocol.
> +\item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/I=
Pv6
> and the inner header is over IPv4/IPv6. The outer header uses UDP as the
> transport protocol.
> +\item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and t=
he inner
> header is over IPv4. The outer header does not contain the transport prot=
ocol.
> +\item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv=
6 and
> the inner header is over IPv4/IPv6. The outer header does not contain the
> transport protocol.
> +\end{itemize}
> +
It does not matter much, but it may be good to arrange above list where all=
 entries that does not have transport header first.
And than protocols with transport header together (vxlan-gpe, genve, nvgre)=
.

> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is
> +not included in the configured \field{hash_tunnel_types}, the hash of th=
e outer
> header is calculated for the received encapsulated packet.
> +
> +The hash is calculated for the received non-encapsulated packet as if
> VIRTIO_NET_F_HASH_TUNNEL was not negotiated.
> +
> +\subparagraph{Supported/enabled encapsulation hash types}
> +\label{sec:Device Types / Network Device / Device Operation /
> +Processing of Incoming Packets / Hash calculation for incoming packets
> +/ Supported/enabled encapsulation hash types}
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
> +\end{lstlisting}
> +
> +Supported encapsulation hash types:
> +Hash type applicable for inner payload of the
> \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 1)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the
> \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 2)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the
> \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 3)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the
> \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 4)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the \hyperref[intro:vxlan]{[VX=
LAN]}
> packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 5)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the
> \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 6)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the
> \hyperref[intro:geneve]{[GENEVE]} packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 7)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the \hyperref[intro:ipip]{[IPI=
P]}
> packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 8)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the \hyperref[intro:nvgre]{[NV=
GRE]}
> packet:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 9)
> +\end{lstlisting}
> +
> +\subparagraph{Advice}
> +Usage scenarios of inner header hash (but not limited to):
> +\begin{itemize}
> +\item Legacy tunneling protocols that lack entropy in the outer header u=
se
> inner header hash to hash flows
> +      with the same outer header but different inner headers to differen=
t queues
> for better-receiving performance.
> +\item In scenarios where the same flow passing through different tunnels=
 is
> expected to be received in the same queue,

> +      warm caches, lessing locking, etc. are optimized to obtain receivi=
ng
> performance.
> +\end{itemize}
> +
Small rewrite as,
to utilize warm caches, to have less locking etc.

> +For scenarios with sufficient outer entropy or no inner header hash
> requirements, inner header hash may not be needed:
> +A tunnel is often expected to isolate the external network from the
> +internal one. By completely ignoring entropy in the outer header and
> +replacing it with entropy from the inner header, for hash calculations,
> +this expectation might be violated to a certain extent, depending on how=
 the
> hash is used. When the hash use is limited to RSS queue selection, inner =
header
> hash may have quality of service (QoS) limitations.
> +
> +Possible mitigations:
> +\begin{itemize}
> +\item Use a tool with good forwarding performance to keep the receive qu=
eue
> from filling up.
Generally filling up is fine as long as its emptied also.
So a rewrite as,

s/from filling up/from dropping packet/

> +\item If the QoS is unavailable, the driver can set \field{hash_tunnel_t=
ypes} to
> VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> +      to disable inner header hash for encapsulated packets.
> +\item Perform appropriate QoS before packets consume the receive buffers=
 of
> the receive queues.
> +\end{itemize}
> +
> +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types /
> +Network Device / Device Operation / Control Virtqueue / Inner Header
> +Hash}
> +
> +The device MUST calculate the hash on the outer header if the type of
> +the received encapsulated packet does not match any value of the configu=
red
> \field{hash_tunnel_types}.
> +
> +The device MUST respond to the VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> command
> +with VIRTIO_NET_ERR if the device receives an unsupported or unrecognize=
d
> VIRTIO_NET_HASH_TUNNEL_TYPE_ flag.
> +
> +The device MUST provide the values of \field{supported_hash_tunnel_types=
} if
> it offers the VIRTIO_NET_F_HASH_TUNNEL feature.
> +
> +Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
> +
> +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types /
> +Network Device / Device Operation / Control Virtqueue / Inner Header
> +Hash}
> +
> +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature
> when issuing commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
> VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
> +
> +The driver MUST ignore the values received from the
> VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with
> VIRTIO_NET_ERR.
> +
> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags which
> are not supported by the device.
> +
>  \paragraph{Hash reporting for incoming packets}  \label{sec:Device Types=
 /
> Network Device / Device Operation / Processing of Incoming Packets / Hash
> reporting for incoming packets}
>=20
> diff --git a/device-types/net/device-conformance.tex b/device-
> types/net/device-conformance.tex
> index 54f6783..f88f48b 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -14,4 +14,5 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion
> / Control Virtqueue / Automatic receive steering in multiqueue mode}  \it=
em
> \ref{devicenormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Receive-side scaling (RSS) / RSS processing}  \item
> \ref{devicenormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Notifications Coalescing}
> +\item \ref{devicenormative:Device Types / Network Device / Device
> +Operation / Control Virtqueue / Inner Header Hash}
>  \end{itemize}
> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/d=
river-
> conformance.tex
> index 97d0cc1..9d853d9 100644
> --- a/device-types/net/driver-conformance.tex
> +++ b/device-types/net/driver-conformance.tex
> @@ -14,4 +14,5 @@
>  \item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion
> / Control Virtqueue / Offloads State Configuration / Setting Offloads Sta=
te}
> \item \ref{drivernormative:Device Types / Network Device / Device Operati=
on /
> Control Virtqueue / Receive-side scaling (RSS) }  \item
> \ref{drivernormative:Device Types / Network Device / Device Operation /
> Control Virtqueue / Notifications Coalescing}
> +\item \ref{drivernormative:Device Types / Network Device / Device
> +Operation / Control Virtqueue / Inner Header Hash}
>  \end{itemize}
> diff --git a/introduction.tex b/introduction.tex index b7155bf..3f34950 1=
00644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -102,6 +102,46 @@ \section{Normative References}\label{sec:Normative
> References}
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic C=
ureve
> Cryptography'', Version 1.0, September 2000.
>  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>=20
> +	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> +    Generic Routing Encapsulation. This protocol is only specified for I=
Pv4 and
> used as either the payload or delivery protocol.
> +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> +	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. T=
his
> protocol describes extensions by which two fields, Key and
> +    Sequence Number, can be optionally carried in the GRE Header
> \ref{intro:gre_rfc2784}.
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> +	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> +    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol =
is
> specified for IPv6 and used as either the payload or
> +    delivery protocol. Note that this does not change the GRE header for=
mat or
> any behaviors specified by RFC 2784 or RFC 2890.
> +	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> +	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]}
> &
> +    GRE-in-UDP Encapsulation. This specifies a method of encapsulating
> network protocol packets within GRE and UDP headers.
> +    This GRE-in-UDP encapsulation allows the UDP source port field to be=
 used
> as an entropy field. This protocol is specified for IPv4 and IPv6,
> +    and used as either the payload or delivery protocol.
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
> +	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
> +    Virtual eXtensible Local Area Network.
> +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> +	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> +    Generic Protocol Extension for VXLAN. This protocol describes extend=
ing
> Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN
> header.
> +	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-
> 12.txt}\\
> +	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
> +    Generic Network Virtualization Encapsulation.
> +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> +	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
> +    IP Encapsulation within IP.
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> +	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
> +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> +	\phantomsection\label{intro:IP}\textbf{[IP]} &
> +    INTERNET PROTOCOL
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> +    User Datagram Protocol
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> +    TRANSMISSION CONTROL PROTOCOL
> +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  \end{longtable}
>=20
>  \section{Non-Normative References}
> --
> 2.19.1.6.gb485710b

With above small fixes,=20
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

