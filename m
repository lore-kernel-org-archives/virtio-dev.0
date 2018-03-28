Return-Path: virtio-return-3031-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 28 Mar 2018 20:21:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328200739-mutt-send-email-mst@kernel.org>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
 <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
Subject: Re: [virtio] [PATCH v12] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 28, 2018 at 06:56:13PM +0200, Halil Pasic wrote:
> 
> 
> On 03/27/2018 06:37 PM, Michael S. Tsirkin wrote:
> > Some devices benefit from ability to find out the number of available
> > descriptors in the ring: for efficiency or as a debugging aid.
> > 
> > To help with these optimizations, add a new feature:
> > VIRTIO_F_NOTIFICATION_DATA. When negotiated, driver notifications to the
> > device include this extra information.
> 
> I'm pondering about symmetry and about the nature of these
> optimizations. By symmetry I mean this only works driver->device.
> Why do we want this the one but not the other way around?

Because
- memory is already closer to CPU than to devices
- there is no way to pass extra data with an interrupt


> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > v11 -> v12
> > 	add missing 'the' article
> > 	drop duplicate text sections
> > 	use separate listing files for BE and LE, making
> > 	format explicit.
> > 
> > v10 -> v11:
> >         drop mention of interrupts: current proposal does not include
> >         this interrupt related information
> >         drop unrelated introduction sections
> > 
> > 
> > 
> >  content.tex        | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  notifications-be.c |   5 +++
> >  notifications-le.c |   5 +++
> >  3 files changed, 113 insertions(+), 6 deletions(-)
> >  create mode 100644 notifications-be.c
> >  create mode 100644 notifications-le.c
> > 
> > diff --git a/content.tex b/content.tex
> > index 7a92cb1..ae5fa4c 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -283,9 +283,49 @@ Packed Virtqueues}).
> >  Every driver and device supports either the Packed or the Split
> >  Virtqueue format, or both.
> > 
> > +\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
> 
> Don't we call the same 'device notification' in 2.5.12.4 Notifying The Device.

Oh right.

> The wordings used to denote the different notifications seems to be
> chaotic and maybe somewhat confusing overall.
> 
> Let me provide some examples:
> For *virtqueue notification sent by the driver to the device* we use:
>    * 'driver notifications' (here)

We should fix this I think.

>    * 'device notification' in 2.5.12.4 Notifying The Device)
>    * 'virtqueue notification' (2.5.9 Virtqueue Notification Suppression)

Let's change these to 'virtqueue device notifications'?
It's a separate issue though, not introduced by this patch.

>    * 'guest -> host notification' (4.3.3.2 Guest->Host Notification)

That's a transport thing specific to virtio over MMIO.

> The notifications *sent by the device to the driver (virtqueue or
> configuration change)* are often referred to as *interrupts* but occasionally
> also as notifications (e.g. 'host->guest notification').
> 
> 
> 
> > +The driver is sometimes required to notify the device after
> > +making changes to the virtqueue.
> > +
> 
> I don't like sometimes. I would prefer something like
> 'Under certain circumstances the driver is required issue
> a virtqueue notification to the device.


Under certain circumstances just says sometimes in 3 words.
Can't we find a way to say it that does not bump the word count x3?

> The method is transport
> defined.'

That's good to add.

> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +this notification involves sending the
> > +virtqueue number to the device (method depending on the transport).
> 
> I don't like 'involves' here. I think it's supposed to tell
> us that notification is a vitqueue level operation. Moreover
> the point is  when VIRTIO_F_NOTIFICATION_DATA has not been negotiated
> it's a virtueue notification and nothing more.
> 
> > +
> > +However, some devices benefit from the ability to find out the number of
> > +available descriptors in the ring without accessing the virtqueue in memory:
> 
> What is 'the ring'? (probably descriptor ring or available ring depending
> on what do we have)

Maybe buffers in the virtqueue?

> > +for efficiency or as a debugging aid.
> > +
> > +To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
> > +has been negotiated, driver notifications to the device include
> > +the following information:
> > +
> > +\begin{description}
> > +\item [VQ number]
> > +\item [Offset]
> > +      Within the ring where the next available ring entry
> > +      will be written.
> > +      Without VIRTIO_F_RING_PACKED this refers to the
> > +      15 least significant bits of the available index.
> > +      With VIRTIO_F_RING_PACKED this refers to the offset
> > +      (in units of descriptor entries)
> 
> What does '(in units of descriptor entries)' mean?

That it's not an address in bytes.
Offset is a distance right?
Within ring implies from start of ring.
What is left is to tell what are the units.

> Is it a
> mod ring size index?

I don't see how specifying units can be taken
to mean it's modulo some value :(

> If it is, why not call it index consequently
> (instead of this offset-index-offset thing)?

In fact index in many places is *not* mod ring size.
For me offset means where it is. Just need to specify
the units.


