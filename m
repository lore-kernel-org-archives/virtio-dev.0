Return-Path: <virtio-dev-return-13010-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93065C001B3
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:46:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 82C3C613F2
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:46:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 793769865D4
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 16:46:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 672C49865BA; Wed, 21 Jun 2023 16:46:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5025E9865BD;
	Wed, 21 Jun 2023 16:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlgagCT_1687365966;
Date: Thu, 22 Jun 2023 00:46:06 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621164606.GI74977@h68b04307.sqa.eu95>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621104647-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 11:38:52AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 21, 2023 at 09:50:52PM +0800, Heng Qi wrote:
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
> 
> don't put an empty line here

Ok. Will remove it.

> 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> 
> ok almost there. small corrections, and one enhancement suggestion.
> 
> 
> > ---
> > v17->v18:
> > 	1. Some rewording suggestions from Michael (Thanks!).
> > 	2. Use 0 to disable inner header hash and remove
> > 	   VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
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
> >  device-types/net/description.tex        | 158 ++++++++++++++++++++++++
> >  device-types/net/device-conformance.tex |   1 +
> >  device-types/net/driver-conformance.tex |   1 +
> >  introduction.tex                        |  39 ++++++
> >  4 files changed, 199 insertions(+)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 3030222..9fdccfc 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -88,6 +88,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >  
> > +\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
> > +
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> >  
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> > @@ -147,6 +149,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS and/or VIRTIO_NET_F_HASH_REPORT.
> 
> I think just or is enough.

Sure. I agree.

> 
> >  \end{description}
> >  
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -869,6 +872,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  If the feature VIRTIO_NET_F_RSS was negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
> > +\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{hash_tunnel_types} of the
> > +      virtnet_hash_tunnel_config_get structure as 'Encapsulation types enabled for inner header hash' bitmask.
> 
> why get and not set? e.g. if I call get then set then the field in set
> will have effect.

If the following command sequence:
1. The driver sets hash_tunnel_types using the SET command and saves it
somewhere e.g. virtnet_info->hash_tunnel_types_saved.
2. The driver fetches hash_tunnel_types using the GET command, which should
be equal to virtnet_info->hash_tunnel_types_saved (or even returned from
virtnet_info->hash_tunnel_types_saved, like RSS).
3. The driver sets hash_tunnel_types again using the SET command and saves
it in virtnet_info->hash_tunnel_types_saved.

But I think your enhanced proposal is also feasible, after all, before
for example RSS etc. we only have SET command can work very well.

> 
> 
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
> >  \end{itemize}
> > @@ -876,6 +881,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  If the feature VIRTIO_NET_F_RSS was not negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
> > +\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device uses \field{hash_tunnel_types} of the
> > +      virtnet_hash_tunnel_config_get structure as 'Encapsulation types enabled for inner header hash' bitmask.
> 
> same
> 
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
> >  \end{itemize}
> > @@ -889,6 +896,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
> >  \end{itemize}
> >  
> > +The per-packet hash calculation can depend on the IP packet type. See
> > +\hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> 
> and end paragraph here.

Is adding a blank line here? --!

> 
> >  \subparagraph{Supported/enabled hash types}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> >  Hash types applicable for IPv4 packets:
> > @@ -1001,6 +1010,155 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
> >  \end{itemize}
> >  
> > +\paragraph{Inner Header Hash}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> > +and VIRTIO_NET_CTRL_HASH_TUNNEL_GET to configure the calculation of the inner header hash.
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
> 
> It would be cleaner to have a single structure for both.
> 

SET carries an additional 32 bits of information. But if you think this
will make the overall structure more concise, I'm ok.

> I also think hash_tunnel is unnecessarily verbose, and _config_ is also
> pointless.
> 
> Returning supported_hash_tunnel_types back to device can also
> be useful for debugging.
> 
> How about:
> 
> 
> struct virtnet_hash_tunnel {
>      le32 supported_tunnel_types;
>      le32 enabled_tunnel_types;
> };
> 

It's OK.

And:
For the GET command, both fields are WO for the device.
For the SET command, \field{supported_tunnel_types} is RO for the device
and \field{enabled_tunnel_types} is WO for the device.

> 
> For VIRTIO_NET_CTRL_HASH_TUNNEL_GET, \field{supported_tunnel_types}
> contains the bitmask of encapsulation types supported
> by the device for inner header hash; \field{enabled_tunnel_types}
> contains the value received in a previous successful
> call to VIRTIO_NET_CTRL_HASH_TUNNEL_SET.
> 
> For VIRTIO_NET_CTRL_HASH_TUNNEL_SET, \field{supported_tunnel_types}
> contains the value returned by a previous
> successful call to VIRTIO_NET_CTRL_HASH_TUNNEL_GET;
> \field{enabled_tunnel_types}
> contains the bitmask of encapsulation types to enable
> for inner header hash.
> 
> and add normative statements to this end.
> 
> 

Ok.

> > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> > +
> > +
> > +Field \field{supported_hash_tunnel_types} provided by the device indicates that the device supports inner header hash for these encapsulation types.
> > +Field \field{supported_hash_tunnel_types} contains the bitmask of encapsulation types supported for inner header hash.
> 
> We don't need these two sentences. Just second one will do.
> 

Ok.

