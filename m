Return-Path: <virtio-dev-return-10371-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87FB79862A3
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Dec 2022 11:32:44 +0000 (UTC)
Date: Sun, 25 Dec 2022 06:32:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221225063158-mutt-send-email-mst@kernel.org>
References: <20221224183010.74297-1-parav@nvidia.com>
 <20221224160852-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813F0DFB11296B8C29BD85DCEF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813F0DFB11296B8C29BD85DCEF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-network: Avoid confusion
 between a card and a device
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Dec 25, 2022 at 12:05:51AM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > 
> > On Sat, Dec 24, 2022 at 08:30:10PM +0200, Parav Pandit wrote:
> > > Ethernet card is a relatively vague term in context of virtio network
> > > device specification. A Ethernet card in the industry has one to
> > > multiple ports, one to multiple PCI functions.
> > 
> > Is this the terminology that IEEE uses?
> 
> I do not know if the IEEE has defined Ethernet _card_ per say.

What terminology does it use? I don't have a spec to hand -
does not it talk about host adapters?

> > 
> > > Historically virtio network device is documented as a Ethernet card.
> > > However it is usually just a single virtual Ethernet device.
> > >
> > > Hence, avoid this confusing term 'card' and align the specification to
> > > adhere to widely used specification term as 'device' used for all
> > > virtio device types.
> > >
> > > This patch is on top of change [1].
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202212/msg00042.html
> > >
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > 
> > This results in a bit of confusion since device has very specific meaning within
> > virtio. I agree "card" sounds archaic.
> > Would "ethernet adapter" work maybe?
> I don't see how virtio net device any different than virtio blk device in context of this definition.
> Anything broken with ethernet device definition?
> Device functional definition is anyway present in the respective section.
> 
> > 
> > > ---
> > >  content.tex        | 6 +++---
> > >  virtio-network.tex | 6 +++---
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/content.tex b/content.tex index 5baef90..37e7943 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> > > Transport Options / Virtio Ov  \hline
> > >  Transitional PCI Device ID  &  Virtio Device    \\
> > >  \hline \hline
> > > -0x1000      &   network card     \\
> > > +0x1000      &   network device     \\
> > >  \hline
> > >  0x1001     &   block device     \\
> > >  \hline
> > > @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> > > Transport Options / Virtio Ov  \hline  \end{tabular}
> > >
> > > -For example, the network card device with the Virtio Device ID 1
> > > +For example, the network device device with the Virtio Device ID 1
> > 
> > 
> > device repeated twice here
> Ah, will fix it in v1.
> 
> > 
> > >  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> > >
> > >  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > > reflect @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device
> > > Types}  \hline \hline
> > >  0          & reserved (invalid) \\
> > >  \hline
> > > -1          &   network card     \\
> > > +1          &   network device     \\
> > >  \hline
> > >  2          &   block device     \\
> > >  \hline
> > > diff --git a/virtio-network.tex b/virtio-network.tex index
> > > 28ed343..b05ce61 100644
> > > --- a/virtio-network.tex
> > > +++ b/virtio-network.tex
> > > @@ -1,6 +1,6 @@
> > >  \section{Network Device}\label{sec:Device Types / Network Device}
> > >
> > > -The virtio network device is a virtual ethernet card, and is the
> > > +The virtio network device is a virtual ethernet device, and is the
> > 
> > "virtio device is an ethernet device" sounds repetetive.
> > 
> Here the definition is clear that it's a virtual ethernet device.
> Similar definition as block, reads fine.
> 
> > 
> > >  most complex of the devices supported so far by virtio. It has
> > > enhanced rapidly and demonstrates clearly how support for new
> > > features are added to an existing device. Empty buffers are @@ -33,7
> > > +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network
> > > Device / Feature bits
> > >
> > >  \begin{description}
> > >  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial
> > checksum.   This
> > > -  ``checksum offload'' is a common feature on modern network cards.
> > > +  ``checksum offload'' is a common feature on modern network device.
> > 
> > ungrammatical
> > 
> Right.
> Will fix it as 
> checksum offload'' is a common feature of modern network device.
> 
> > >
> > >  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial
> > checksum.
> > >
> > > @@ -323,7 +323,7 @@ \subsection{Device
> > > Initialization}\label{sec:Device Types / Network Device / Dev
> > >
> > >  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
> > >    space \field{mac} entry indicates the ``physical'' address of the
> > > -  network card, otherwise the driver would typically generate a
> > > random
> > > +  network device, otherwise the driver would typically generate a
> > > + random
> > >    local MAC address.
> > 
> > here it is unclear whether this refers to virtio device or ethernet device
> >
> Virtio network device because it is in the subsection.
> "virtio" is not repeated every time a network device is referenced.
> Do you suggest to prefix it every time?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

