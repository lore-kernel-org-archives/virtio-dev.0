Return-Path: <virtio-comment-return-3892-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 20 Jan 2023 12:44:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230120124450.7fdacf24.pasic@linux.ibm.com>
In-Reply-To: <20230112212632.763955-1-parav@nvidia.com>
References: <20230112212632.763955-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v4] virtio-net: Avoid confusion between
 a card and a device
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Jan 2023 23:26:32 +0200
Parav Pandit <parav@nvidia.com> wrote:

> Ethernet card is a relatively vague term in context of virtio network
> device specification. A Ethernet card in the industry has one to
> multiple ports, one to multiple PCI functions.
>=20
> Historically virtio network device is documented as a Ethernet card.
> However it is usually just a single virtual Ethernet device.

"Ethernet device" does not seem to be a well established term for what
we are trying to express here.

Please compare:
https://en.wikipedia.org/w/index.php?search=3Dethernet+device
to
https://en.wikipedia.org/w/index.php?search=3Dethernet+card

You can also have a look at

https://www.google.com/search?q=3D%22ethernet+device%22

>=20
> Hence, avoid this confusing term 'card' and align the specification
> to adhere to widely used specification term as 'device' used for all
> virtio device types.

I don't think all the places you touch refer to the virtio device --
some rather are for describing what the nature of the virtio device
(and its functionality).=20

>=20
> This patch is on top of change [1].
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v3->v4:
> - rebased to new directory name
> v2->v3:
> - rebased to new file name
> v1->v2:
> - adapt to new file path
> v0->v1:
> - removed device word twice
> - corrected grammar for changing from card to device
> ---
>  content.tex                      | 6 +++---
>  device-types/net/description.tex | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index 0118b8a..df5ce16 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tr=
ansport Options / Virtio Ov
>  \hline
>  Transitional PCI Device ID  &  Virtio Device    \\
>  \hline \hline
> -0x1000      &   network card     \\
> +0x1000      &   network device     \\

This makes sense

>  \hline
>  0x1001     &   block device     \\
>  \hline
> @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tr=
ansport Options / Virtio Ov
>  \hline
>  \end{tabular}
> =20
> -For example, the network card device with the Virtio Device ID 1
> +For example, the network device with the Virtio Device ID 1
>  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> =20
>  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline \hline
>  0          & reserved (invalid) \\
>  \hline
> -1          &   network card     \\
> +1          &   network device     \\

This too.

>  \hline
>  2          &   block device     \\
>  \hline
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 2bd82ee..7409f2a 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1,6 +1,6 @@
>  \section{Network Device}\label{sec:Device Types / Network Device}
> =20
> -The virtio network device is a virtual ethernet card, and is the
> +The virtio network device is a virtual ethernet device, and is the

See, before you change the subject is "virtio network *device*"
and we describe it as a "virtual ethernet *card*".

Yes we could replace card with NIC or network interface controller, or
network adapter, or adapter. But device does not work for me. Sorry.

>  most complex of the devices supported so far by virtio. It has
>  enhanced rapidly and demonstrates clearly how support for new
>  features are added to an existing device. Empty buffers are
> @@ -33,7 +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Netw=
ork Device / Feature bits
> =20
>  \begin{description}
>  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksu=
m.   This
> -  ``checksum offload'' is a common feature on modern network cards.
> +  ``checksum offload'' is a common feature of a modern network device.

Here again, we are not talking about the virtio device, but the real HW
stuff upon which the virtio device is modeled.

> =20
>  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial c=
hecksum.
> =20
> @@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Network Device / Dev
> =20
>  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
>    space \field{mac} entry indicates the ``physical'' address of the
> -  network card, otherwise the driver would typically generate a random
> +  network device, otherwise the driver would typically generate a random
>    local MAC address.

I guess this also explains MAC in general, not scoped down to the
virtio-net device.

All this given I'm not in favor of this patch!=20

Yes, I do think we can do better than "card", but in the cases above
"device" is not the right way to go.

Regards,
Halil


[..]

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

