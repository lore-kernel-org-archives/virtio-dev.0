Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v7] virtio-net: support inner header hash
Date: Wed, 18 Jan 2023 23:45:39 +0000
Message-ID: <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230104071401.31746-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>=
=20
> Sent: Wednesday, January 4, 2023 2:14 AM

> If the tunnel is used to encapsulate the packets, the hash calculated usi=
ng the
> outer header of the receive packets is always fixed for the same flow pac=
kets,
> i.e. they will be steered to the same receive queue.

> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packets.
> +
A device may not support all 3 at the same time.
Please remove mentioning tunneling protocols description from here.
Just say device support inner header hash ...

An additional bit map somewhere else should say supported hash over differe=
nt tunneling types.

[...]

> +The device calculates the hash on the inner IPv4 packet of an
> +encapsulated packet according to 'Enabled hash types' bitmask as follows=
:
> +\begin{itemize}
> +  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the encapsulated packet
> has an inner
> +=09TCPv4 header, the hash is calculated over the following fields:
> +        \begin{itemsize}
> +          \item inner Source IP address
> +          \item inner Destination IP address
> +          \item inner Source TCP port
> +          \item inner Destination TCP port
> +        \end{itemsize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set and the encapsulated
> packet has an
> +=09inner UDPv4 header, the hash is calculated over the following fields:
> +        \begin{itemsize}
> +          \item inner Source IP address
> +          \item inner Destination IP address
> +          \item inner Source UDP port
> +          \item inner Destination UDP port
> +        \end{itemize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set, the hash is calculated=
 over
> the
> +=09following fields:
> +        \begin{itemsize}
> +          \item inner Source IP address
> +          \item inner Destination IP address
> +        \end{itemsize}
> +  \item Else the device does not calculate the hash \end{itemize}
> +
> +The device calculates the hash on the inner IPv6 packet without an
> +extension header of an encapsulated packet according to 'Enabled hash ty=
pes'
> bitmask as follows:
> +\begin{itemize}
> +  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the encapsulated packet
> has an inner
> +=09TCPv6 header, the hash is calculated over the following fields:
> +        \begin{itemsize}
> +          \item inner Source IPv6 address
> +          \item inner Destination IPv6 address
> +          \item inner Source TCP port
> +          \item inner Destination TCP port
> +        \end{itemsize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set and the encapsulated
> packet has an
> +=09inner UDPv6 header, the hash is calculated over the following fields:
> +        \begin{itemsize}
> +          \item inner Source IPv6 address
> +          \item inner Destination IPv6 address
> +          \item inner Source UDP port
> +          \item inner Destination UDP port
> +        \end{itemize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set, the hash is calculated=
 over
> the
> +=09following fields:
> +        \begin{itemsize}
> +          \item inner Source IPv6 address
> +          \item inner Destination IPv6 address
> +        \end{itemsize}
> +  \item Else the device does not calculate the hash \end{itemize}
> +
> +The device calculates the hash on the inner IPv6 packet with an
> +extension header of an encapsulated packet according to 'Enabled hash ty=
pes'
> bitmask as follows:
> +\begin{itemsize}
> +  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the encapsulated packe=
t
> has an inner
> +=09TCPv6 header, the hash is calculated over the following fields:
> +        \begin{itemize}
> +          \item Home address from the home address option in the inner I=
Pv6
> destination
> +              options header. If the inner extension header is not prese=
nt, use the
> +              inner Source IPv6 address.
> +          \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from
> the
> +              associated inner extension header. If the inner extension =
header is not
> +              present, use the inner Destination IPv6 address.
> +          \item inner Source TCP port
> +          \item inner Destination TCP port
> +        \end{itemize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set and the encapsulated
> packet has an inner
> +=09UDPv6 header, the hash is calculated over the following fields:
> +        \begin{itemsize}
> +          \item Home address from the home address option in the inner I=
Pv6
> destination
> +              options header. If the inner extension header is not prese=
nt, use the
> +              inner Source IPv6 address.
> +          \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from
> the
> +              associated inner extension header. If the inner extension =
header is not
> +              present, use the inner Destination IPv6 address.
> +          \item inner Source UDP port
> +          \item inner Destination UDP port
> +        \end{itemize}
> +  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set, the hash is calculate=
d
> over the
> +=09following fields:
> +        \begin{itemsize}
> +          \item Home address from the home address option in the inner I=
Pv6
> destination
> +              options header. If the inner extension header is not prese=
nt, use the
> +              inner Source IPv6 address.
> +          \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from
> the
> +              associated inner extension header. If the inner extension =
header is not
> +              present, use the inner Destination IPv6 address.
> +        \end{itemize}
> +  \item Else skip the inner IPv6 extension header and calculate the inne=
r
> header hash as
> +=09defined for an encapsulated packet whose inner payload is an IPv6
> packet without
> +=09an extension header.
> +\end{itemsize}
> +

With the inclusion of tunnel outer header, it doesn't need to redefine the =
hashing for inner packets which is exactly same without the tunnel.
hash tunnel capability only indicates that hashing is done on the inner pac=
kets as_before.

