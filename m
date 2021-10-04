Return-Path: <mst@redhat.com>
Date: Mon, 4 Oct 2021 08:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004083455-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ee912e45.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Sent too early. So here's what I propose. Could you pls take a look
> > and if you like this, post a ccw section?
> 
> We have not talked about the mmio transport so far, but I guess it
> should be fine as legacy and standard are separated.
> 
> > There's also an attempt to prevent fallback from modern to legacy
> > here since if driver does fallback then failing FEATURES_OK can't work
> > properly.
> > That's a separate issue, will be a separate patch when I post
> > this for consideration by the TC.
> >
> >
> > diff --git a/content.tex b/content.tex
> > index 1398390..06271f4 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -140,10 +140,13 @@ \subsection{Legacy Interface: A Note on Feature
> >  Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
> >  Bits / Legacy Interface: A Note on Feature Bits}
> >  
> > -Transitional Drivers MUST detect Legacy Devices by detecting that
> > -the feature bit VIRTIO_F_VERSION_1 is not offered.
> > -Transitional devices MUST detect Legacy drivers by detecting that
> > -VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
> > +Transitional drivers MAY support operating legacy devices.
> > +Transitional devices MAY support operation by legacy drivers.
> 
> Why 'MAY'? Isn't the whole point of transitional that it can deal with
> both?

I guess. OK we can make it MUST.

> > +
> > +Transitional drivers MUST detect legacy devices in a way that is
> > +transport specific.
> > +Transitional devices MUST detect legacy drivers in a way that
> > +is transport specific.
> >  
> >  In this case device is used through the legacy interface.
> >  
> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >  Specification text within these sections generally does not apply
> >  to non-transitional devices.
> >  
> > +\begin{note}
> > +The device offers different features when used through
> > +the legacy interface and when operated in accordance with this
> > +specification.
> > +\end{note}
> > +
> > +Transitional drivers MUST use Devices only through the legacy interface
> 
> s/Devices only through the legacy interface/devices through the legacy
> interface only/
> 
> ?

Both versions are actually confused, since how do you
find out that device does not offer VIRTIO_F_VERSION_1?

I think what this should really say is

Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
the legacy interface.


Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
through the legacy interface if offered?

> > +if the feature bit VIRTIO_F_VERSION_1 is not offered.
> > +Transitional devices MUST NOT offer VIRTIO_F_VERSION_1 when used through
> > +the legacy interface.
> > +
> > +When the driver uses a device through the legacy interface, then it
> > +MUST only accept the features the device offered through the
> > +legacy interface.
> > +
> > +When used through the legacy interface, the device SHOULD
> > +validate that the driver only accepted the features it
> > +offered through the legacy interface.
> > +
> > +When operating a transitional device, a transitional driver
> > +SHOULD NOT use the device through the legacy interface if
> > +operation through the modern interface has failed.
> > +In particular, a transitional driver
> > +SHOULD NOT fall back to using the device through the
> > +legacy interface if feature negotiation failed
> > +(since that would defeat the purpose of the FEATURES_OK bit).
> > +
> >  \section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> >  / Notifications}
> >  
> > @@ -1003,6 +1033,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >  
> >  The driver MUST NOT write a 0 to \field{queue_enable}.
> >  
> > +\paragraph}{Legacy Interface: Common configuration structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interface: Common configuration structure layout}
> > +Transitional drivers SHOULD detect legacy devices by detecting
> > +that the device has the Transitional PCI Device ID in
> > +the range 0x1000 to 0x103f and lacks a VIRTIO_PCI_CAP_COMMON_CFG
> > +capability specifying the location of a common configuration structure.
> > +
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >  
> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> > @@ -1288,6 +1324,10 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
> >  Transitional devices MUST present part of configuration
> >  registers in a legacy configuration structure in BAR0 in the first I/O
> >  region of the PCI device, as documented below.
> > +
> > +Transitional devices SHOULD detect legacy drivers by detecting
> > +access to the legacy configuration structure.
> > +
> >  When using the legacy interface, transitional drivers
> >  MUST use the legacy configuration structure in BAR0 in the first
> >  I/O region of the PCI device, as documented below.
> 
> Generally, looks good to me.

Do we want to also add explanation that features can be
changed until FEATURES_OK?

