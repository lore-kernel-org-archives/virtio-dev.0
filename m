Return-Path: <mst@redhat.com>
Date: Tue, 3 Jan 2023 05:38:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v5] virtio-net: support inner header
 hash
Message-ID: <20230103052538-mutt-send-email-mst@kernel.org>
References: <20230103023655.127077-1-hengqi@linux.alibaba.com>
 <20230103014559-mutt-send-email-mst@kernel.org>
 <20230103095228.GA50094@h68b04307.sqa.eu95>
MIME-Version: 1.0
In-Reply-To: <20230103095228.GA50094@h68b04307.sqa.eu95>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 03, 2023 at 05:52:28PM +0800, Heng Qi wrote:
> On Tue, Jan 03, 2023 at 02:35:10AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Jan 03, 2023 at 10:36:55AM +0800, Heng Qi wrote:
> > > If the tunnel is used to encapsulate the packets, the hash calculated
> > > using the outer header of the receive packets is always fixed for the
> > > same flow packets, i.e. they will be steered to the same receive queue.
> > > 
> > > We add a tunnel feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
> > > in \field{hash_types}, which instructs the device to calculate the
> > > hash using the inner headers of tunnel-encapsulated packets. Besides,
> > > values in \field{hash_report_tunnel} are added to report tunnel types.
> > > 
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151
> > > 
> > > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > 
> > 
> > went over this, thanks! overall it's good but I think some work
> > is still needed.
> > 
> > > ---
> > > v4:
> > > 	1. Clarify some paragraphs. @Cornelia Huck
> > > 	2. Fix the u8 type. @Cornelia Huck
> > > 
> > > v3:
> > > 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
> > > 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
> > > 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
> > > 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
> > > 
> > > v2:
> > > 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> > > 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
> > > 
> > > v1:
> > > 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> > > 	2. Clarify some paragraphs. @Jason Wang
> > > 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
> > > 
> > >  content.tex | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 191 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index e863709..178a627 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > >      channel.
> > >  
> > > +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> > > +    header hash for GRE, VXLAN and GENEVE-encapsulated packets.
> > > +
> > 
> > You say encapsulated here.
> > Do we want to rename "tunnel" to "encapsulation" everywhere?
> 
> As you suggest in the subsequent comments, we can use tunnel/encapsulated at the
> beginning of the paragraph and 'encapsulated' afterward to avoid confusion.
> 
> > This matches the relevant specs more closely.
> > Also see below.
> > 
> > 
> > >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> > >  
> > >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > > @@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > >   to several segments when each of these smaller packets has UDP header.
> > >  
> > >  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
> > > -    value and a type of calculated hash.
> > > +    value, a type of calculated hash, and, if VIRTIO_NET_F_HASH_TUNNEL
> > > +    is negotiated, a tunnel packet type.
> > >  
> > >  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
> > >      value. Device benefits from knowing the exact header length.
> > > @@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> > >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \end{description}
> > >  
> > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > @@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> > >          le16 num_buffers;
> > >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > +        u8 hash_report_tunnel;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated, only valid of VIRTIO_NET_F_HASH_TUNNEL negotiated)
> > > +        u8 padding_reserved;    (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > >  };
> > >  \end{lstlisting}
> > >  
> > > @@ -3837,7 +3843,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> > >  A device attempts to calculate a per-packet hash in the following cases:
> > >  \begin{itemize}
> > >  \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
> > > -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
> > > +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type. If additionally
> > > +VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device reports the tunnel type as well.
> > >  \end{itemize}
> > >  
> > >  If the feature VIRTIO_NET_F_RSS was negotiated:
> > > @@ -3863,6 +3870,42 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> > >   \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
> > >  \end{itemize}
> > >  
> > > +\subparagraph{Tunnel packet}
> > > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel packet}
> > > +The tunnel packet is encapsulated from the original packet based on the
> > > +tunneling protocol, and it contains an outer header and an inner header.
> > 
> > The tunnel -> a tunnel?
> 
> Ok, I'll modify it in the next version.
> 
> > 
> > is -> the packet.
> 
> Sorry, I don't understand what you mean, can you describe it again?

typo, sorry. it -> the packet.

> > 
> > > +The processing of the tunnel packets requires that the device has the
> > 
> > 'Processing' I think
> 
> Ok, I'll modify it in the next version.
> 
> > 
> > > +capability of identifying and parsing the tunnel packets, for example,
> > > +the type of the tunnel packets can be obtained.
> > 
> > what do you mean 'can'? obtained by what? this paragraph just
> 
> I want to express that the device has the ability to obtain the type of tunnel-encapsulated packets.

