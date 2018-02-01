Return-Path: virtio-return-2857-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Feb 2018 11:11:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201111128.13aead66.cohuck@redhat.com>
In-Reply-To: <20180201030535.xog5zajata4sohph@debian-xvivbkq.sh.intel.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-8-git-send-email-mst@redhat.com>
	<20180130145044.648bbe4e.cohuck@redhat.com>
	<20180130211719-mutt-send-email-mst@kernel.org>
	<20180201030535.xog5zajata4sohph@debian-xvivbkq.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, kully.dhanoa@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 1 Feb 2018 11:05:35 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> On Tue, Jan 30, 2018 at 09:40:35PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Jan 30, 2018 at 02:50:44PM +0100, Cornelia Huck wrote:  
> > > On Tue, 23 Jan 2018 02:01:07 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > > +\subsubsection{Driver notifications}
> > > > +\label{sec:Packed Virtqueues / Driver notifications}
> > > > +Whenever not suppressed by Device Event Suppression,
> > > > +driver is required to notify the device after
> > > > +making changes to the virtqueue.
> > > > +
> > > > +Some devices benefit from ability to find out the number of
> > > > +available descriptors in the ring, and whether to send
> > > > +interrupts to drivers without accessing virtqueue in memory:
> > > > +for efficiency or as a debugging aid.
> > > > +
> > > > +To help with these optimizations, driver notifications
> > > > +to the device include the following information:
> > > > +
> > > > +\begin{itemize}
> > > > +\item VQ number
> > > > +\item Offset (in units of descriptor size) within the ring
> > > > +      where the next available descriptor will be written
> > > > +\item Wrap Counter referring to the next available
> > > > +      descriptor
> > > > +\end{itemize}
> > > > +
> > > > +Note that driver can trigger multiple notifications even without
> > > > +making any more changes to the ring. These would then have
> > > > +identical \field{Offset} and \field{Wrap Counter} values.  
> > > 
> > > (...)
> > >   
> > > > +\subsection{Driver Notification Format}\label{sec:Basic
> > > > +Facilities of a Virtio Device / Packed Virtqueues / Driver Notification Format}
> > > > +
> > > > +The following structure is used to notify device of
> > > > +device events - i.e. available descriptors:
> > > > +
> > > > +\begin{lstlisting}
> > > > +__le16 vqn;
> > > > +__le16 next_off : 15;
> > > > +int    next_wrap : 1;
> > > > +\end{lstlisting}  
> > > 
> > > (...)
> > >   
> > > > +\subsubsection{Notifying The Device}\label{sec:Basic Facilities
> > > > +of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> > > > +
> > > > +The actual method of device notification is bus-specific, but generally
> > > > +it can be expensive.  So the device MAY suppress such notifications if it
> > > > +doesn't need them, using the Driver Event Suppression structure
> > > > +as detailed in section \ref{sec:Basic
> > > > +Facilities of a Virtio Device / Packed Virtqueues / Event
> > > > +Suppression Structure Format}.
> > > > +
> > > > +The driver has to be careful to expose the new \field{flags}
> > > > +value before checking if notifications are suppressed.  
> > > 
> > > This is all I could find regarding notifications, and it leaves me
> > > puzzled how notifications are actually supposed to work; especially,
> > > where that driver notification structure is supposed to be relayed.
> > > 
> > > I'm obviously coming from a ccw perspective, but I don't think that pci
> > > is all that different (well, hopefully).
> > > 
> > > Up to now, we notified for a certain virtqueue -- i.e., the device
> > > driver notified the device that there is something to process for a
> > > certain queue. ccw uses the virtqueue number in a gpr for a hypercall,
> > > pci seems to use a write to the config space IIUC. With the packed
> > > layout, we have more payload per notification. We should be able to put
> > > it in the same gpr than the virtqueue for ccw (if needed, with some
> > > compat magic, or with a new hypercall, which would be ugly but doable).
> > > Not sure how this is supposed to work with pci.
> > > 
> > > Has there been any prototyping done to implement this in qemu + KVM?
> > > I'm unsure how this will work with ioeventfds, which just trigger.  
> > 
> > The PCI MMIO version would just trigger on access to a specific
> > address, ignoring all data in there. PIO would need something
> > like a data mask so it can ignore everything except the vq #.
> > 
> > This is helpful for hardware offloads but I'm open to
> > making this PCI specific or deferring until we have
> > explicit support for hardware offloads.
> > 
> > What do you think?
> >   
> 
> Hi,
> 
> I prefer to keep it (at least for PCI) and refine it if
> necessary.
> 
> Because one of the important goals of packed ring is to
> be hardware friendly. Supporting tail pointer is one of
> the important things to make it hardware friendly. More
> details could be found in Kully's below mail (I've done
> some slight reformatting):
> 
> ----- START -----

<thanks for the explanation>

> ----- END -----

So, my takeaway is here:

- Having this information (or a variant of it) available on
  notification is useful.
- The specifics on how to convey the info are still a bit unsettled.

I think this should be optionally available to any transport (i.e. not
pci-specific). What about the following wording:

"Driver notifications to the device include the virtqueue number. To
help with these optimizations, they also may include the following
information: ..."

(With some MUST/MAY wording in the normative sections, I guess.)

Also, I think the notification structure should not include any
endianness requirements. For ccw, we notify via a hypercall with the
payload in the GPRs, which are big endian. I would like to avoid
conversions in that case. Maybe make the details of how the information
is included entirely transport-specific?

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