> > +See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}.
> > +
> > +Field \field{hash_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
> 
> They have different meanings for set and get though.
> 
> 
> > +See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}.
> > +
> > +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> > +\begin{itemize}
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{hash_tunnel_types} for the device using the
> > +      virtnet_hash_tunnel_config_set structure, which is read-only for the device.
> > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{hash_tunnel_types} and \field{supported_hash_tunnel_types}
> > +      from the device using the virtnet_hash_tunnel_config_get structure, which is write-only for the device.
> > +\end{itemize}
> > +
> > +\subparagraph{Encapsulated packet}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Encapsulated packet}
> > +
> > +Multiple tunneling protocols allow encapsulating an inner, payload packet in an outer, encapsulated packet.
> > +The encapsulated packet thus contains an outer header and an inner header, and the device calculates the
> > +hash over either the inner header or the outer header.
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated packet's outer header matches one of the
> > +encapsulation types enabled in \field{hash_tunnel_types}, then the device uses the inner header for hash
> > +calculations (only a single level of encapsulation is currently supported).
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's (outer) header does not match any types enabled
> > +in \field{hash_tunnel_types}, then the device uses the outer header for hash calculations.
> > +
> > +Initially all encapsulation types are disabled (the value of \field{hash_tunnel_types} is 0) for inner header hash
> > +before any VIRTIO_NET_CTRL_HASH_TUNNEL_SET command are sent by the driver.
> 
> Initially (before driver sends VIRTIO_NET_CTRL_HASH_TUNNEL_SET)
> all encapsulation types are disabled 
> 

Ok.

> > +
> > +Encapsulation types supported/enabled for inner header hash:
> > +\begin{itemize}
> > +    \item The outer header of the following encapsulation types does not contain the transport protocol:
> > +        \begin{enumerate}
> > +	    \item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +	    \item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +	    \item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +	    \item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header is over IPv4 and the inner header is over IPv4.
> > +	    \item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +        \end{enumerate}
> > +
> > +    \item The outer header of the following encapsulation types uses UDP as the transport protocol:
> > +        \begin{enumerate}
> > +	    \item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +	    \item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +	    \item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +	    \item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > +        \end{enumerate}
> > +\end{itemize}
> > +
> > +\subparagraph{Encapsulation types supported/enabled for inner header hash}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}
> > +
> > +Encapsulation types applicable for inner header hash:
> > +\begin{lstlisting}
> > +The \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0)
> > +
> > +The \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1)
> > +
> > +The \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2)
> > +
> > +The \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3)
> > +
> > +The \hyperref[intro:vxlan]{[VXLAN]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4)
> > +
> > +The \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5)
> > +
> > +The \hyperref[intro:geneve]{[GENEVE]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6)
> > +
> > +The \hyperref[intro:ipip]{[IPIP]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7)
> > +
> > +The \hyperref[intro:nvgre]{[NVGRE]} encapsulation type:
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8)
> > +\end{lstlisting}
> > +
> > +\subparagraph{Advice}
> > +Example uses of inner header hash:
> > +\begin{itemize}
> > +\item Legacy tunneling protocols, lacking outer header entropy, can use RSS with inner header hash to
> > +      distribute flows with identical outer but different inner headers across various queues, improving performance.
> > +\item Identify an inner flow distributed across multiple outer tunnels.
> > +\end{itemize}
> > +
> > +As using the inner header hash completely discards the outer header entropy, care must be taken
> > +if the inner header is controlled by an adversary, as the adversary can then intentionally create
> > +configurations with insufficient entropy.
> > +
> > +Besides disabling inner header hash, mitigations would depend on:
> > +\begin{itemize}
> > +\item Use a tool with good forwarding performance to keep the receive queue from dropping packets.
> 
> this is quite vague
> 

Giving too specific advice would be too specific, which we discussed a
long time ago.

> > +\item If the QoS (Quality of service) is unavailable, the driver can set \field{hash_tunnel_types} to 0
> > +      to disable inner header hash for all encapsulated packets.
> 
> this is precisely disabling

\field{hash_tunnel_types} to 0 disabling inner ?

> 
> > +\item Perform appropriate QoS before packets consume the receive buffers of the receive queues.
> 
> it is not at all clear how would devices do this.
> 

The reason we're describing it broadly here is that this is done by
devices, which usually know what to do, and can also take actions
off-device, such as firewalls off-device, etc.

> > +\end{itemize}
> 
> Oh sorry I didn't complete the sentence :(
> I suggest dropping above and having something like:
> 
> 	Besides disabling inner header hash, mitigations would depend on how the
> 	hash is used, and the consequences of a successful attack.
> 	For example, if the attack causes packet drops, using a deeper queue
> 	might be able to mitigate it.

Ok, I got you now!

> 
> 
> 
> > +
> > +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> > +
> > +If the (outer) header of the received packet does not match any value
> 
> any encapsulation type

Ok. And 'any bits' instead of 'any value' I think.

> 
> > enabled in \field{hash_tunnel_types},
> > +the device MUST calculate the hash on the outer header.
> > +
> > +If the device receives an unsupported or unrecognized value for \field{hash_tunnel_types}, it MUST respond to
> > +the VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRTIO_NET_ERR.
> 
> let's be specific. if any bits in hash_tunnel_types are not set in
> supported_hash_tunnel_types

Ok.

> 
> > +
> > +If the device offers the VIRTIO_NET_F_HASH_TUNNEL feature, it MUST provide the values for \field{supported_hash_tunnel_types}.
> 
> what does this mean even?

When the driver uses the GET command, the device should preferably
return the corresponding value..

> 
> > +
> > +If \field{hash_tunnel_types} is set to 0 or upon device reset, the device MUST disable inner header hash for all encapsulation types.
> > +
> > +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> > +
> > +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature when issuing
> > +commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
> > +
> > +The driver MUST ignore the values received from the VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with VIRTIO_NET_ERR.
> > +
> > +The driver MUST NOT set any value in \field{hash_tunnel_types} which is not set in \field{supported_hash_tunnel_types}.
> 
> any bits. not any value

Get.

Thanks.

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
> > index b7155bf..81f07a4 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -102,6 +102,45 @@ \section{Normative References}\label{sec:Normative References}
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
> > +    This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
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
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

