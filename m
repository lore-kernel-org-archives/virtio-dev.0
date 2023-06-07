Return-Path: <virtio-dev-return-12883-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1262C7EE23
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 19:55:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0177029FE1
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 19:55:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E476698667C
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 19:55:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D88A8986663; Wed,  7 Jun 2023 19:55:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C443D986662;
	Wed,  7 Jun 2023 19:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v15] virtio-net: support inner header hash
Thread-Index: AQHZl32d41AbT091pUmTjH3klOy5k69/wSJg
Date: Wed, 7 Jun 2023 19:55:19 +0000
Message-ID:
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230605071608.73016-1-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|LV2PR12MB5848:EE_
x-ms-office365-filtering-correlation-id: 02e0cbc1-c250-4b0a-37d2-08db67911f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1GHpquIXO5goXbByGQkVcL9YqLzO3mbr8fELwGlfzUr9DwrWRaX8+jEZ32TjWTHu4uaJ3DdBYP2qkOOr+uAEsL3ZVK8c1MHr0Rb6dAWZKIfVu4lAUgUkRKDXokfxC+iTMYHyw+nkTKFKAURnbk0xdLNXG9XJYZNhWyOLgm5GEr7sCe+KFNnEpF4+7GywrE5W+V0BdoMW6LDVt+Z/unCFRY+KpDLwy7CL5Phsya+byRuBigffwQWv2xoN+fdjd94OpPwFHDPgp9OZ+4CsGJUjQqMIs3bf7xYeqHRcY3pKarorJVksQnFihhu+nnNj5C0o/TURhzW0NuiojZQUvDO06Kq+GckAwlRonZGQEQCWLQC2pyS/Mbn3pN0E9u/mXfuF9yHpGUlENRhz7FsZCNb943v03F4oK+7fBtklpWpdBh+03cyFZWKi725otEfjE10sFVfRo4V5HKPhTuEhMSArp16u71yJT5ZWslIFOvR1qmj1lzHNQzRzjM6cwEhS7V7UcmfuJsFKPchgAuIz852P4DInWGe9zqd4uo1tdOx7/tRqglKDYoXJTkVySDz6t0VhXQt3ZutEFkuAc9CSpfczx1Z1ybhSBrn8ego5ZKwTVihdrMtQ9StfjDifpln2Irv1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(52536014)(8936002)(110136005)(316002)(66446008)(54906003)(41300700001)(33656002)(7696005)(71200400001)(86362001)(5660300002)(4326008)(9686003)(186003)(66556008)(66476007)(64756008)(66946007)(76116006)(6506007)(2906002)(30864003)(38070700005)(38100700002)(83380400001)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ZpoKsZohNjEz3Jw9Cznw5OKyM8cbunk1CQ656XfrEzkdGtEJYCHc4ZYvmrE?=
 =?us-ascii?Q?M/urpQRLjyfAJemfLuY26CoBdAB8bjJvcl43TBMEyM0cLEHJi6CqarI3pPpT?=
 =?us-ascii?Q?ww7cX0vlGfY3wQXSdGLrLBfqw81XaJF/mB4iNpF8uCwjJpWuDwgPxDaqcWUx?=
 =?us-ascii?Q?b6QPfrHkGbtmAzvtj4/nxNernFjJv/yMu1QycEn6yDUNhRnxiYhABiCY3z+8?=
 =?us-ascii?Q?R7cW/tJxMNDIXNiLhYFYCmOxqb/Im74ugq5yNjP+542mipBEZsT7Fsu8zUkI?=
 =?us-ascii?Q?QvxR8Jun1stzYa10pddETRS0P+YDIhUH+Rk+XoI2OnrH1TByoOW1FnwXoHE2?=
 =?us-ascii?Q?U5rIBqpoMKviB2AIzQwuDgNu7VfPUv8mytNCCVu55oHBmzgR8MVMxoqdYayf?=
 =?us-ascii?Q?Yg5XgfrRkFXybjdgzPygVwL6jZzBdezFcs1XckKISp9+HO1jK9vIOjZotfJN?=
 =?us-ascii?Q?XaKY6j2COdIzj/Aun9I9cOR/ZJ8SV0QTk4b5UFHuaDKuNjVnxQ1AxdK8QXU8?=
 =?us-ascii?Q?yMTCwmK5lyFDSzbIC5urIwX+u4Ygz2LNQMIY5EclNje6qujiIXQJOHuw/vcr?=
 =?us-ascii?Q?JAowiWFGUM89wG0at7edlEvJUA0j7xL6P92xPzQzzzYV+5LeHC65rOpJ7t6s?=
 =?us-ascii?Q?i+BH3LUTefwuGDWSch5ARCEDwAu6K3+eJplmCkdG/Pn+3lFX2voPAAVqhdlN?=
 =?us-ascii?Q?oo0Dbd4hgUw1lLnFfk3DYoSdI+BKE12al6mM7rXXZtG5LACDouuLGIwOL9CK?=
 =?us-ascii?Q?JwEUPXit0gDS8ZrDtwrrTjPw7x7W5MKccP6kjophEkNYlOZ5Hr7uJszit4iw?=
 =?us-ascii?Q?C++zfPtAoN8PBQh8bTVoLu9mz5WB3PHA3Dv+f4z0t5w8njTWYzwan9L2iuzA?=
 =?us-ascii?Q?01jrKmAPyxNoEHw7OeBb23Sc+fRKaz7CppOUECkCDFR4cXAVvmXCtBmYIPea?=
 =?us-ascii?Q?j8HsVZjJwNIMhTB6uVCn/zsxgGk5kSlbRqCCpoT+hSElf39t9rE3s6KxAuT2?=
 =?us-ascii?Q?XS+apzlS+c82yrRB51++KHWVhTtZOewG7M7OAgx+PorfVjrjF7JX8RatqA3l?=
 =?us-ascii?Q?gWfYvlCQ79+SMC7Hy8lRYgyPdIUrD3E/Qigwt0Um7r2jlt3JoEIDxXjc3wRg?=
 =?us-ascii?Q?0fI6A+KJPeiY0MitxwvBeJLjk0+LWGpTvNCKMqAIdHzJXhUtVv8+9GITNYPn?=
 =?us-ascii?Q?2LXBm6J1yOt6a5RJYri2cO0Ez47Qeto9qkQD3/aTZEYKjStDVJQH2khQKPc+?=
 =?us-ascii?Q?DB6+utl81Ju1HB9zT32AJB6VI9zreRLMPYx+J+HJBjdjPDkUDvkTr83jTE2z?=
 =?us-ascii?Q?KtaiYzTwzNnJO1wVQ80E2jU5PXwpCifB6MMhS5KbEG6VmykEnVnzno3it63I?=
 =?us-ascii?Q?xlhLdBBdR8euBGPIO+HnIHHTqFXnmnGiFL92/OOqQVpk20V9ki4lvO3RBJlN?=
 =?us-ascii?Q?SXe/tTQx65kUwCkWwnE5huDAbwb5xm1zy6+0II3fPpkQExtQ0jB+BdrUHXWc?=
 =?us-ascii?Q?ZF/7k4Mm47p4pdhUlgaMvG+994A3Cahe3K8jxxPSFzAstH/j2VvH5azFDmr5?=
 =?us-ascii?Q?c/eVMMCQq7sMMiEbRRIDtGoOhlzWrbPkYXN+4dx6AIOunDj1/r8eBCBpI9a+?=
 =?us-ascii?Q?gWjEPmt47jlyIXzdTXWuds8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0cbc1-c250-4b0a-37d2-08db67911f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 19:55:19.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOunMyWyQ43SIt8IpJ6EsUSx0IES2lobHzt1vBmp3Ci2lBSH/Lf5BOYzix0XUPeKlNcZqoOc0xEGyv1nof7zhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
