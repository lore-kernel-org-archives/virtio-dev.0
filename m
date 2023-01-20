Return-Path: <virtio-dev-return-10643-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28A6498667E
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Jan 2023 12:27:44 +0000 (UTC)
Date: Fri, 20 Jan 2023 07:27:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230120072432-mutt-send-email-mst@kernel.org>
References: <20230112212632.763955-1-parav@nvidia.com>
 <20230120124450.7fdacf24.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230120124450.7fdacf24.pasic@linux.ibm.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v4] virtio-net: Avoid confusion between
 a card and a device
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 20, 2023 at 12:44:50PM +0100, Halil Pasic wrote:
> On Thu, 12 Jan 2023 23:26:32 +0200
> Parav Pandit <parav@nvidia.com> wrote:
> 
> > Ethernet card is a relatively vague term in context of virtio network
> > device specification. A Ethernet card in the industry has one to
> > multiple ports, one to multiple PCI functions.
> > 
> > Historically virtio network device is documented as a Ethernet card.
> > However it is usually just a single virtual Ethernet device.
> 
> "Ethernet device" does not seem to be a well established term for what
> we are trying to express here.
> 
> Please compare:
> https://en.wikipedia.org/w/index.php?search=ethernet+device
> to
> https://en.wikipedia.org/w/index.php?search=ethernet+card
> 
> You can also have a look at
> 
> https://www.google.com/search?q=%22ethernet+device%22


Thanks Halil, this sounds convincing.

Generally I'm not sure how is virtio different from a single port
device. Neither am I sure we'll never have a multiport virtio network
device.

> > 
> > Hence, avoid this confusing term 'card' and align the specification
> > to adhere to widely used specification term as 'device' used for all
> > virtio device types.
> 
> I don't think all the places you touch refer to the virtio device --
> some rather are for describing what the nature of the virtio device
> (and its functionality). 
> 
> > 
> > This patch is on top of change [1].
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html
> > 
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
> > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v3->v4:
> > - rebased to new directory name
> > v2->v3:
> > - rebased to new file name
> > v1->v2:
> > - adapt to new file path
> > v0->v1:
> > - removed device word twice
> > - corrected grammar for changing from card to device
> > ---
> >  content.tex                      | 6 +++---
> >  device-types/net/description.tex | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 0118b8a..df5ce16 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
> >  \hline
> >  Transitional PCI Device ID  &  Virtio Device    \\
> >  \hline \hline
> > -0x1000      &   network card     \\
> > +0x1000      &   network device     \\
> 
> This makes sense
> 
> >  \hline
> >  0x1001     &   block device     \\
> >  \hline
> > @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
> >  \hline
> >  \end{tabular}
> >  
> > -For example, the network card device with the Virtio Device ID 1
> > +For example, the network device with the Virtio Device ID 1
> >  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> >  
> >  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> > @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline \hline
> >  0          & reserved (invalid) \\
> >  \hline
> > -1          &   network card     \\
> > +1          &   network device     \\
> 
> This too.
> 
> >  \hline
> >  2          &   block device     \\
> >  \hline
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 2bd82ee..7409f2a 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1,6 +1,6 @@
> >  \section{Network Device}\label{sec:Device Types / Network Device}
> >  
> > -The virtio network device is a virtual ethernet card, and is the
> > +The virtio network device is a virtual ethernet device, and is the
> 
> See, before you change the subject is "virtio network *device*"
> and we describe it as a "virtual ethernet *card*".
> 
> Yes we could replace card with NIC or network interface controller, or
> network adapter, or adapter. But device does not work for me. Sorry.
> 
> >  most complex of the devices supported so far by virtio. It has
> >  enhanced rapidly and demonstrates clearly how support for new
> >  features are added to an existing device. Empty buffers are
> > @@ -33,7 +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  
> >  \begin{description}
> >  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.   This
> > -  ``checksum offload'' is a common feature on modern network cards.
> > +  ``checksum offload'' is a common feature of a modern network device.
> 
> Here again, we are not talking about the virtio device, but the real HW
> stuff upon which the virtio device is modeled.
> 
> >  
> >  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial checksum.
> >  
> > @@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Network Device / Dev
> >  
> >  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
> >    space \field{mac} entry indicates the ``physical'' address of the
> > -  network card, otherwise the driver would typically generate a random
> > +  network device, otherwise the driver would typically generate a random
> >    local MAC address.
> 
> I guess this also explains MAC in general, not scoped down to the
> virtio-net device.
> 
> All this given I'm not in favor of this patch! 
> 
> Yes, I do think we can do better than "card", but in the cases above
> "device" is not the right way to go.
> 
> Regards,
> Halil
> 
> 
> [..]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

