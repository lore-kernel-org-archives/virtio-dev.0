Return-Path: <virtio-dev-return-12998-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E9DEB64D8
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 13:48:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C91823D41
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 13:48:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8297B98650F
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 13:48:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7563B98641D; Tue, 20 Jun 2023 13:48:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FDDB9863E1;
	Tue, 20 Jun 2023 13:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vlc9WBO_1687268914;
Date: Tue, 20 Jun 2023 21:48:33 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230620134833.GG74977@h68b04307.sqa.eu95>
References: <20230612080920.116385-1-hengqi@linux.alibaba.com>
 <20230620070103-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620070103-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v17] virtio-net:
 support inner header hash

On Tue, Jun 20, 2023 at 08:06:16AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 12, 2023 at 04:09:20PM +0800, Heng Qi wrote:
> > 1. Currently, a received encapsulated packet has an outer and an inner header, but
> > the virtio device is unable to calculate the hash for the inner header. The same
> > flow can traverse through different tunnels, resulting in the encapsulated
> > packets being spread across multiple receive queues (refer to the figure below).
> > However, in certain scenarios, we may need to direct these encapsulated packets of
> > the same flow to a single receive queue. This facilitates the processing
> > of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
> > 
> >                client1                    client2
> >                   |        +-------+         |
> >                   +------->|tunnels|<--------+
> >                            +-------+
> >                               |  |
> >                               v  v
> >                       +-----------------+
> >                       | monitoring host |
> >                       +-----------------+
> > 
> > To achieve this, the device can calculate a symmetric hash based on the inner headers
> > of the same flow.
> > 
> > 2. For legacy systems, they may lack entropy fields which modern protocols have in
> > the outer header, resulting in multiple flows with the same outer header but
> > different inner headers being directed to the same receive queue. This results in
> > poor receive performance.
> > 
> > To address this limitation, inner header hash can be used to enable the device to advertise
> > the capability to calculate the hash for the inner packet, regaining better receive performance.
> > 
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> 
> Looks good but small rewording suggestions:
> 
> > ---
> > v16->v17:
> > 	1. Some small rewrites. @Parav Pandit
> > 	2. Add Parav's Reviewed-by tag (Thanks!).
> > 
> > v15->v16:
> > 	1. Remove the hash_option. In order to delimit the inner header hash and RSS
> > 	   configuration, the ability to configure the outer src udp port hash is given
> > 	   to RSS. This is orthogonal to inner header hash, which will be done in the
> > 	   RSS capability extension topic (considered as an RSS extension together
> > 	   with the symmetric toeplitz hash algorithm, etc.). @Parav Pandit @Michael S . Tsirkin
> 
> Hmm maybe. I'd like the TC see this patch though, they are designed to
> work together. Can we see at least a draft? I have been burned

I've drawn up a simple draft on hashing based on outer src port,
but not yet on toeplitz symmetric hashing, I'll send it out in about 4
weeks, but please don't delay this work. You have my word.

> many times by contributors just addressing what they
> care about, promising to follow through with other work and
> never bothering.

I got it.

