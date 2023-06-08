Return-Path: <virtio-dev-return-12884-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C44C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 06:40:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 11E3023D60
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 06:40:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06C96986673
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 06:40:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE071986259; Thu,  8 Jun 2023 06:40:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2EE7986667;
	Thu,  8 Jun 2023 06:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkdAg07_1686206442;
Date: Thu, 8 Jun 2023 14:40:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230608064042.GC28580@h68b04307.sqa.eu95>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash

On Wed, Jun 07, 2023 at 07:55:19PM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Monday, June 5, 2023 3:16 AM
> > 
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /
> > Network Device / Feature bits / Legacy Interface: Feature bits} @@ -869,6
> > +872,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device
> > Types / Network  If the feature VIRTIO_NET_F_RSS was negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_rss_config structure
> > as 'Enabled hash types' bitmask.
> > +\item The device uses \field{hash_tunnel_types} of the
> > virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash types'
> > bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
> >  \item The device uses a key as defined in \field{hash_key_data} and
> > \field{hash_key_length} of the virtio_net_rss_config structure (see
> > \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue
> > / Receive-side scaling (RSS) / Setting RSS parameters}).
> >  \end{itemize}
> > @@ -891,6 +895,7 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network
> > 
> >  \subparagraph{Supported/enabled hash types}  \label{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > calculation for incoming packets / Supported/enabled hash types}
> > +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
> > \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> >  Hash types applicable for IPv4 packets:
> >  \begin{lstlisting}
> >  #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > @@ -1001,6 +1006,185 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network  (see \ref{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > calculation for incoming packets / IPv6 packets without extension header}).
> >  \end{itemize}
> > 
> > +\paragraph{Inner Header Hash}
> > +\label{sec:Device Types / Network Device / Device Operation /
> > +Processing of Incoming Packets / Inner Header Hash}
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send
> > +commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
> > VIRTIO_NET_CTRL_HASH_TUNNEL_GET for the inner header hash
> > configuration.
> > +
> > +struct virtnet_hash_tunnel_config_set {
> > +    le32 hash_tunnel_types;
> > +    u8 hash_option;
> > +    u8 reserved[3];
> > +};
> > +struct virtnet_hash_tunnel_config_get {
> > +    le32 supported_hash_tunnel_types;
> > +    le32 hash_tunnel_types;
> > +    u8 hash_option;
> > +    u8 reserved[3];
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0  #define
> > +VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> > +
> > +Filed \field{supported_hash_tunnel_types} provided by the device indicates
> s/Filed/Field

Will fix.

> 
> > that the device is capable of supporting inner header hash for these
> s/the device is capable of supporting/the device supports/
> 

Will modify.

> > encapsulation types.
> > +\field{supported_hash_tunnel_types} contains the bitmask of supported
> > +tunnel hash types. See \ref{sec:Device Types / Network Device / Device
> > Operation / Processing of Incoming Packets / Hash calculation for incoming
> > packets / Supported/enabled encapsulation hash types}.
> > +
> > +Filed \field{hash_tunnel_types} contains the bitmask of configured tunnel hash
> s/Filed/Field
> 
> > types.
> > +See \ref{sec:Device Types / Network Device / Device Operation / Processing of
> > Incoming Packets / Hash calculation for incoming packets / Supported/enabled
> > encapsulation hash types}.
> > +
> > +Field \field{hash_option} is one byte containing 0 (off) or 1 (on).
> > +\begin{itemize}
> > +\item \field{hash_option} = 0: instruct the device to calculate the inner header
> > hash for the configured \field{hash_tunnel_types}.
> > +\item \field{hash_option} = 1: instruct the device to calculate the hash on the
> > source UDP port for all encapsulated and non-encapsulated UDP packets.
> Why non-encapsulated UDP packets also?
> Shouldn't we use the regular RSS hashing for non-encapsulated UDP packets which uses all 4 fields of ip and port?

I think this simplifies the work of the device parsing the packet, that
is, if \field{hash_option} is set to 1, then the device only needs to
parse to the outer transport header, without knowing what tunneling
protocol the special dst port corresponds to or further checking the
tunneling protocol information.

But this is really a bit rough for non-encapsulated packets, we can only
support this operation for encapsulated packets.

> 
> > +\end{itemize}
> > +
> > +For most UDP-encapsulated packets, the outer source UDP port may
> > +identify a specific flow, such as
> > +\hyperref[intro:vxlan_gpe]{[VXLAN-GPE]},
> > +\hyperref[intro:geneve]{[GENEVE]} and
> > \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}.
> > +Therefore, the hash calculated on the outer source UDP port can allow the
> > same flow passing through different tunnels to be directed to the same receive
> > queue.
> > +
> > +Field \field{reserved} is reserved and is ignored by the device.
> > +
> > +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> > +\begin{itemize}
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set the tunnel hash
> > configuration for the device using the virtnet_hash_tunnel_config_set structure,
> > which is read-only for the driver.
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get the tunnel hash
> > configuration from the device using the virtnet_hash_tunnel_config_get
> > structure, which is write-only for the driver.
> > +\end{itemize}
> > +
> > +\subparagraph{Tunnel/Encapsulated packet} \label{sec:Device Types /
> > +Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> > +
> > +A tunnel packet is encapsulated from the original packet based on the
> > +tunneling protocol (only a single level of encapsulation is currently
> > +supported). The encapsulated packet contains an outer header and an inner
> > header, and the device calculates the hash over either the inner header or the
> > outer header.
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and \field{hash_option} is set to
> > 1 by the driver:
> > +\begin{itemize}
> > +\item the hash on the source UDP port is calculated for a received UDP packet.
> 
> Need to mention here that the source UDP port is of outer or inner header.

Yes, if we only support encapsulated packets for \field{hash_option} or
\field{hash_src_udp_port}, that should be the source UDP port number.

> 
> > +\item the inner header hash is calculated for the configured
> > \field{hash_tunnel_types} without the outer UDP header.
> > +\end{itemize}
> > +
> > +If \field{hash_option} is 0, tunnel hashing behaves as follows:
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated
> > +packet's outer header matches one of the configured
> > \field{hash_tunnel_types}, the hash of the inner header is calculated.
> > +
> > +Supported encapsulated packet types:
> > +\begin{itemize}
> > +\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is over
> > IPv4 and the inner header is over IPv4. The outer header does not contain the
> > transport protocol.
> > +\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is over
> > IPv4 and the inner header is over IPv4. The outer header does not contain the
> > transport protocol.
> > +\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is over
> > IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header does not
> > contain the transport protocol.
> > +\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer header is
> > over IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses
> > UDP as the transport protocol.
> > +\item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv6 and
> > the inner header is over IPv4/IPv6. The outer header uses UDP as the transport
> > protocol.
> > +\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over
> > IPv4/IPv6 and the inner header is over IPv4/IPv6. The outer header uses UDP as
> > the transport protocol.
> > +\item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/IPv6
> > and the inner header is over IPv4/IPv6. The outer header uses UDP as the
> > transport protocol.
> > +\item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and the inner
> > header is over IPv4. The outer header does not contain the transport protocol.
> > +\item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv6 and
> > the inner header is over IPv4/IPv6. The outer header does not contain the
> > transport protocol.
> > +\end{itemize}
> > +
> > +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is
> > +not included in the configured \field{hash_tunnel_types}, the hash of the outer
> > header is calculated for the received encapsulated packet.
> > +
> > +\subparagraph{Advice}
> > +Usage scenarios of inner header hash (but not limited to):
> > +\begin{itemize}
> > +\item Legacy tunneling protocols that lack entropy in the outer header use
> > inner header hash to hash flows
> > +      with the same outer header but different inner headers to different queues
> > for better-receiving performance.
> > +\item In scenarios where the same flow passing through different tunnels is
> > expected to be received in the same queue,
> > +      warm caches, lessing locking, etc. are optimized to obtain receiving
> > performance.
> > +\end{itemize}
> > +
> > +For scenarios with sufficient outer entropy or no inner header hash
> > requirements, inner header hash may not be needed:
> > +A tunnel is often expected to isolate the external network from the
> > +internal one. By completely ignoring entropy in the outer header and
> > +replacing it with entropy from the inner header, for hash calculations,
> > +this expectation might be violated to a certain extent, depending on how the
> > hash is used. When the hash use is limited to RSS queue selection, inner header
> > hash may have quality of service (QoS) limitations.
> > +
> > +Possible mitigations:
> > +\begin{itemize}
> > +\item Use a tool with good forwarding performance to keep the receive queue
> > from filling up.
> > +\item If the QoS is unavailable, the driver can set \field{hash_tunnel_types} to
> > VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> > +      to disable inner header hash for encapsulated packets.
> > +\item Perform appropriate QoS before packets consume the receive buffers of
> > the receive queues.
> > +\end{itemize}
> > +
> > +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types /
> > +Network Device / Device Operation / Control Virtqueue / Inner Header
> > +Hash}
> > +
> > +The device MUST calculate the hash on the source UDP port for all UDP
> > packets if \field{hash_option} is 1.
> > +
> > +The device MUST calculate the inner header hash for the configured
> > \field{hash_tunnel_types} without the outer UDP header if \field{hash_option} is
> > 1.
> > +
> This I think conflicts with the current RSS where if this override (higher priority than RSS) or not.