ok however we only care about device behaviour. i don't see much of a
point explaining that it obtains a value if we don't also explain what
it does with it. just drop this part?

> > confuses me. maybe the feature should be called
> > "incoming tunnel packet processing" as opposed to "the tunnel
> > feature" and then we can say
> > "when enabled, incoming tunnel packet processing
> > involves identifying and parsing of the incoming tunnel packets".
> 
> I don't understand what you mean, but I guess your suggestion is to use the following sentence
> "When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, incoming tunnel packet processing involves
> identifying and parsing of the incoming tunnel packets" instead of "The processing of the tunnel
> packets requires that the device has the capability of identifying and parsing the tunnel packets"?

something like this, yes.

> > 
> > 
> > > +
> > > +If the tunnel-related type is set in \field{hash_types},
> > 
> > what is " the tunnel-related type"? this is the first this is mentioned.
> 
> I mean "the tunnel hash type" and I'll modify it in the next version.

are you sure? isn't the tunnel type set there? of course it all will
become encapsulation type etc.

> > 
> > > then the
> > > +corresponding tunnel packet calculates the hash over the inner header.
> > 
> > packet calculates the hash? do you mean that hash is calculated?
> 
> Yes, you are right. I'll fix it in the next version.
> 
> > and again this is the first some hash is mentioned, which hash does
> > this refer to?
> 
> The hash here is the per-packet hash, and the device uses the hash to determine the receive virtqueue to place incoming packets.


You need to change the introduction sentence at the beginning of the
paragraph then to talk about hashing, and explain that the hash
for specific type of encapsulated packet is calculated over
the inner as opposed to outer packet. Also mention that
only a single level of encapsulation is currently supported.


