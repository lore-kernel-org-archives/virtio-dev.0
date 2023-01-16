Return-Path: <virtio-dev-return-10629-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95B299861B1
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Jan 2023 20:33:50 +0000 (UTC)
Date: Mon, 16 Jan 2023 15:33:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230116152504-mutt-send-email-mst@kernel.org>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 16, 2023 at 07:42:01PM +0000, Parav Pandit wrote:
> Hi Alvaro,
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Alvaro Karsz
> > 
> > This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
> > clarifying/fixing existing coalescing concepts.
> > 
> While its visible in the patch itself, what is being done, 
> its important to mention the problem statement/motivation for the feature at start of the commit log as first step.
> 
> So, can you please describe the motivation, what problem does the new command solve?
> It is likely that control entity which want to set different coalescing parameters likely wants to more than just two values.
> This is something already supported today.

Interesting. Parav can you give some examples?

> > The new feature adds 4 new commands to VIRTIO_NET_CTRL_NOTF_COAL
> > class:
> > 	- VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET - coalescing
> > parameters
> > 	  to use when the packet rate is equal or lower then the low
> > 	  threshold for TX.
> >         - VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET - coalescing parameters
> >           to use when the packet rate is equal or lower then the low
> >           threshold for RX.
> >         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET - coalescing parameters
> >           to use when the packet rate is equal or higher then the high
> >           threshold for TX.
> >         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET - coalescing parameters
> >           to use when the packet rate is equal or higher then the high
> >           threshold for RX.
> > 
> > On top of the new feature, this patch:
> > 	- Unifies the virtio_net_ctrl_coal structs, since the one for tx
> > 	  and the one for rx are identical.
> > 	- Clarifies that the coalescing commands are best-effort.
> > 	- Specifies coalescing in respect to delivering interrupts when config
> >           changes.
> > 
> They are best to be handled a pre-patch to this one.
> Please split them so that spec improvement work can progress while new features are under review.

Yea it's not a bad idea. I figured it out but 

> > 
> > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports
> > notifications coalescing low rate and high rate sets.
> > +
> Even though historically, many feature bits exists, adding more feature bits is not scalable.

I disagree here. We have unlimited feature bits and I see no problem
with their scalability. Devices (such as SIOV as opposed to SRIOV) which
have very limited memory need to use the proposed vq transport
that intel's working on, pci transport is wasting too much memory
anyway. I hope we are not going to repeat this discussion for each and
every new feature :)

> It is also limits to enable such functionality at very early stage in the device configuration.

Not really, it just handles compatibility and enables the commands.

> So, if at all this proceeds, we want the new admin q to discover and negotiate the new features.
> (Instead of features bits).

Sounds like a new transport. I wouldn't make it gate this proposal.

> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications
> > coalescing.
> > 
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -3142,6 +3144,7 @@ \subsubsection{Feature bit
> > requirements}\label{sec:Device Types / Network Device
> > \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires
> > VIRTIO_NET_F_NOTF_COAL.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> > VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> > @@ -4493,43 +4496,62 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi  If the
> > VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can  send control
> > commands for dynamically changing the coalescing parameters.
> > 
> > +Note: In general, these commands are best-effort: A device could send a
> > notification even if it is not supposed to.
> > +
> >  \begin{lstlisting}
> > -struct virtio_net_ctrl_coal_rx {
> > -    le32 rx_max_packets;
> > -    le32 rx_usecs;
> > +struct virtio_net_ctrl_coal {
> > +    le32 max_packets;
> > +    le32 usecs;
> >  };
> > 
> Please put this change in a pre-patch along with additional rework of below.
> 
> 
> > -struct virtio_net_ctrl_coal_tx {
> > -    le32 tx_max_packets;
> > -    le32 tx_usecs;
> > +struct virtio_net_ctrl_coal_threshold {
> > +    le32 pkt_rate;
> > +    struct virtio_net_ctrl_coal params;
> >  };
> > 
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if
> > + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> > + VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if
> > + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> > + VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if
> > + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> > + VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if
> > + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> >  \end{lstlisting}
> > 
> > -Coalescing parameters:
> > +TX Coalescing parameters:
> > +\begin{itemize}
> > +\item \field{usecs}: Maximum number of usecs to delay a TX notification.
> > +\item \field{max_packets}: Maximum number of packets to send before a TX
> > notification.
> > +\end{itemize}
> > +
> > +RX Coalescing parameters:
> > +\begin{itemize}
> > +\item \field{usecs}: Maximum number of usecs to delay a RX notification.
> > +\item \field{max_packets}: Maximum number of packets to receive before a
> > RX notification.
> > +\end{itemize}
> > +
> > +General Coalescing parameters:
> >  \begin{itemize}
> > -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> > -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> > -\item \field{rx_max_packets}: Maximum number of packets to receive before
> > a RX notification.
> > -\item \field{tx_max_packets}: Maximum number of packets to send before a
> > TX notification.
> > +\item \field{pkt_rate}: Threshold for low/high packet rate coalescing
> > parameters, in units of packets per second.
> >  \end{itemize}
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