VIRTIO_NET_F_HASH_TUNNEL instructs the device to calculate an
inner header hash for configured tunnel types.
Then, which fields are used for the calculation of the inner header
hash is determined by the RSS configuration.

Therefore, if the inner header hash uses \field{hash_option} to indicate that
the outer source UDP port is used to calculate the hash, it overrides the RSS
configuration (higher priority than RSS). It now not only indicates for which
tunnel types the inner hash should be calculated, but also indicates which
fields participate in the RSS hash calculation.

At this point, we can
1. continue to allow this behavior. That is, if \field{hash_option} is
set to 1, the hash value calculated based on the outer source port
indicated by VIRTIO_NET_F_HASH_TUNNEL is provided to the indirection
table to select the rxq instead of the hash value provided by RSS.

2. hand over to RSS the ability to specify a hash based on the outer source port.
That is, we can add VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_{v4, v6, EX} in
\field{supported_hash_types} to indicate that the hash should be calculated
using the outer source port for all UDP tunneling protocols.
This approach removes the need for \field{hash_option} and makes the line between
VIRTIO_NET_F_HASH_TUNNEL and VIRTIO_NET_F_RSS clearer.

> I do not understand the motivation for hash_option = 1 for non-encapsulated packet.
> Also it is probably rename from hash_option to hash_src_udp_port.

Ok. Will rename.

Thanks!

> 
> > +The device MUST calculate the hash on the outer header if
> > +\field{hash_option} is 0 and the type of the received encapsulated packet does
> > not match any value of \field{hash_tunnel_types}.
> > +
> 
> [..]
> > +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags not
> > supported by the device.
> > +
> s/flags not supported/flags which are not supported/
> 
> > +The driver MUST NOT set \field{hash_option} to any value not supported by
> > the device.
> > +
> >  \paragraph{Hash reporting for incoming packets}  \label{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > reporting for incoming packets}
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

