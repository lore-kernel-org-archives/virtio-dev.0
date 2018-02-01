Return-Path: virtio-dev-return-3120-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Thu, 1 Feb 2018 11:05:35 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180201030535.xog5zajata4sohph@debian-xvivbkq.sh.intel.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
 <20180130145044.648bbe4e.cohuck@redhat.com>
 <20180130211719-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180130211719-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, kully.dhanoa@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 30, 2018 at 09:40:35PM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 30, 2018 at 02:50:44PM +0100, Cornelia Huck wrote:
> > On Tue, 23 Jan 2018 02:01:07 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > Performance analysis of this is in my kvm forum 2016 presentation.  The
> > > idea is to have a r/w descriptor in a ring structure, replacing the used
> > > and available ring, index and descriptor buffer.
> > > 
> > > This is also easier for devices to implement than the 1.0 layout.
> > > Several more enhancements will be necessary to actually make this
> > > efficient for devices to use.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  content.tex     |  25 ++-
> > >  packed-ring.tex | 678 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 700 insertions(+), 3 deletions(-)
> > >  create mode 100644 packed-ring.tex
> > 
> > (...)
> > 
> > > +\subsubsection{Driver notifications}
> > > +\label{sec:Packed Virtqueues / Driver notifications}
> > > +Whenever not suppressed by Device Event Suppression,
> > > +driver is required to notify the device after
> > > +making changes to the virtqueue.
> > > +
> > > +Some devices benefit from ability to find out the number of
> > > +available descriptors in the ring, and whether to send
> > > +interrupts to drivers without accessing virtqueue in memory:
> > > +for efficiency or as a debugging aid.
> > > +
> > > +To help with these optimizations, driver notifications
> > > +to the device include the following information:
> > > +
> > > +\begin{itemize}
> > > +\item VQ number
> > > +\item Offset (in units of descriptor size) within the ring
> > > +      where the next available descriptor will be written
> > > +\item Wrap Counter referring to the next available
> > > +      descriptor
> > > +\end{itemize}
> > > +
> > > +Note that driver can trigger multiple notifications even without
> > > +making any more changes to the ring. These would then have
> > > +identical \field{Offset} and \field{Wrap Counter} values.
> > 
> > (...)
> > 
> > > +\subsection{Driver Notification Format}\label{sec:Basic
> > > +Facilities of a Virtio Device / Packed Virtqueues / Driver Notification Format}
> > > +
> > > +The following structure is used to notify device of
> > > +device events - i.e. available descriptors:
> > > +
> > > +\begin{lstlisting}
> > > +__le16 vqn;
> > > +__le16 next_off : 15;
> > > +int    next_wrap : 1;
> > > +\end{lstlisting}
> > 
> > (...)
> > 
> > > +\subsubsection{Notifying The Device}\label{sec:Basic Facilities
> > > +of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> > > +
> > > +The actual method of device notification is bus-specific, but generally
> > > +it can be expensive.  So the device MAY suppress such notifications if it
> > > +doesn't need them, using the Driver Event Suppression structure
> > > +as detailed in section \ref{sec:Basic
> > > +Facilities of a Virtio Device / Packed Virtqueues / Event
> > > +Suppression Structure Format}.
> > > +
> > > +The driver has to be careful to expose the new \field{flags}
> > > +value before checking if notifications are suppressed.
> > 
> > This is all I could find regarding notifications, and it leaves me
> > puzzled how notifications are actually supposed to work; especially,
> > where that driver notification structure is supposed to be relayed.
> > 
> > I'm obviously coming from a ccw perspective, but I don't think that pci
> > is all that different (well, hopefully).
> > 
> > Up to now, we notified for a certain virtqueue -- i.e., the device
> > driver notified the device that there is something to process for a
> > certain queue. ccw uses the virtqueue number in a gpr for a hypercall,
> > pci seems to use a write to the config space IIUC. With the packed
> > layout, we have more payload per notification. We should be able to put
> > it in the same gpr than the virtqueue for ccw (if needed, with some
> > compat magic, or with a new hypercall, which would be ugly but doable).
> > Not sure how this is supposed to work with pci.
> > 
> > Has there been any prototyping done to implement this in qemu + KVM?
> > I'm unsure how this will work with ioeventfds, which just trigger.
> 
> The PCI MMIO version would just trigger on access to a specific
> address, ignoring all data in there. PIO would need something
> like a data mask so it can ignore everything except the vq #.
> 
> This is helpful for hardware offloads but I'm open to
> making this PCI specific or deferring until we have
> explicit support for hardware offloads.
> 
> What do you think?
> 

Hi,

I prefer to keep it (at least for PCI) and refine it if
necessary.

Because one of the important goals of packed ring is to
be hardware friendly. Supporting tail pointer is one of
the important things to make it hardware friendly. More
details could be found in Kully's below mail (I've done
some slight reformatting):

----- START -----

why tail pointer is good for hardware implementation:

Assuming no tail pointer:

1. Hardware would have to speculatively read descriptors
   and check their validity by checking that DESC_HW=1.

1.1 Yes Hardware could request a large number of
    descriptors at a time, making the PCIe read
    response transfer (i.e. read descriptors) an
    efficient PCIe transfer.

The problems are as follows:

2. Issue 1: Wasting PCIe bandwidth

2.1 Although the PCIe read responses may be efficient
    transfers, if they contain invalid descriptors
    (DESC_HW=0), we have wasted PCIe bandwidth. This
    can be a problem when trying to maximize the
    performance possible from a design.

3. Issue 2: Wasting Hardware memory resources

3.1 When issuing PCIe read requests for descriptors,
    the hardware must reserve inadvance memory to
    store the descriptors.

3.2 Given PCIe read latencies can be in the order
    of 1us, this memory is reserved for that length
    of time.

3.3 For hardware, 1us is a very long time and for
    FPGAs, memory is not as plentiful/cheap as in
    a PC.

3.4 So reserving memory for descriptors that may
    end up being invalid is a waste. Ultimately,
    this could effect performance if a large number
    of invalid descriptors are being read.

So it is better for hardware to know which queues
(and hence guests) have descriptors available and
fetch those only.

The argument above is biased towards Tx (transfer
of packets from guest to device) but does also apply
for Rx.

Tail pointer resides in the hardware and so the
hardware always knows how many descriptors are
available for each queue (no need to waste PCIe
bandwidth to determine this) and so can fetch
only those valid descriptors.

----- END -----

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