Subject: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header hash



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Monday, June 5, 2023 3:16 AM
>=20
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /
> Network Device / Feature bits / Legacy Interface: Feature bits} @@ -869,6
> +872,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device
> Types / Network  If the feature VIRTIO_NET_F_RSS was negotiated:
>  \begin{itemize}
>  \item The device uses \field{hash_types} of the virtio_net_rss_config st=
ructure
> as 'Enabled hash types' bitmask.
> +\item The device uses \field{hash_tunnel_types} of the
> virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash t=
ypes'
> bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
>  \item The device uses a key as defined in \field{hash_key_data} and
> \field{hash_key_length} of the virtio_net_rss_config structure (see
> \ref{sec:Device Types / Network Device / Device Operation / Control Virtq=
ueue
> / Receive-side scaling (RSS) / Setting RSS parameters}).
>  \end{itemize}
> @@ -891,6 +895,7 @@ \subsubsection{Processing of Incoming
> Packets}\label{sec:Device Types / Network
>=20
>  \subparagraph{Supported/enabled hash types}  \label{sec:Device Types /
> Network Device / Device Operation / Processing of Incoming Packets / Hash
> calculation for incoming packets / Supported/enabled hash types}
> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
> \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>  Hash types applicable for IPv4 packets:
>  \begin{lstlisting}
>  #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> @@ -1001,6 +1006,185 @@ \subsubsection{Processing of Incoming
> Packets}\label{sec:Device Types / Network  (see \ref{sec:Device Types /
> Network Device / Device Operation / Processing of Incoming Packets / Hash
> calculation for incoming packets / IPv6 packets without extension header}=
).
>  \end{itemize}
>=20
> +\paragraph{Inner Header Hash}
> +\label{sec:Device Types / Network Device / Device Operation /
> +Processing of Incoming Packets / Inner Header Hash}
> +
> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send
> +commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
> VIRTIO_NET_CTRL_HASH_TUNNEL_GET for the inner header hash
> configuration.
> +
> +struct virtnet_hash_tunnel_config_set {
> +    le32 hash_tunnel_types;
> +    u8 hash_option;
> +    u8 reserved[3];
> +};
> +struct virtnet_hash_tunnel_config_get {
> +    le32 supported_hash_tunnel_types;
> +    le32 hash_tunnel_types;
> +    u8 hash_option;
> +    u8 reserved[3];
> +};
> +
> +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0  #define
> +VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> +
> +Filed \field{supported_hash_tunnel_types} provided by the device indicat=
es
s/Filed/Field

> that the device is capable of supporting inner header hash for these
s/the device is capable of supporting/the device supports/

> encapsulation types.
> +\field{supported_hash_tunnel_types} contains the bitmask of supported
> +tunnel hash types. See \ref{sec:Device Types / Network Device / Device
> Operation / Processing of Incoming Packets / Hash calculation for incomin=
g
> packets / Supported/enabled encapsulation hash types}.
> +
> +Filed \field{hash_tunnel_types} contains the bitmask of configured tunne=
l hash
s/Filed/Field

> types.
> +See \ref{sec:Device Types / Network Device / Device Operation / Processi=
ng of
> Incoming Packets / Hash calculation for incoming packets / Supported/enab=
led
> encapsulation hash types}.
> +
> +Field \field{hash_option} is one byte containing 0 (off) or 1 (on).
> +\begin{itemize}
> +\item \field{hash_option} =3D 0: instruct the device to calculate the in=
ner header
> hash for the configured \field{hash_tunnel_types}.
> +\item \field{hash_option} =3D 1: instruct the device to calculate the ha=
sh on the
> source UDP port for all encapsulated and non-encapsulated UDP packets.
Why non-encapsulated UDP packets also?
Shouldn't we use the regular RSS hashing for non-encapsulated UDP packets w=
hich uses all 4 fields of ip and port?

> +\end{itemize}
> +
> +For most UDP-encapsulated packets, the outer source UDP port may
> +identify a specific flow, such as
> +\hyperref[intro:vxlan_gpe]{[VXLAN-GPE]},
> +\hyperref[intro:geneve]{[GENEVE]} and
> \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}.
> +Therefore, the hash calculated on the outer source UDP port can allow th=
e
> same flow passing through different tunnels to be directed to the same re=
ceive
> queue.
> +
> +Field \field{reserved} is reserved and is ignored by the device.
> +
> +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set the tunnel hash
> configuration for the device using the virtnet_hash_tunnel_config_set str=
ucture,
> which is read-only for the driver.
> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get the tunnel hash
> configuration from the device using the virtnet_hash_tunnel_config_get
> structure, which is write-only for the driver.
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
> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and \field{hash_option} is set=
 to
