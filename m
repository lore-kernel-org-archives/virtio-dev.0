Return-Path: virtio-return-2872-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 6 Feb 2018 02:05:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180206020102-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-1-git-send-email-mst@redhat.com>
 <db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
Subject: Re: [virtio] [PATCH v7 01/11] content: move 1.0 queue format out to
 a separate section
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 05, 2018 at 11:54:52PM +0100, Halil Pasic wrote:
> 
> 
> On 01/23/2018 01:01 AM, Michael S. Tsirkin wrote:
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index c7ef7fd..4483a4b 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -230,7 +230,30 @@ result.
> >  The mechanism for bulk data transport on virtio devices is
> >  pretentiously called a virtqueue. Each device can have zero or more
> >  virtqueues\footnote{For example, the simplest network device has one virtqueue for
> > -transmit and one for receive.}.  Each queue has a 16-bit queue size
> > +transmit and one for receive.}.
> > +
> > +Driver makes requests available to device by adding
> > +an available buffer to the queue - i.e. adding a buffer
> > +describing the request to a virtqueue, and optionally triggering
> > +a driver event - i.e. sending a notification to the device.
> > +
> > +Device executes the requests and - when complete - adds
> > +a used buffer to the queue - i.e. lets the driver
> > +know by marking the buffer as used. Device can then trigger
> > +a device event - i.e. send an interrupt to the driver.
> > +
> 
> Here I seem to recognize my suggestion about describing the
> relationship between virtqueue buffers and requests. But none
> of the terms your are using are defined yet, so assuming linear
> reading, this may not be the best place to establish that relationship.
> 
> Furthermore I think the usage of the term 'buffer' got even messier
> that in v1.0. I will elaborate on that later.
> 

Sounds like a subject for a rework unrelated to this specific
project?

> > +For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
> > +
> > +\section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
> > +The split virtqueue format is the original format used by legacy
> > +virtio devices.
> 
> All v1.0 devices and drivers are using split too not only legacy (aka pre v1.0). 

Yes but there's no versioning in virtio. IOW there is not need to
introduce a concept of "1.0 device". Devices just either do or
do not support the packed format.

> >  The split virtqueue format separates the
> > +virtqueue into several parts, where each part is write-able by
> > +either the driver or the device, but not both. Multiple
> > +locations need to be updated when making a buffer available
> > +and when marking it as used.
> > +
> 
> If we assume 3 parts (available ring, used ring and descriptor table),
> then the two last sentences are contradictory: as one of three would have
> to be updated by both the device and the driver. Or did I misunderstand
> something?

I don't see a contradiction.
Split rings only have RO and WO parts. There are 

> I think, the purpose of this paragraph is to distinguish the split
> form the packed. We probably don't need these additions to understand
> 'split'. I would rather see a discussion on the two formats in the
> common (2.4) virtqueue section.
> 
> [..]
> 
> Regards,
> Halil

This doesn't really scale - if we have a 3rd format we do not
want to mix them all in a common section.
So description of split format goes into split section, and so on.
I'd be fine to add a format comparison section if that will
make things easier.



---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

