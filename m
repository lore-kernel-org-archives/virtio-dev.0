Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 12:05:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230221115147-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 21, 2023 at 04:20:59AM +0000, Parav Pandit wrote:
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Saturday, February 18, 2023 9:37 AM
> 
> > If the tunnel is used to encapsulate the packets, the hash calculated using the
> s/hash calculated/hash is calculated
> 
> > outer header of the receive packets is always fixed for the same flow packets,
> > i.e. they will be steered to the same receive queue.
> > 
> A little descriptive commit message like below reads better to me.
> Currently, when a received packet is an encapsulated packet meaning there is an outer and an inner header, virtio device is unable to calculate the hash for the inner header.
> Due to this limitation, multiple different flows identified by the inner header for the same outer header result in selecting the same receive queue.
> This effectively disables the RSS, resulting in poor receive performance.
> 
> Hence, to overcome this limitation, a new feature is introduced using a feature bit VIRTIO_NET_F_HASH_TUNNEL.
> This feature enables the device to advertise the capability to calculate the hash for the inner packet header.
> Thereby regaining better RSS performance in presence of outer packet header.

I think this is a good description however Parav I think it is important
to make contributors write their own commit messages so they know what
is the reason for the proposed change. What's good for the goose is good
for the gander - contributors should explain why their change to spec is
benefitial but reviewers should also explain why their changes to the
patch are benefitial, and "reads better to me" does not cut it - it does
not allow the contributor to improve with time.  It's more than about a
single contribution, see?

In this case I would say the issue is that motivation for the
change is never explained.

I am yet to review the patchset.