> 1 by the driver:
> +\begin{itemize}
> +\item the hash on the source UDP port is calculated for a received UDP p=
acket.

Need to mention here that the source UDP port is of outer or inner header.

> +\item the inner header hash is calculated for the configured
> \field{hash_tunnel_types} without the outer UDP header.
> +\end{itemize}
> +
> +If \field{hash_option} is 0, tunnel hashing behaves as follows:
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
> +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is
> +not included in the configured \field{hash_tunnel_types}, the hash of th=
e outer
> header is calculated for the received encapsulated packet.
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
> +The device MUST calculate the hash on the source UDP port for all UDP
> packets if \field{hash_option} is 1.
> +
> +The device MUST calculate the inner header hash for the configured
> \field{hash_tunnel_types} without the outer UDP header if \field{hash_opt=
ion} is
> 1.
> +
This I think conflicts with the current RSS where if this override (higher =
priority than RSS) or not.
I do not understand the motivation for hash_option =3D 1 for non-encapsulat=
ed packet.
Also it is probably rename from hash_option to hash_src_udp_port.

> +The device MUST calculate the hash on the outer header if
> +\field{hash_option} is 0 and the type of the received encapsulated packe=
t does
> not match any value of \field{hash_tunnel_types}.
> +

[..]
> +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags not
> supported by the device.
> +
s/flags not supported/flags which are not supported/

> +The driver MUST NOT set \field{hash_option} to any value not supported b=
y
> the device.
> +
>  \paragraph{Hash reporting for incoming packets}  \label{sec:Device Types=
 /
> Network Device / Device Operation / Processing of Incoming Packets / Hash
> reporting for incoming packets}

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