> 
> > 	2. Fix a 'field' typo. @Parav Pandit
> > 
> > v14->v15:
> > 	1. Add tunnel hash option suggested by @Michael S . Tsirkin
> > 	2. Adjust some descriptions.
> > 
> > v13->v14:
> > 	1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
> > 	2. Rebase to master branch.
> > 	3. Some minor modifications.
> > 
> > v12->v13:
> > 	1. Add a GET command for hash_tunnel_types. @Parav Pandit
> > 	2. Add tunneling protocol explanation. @Jason Wang
> > 	3. Add comments on some usage scenarios for inner hash.
> > 
> > v11->v12:
> > 	1. Add a command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
> > 	2. Refine the commit log. @Michael S . Tsirkin
> > 	3. Add some tunnel types.
> > 
> > v10->v11:
> > 	1. Revise commit log for clarity for readers.
> > 	2. Some modifications to avoid undefined terms. @Parav Pandit
> > 	3. Change VIRTIO_NET_F_HASH_TUNNEL dependency. @Parav Pandit
> > 	4. Add the normative statements. @Parav Pandit
> > 
> > v9->v10:
> > 	1. Removed hash_report_tunnel related information. @Parav Pandit
> > 	2. Re-describe the limitations of QoS for tunneling.
> > 	3. Some clarification.
> > 
> > v8->v9:
> > 	1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
> > 	2. Add tunnel security section. @Michael S . Tsirkin
> > 	3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
> > 	4. Fix some typos.
> > 	5. Add more tunnel types. @Michael S . Tsirkin
> > 
> > v7->v8:
> > 	1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
> > 	2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pandit
> > 	3. Removed re-definition for inner packet hashing. @Parav Pandit
> > 	4. Fix some typos. @Michael S . Tsirkin
> > 	5. Clarify some sentences. @Michael S . Tsirkin
> > 
> > v6->v7:
> > 	1. Modify the wording of some sentences for clarity. @Michael S. Tsirkin
> > 	2. Fix some syntax issues. @Michael S. Tsirkin
> > 
> > v5->v6:
> > 	1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
> > 	2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
> > 	3. Move the links to introduction section. @Michael S. Tsirkin
> > 	4. Clarify some sentences. @Michael S. Tsirkin
> > 
> > v4->v5:
> > 	1. Clarify some paragraphs. @Cornelia Huck
> > 	2. Fix the u8 type. @Cornelia Huck
> > 
> > v3->v4:
> > 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
> > 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
> > 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
> > 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
> > 
> > v2->v3:
> > 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> > 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
> > 
> > v1->v2:
> > 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> > 	2. Clarify some paragraphs. @Jason Wang
> > 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
> > 
> >  device-types/net/description.tex        | 161 ++++++++++++++++++++++++
> >  device-types/net/device-conformance.tex |   1 +
> >  device-types/net/driver-conformance.tex |   1 +
> >  introduction.tex                        |  40 ++++++
> >  4 files changed, 203 insertions(+)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 3030222..6bf65ff 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -88,6 +88,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >  
> > +\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for tunnel-encapsulated packets.
> > +
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> >  
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> > @@ -147,6 +149,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
> >  \end{description}
> >  
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -869,6 +872,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  If the feature VIRTIO_NET_F_RSS was negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
> > +\item The device uses \field{hash_tunnel_types} of the virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
> 
> I think you mean both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_TUNNEL?

Yes.

> then:
> 
> 	If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the
> 	device ...

Ok. Will modify in the next version.

> 
> 
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
> >  \end{itemize}
> > @@ -876,6 +880,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  If the feature VIRTIO_NET_F_RSS was not negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
> > +\item The device uses \field{hash_tunnel_types} of the virtnet_hash_tunnel_config_get structure as 'Enabled encapsulation hash types' bitmask if VIRTIO_NET_F_HASH_TUNNEL was negotiated.
> 
> 
> 	If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the
> 	device ...
> 
> 
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
> >  \end{itemize}
> > @@ -891,6 +896,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  
> >  \subparagraph{Supported/enabled hash types}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> > +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> 
> which paragraph? until where? Maybe, just before
> \subparagraph{Supported/enabled hash types}
> 
> we should add something like:
> 
> 	+The per-packet hash calculation can depend on the IP
> 	+packet type, see \hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]}
> 	+and \hyperref[intro:TCP]{[TCP]}.
> 	+
> 	 \subparagraph{Supported/enabled hash types}

Ok.

> 
> 
> >  Hash types applicable for IPv4 packets:
> >  \begin{lstlisting}
> >  #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > @@ -1001,6 +1007,161 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
> >  \end{itemize}
> >  
> > +\paragraph{Inner Header Hash}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> > +and VIRTIO_NET_CTRL_HASH_TUNNEL_GET for the inner header hash configuration.
> 
> not the hash, the calculation is configured:
> 
> 	to configure the calculation of the inner header hash

Ok.