> 
> > We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks in
> > \field{hash_tunnel_types}, which instructs the device to calculate the hash
> > using the inner headers of tunnel-encapsulated packets. Note that
> > VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the inner header
> > hash, and does not give the device the ability to use the hash value to select a
> > receiving queue to place the packet.
> > 
> > Also, a feature bit VIRTIO_NET_F_HASH_REPORT_TUNNEL are added to report
> > an encapsulation type, and the feature depends on
> > VIRTIO_NET_F_HASH_REPORT.
> 
> As we discussed that tunnel type alone is not useful the sw, neither as an individual field nor merged with some other field.
> Hence, please remove this feature bit. HASH_TUNNEL is good enough.
> Please remove the references to it at more places below.
> 
> > It only means that the encapsulation type can be reported, it cannot instruct
> > the device to calculate the hash.
> > 
> 
> > 
> > +\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash
> > +	for tunnel-encapsulated packets.
> > +
> > +\item[VIRTIO_NET_F_HASH_REPORT_TUNNEL(52)] Device can report an
> > encapsulation type.
> > +
> Please remove this.
> 
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications
> > coalescing.
> > 
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -3140,6 +3145,8 @@ \subsubsection{Feature bit
> > requirements}\label{sec:Device Types / Network Device
> > \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> > VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_HASH_REPORT_TUNNEL] Requires
> > VIRTIO_NET_F_HASH_REPORT.
> >  \end{description}
> > 
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /
> > Network Device / Feature bits / Legacy Interface: Feature bits} @@ -3199,20
> > +3206,27 @@ \subsection{Device configuration layout}\label{sec:Device Types
> > / Network Device
> >          u8 rss_max_key_size;
> >          le16 rss_max_indirection_table_length;
> >          le32 supported_hash_types;
> > +        le32 supported_tunnel_hash_types;
> >  };
> >  \end{lstlisting}
> > -The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS
> > or VIRTIO_NET_F_HASH_REPORT is set.
> > +The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS,
> > VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
> >  It specifies the maximum supported length of RSS key in bytes.
> > 
> >  The following field, \field{rss_max_indirection_table_length} only exists if
> > VIRTIO_NET_F_RSS is set.
> >  It specifies the maximum number of 16-bit entries in RSS indirection table.
> > 
> >  The next field, \field{supported_hash_types} only exists if the device supports
> > hash calculation, -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is
> > set.
> > +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or
> > VIRTIO_NET_F_HASH_TUNNEL is set.
> > 
> >  Field \field{supported_hash_types} contains the bitmask of supported hash
> > types.
> >  See \ref{sec:Device Types / Network Device / Device Operation / Processing of
> > Incoming Packets / Hash calculation for incoming packets / Supported/enabled
> > hash types} for details of supported hash types.
> > 
> > +The next field, \field{supported_tunnel_hash_types} only exists if the
> > +device supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is
> > set.
> > +
> > +Field \field{supported_tunnel_hash_types} contains the bitmask of supported
> > tunnel hash types.
> > +See \ref{sec:Device Types / Network Device / Device Operation / Processing
> > of Incoming Packets / Hash calculation for incoming packets /
> > Supported/enabled tunnel hash types} for details of supported tunnel hash
> > types.
> > +
> >  \devicenormative{\subsubsection}{Device configuration layout}{Device Types /
> > Network Device / Device configuration layout}
> > 
> >  The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000
> > inclusive, @@ -3236,7 +3250,7 @@ \subsection{Device configuration
> > layout}\label{sec:Device Types / Network Device  negotiated.
> > 
> >  The device MUST set \field{rss_max_key_size} to at least 40, if it offers -
> > VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or
> > VIRTIO_NET_F_HASH_TUNNEL.
> > 
> >  The device MUST set \field{rss_max_indirection_table_length} to at least 128,
> > if it offers  VIRTIO_NET_F_RSS.
> > @@ -3385,7 +3399,8 @@ \subsection{Device Operation}\label{sec:Device
> > Types / Network Device / Device O
> >          le16 csum_offset;
> >          le16 num_buffers;
> >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > +        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated,
> > and the upper 8 bits indicates the
> > +                                 encapsulation type if
> > + VIRTIO_NET_F_HASH_REPORT_TUNNEL negotiated, otherwise reserved)
> >          le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
> > negotiated)  };  \end{lstlisting} @@ -3838,11 +3853,15 @@
> > \subsubsection{Processing of Incoming Packets}\label{sec:Device Types /
> > Network  \begin{itemize}  \item The feature VIRTIO_NET_F_RSS was
> > negotiated. The device uses the hash to determine the receive virtqueue to
> > place incoming packets.
> >  \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
> > reports the hash value and the hash type with the packet.
> > +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device
> > supports inner hash calculation. If additionally
> > +      VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the device reports
> > the encapsulation type as well.
> >  \end{itemize}
> > 
> >  If the feature VIRTIO_NET_F_RSS was negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_rss_config structure
> > as 'Enabled hash types' bitmask.
> > +	If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the
> > device uses \field{hash_tunnel_types} of the
> > +	virtio_net_rss_config structure as 'Enabled hash tunnel types' bitmask.
> >  \item The device uses a key as defined in \field{hash_key_data} and
> > \field{hash_key_length} of the virtio_net_rss_config structure (see
> > \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue
> > / Receive-side scaling (RSS) / Setting RSS parameters}).
> >  \end{itemize}
> > @@ -3850,11 +3869,13 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network  If the feature VIRTIO_NET_F_RSS
> > was not negotiated:
> >  \begin{itemize}
> >  \item The device uses \field{hash_types} of the virtio_net_hash_config
> > structure as 'Enabled hash types' bitmask.
> > +	If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the
> > device uses \field{hash_tunnel_types} of the
> > +	virtio_net_hash_config structure as 'Enabled hash tunnel types'
> > bitmask.
> >  \item The device uses a key as defined in \field{hash_key_data} and
> > \field{hash_key_length} of the virtio_net_hash_config structure (see
> > \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue
> > / Automatic receive steering in multiqueue mode / Hash calculation}).
> >  \end{itemize}
> > 
> > -Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
> > supports only one pair of virtqueues, it MUST support
> > +Note that if the device offers VIRTIO_NET_F_HASH_REPORT or
> > +VIRTIO_NET_F_HASH_TUNNEL, even if it supports only one pair of
> > +virtqueues, it MUST support
> >  at least one of commands of VIRTIO_NET_CTRL_MQ class to configure
> > reported hash parameters:
> >  \begin{itemize}
> >  \item If the device offers VIRTIO_NET_F_RSS, it MUST support
> > VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per @@ -3863,8 +3884,36 @@
> > \subsubsection{Processing of Incoming Packets}\label{sec:Device Types /
> > Network
> >   \ref{sec:Device Types / Network Device / Device Operation / Control
> > Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
> >  \end{itemize}
> > 
> > +\subparagraph{Tunnel/Encapsulated packet} \label{sec:Device Types /
> > +Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Tunnel/Encapsulated packet} A
> > +tunnel packet is encapsulated from the original packet based on the
> > +tunneling protocol (only a single level of encapsulation is currently
> > +supported). The encapsulated packet contains an outer header and an inner
> > header, and the device calculates the hash over either the inner header or the
> > outer header.
> > +
> > +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the
> > +corresponding encapsulation type is set in \field{hash_tunnel_types},
> > +the hash for a specific type of encapsulated packet is calculated over the inner
> > as opposed to outer header.
> To the outer header.
> 
> Here, you want to say that 
> When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's outer header matches one of the supported hash_tunnel_types, the hash of the inner header is calculated.
> 
> > +Supported encapsulation types are listed in \ref{sec:Device Types /
> > +Network Device / Device Operation / Processing of Incoming Packets /
> > +Hash calculation for incoming packets / Supported/enabled hash tunnel
> > types}.
> > +
> > +If both VIRTIO_NET_F_HASH_REPORT_TUNNEL and
> > VIRTIO_NET_F_HASH_REPORT
> > +are negotiated, and hash is calculated for an encapsulated  packet, the
> > +device reports the encapsulation type in addition to the hash value and
> > +hash type, regardless of whether the hash is calculated on the inner header or
> > the outer header.
> > +
> > +If VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_REPORT_TUNNEL
> > are
> > +negotiated but VIRTIO_NET_F_HASH_TUNNEL is not negotiated, the device
> > +calculates the hash over the outer header, and \field{hash_report} reports the
> > hash type and encapsulation type.
> > +
> > +Some encapsulated packet types: \hyperref[intro:GRE]{[GRE]},
> > +\hyperref[intro:VXLAN]{[VXLAN]}, \hyperref[intro:GENEVE]{[GENEVE]},
> > \hyperref[intro:IPIP]{[IPIP]} and \hyperref[intro:NVGRE]{[NVGRE]}.
> > +
> >  \subparagraph{Supported/enabled hash types}  \label{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > calculation for incoming packets / Supported/enabled hash types}
> > +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
> > +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> >  Hash types applicable for IPv4 packets:
> >  \begin{lstlisting}
> >  #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > @@ -3884,6 +3933,32 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> >  \end{lstlisting}
> > 
> Lets please remove the below encoding.
> 
> > +\subparagraph{Supported/enabled tunnel hash types} \label{sec:Device
> > +Types / Network Device / Device Operation / Processing of Incoming
> > +Packets / Hash calculation for incoming packets / Supported/enabled
> > +tunnel hash types} If the feature VIRTIO_NET_F_HASH_TUNNEL is
> > +negotiated, the encapsulation hash type indicates that the hash is calculated
> > over the inner header of the encapsulated packet:
> > +Hash type applicable for inner payload of the gre-encapsulated packet
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 0)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the vxlan-encapsulated packet
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 1)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the geneve-encapsulated
> > +packet \begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 2)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the ip-encapsulated packet
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 3)
> > +\end{lstlisting}
> > +Hash type applicable for inner payload of the nvgre-encapsulated packet
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 4)
> > +\end{lstlisting}
> > +
> >  \subparagraph{IPv4 packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of
> > Incoming Packets / Hash calculation for incoming packets / IPv4 packets}  The
> > device calculates the hash on IPv4 packets according to 'Enabled hash types'
> > bitmask as follows:
> > @@ -3975,17 +4050,47 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network  (see \ref{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > calculation for incoming packets / IPv6 packets without extension header}).
> >  \end{itemize}
> > 
> > +\subparagraph{Inner hash calculation of an encapsulated packet} If the
> > +feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corresponding
> > +encapsulation hash type is set in \field{hash_tunnel_types}, the device
> > +calculates the hash on the inner header of an encapsulated packet (See
> > +\ref{sec:Device Types / Network Device / Device Operation / Processing
> > +of Incoming Packets / Hash calculation for incoming packets /
> > Tunnel/Encapsulated packet}).
> > +
> > +\subparagraph{Security risks between encapsulated packets and RSS}
> > +There may be potential security risks when encapsulated packets using
> s/when encapsulated/when encapsulating/
> 
> > +RSS to select queues for placement. When a user inside a tunnel tries
> > +to control the enqueuing of encapsulated packets, then the user can
> > +flood the device with invaild packets, and the flooded packets may be
> > +hashed into the same queue as packets in other normal tunnels, which causing
> > the queue to overflow.
> > 
> Invalid packets are confusing and the wording of "which causing" is not proper.
> There is some duplicate wording below too.
> 
> I think above and below risk can be summarized in bit simpler manner.
> 
> How about,
> 
> When a specific receive queue is shared to receive packets of multiple tunnels, there is no quality of service for packets of multiple tunnels.