> > +      within the descriptor ring where the next available
> > +      descriptor will be written.
> > +\item [Wrap Counter]
> > +      With VIRTIO_F_RING_PACKED this is the wrap counter
> > +      referring to the next available descriptor.
> > +      Without VIRTIO_F_RING_PACKED this is the most significant bit
> > +      of the available index.
> > +\end{description}
> > +
> > +Note that the driver can trigger multiple notifications even without
> > +making any more changes to the ring. When VIRTIO_F_NOTIFICATION_DATA
> > +has been negotiated, these notifications would then have
> > +identical \field{Offset} and \field{Wrap Counter} values.
> > +
> >  \input{split-ring.tex}
> > 
> >  \input{packed-ring.tex}
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> > 
> >  We start with an overview of device initialization, then expand on the
> > @@ -862,7 +902,9 @@ the same Queue Notify address for all queues.
> >  \devicenormative{\paragraph}{Notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >  The device MUST present at least one notification capability.
> > 
> > -The \field{cap.offset} MUST be 2-byte aligned.  
> > +For devices not offering VIRTIO_F_NOTIFICATION_DATA:
> > +
> > +The \field{cap.offset} MUST be 2-byte aligned.
> > 
> >  The device MUST either present \field{notify_off_multiplier} as an even power of 2,
> >  or present \field{notify_off_multiplier} as 0.
> > @@ -876,6 +918,23 @@ For all queues, the value \field{cap.length} presented by the device MUST satisf
> >  cap.length >= queue_notify_off * notify_off_multiplier + 2
> >  \end{lstlisting}
> > 
> > +For devices offering VIRTIO_F_NOTIFICATION_DATA:
> > +
> > +The device MUST either present \field{notify_off_multiplier} as a
> > +number that is a power of 2 that is also a multiple 4,
> > +or present \field{notify_off_multiplier} as 0.
> > +
> > +The \field{cap.offset} MUST be 4-byte aligned.
> > +
> > +The value \field{cap.length} presented by the device MUST be at least 4
> > +and MUST be large enough to support queue notification offsets
> > +for all supported queues in all possible configurations.
> > +
> > +For all queues, the value \field{cap.length} presented by the device MUST satisfy:
> > +\begin{lstlisting}
> > +cap.length >= queue_notify_off * notify_off_multiplier + 4
> > +\end{lstlisting}
> > +
> >  \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
> > 
> >  The VIRTIO_PCI_CAP_ISR_CFG capability
> > @@ -1268,8 +1327,21 @@ separate cache lines.
> > 
> >  \subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notifying The Device}
> > 
> > -The driver notifies the device by writing the 16-bit virtqueue index
> > -of this virtqueue to the Queue Notify address.  See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate this address.
> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +the driver notifies the device by writing the 16-bit virtqueue index
> > +of this virtqueue (in little-endian byte order format)
> > +to the Queue Notify address.
> > +
> > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > +the driver notifies the device by writing the following
> > +32-bit value to the Queue Notify address:
> > +\lstinputlisting{notifications-le.c}
> > +
> > +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> > +for the definition of the components.
> > +
> > +See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate the
> > +Queue Notify address.
> > 
> >  \subsubsection{Virtqueue Interrupts From The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
> > 
> > @@ -1500,8 +1572,19 @@ All register values are organized as Little Endian.
> >    }
> >    \hline 
> >    \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> > -    Writing a queue index to this register notifies the device that
> > -    there are new buffers to process in the queue.
> > +    Writing a value this register notifies the device that
> > +    there are new buffers to process in a queue.
> > +
> > +    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +    the value written is the queue index.
> > +
> > +    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > +    the value has the following format:
> > +
> > +    \lstinputlisting{notifications-le.c}
> > +
> > +    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> > +    for the definition of the components.
> >    }
> >    \hline 
> >    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> > @@ -2340,12 +2423,22 @@ GPR  &   Input Value     & Output Value \\
> >  \hline
> >    2   &  Subchannel ID    & Host Cookie  \\
> >  \hline
> > -  3   & Virtqueue number  &              \\
> > +  3   & Notification data &              \\
> >  \hline
> >    4   &   Host Cookie     &              \\
> >  \hline
> >  \end{tabular}
> > 
> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +the \field{Notification data} contains the Virtqueue number.
> > +
> > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > +the value has the following format:
> > +\lstinputlisting{notifications-be.c}
> > +
> > +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
> > +for the definition of the components.
> > +
> >  \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
> >  The device MUST ignore bits 0-31 (counting from the left) of GPR2.
> >  This aligns passing the subchannel ID with the way it is passed
> > @@ -5348,6 +5441,10 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> >    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> >    that all buffers are used by the device in the same
> >    order in which they have been made available.
> > +  \item[VIRTIO_F_NOTIFICATION_DATA(36)] This feature indicates
> > +  that drivers pass extra data (besides identifying the Virtqueue)
> 
> s/drivers/driver/ plural seems inappropriate
> 
> > +  in their device notifications.
> 
> I'm not really satisfied with this description but have nothing
> better to offer, so I'm willing to accept.
> 
> 
> > +  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
> >  \end{description}
> > 
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > diff --git a/notifications-be.c b/notifications-be.c
> > new file mode 100644
> > index 0000000..5be947e
> > --- /dev/null
> > +++ b/notifications-be.c
> > @@ -0,0 +1,5 @@
> > +be32 {
> > +	vqn : 16;
> > +	next_off : 15;
> > +	next_wrap : 1;
> 
> Would it make sense to switch next_wrap and next_off for be.
> I mean that way we should be able to read the avail_idx at
> once (I think) instead of having to compute it first from
> next_off and next_wrap.

Makes sense.

> Again, I can't really tell what is behind yet. Thus it may
> be completely irrelevant.
> 
> 
> Regards,
> Halil
> 
> > +};
> > diff --git a/notifications-le.c b/notifications-le.c
> > new file mode 100644
> > index 0000000..fe51267
> > --- /dev/null
> > +++ b/notifications-le.c
> > @@ -0,0 +1,5 @@
> > +le32 {
> > +	vqn : 16;
> > +	next_off : 15;
> > +	next_wrap : 1;
> > +};
> > 

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