> 
> > +
> > +struct virtnet_hash_tunnel_config_set {
> > +    le32 hash_tunnel_types;
> > +};
> > +
> > +struct virtnet_hash_tunnel_config_get {
> > +    le32 supported_hash_tunnel_types;
> > +    le32 hash_tunnel_types;
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> > +
> > +Field \field{supported_hash_tunnel_types} provided by the device indicates that the device supports inner header hash for these encapsulation types.
> > +\field{supported_hash_tunnel_types} contains the bitmask of supported tunnel hash types.
> 
> 
> I think "tunnel hash types" is the same as "encapsulation hash types".
> You seem to use them interchangeably.

Then I would use like this:
tunneling protocols, encapsulated packets and encapsulation hash types.

> you also never explain what it is. I think it means
> "tunnel types supported/enabled for inner header hash"
> 
> can we just say it like this everywhere?
> 

Ok.

> 
> I assume that the initial configuration (before any VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> commands) is that no tunnel types are enabled for inner header hash ?
> 
> 

Yes. you are right.

> 
> > See \ref{sec:Device Types / Network Device / Device Operation / Processing
> > +of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}.
> > +
> > +Field \field{hash_tunnel_types} contains the bitmask of configured tunnel hash types.
> 
> and is configured same as enabled? enabled seems clearer.

Ok. Will modify.

> 
> > +See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}.
> 
> > +
> > +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> > +\begin{itemize}
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{hash_tunnel_types} for the device using the virtnet_hash_tunnel_config_set structure, which is read-only for the device.
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{hash_tunnel_types} and \field{supported_hash_tunnel_types} from the device using the virtnet_hash_tunnel_config_get
> > +      structure, which is write-only for the device.
> > +\end{itemize}
> > +
> > +\subparagraph{Tunnel/Encapsulated packet}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encapsulated packet}
> > +
> > +A tunnel packet is encapsulated from the original packet based on the tunneling protocol (only a single level of
> > +encapsulation is currently supported
> 
> this support is really for inner hash. So I'd move this statement there:
> 	the hash of the inner header is calculated 
> 	(only a single level of encapsulation is currently supported)
> 

Ok.

> 
> 
> Wait so is "a tunnel packet" same as "encapsulated packet"?

Yes, Like explained above.

> What then is 
> "the original packet" - this is the 1st time you mention it -
> the payload?

Yes. The inner payload.

> 
> I'd maybe drop "tunnel packet" completely - I don't think this
> is a standard term, right?
> 
> Mean something like:
> 
> 	Multiple tunneling protocols allow encapsulating an inner,
> 	payload packet in an outer, encapsulated packet. 
> 

Ok.

> > +The encapsulated packet contains an outer header and an inner header,
> 
> maybe "thus contains"
> 

Will add.

> > and
> > +the device calculates the hash over either the inner header or the outer header.
> 
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated packet's outer header matches one of the
> > +configured \field{hash_tunnel_types}
> 
> packet types enabled in hash_tunnel_types ?

Yes.

> 
> >, the hash of the inner header is calculated.
> 
> I think the point is not that it's calculated. I would say:
> 	the device uses the inner header for hash calculations.
> 	If the received packet's (outer) header
> 	does not match any types enabled in \field{hash_tunnel_types}
> 	then the device uses the outer header for hash calculations.
> 
> 

Ok.

> 
> 
> > +
> > +Supported encapsulated packet types:
> > +\begin{itemize}
> > +\item The outer header of the following encapsulation types does not contain the transport protocol:
> > +\begin{itemize}
> > +\item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +\item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +\item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +\item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\end{itemize}
> > +\item The outer header of the following encapsulation types uses UDP as the transport protocol:
> > +\begin{itemize}
> > +\item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +\end{itemize}
> > +\end{itemize}
> 
> itemize inside itemize is a mess. number one of these?
> 

Do you mean by numbers? I think it would be clearer to add the tab key here.

> 
> > +
> > +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is not included in the configured \field{hash_tunnel_types},
> > +the hash of the outer header is calculated for the received encapsulated packet.
> 
> I don't get this part. So if bit 0 is set then other bits do not matter
> at all?

Yes.

> 
> > +
> > +The hash is calculated for the received non-encapsulated packet as if VIRTIO_NET_F_HASH_TUNNEL was not negotiated.
> 
> Now you are introducing a term non-encapsulated.
> I think what you really mean is simply what I wrote above:

I got it. Will modify.

> 	if the received packet's (outer) header
> 	does not match any types enabled in \field{hash_tunnel_types}
> 	then the device uses the outer header for hash calculations.
> 
> 
> 
> 
> > +
> > +\subparagraph{Supported/enabled encapsulation hash types}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NONE        (1 << 0)
> > +\end{lstlisting}
> > +
> > +Supported encapsulation hash types:
> > +Hash type applicable for inner payload of the \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 1)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 2)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 3)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 4)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:vxlan]{[VXLAN]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 5)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 6)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:geneve]{[GENEVE]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 7)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:ipip]{[IPIP]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 8)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the \hyperref[intro:nvgre]{[NVGRE]} packet:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 9)
> > +\end{lstlisting}
> 
> Just have a single listing and put explanation in the comments.
> 