"shared to receive" is not grammatical either :)

If you are talking about a security risk you need to explain
1- what is the threat, what configurations are affected.
2- what is the attack type: DOS, information leak, etc.
3- how to mitigate it

This text touches a bit on 1 and 2 but not in an ordererly way.


> +
> > +This can pose several security risks:
> > +\begin{itemize}
> > +\item  Encapsulated packets in the normal tunnels cannot be enqueued due to
> > queue
> > +       overflow, resulting in a large amount of packet loss.
> > +\item  The delay and retransmission of packets in the normal tunnels are
> > extremely increased.
> This is something very protocol specific and doesn't belong here.

I don't see how it's specific - many protocols have retransmission and
are affected by delays. "extremely increased" sounds unrammatical to me
though.


> > +\item  The user can observe the traffic information and enqueue information
> > of other normal
> > +       tunnels, and conduct targeted DoS attacks.
> Once hash_report_tunnel_types is removed, this second attack is no longer applicable.
> Hence, please remove this too.


?
I don't get how removing a field helps DoS.

> > +\end{\itemize}
> > +
> >  \paragraph{Hash reporting for incoming packets}  \label{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > reporting for incoming packets}
> > -
> > -If VIRTIO_NET_F_HASH_REPORT was negotiated and
> > - the device has calculated the hash for the packet, the device fills
> > \field{hash_report} with the report type of calculated hash -and
> > \field{hash_value} with the value of calculated hash.
> > -
> > -If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the -
> > hash was not calculated, the device sets \field{hash_report} to
> > VIRTIO_NET_HASH_REPORT_NONE.
> > -
> > -Possible values that the device can report in \field{hash_report} are defined
> > below.
> > +If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has
> > +calculated the hash for the packet, the device fills the lower 8 bits
> > +of \field{hash_report} with the report type of calculated hash, and
> > +\field{hash_value} with the value of calculated hash. Also, if
> > +VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the device needs to
> > fill the upper 8 bits of \field{hash_report} with the encapsulation type.
> > +
> > +If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> > +hash was not calculated, the device sets the lower 8 bits of
> > +\field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
> > +
> > +If VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the device fills the
> > +upper
> > +8 bits of \field{hash_report} with the encapsulation type for an
> > +encapsulated packet. Note that the upper 8 bits are all set to 0 for an
> > +unencapsulated packet, regardless of whether
> > VIRTIO_NET_F_HASH_REPORT_TUNNEL is negotiated or not.
> > +
> > +Possible hash types that the device can report in \field{hash_report} are
> > defined below.
> >  They correspond to supported hash types defined in  \ref{sec:Device Types /
> > Network Device / Device Operation / Processing of Incoming Packets / Hash
> > calculation for incoming packets / Supported/enabled hash types}  as follows:
> > @@ -4005,6 +4110,26 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >  \end{lstlisting}
> > 
> > +The upper 8 bits of \field{hash_report} can report the encapsulation
> > +type to the driver if VIRTIO_NET_F_HASH_REPORT_TUNNEL is negotiated.
> > +Possible encapsulation types that the device can report in \field{hash_report}
> > are defined below.
> > +They correspond to supported hash tunnel types defined in
> > +\ref{sec:Device Types / Network Device / Device Operation / Processing
> > +of Incoming Packets / Hash calculation for incoming packets /
> > Supported/enabled hash tunnel types} as follows:
> > +
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_XXX = 1 <<
> > +(VIRTIO_NET_HASH_TUNNEL_REPORT_XXX - 256)
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GRE      256
> > +#define VIRTIO_NET_HASH_TUNNEL_REPORT_VXLAN    257
> > +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GENEVE   258
> > +#define VIRTIO_NET_HASH_TUNNEL_REPORT_IPIP     259
> > +#define VIRTIO_NET_HASH_TUNNEL_REPORT_NVGRE    260
> > +\end{lstlisting}
> > +
> > +They correspond to supported hash types defined in \ref{sec:Device
> > +Types / Network Device / Device Operation / Processing of Incoming Packets /
> > Hash calculation for incoming packets / Supported/enabled hash types}.
> > +
> >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device /
> > Device Operation / Control Virtqueue}
> > 
> >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is @@ -
> > 4364,6 +4489,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types
> > / Network Device / Devi  \begin{lstlisting}  struct virtio_net_hash_config {
> >      le32 hash_types;
> > +    le32 hash_tunnel_types;
> >      le16 reserved[4];
> >      u8 hash_key_length;
> >      u8 hash_key_data[hash_key_length];
> > @@ -4372,7 +4498,11 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi  Field
> > \field{hash_types} contains a bitmask of allowed hash types as  defined in
> > \ref{sec:Device Types / Network Device / Device Operation / Processing of
> > Incoming Packets / Hash calculation for incoming packets / Supported/enabled
> > hash types}.
> > -Initially the device has all hash types disabled and reports only
> > VIRTIO_NET_HASH_REPORT_NONE.
> > +
> > +Field \field{hash_tunnel_types} contains a bitmask of allowed hash
> > +tunnel types as defined in \ref{sec:Device Types / Network Device / Device
> > Operation / Processing of Incoming Packets / Hash calculation for incoming
> > packets / Supported/enabled hash tunnel types}.
> > +
> > +Initially the device has all hash types and hash tunnel types disabled and
> > reports only VIRTIO_NET_HASH_REPORT_NONE.
> > 
> >  Field \field{reserved} MUST contain zeroes. It is defined to make the structure
> > to match the layout of virtio_net_rss_config structure,  defined in
> > \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue
> > / Receive-side scaling (RSS)}.
> > @@ -4390,6 +4520,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi  \begin{lstlisting}  struct virtio_net_rss_config {
> >      le32 hash_types;
> > +    le32 hash_tunnel_types;
> This field is not needed as device config space advertisement for the support is enough.
> 
> If the intent is to enable hashing for the specific tunnel(s), an individual command is better.

new command? I am not sure why we want that. why not handle
tunnels like we do other protocols?

> Regardless, this new field cannot be in the middle of the new structure as it breaks backward compatibility.

absolutely.

> >      le16 indirection_table_mask;
> >      le16 unclassified_queue;
> >      le16 indirection_table[indirection_table_length];
> > @@ -4402,6 +4533,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi  defined in  \ref{sec:Device Types / Network
> > Device / Device Operation / Processing of Incoming Packets / Hash calculation
> > for incoming packets / Supported/enabled hash types}.
> > 
> > +Field \field{hash_tunnel_types} contains a bitmask of allowed hash
> > +tunnel types as defined in \ref{sec:Device Types / Network Device / Device
> > Operation / Processing of Incoming Packets / Hash calculation for incoming
> > packets / Supported/enabled hash tunnel types}.
> > +
> >  Field \field{indirection_table_mask} is a mask to be applied to  the calculated
> > hash to produce an index in the  \field{indirection_table} array.
> > diff --git a/introduction.tex b/introduction.tex index 287c5fc..69b95ae 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex

