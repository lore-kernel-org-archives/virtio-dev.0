Return-Path: virtio-dev-return-4841-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24D98985D0B
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Sep 2018 15:22:45 +0000 (UTC)
Date: Wed, 12 Sep 2018 11:22:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180912112228-mutt-send-email-mst@kernel.org>
References: <df44ecd7-4d0b-2e72-6781-82a081807c8a@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <df44ecd7-4d0b-2e72-6781-82a081807c8a@solarflare.com>
Subject: Re: [virtio-dev] [PATCH v11] VIRTIO_F_NOTIFICATION_DATA: extra data
 to devices
To: David Riddoch <driddoch@solarflare.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Sounds good, I will rebase this and start voting.

On Wed, Sep 12, 2018 at 04:20:20PM +0100, David Riddoch wrote:
> All,
>=20
> Sorry for resurrecting an old thread.=A0 I implement the sort of devices =
that
> would benefit from this feature, so just want to express my support.=A0 It
> will simplify implementation and improve performance.=A0 The mechanism
> proposed below works for me.
>=20
> David
>=20
>=20
> > On Tue, 27 Mar 2018 05:59:27 +0300
> > "Michael S. Tsirkin" <m...@redhat.com> wrote:
> > Some devices benefit from ability to find out the number of available
> > descriptors in the ring: for efficiency or as a debugging aid.
> > To help with these optimizations, add a new feature:
> > VIRTIO_F_NOTIFICATION_DATA. When negotiated, driver notifications to the
> > device include this extra information.
> >=20
> > Signed-off-by: Michael S. Tsirkin <m...@redhat.com>
> > ---
> >=20
> > v10 -> v11:
> >          drop mention of interrupts: current proposal does not include
> >          this interrupt related information
> >          drop unrelated introduction sections
> >=20
> >   content.tex | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++---
> >   1 file changed, 133 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/content.tex b/content.tex
> > index 7a92cb1..95e9b82 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -283,9 +283,75 @@ Packed Virtqueues}).
> >   Every driver and device supports either the Packed or the Split
> >   Virtqueue format, or both.
> > +\subsection{Driver notifications} \label{sec:Virtqueues / Driver notif=
ications}
> > +Driver is sometimes required to notify the device after
> > +making changes to the virtqueue.
> > +
> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +this notification involves sending the
> > +virtqueue number to the device (depending on the transport).
> > +
> > +However, some devices benefit from ability to find out the number of
> > +available descriptors in the ring without accessing virtqueue in memor=
y:
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
> > +      (in units of descritor entries)
> > +      within the descriptor ring where the next available
> > +      descriptor will be written.
> > +\item [Wrap Counter]
> > +      With VIRTIO_F_RING_PACKED this is the wrap counter
> > +      referring to the next available descriptor.
> > +      Without VIRTIO_F_RING_PACKED this is the most significant bit
> > +      of the available index.
> > +\end{description}
> > +
> > +Note that driver can trigger multiple notifications even without
> > +making any more changes to the ring. When VIRTIO_F_NOTIFICATION_DATA
> > +has been negotiated, these notifications would then have
> > +identical \field{Offset} and \field{Wrap Counter} values.
> > +
> >   \input{split-ring.tex}
> >   \input{packed-ring.tex}
> > +
> > +\subsubsection{Driver notifications}
> > +
> > +\label{sec:Packed Virtqueues / Driver notifications}
> > +Whenever not suppressed by Device Event Suppression,
> > +driver is required to notify the device after
> > +making changes to the virtqueue.
> > +
> > +Some devices benefit from ability to find out the number of
> > +available descriptors in the ring without accessing virtqueue in memor=
y:
> > +for efficiency or as a debugging aid.
> > +
> > +To help with these optimizations, driver notifications
> > +to the device include the following information:
> > +
> > +\begin{itemize}
> > +\item VQ number
> > +\item Offset (in units of descriptor size) within the ring
> > +      where the next available descriptor will be written
> > +\item Wrap Counter referring to the next available
> > +      descriptor
> > +\end{itemize}
> > +
> > +Note that driver can trigger multiple notifications even without
> > +making any more changes to the ring. These would then have
> > +identical \field{Offset} and \field{Wrap Counter} values.
> > +
> >   \chapter{General Initialization And Device Operation}\label{sec:Gener=
al
> > Initialization And Device Operation}
> >   We start with an overview of device initialization, then expand on the
> > @@ -862,7 +928,9 @@ the same Queue Notify address for all queues.
> >   \devicenormative{\paragraph}{Notification capability}{Virtio Transpor=
t Options
> > / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> >   The device MUST present at least one notification capability.
> > -The \field{cap.offset} MUST be 2-byte aligned.
> > +For devices not offering VIRTIO_F_NOTIFICATION_DATA:
> > +
> > +The \field{cap.offset} MUST be 2-byte aligned.
> >   The device MUST either present \field{notify_off_multiplier} as an ev=
en power
> > of 2,
> >   or present \field{notify_off_multiplier} as 0.
> > @@ -876,6 +944,23 @@ For all queues, the value \field{cap.length} prese=
nted by
> > the device MUST satisf
> >   cap.length >=3D queue_notify_off * notify_off_multiplier + 2
> >   \end{lstlisting}
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
> > +For all queues, the value \field{cap.length} presented by the device M=
UST
> > satisfy:
> > +\begin{lstlisting}
> > +cap.length >=3D queue_notify_off * notify_off_multiplier + 4
> > +\end{lstlisting}
> > +
> >   \subsubsection{ISR status capability}\label{sec:Virtio Transport Opti=
ons /
> > Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
> >   The VIRTIO_PCI_CAP_ISR_CFG capability
> > @@ -1268,8 +1353,25 @@ separate cache lines.
> >   \subsubsection{Notifying The Device}\label{sec:Virtio Transport Optio=
ns /
> > Virtio Over PCI Bus / PCI-specific Initialization And Device Operation /
> > Notifying The Device}
> > -The driver notifies the device by writing the 16-bit virtqueue index
> > -of this virtqueue to the Queue Notify address.  See \ref{sec:Virtio Tr=
ansport
> > Options / Virtio Over PCI Bus / PCI Device Layout / Notification capabi=
lity}
> > for how to calculate this address.
> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +the driver notifies the device by writing the 16-bit virtqueue index
> > +of this virtqueue (in little-endian byte order format)
> > +to the Queue Notify address.
> > +
> > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > +the driver notifies the device by writing the following
> > +32-bit value to the Queue Notify address:
> > +\begin{lstlisting}
> > +le32 vqn : 16,
> > +     next_off : 15,
> > +     next_wrap : 1;
> > +\end{lstlisting}
> > +
> > +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s /
> > Driver notifications}
> > +for the definition of the components.
> > +
> > +See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Devi=
ce
> > Layout / Notification capability} for how to calculate the
> > +Queue Notify address.
> >   \subsubsection{Virtqueue Interrupts From The Device}\label{sec:Virtio
> > Transport Options / Virtio Over PCI Bus / PCI-specific Initialization A=
nd
> > Device Operation / Virtqueue Interrupts From The Device}
> > @@ -1500,8 +1602,19 @@ All register values are organized as Little Endi=
an.
> >     }
> >     \hline
> >     \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
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
> > +    \lstinputlisting{notifications.c}
> > +
> > +    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtq=
ueues /
> > Driver notifications}
> > +    for the definition of the components.
> >     }
> >     \hline
> >     \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> > @@ -2340,12 +2453,22 @@ GPR  &   Input Value     & Output Value \\
> >   \hline
> >     2   &  Subchannel ID    & Host Cookie  \\
> >   \hline
> > -  3   & Virtqueue number  &              \\
> > +  3   & Notification data &              \\
> >   \hline
> >     4   &   Host Cookie     &              \\
> >   \hline
> >   \end{tabular}
> > +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > +the \field{Notification data} includes the Virtqueue number.
> > +
> > +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > +the value has the following format:
> > +\lstinputlisting{notifications.c}
> > +
> > +See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s /
> > Driver notifications}
> > +for the definition of the components.
> > +
> >   \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transpo=
rt
> > Options / Virtio over channel I/O / Device Operation / Guest->Host Noti=
fication}
> >   The device MUST ignore bits 0-31 (counting from the left) of GPR2.
> >   This aligns passing the subchannel ID with the way it is passed
> > @@ -5348,6 +5471,10 @@ Descriptors} and \ref{sec:Packed Virtqueues / In=
direct
> > Flag: Scatter-Gather Supp
> >     \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> >     that all buffers are used by the device in the same
> >     order in which they have been made available.
> > +  \item[VIRTIO_F_NOTIFICATION_DATA(36)] This feature indicates
> > +  that drivers pass extra data (besides identifying the Virtqueue)
> > +  in their device notifications.
> > +  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtque=
ues /
> > Driver notifications}.
> >   \end{description}
> >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bi=
ts}
>=20
> --=20
> David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