Ok.

> 
> > +\subparagraph{Advice}
> > +Usage scenarios of inner header hash (but not limited to):
> 
> This "but not limited to" is ungrammatical.
> 
> 
>  Better:
> 
> 	Example uses of inner header hash:
> 

Ok.

> > +\begin{itemize}
> > +\item Legacy tunneling protocols that lack entropy in the outer header use inner header hash to hash flows
> > +      with the same outer header but different inner headers to different queues for better-receiving performance.
> 
> 
> 
> 	Legacy tunneling protocols, lacking outer header entropy, can use
> 	RSS with inner
> 	header hash to distribute flows with identical outer but different
> 	inner headers across various queues, improving performance.
> 
> 
> > +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
> > +      to utilize warm caches, to have less locking etc. are optimized to obtain receiving performance.
> 
> Both examples here
> are with RSS, and only for performance, while you indicated
> there are uses for correctness too. How about:
> 
> 	Indentify an inner flow distributed across multiple outer tunnels.
> 

Ok, I think this is a generic description too.

> 
> > +\end{itemize}
> > +
> > +For scenarios with sufficient outer entropy or no inner header hash requirements, inner header hash may not be needed:
> > +A tunnel is often expected to isolate the external network from the internal one. By completely ignoring entropy
> > +in the outer header and replacing it with entropy from the inner header, for hash calculations, this expectation
> > +might be violated to a certain extent, depending on how the hash is used. When the hash use is limited to RSS queue
> > +selection, inner header hash may have quality of service (QoS) limitations.
> 
> 
> 
> > +
> > +Possible mitigations:
> > +\begin{itemize}
> > +\item Use a tool with good forwarding performance to keep the receive queue from dropping packets.
> > +\item If the QoS is unavailable, the driver can set \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> > +      to disable inner header hash for encapsulated packets.
> > +\item Perform appropriate QoS before packets consume the receive buffers of the receive queues.
> > +\end{itemize}
> 
> Lots of words here saying very little. You don't need to sell this to
> readers, I think it's enough to say:
> 
> As using the inner header hash completely discards the outer header
> entropy, care must be taken if the inner header is controlled by an adversary,
> as the adversary can then intentionally create configurations with
> insufficient entropy.
> 
> Besides disabling Mitigations would depend on the 
> 
> 

Ok.

> 
> > +
> > +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> > +
> > +The device MUST calculate the hash on the outer header if the type of the received encapsulated packet does not match
> > +any value of the configured \field{hash_tunnel_types}.
> 
> Flip things about please. First condition then what happens.
> 

Ok. Will modify.

> 
> > +
> > +The device MUST respond to the VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRTIO_NET_ERR if the device receives
> > +an unsupported or unrecognized VIRTIO_NET_HASH_TUNNEL_TYPE_ flag.
> > +
> > +The device MUST provide the values of \field{supported_hash_tunnel_types} if it offers the VIRTIO_NET_F_HASH_TUNNEL feature.
> 
> provide where? what is it saying?

Here:
+ Field \field{supported_hash_tunnel_types} provided by the device indicates that the device supports inner header hash for these encapsulation types.
+ \field{supported_hash_tunnel_types} contains the bitmask of supported tunnel hash types.
+ See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled encapsulation hash types}.

