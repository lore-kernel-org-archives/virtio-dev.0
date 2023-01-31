Return-Path: <hengqi@linux.alibaba.com>
Date: Tue, 31 Jan 2023 13:57:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH v7] virtio-net: support
 inner header hash
Message-ID: <20230131055710.GC34480@h68b04307.sqa.eu95>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 18, 2023 at 11:45:39PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> 
> > Sent: Wednesday, January 4, 2023 2:14 AM
> 
> > If the tunnel is used to encapsulate the packets, the hash calculated using the
> > outer header of the receive packets is always fixed for the same flow packets,
> > i.e. they will be steered to the same receive queue.
> 
> > +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> > +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets.
> > +
> A device may not support all 3 at the same time.
> Please remove mentioning tunneling protocols description from here.
> Just say device support inner header hash ...

Sorry for the late reply due to vacation.

Good idea, Michael suggested doing the same. But we also discussed this issue:
Early, we used a feature bit to force devices to support GRE and VXLAN (see
https://lists.oasis-open.org/archives/virtio-dev/202211/msg00183.html ).
Later Jason suggested to use VIRTIO_NET_F_HASH_TUNNEL instead of VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER (see
https://lists.oasis-open.org/archives/virtio-dev/202212/msg00014.html ). Now Michael proposes to remove this list (see
https://lists.oasis-open.org/archives/virtio-dev/202301/msg00079.html ), because the migration is based on the feature
bit and hash types to determine whether the live migration is successful.
> 
> An additional bit map somewhere else should say supported hash over different tunneling types.
> 

Yes, we use \field{supported_hash_types} to declare supported hash types.

> [...]
> 
> > +The device calculates the hash on the inner IPv4 packet of an
> > +encapsulated packet according to 'Enabled hash types' bitmask as follows:
> > +\begin{itemize}
> > +  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the encapsulated packet
> > has an inner
> > +	TCPv4 header, the hash is calculated over the following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IP address
> > +          \item inner Destination IP address
> > +          \item inner Source TCP port
> > +          \item inner Destination TCP port
> > +        \end{itemsize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set and the encapsulated
> > packet has an
> > +	inner UDPv4 header, the hash is calculated over the following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IP address
> > +          \item inner Destination IP address
> > +          \item inner Source UDP port
> > +          \item inner Destination UDP port
> > +        \end{itemize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set, the hash is calculated over
> > the
> > +	following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IP address
> > +          \item inner Destination IP address
> > +        \end{itemsize}
> > +  \item Else the device does not calculate the hash \end{itemize}
> > +
> > +The device calculates the hash on the inner IPv6 packet without an
> > +extension header of an encapsulated packet according to 'Enabled hash types'
> > bitmask as follows:
> > +\begin{itemize}
> > +  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the encapsulated packet
> > has an inner
> > +	TCPv6 header, the hash is calculated over the following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IPv6 address
> > +          \item inner Destination IPv6 address
> > +          \item inner Source TCP port
> > +          \item inner Destination TCP port
> > +        \end{itemsize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set and the encapsulated
> > packet has an
> > +	inner UDPv6 header, the hash is calculated over the following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IPv6 address
> > +          \item inner Destination IPv6 address
> > +          \item inner Source UDP port
> > +          \item inner Destination UDP port
> > +        \end{itemize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set, the hash is calculated over
> > the
> > +	following fields:
> > +        \begin{itemsize}
> > +          \item inner Source IPv6 address
> > +          \item inner Destination IPv6 address
> > +        \end{itemsize}
> > +  \item Else the device does not calculate the hash \end{itemize}
> > +
> > +The device calculates the hash on the inner IPv6 packet with an
> > +extension header of an encapsulated packet according to 'Enabled hash types'
> > bitmask as follows:
> > +\begin{itemsize}
> > +  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the encapsulated packet
> > has an inner
> > +	TCPv6 header, the hash is calculated over the following fields:
> > +        \begin{itemize}
> > +          \item Home address from the home address option in the inner IPv6
> > destination
> > +              options header. If the inner extension header is not present, use the
> > +              inner Source IPv6 address.
> > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from
> > the
> > +              associated inner extension header. If the inner extension header is not
> > +              present, use the inner Destination IPv6 address.
> > +          \item inner Source TCP port
> > +          \item inner Destination TCP port
> > +        \end{itemize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set and the encapsulated
> > packet has an inner
> > +	UDPv6 header, the hash is calculated over the following fields:
> > +        \begin{itemsize}
> > +          \item Home address from the home address option in the inner IPv6
> > destination
> > +              options header. If the inner extension header is not present, use the
> > +              inner Source IPv6 address.
> > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from
> > the
> > +              associated inner extension header. If the inner extension header is not
> > +              present, use the inner Destination IPv6 address.
> > +          \item inner Source UDP port
> > +          \item inner Destination UDP port
> > +        \end{itemize}
> > +  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set, the hash is calculated
> > over the
> > +	following fields:
> > +        \begin{itemsize}
> > +          \item Home address from the home address option in the inner IPv6
> > destination
> > +              options header. If the inner extension header is not present, use the
> > +              inner Source IPv6 address.
> > +          \item IPv6 address that is contained in the Routing-Header-Type-2 from
> > the
> > +              associated inner extension header. If the inner extension header is not
> > +              present, use the inner Destination IPv6 address.
> > +        \end{itemize}
> > +  \item Else skip the inner IPv6 extension header and calculate the inner
> > header hash as
> > +	defined for an encapsulated packet whose inner payload is an IPv6
> > packet without
> > +	an extension header.
> > +\end{itemsize}
> > +
> 
> With the inclusion of tunnel outer header, it doesn't need to redefine the hashing for inner packets which is exactly same without the tunnel.
> hash tunnel capability only indicates that hashing is done on the inner packets as_before.
> 

This seems like a trade-off, and I can get rid of this if the simple statement
"computing the hash for the inner header of the tunnel packet is the same as without tunnel"
is also clear to the reader.
What do you think? Cc Jason and Michael.

Thanks.

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