> > 
> > > +Tunnel hash types are listed in \ref{sec:Device Types / Network Device /
> > 
> > these are really more "supported tunnel types".
> 
> Ok, I'll modify it in the next version.
> 
> > 
> > > +Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets /
> > > +Supported/enabled hash types}.
> > 
> > 
> > > +
> > > +Besides, if both VIRTIO_NET_F_REPORT and the tunnel feature (e.g.
> > > +VIRTIO_NET_F_HASH_TUNNEL) are negotiated, \field{hash_report} reports the hash
> > > +types and \field{hash_report_tunnel} reports the corresponging tunnel type.
> > 
> > besides what? what else is reported? if nothing drop "Besides".
> 
> Ok, I'll drop it.
> 
> > 
> > > +
> > > +If the tunnel feature is not negotiated,
> > 
> > just call the feature bit out.
> 
> Ok.
> 
> > 
> > > the device calculates the hash over
> > > +the default outer header.
> > 
> > what is the default header? i think you just mean
> > only calculates the hash over the outer header?
> 
> Yes, you are right.
> 
> > 
> > > Also, if the feature VIRTIO_NET_F_REPORT is negotiated,
> > > +\field{hash_report} reports the hash types, but \field{hash_report_tunnel} is set
> > > +to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE.
> > 
> > also refers to when? above paragraph also said VIRTIO_NET_F_REPORT
> > negotiated.
> 
> I'm going to merge this paragraph with the previous one and remove the "Also".
> 
> > 
> > > +
> > > +If the tunnel feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the device
> > 
> > just say VIRTIO_NET_F_HASH_TUNNEL don't keep saying "the tunnel
> > feature".
> 
> Ok, I'll modify it.
> 
> > 
> > > +supports inner hash calculation for GRE, VXLAN and GENEVE tunnel packets,
> > > +and the corresponding tunnel type in \field{hash_types} is
> > > +VIRTIO_NET_HASH_TYPE_{GRE, VXLAN, GENEVE}_INNER. Besides, the value in
> > > +\field{hash_report_tunnel} is VIRTIO_NET_HASH_REPORT_{GRE, VXLAN, GENEVE}.
> > > +
> > > +The relevant tunnel type links are documented below:
> > > +\begin{itemize}
> > > +\item GRE type link: https://datatracker.ietf.org/doc/rfc2784/
> > > +\item VXLAN type link: https://datatracker.ietf.org/doc/rfc7348/
> > > +\item GENEVE type link: https://datatracker.ietf.org/doc/rfc8926/
> > > +\end{itemize}
> > > +
> > 
> > 
> > links need to go into Normative references section, and be linked from
> > here.
> 
> Ok, thanks for the reminder.
> 
> > 
> > You keep using the term "tunnel packet" but e.g. GRE and GENEVE
> > specs always say "encapsulated packet". VXLAN does say both
> > tunnel packets and encapsulated packets just once but mostly
> 
> As you suggest, use "encapsulated" for uniformity.
> 
> > just says "VXLAN packets", and it's not clear to me whether
> > in VXLAN spec "tunnel packet" is the inner part of the packet or
> > the encapsulated one.
> > 
> 
> If I'm not wrong, "tunnel packet" is the encapsulated part of the packet.
> 
> > 
> > >  \subparagraph{Supported/enabled hash types}
> > >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> > >  Hash types applicable for IPv4 packets:
> > > @@ -3884,6 +3927,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> > >  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> > >  \end{lstlisting}
> > >  
> > > +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the tunnel hash
> > > +types below indicates
> > 
> > if types then indicate. if indicates then type
> 
> Thanks for the reminder, I will fix it in the next version.
> 
> > 
> > > that the hash can be calculated over the inner
> > > +header of the tunnel packet:
> > 
> > 
> > "can" in what sense? it has been calculated no?
> 
> I should use "the hash is calculated over the inner header of the tunnel packet."
> 
> > and don't the types just indicate the tunnel type?
> 
> Yes.
> 
> > 
> > > +Hash types applicable to inner payloads of GRE-encapsulated packets
> > 
> > don't capitalize in the middle of the sentence
> 
> Ok, I'll modify it in the next version.
> 
> > 
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> > > +\end{lstlisting}
> > > +Hash types applicable to inner payloads of VXLAN-encapsulated packets
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_TYPE_VXLAN_INNER       (1 << 10)
> > > +\end{lstlisting}
> > > +Hash types applicable to inner payloads of GENEVE-encapsulated packets
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_TYPE_GENEVE_INNER      (1 << 11)
> > > +\end{lstlisting}
> > 
> > 
> > I see a single bit in each case. in what sense is this "hash types".
> 
> Yes, this should be "Hash type" instead of "Hash types".
> 
> > 
> > 
> > 
> > 
> > > +
> > >  \subparagraph{IPv4 packets}
> > >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
> > >  The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
> > > @@ -3975,15 +4034,124 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> > >  (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
> > >  \end{itemize}
> > >  
> > > +\subparagraph{Inner payloads of tunnel-encapsulated packets}
> > > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Inner payloads of tunnel-encapsulated packets}
> > > +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
> > > +tunnel hash type is set in \field{hash_types}, the device calculates the
> > > +inner header hash on tunnel packets as below
> > 
> > as follows
> 
> Ok.
> 
> > 
> > > +(See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Tunnel packet}):
> > 
> > move the link to before "as follows"
> 
> Ok.
> 
> > > +
> > > +If inner payloads of the tunnel packets are IPv4 packets according to
> > 
> > why plural all of a sudden?
> 
> The singular is more reasonable here.
> 
> > 
> > > +'Enabled hash types' bitmasks as follows:
> > 
> > this sentence lacks a verb
> > 
> > are set as follows?
> 
> Yes, I'll fix this.
> 
> > 
> > 
> > > +\begin{itemize}
> > > +  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the tunnel packet has an inner
> > > +	TCPv4 header, the hash is calculated over the following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IP address
> > > +          \item inner Destination IP address
> > > +          \item inner Source TCP port
> > > +          \item inner Destination TCP port
> > > +        \end{itemsize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set and the tunnel packet has an
> > > +	inner UDPv4 header, the hash is calculated over the following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IP address
> > > +          \item inner Destination IP address
> > > +          \item inner Source UDP port
> > > +          \item inner Destination UDP port
> > > +        \end{itemize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set, the hash is calculated over the
> > > +	following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IP address
> > > +          \item inner Destination IP address
> > > +        \end{itemsize}
> > > +  \item Else the device does not calculate the hash
> > > +\end{itemize}
> > > +
> > > +If inner payloads of the tunnel packets are IPv6 packets without extension
> > > +headers according to 'Enabled hash types' bitmasks as follows:
> > 
> > same
> > 
> > > +\begin{itemize}
> > > +  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the tunnel packet has an inner
> > > +	TCPv6 header, the hash is calculated over the following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IPv6 address
> > > +          \item inner Destination IPv6 address
> > > +          \item inner Source TCP port
> > > +          \item inner Destination TCP port
> > > +        \end{itemsize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set and the tunnel packet has an
> > > +	inner UDPv6 header, the hash is calculated over the following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IPv6 address
> > > +          \item inner Destination IPv6 address
> > > +          \item inner Source UDP port
> > > +          \item inner Destination UDP port
> > > +        \end{itemize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set, the hash is calculated over the
> > > +	following fields:
> > > +        \begin{itemsize}
> > > +          \item inner Source IPv6 address
> > > +          \item inner Destination IPv6 address
> > > +        \end{itemsize}
> > > +  \item Else the device does not calculate the hash
> > > +\end{itemize}
> > > +
> > > +If inner payloads of the tunnel packets are IPv6 packets with extension headers
> > > +according to 'Enabled hash types' bitmasks as follows:
> > 
> > same
> > 
> > > +\begin{itemsize}
> > > +  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the tunnel packet has an inner
> > > +	TCPv6 header, the hash is calculated over the following fields:
> > > +        \begin{itemize}
> > > +          \item Home address from the home address option in the inner IPv6 destination
> > > +              options header. If the inner extension header is not present, use the
> > > +              inner Source IPv6 address.
> > > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> > > +              associated inner extension header. If the inner extension header is not
> > > +              present, use the inner Destination IPv6 address.
> > > +          \item inner Source TCP port
> > > +          \item inner Destination TCP port
> > > +        \end{itemize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set and the tunnel packet has an inner
> > > +	UDPv6 header, the hash is calculated over the following fields:
> > > +        \begin{itemsize}
> > > +          \item Home address from the home address option in the inner IPv6 destination
> > > +              options header. If the inner extension header is not present, use the
> > > +              inner Source IPv6 address.
> > > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> > > +              associated inner extension header. If the inner extension header is not
> > > +              present, use the inner Destination IPv6 address.
> > > +          \item inner Source UDP port
> > > +          \item inner Destination UDP port
> > > +        \end{itemize}
> > > +  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set, the hash is calculated over the
> > > +	following fields:
> > > +        \begin{itemsize}
> > > +          \item Home address from the home address option in the inner IPv6 destination
> > > +              options header. If the inner extension header is not present, use the
> > > +              inner Source IPv6 address.
> > > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> > > +              associated inner extension header. If the inner extension header is not
> > > +              present, use the inner Destination IPv6 address.
> > > +        \end{itemize}
> > > +  \item Else skip inner IPv6 extension headers and calculate the inner header hash as
> > > +	defined for a tunnel packet whose inner payload is an IPv6 packet without
> > > +	extension headers.
> > > +\end{itemsize}
> > > +
> > 
> > what is the reason for the weird capitalization? to match
> > rfc791 etc? if yes maybe we should add a link to the relevant specs.
> > 
> 
> This is for consistency with existing specs, as they do.

then let's add links to these specs too.

> > 
> > >  \paragraph{Hash reporting for incoming packets}
> > >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
> > >  
> > > -If VIRTIO_NET_F_HASH_REPORT was negotiated and
> > > - the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
> > > -and \field{hash_value} with the value of calculated hash.
> > > +If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated the
> > > +hash for the packet, the device fills \field{hash_report} with the report type
> > > +of calculated hash, and \field{hash_value} with the value of calculated hash.
> > > +Also, if VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device needs to fill
> > > +\field{hash_report_tunnel} with the report type of the tunnel packet, and it
> > > +is set to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE for the unencapsulated packet.
> > 
> > this mix of "tunnel" and "unencapsulated" is confusing. switch to
> > "encapsulated"? Also this is the first you mention
> > tunnel and unencapsulated packets in this paragraph. So I think
> > a tunnel/encapsulated packet.
> > 
> 
> No problem, I'll use "encapsulated" uniformly.
> 
> Thanks.
> 
> > >  
> > >  If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> > > -hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
> > > +hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE,
> > > +and sets \field{hash_report_tunnel} to VIRTIO_NET_HASH_REPORT_TUNNEL_NONE.
> > >  
> > >  Possible values that the device can report in \field{hash_report} are defined below.
> > >  They correspond to supported hash types defined in
> > > @@ -4005,6 +4173,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> > >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > >  \end{lstlisting}
> > >  
> > > +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
> > > +\field{hash_report_tunnel} can report the type of the tunnel-encapsulated
> > > +packet to the driver over the inner header hash calculation.
> > > +Possible values that the device can report in \field{hash_report_tunnel}
> > > +are defined below:
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_REPORT_TUNNEL_NONE     0
> > > +#define VIRTIO_NET_HASH_REPORT_GRE             1
> > > +#define VIRTIO_NET_HASH_REPORT_VXLAN           2
> > > +#define VIRTIO_NET_HASH_REPORT_GENEVE          3
> > > +\end{lstlisting}
> > > +
> > > +They correspond to supported hash types defined in
> > > +\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
> > > +
> > >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
> > >  
> > >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> > > -- 
> > > 2.19.1.6.gb485710b
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