The device does not provide supported_hash_tunnel_types in the device
configuration space. After the driver has negotiated the
VIRTIO_NET_F_HASH_TUNNEL feature, the driver can use the
VIRTIO_NET_CTRL_HASH_TUNNEL_GET command to get
supported_hash_tunnel_types from the device.

> 
> > +
> > +Upon reset, the device MUST initialize \field{hash_tunnel_type} to 0.
> 
> what is hash_tunnel_type ? 

Here it should be \field{hash_tunnel_types}.

> initialize where?

I don't get this. This is the same as 'Notifications Coalescing':

"Upon reset, a device MUST initialize all coalescing parameters to 0."

> 
> and how does 0 differ from VIRTIO_NET_HASH_TUNNEL_TYPE_NONE ?

They work the same. Maybe we just need a 0.

> 
> > +
> > +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> > +
> > +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature when issuing commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
> > +
> > +The driver MUST ignore the values received from the VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with VIRTIO_NET_ERR.
> > +
> > +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags which are not supported by the device.
> 
> more specific here? supported -> set in supported_hash_tunnel_types ?

The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags in
\field{hash_tunnel_types} which are not supported by the device.

See: 
+The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
+\begin{itemize}
+\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{hash_tunnel_types} for the device using the virtnet_hash_tunnel_config_set structure, which is read-only for the device.
+\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{hash_tunnel_types} and \field{supported_hash_tunnel_types} from the device using the virtnet_hash_tunnel_config_get
+      structure, which is write-only for the device.
+\end{itemize}

> and set in hash_tunnel_types
> 
> so really this boils down to hash_tunnel_types not having any bits
> not set in supported_hash_tunnel_types? for the set command?

Yes, you are right.

> and VIRTIO_NET_HASH_TUNNEL_TYPE_ can be ignored I think.
> 

But the driver needs to know what those bits are, which is why we
hardcode them...

> 
> > +
> >  \paragraph{Hash reporting for incoming packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
> >  
> > diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
> > index 54f6783..f88f48b 100644
> > --- a/device-types/net/device-conformance.tex
> > +++ b/device-types/net/device-conformance.tex
> > @@ -14,4 +14,5 @@
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> >  \end{itemize}
> > diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
> > index 97d0cc1..9d853d9 100644
> > --- a/device-types/net/driver-conformance.tex
> > +++ b/device-types/net/driver-conformance.tex
> > @@ -14,4 +14,5 @@
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> >  \end{itemize}
> > diff --git a/introduction.tex b/introduction.tex
> > index b7155bf..3f34950 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -102,6 +102,46 @@ \section{Normative References}\label{sec:Normative References}
> >      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
> >  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> >  
> > +	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> > +    Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
> > +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> > +	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> > +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This protocol describes extensions by which two fields, Key and
> > +    Sequence Number, can be optionally carried in the GRE Header \ref{intro:gre_rfc2784}.
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> > +	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> > +    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or
> > +    delivery protocol. Note that this does not change the GRE header format or any behaviors specified by RFC 2784 or RFC 2890.
> > +	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> > +	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]} &
> > +    GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
> > +    This GRE-in-UDP encapsulation allows the UDP source port field to be used as an entropy field.
> 
> 
> why call this use of src port out ? many other protocols on this list do
> this.

Just refer to its abstract. Will remove this.

Thanks.

> 
> > This protocol is specified for IPv4 and IPv6,
> > +    and used as either the payload or delivery protocol.
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
> > +	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
> > +    Virtual eXtensible Local Area Network.
> > +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> > +	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> > +    Generic Protocol Extension for VXLAN. This protocol describes extending Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN header.
> > +	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.txt}\\
> > +	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
> > +    Generic Network Virtualization Encapsulation.
> > +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> > +	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
> > +    IP Encapsulation within IP.
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> > +	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
> > +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> > +	\phantomsection\label{intro:IP}\textbf{[IP]} &
> > +    INTERNET PROTOCOL
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> > +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> > +    User Datagram Protocol
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> > +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> > +    TRANSMISSION CONTROL PROTOCOL
> > +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
> >  \end{longtable}
> >  
> >  \section{Non-Normative References}
> > -- 
> > 2.19.1.6.gb485710b
> > 
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> > 
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

