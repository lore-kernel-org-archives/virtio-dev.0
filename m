Return-Path: virtio-dev-return-4909-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05FCF985BC0
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Oct 2018 16:08:32 +0000 (UTC)
Date: Tue, 23 Oct 2018 12:08:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023120633-mutt-send-email-mst@kernel.org>
References: <20181023130451.10481-1-kraxel@redhat.com>
 <20181023091932-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023091932-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v3] Add virtio input device
 specification.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Ladi Prosek <lprosek@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 23, 2018 at 09:20:49AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 23, 2018 at 03:04:51PM +0200, Gerd Hoffmann wrote:
> > Support has been added to the linux kernel version 4.1
> > and to qemu version 2.4.
> > 
> > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Great, thank you!

And given that it's been out without big changes for a long time,
I'm inlined to say let's start voting on it.
Do you agree? If yes pls create a github issue with link to archives, send
the Fixes: tag and I'll get the ball rolling.
Lots of conferences going on so I think we should do a longer
than usual voting period, say 3 weeks.

> > ---
> > v2->v3:
> > * add missing abs field to virtio_input_absinfo.
> > 
> > v1->v2 (by Ladi):
> > * added VIRTIO_INPUT_CFG_ID_DEVIDS / virtio_input_devids
> > * added normative statements and moved them all to
> >   \devicenormative and \drivernormative sections
> > * made it clearer that this specifies virtio transport,
> >   not evdev itself
> > * Michael's feedback on the incremental patch
> > * minor tweaks
> > ---
> >  conformance.tex  |  18 ++++++
> >  content.tex      |   2 +
> >  virtio-input.tex | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 214 insertions(+)
> >  create mode 100644 virtio-input.tex
> > 
> > diff --git a/conformance.tex b/conformance.tex
> > index 7b7df32..2486e9a 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -145,6 +145,15 @@ An SCSI host driver MUST conform to the following normative statements:
> >  \item \ref{drivernormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
> >  \end{itemize}
> >  
> > +\subsection{Input Driver Conformance}\label{sec:Conformance / Driver Conformance / Input Driver Conformance}
> > +
> > +An input driver MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{drivernormative:Device Types / Input Device / Device Initialization}
> > +\item \ref{drivernormative:Device Types / Input Device / Device Operation}
> > +\end{itemize}
> > +
> >  \section{Device Conformance}\label{sec:Conformance / Device Conformance}
> >  
> >  A device MUST conform to the following normative statements:
> > @@ -265,6 +274,15 @@ An SCSI host device MUST conform to the following normative statements:
> >  \item \ref{devicenormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
> >  \end{itemize}
> >  
> > +\subsection{Input Device Conformance}\label{sec:Conformance / Device Conformance / Input Device Conformance}
> > +
> > +An input device MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{devicenormative:Device Types / Input Device / Device Initialization}
> > +\item \ref{devicenormative:Device Types / Input Device / Device Operation}
> > +\end{itemize}
> > +
> >  \section{Legacy Interface: Transitional Device and
> >  Transitional Driver Conformance}\label{sec:Conformance / Legacy
> >  Interface: Transitional Device and 
> > diff --git a/content.tex b/content.tex
> > index d989d98..4c0c4c9 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5641,6 +5641,8 @@ descriptor for the \field{sense_len}, \field{residual},
> >  \field{status_qualifier}, \field{status}, \field{response} and
> >  \field{sense} fields.
> >  
> > +\input{virtio-input.tex}
> > +
> >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >  
> >  Currently there are three device-independent feature bits defined:
> > diff --git a/virtio-input.tex b/virtio-input.tex
> > new file mode 100644
> > index 0000000..044c714
> > --- /dev/null
> > +++ b/virtio-input.tex
> > @@ -0,0 +1,194 @@
> > +\section{Input Device}\label{sec:Device Types / Input Device}
> > +
> > +The virtio input device can be used to create virtual human interface
> > +devices such as keyboards, mice and tablets. An instance of the virtio
> > +device represents one such input device. Device behavior mirrors that
> > +of the evdev layer in Linux, making pass-through implementations on top
> > +of evdev easy.
> > +
> > +This specification defines how evdev events are transported
> > +over virtio and how the set of supported events is discovered by a driver.
> > +It does not, however, define the semantics of input events as this is
> > +dependent on the particular evdev implementation. For the list of events
> > +used by Linux input devices, see
> > +\href{https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/input-event-codes.h}{include/uapi/linux/input-event-codes.h}
> > +in the Linux source tree.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / Input Device / Device ID}
> > +
> > +18
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / Input Device / Virtqueues}
> > +
> > +\begin{description}
> > +\item[0] eventq
> > +\item[1] statusq
> > +\end{description}
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / Input Device / Feature bits}
> > +
> > +None.
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / Input Device / Device configuration layout}
> > +
> > +Device configuration holds all information the guest needs to handle
> > +the device, most importantly the events which are supported.
> > +
> > +\begin{lstlisting}
> > +enum virtio_input_config_select {
> > +	VIRTIO_INPUT_CFG_UNSET      = 0x00,
> > +	VIRTIO_INPUT_CFG_ID_NAME    = 0x01,
> > +	VIRTIO_INPUT_CFG_ID_SERIAL  = 0x02,
> > +	VIRTIO_INPUT_CFG_ID_DEVIDS  = 0x03,
> > +	VIRTIO_INPUT_CFG_PROP_BITS  = 0x10,
> > +	VIRTIO_INPUT_CFG_EV_BITS    = 0x11,
> > +	VIRTIO_INPUT_CFG_ABS_INFO   = 0x12,
> > +};
> > +
> > +struct virtio_input_absinfo {
> > +	le32  min;
> > +	le32  max;
> > +	le32  fuzz;
> > +	le32  flat;
> > +	le32  res;
> > +};
> > +
> > +struct virtio_input_devids {
> > +	le16  bustype;
> > +	le16  vendor;
> > +	le16  product;
> > +	le16  version;
> > +};
> > +
> > +struct virtio_input_config {
> > +	u8    select;
> > +	u8    subsel;
> > +	u8    size;
> > +	u8    reserved[5];
> > +	union {
> > +		char string[128];
> > +		u8   bitmap[128];
> > +		struct virtio_input_absinfo abs;
> > +		struct virtio_input_devids ids;
> > +	} u;
> > +};
> > +\end{lstlisting}
> > +
> > +To query a specific piece of information the driver sets
> > +\field{select} and \field{subsel} accordingly, then checks \field{size}
> > +to see how much information is available.  \field{size} can be
> > +zero if no information is available.  Strings do not include a
> > +NUL terminator. Related evdev ioctl names are provided for reference.
> > +\begin{description}
> > +
> > +\item[VIRTIO_INPUT_CFG_ID_NAME]
> > +\field{subsel} is zero.
> > +Returns the name of the device, in \field{u.string}.
> > +
> > +Similar to EVIOCGNAME ioctl for Linux evdev devices.
> > +
> > +\item[VIRTIO_INPUT_CFG_ID_SERIAL]
> > +\field{subsel} is zero.
> > +Returns the serial number of the device, in \field{u.string}.
> > +
> > +\item[VIRTIO_INPUT_CFG_ID_DEVIDS]
> > +\field{subsel} is zero.
> > +Returns ID information of the device, in \field{u.ids}.
> > +
> > +Similar to EVIOCGID ioctl for Linux evdev devices.
> > +
> > +\item[VIRTIO_INPUT_CFG_PROP_BITS]
> > +\field{subsel} is zero.
> > +Returns input properties of the device, in \field{u.bitmap}.
> > +Individual bits in the bitmap correspond to INPUT_PROP_*
> > +constants used by the underlying evdev implementation.
> > +
> > +Similar to EVIOCGPROP ioctl for Linux evdev devices.
> > +
> > +\item[VIRTIO_INPUT_CFG_EV_BITS]
> > +\field{subsel} specifies the event type using EV_*
> > +constants in the underlying evdev implementation. If
> > +\field{size} is non-zero the event type is supported and
> > +a bitmap of supported event codes is returned in \field{u.bitmap}.
> > +Individual bits in the bitmap correspond to
> > +implementation-defined input event codes, for example keys
> > +or pointing device axes.
> > +
> > +Similar to EVIOCGBIT ioctl for Linux evdev devices.
> > +
> > +\item[VIRTIO_INPUT_CFG_ABS_INFO]
> > +\field{subsel} specifies the absolute axis using ABS_*
> > +constants in the underlying evdev implementation.
> > +Information about the axis will be returned in \field{u.abs}.
> > +
> > +Similar to EVIOCGABS ioctl for Linux evdev devices.
> > +
> > +\end{description}
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / Input Device / Device Initialization}
> > +
> > +\begin{enumerate}
> > +\item The device is queried for supported event types and codes.
> > +\item The eventq is populated with receive buffers.
> > +\end{enumerate}
> > +
> > +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Input Device / Device Initialization}
> > +A driver MUST set both \field{select} and \field{subsel} when querying
> > +  device configuration, in any order.
> > +
> > +A driver MUST NOT write to configuration fields other than \field{select}
> > +  and \field{subsel}.
> > +
> > +A driver SHOULD check the \field{size} field before accessing the
> > +  configuration information.
> > +
> > +\devicenormative{\subsubsection}{Device Initialization}{Device Types / Input Device / Device Initialization}
> > +A device MUST set the \field{size} field to zero if it doesn't support a
> > +  given \field{select} and \field{subsel} combination.
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / Input Device / Device Operation}
> > +
> > +\begin{enumerate}
> > +\item Input events such as press and release events for keys and
> > +  buttons, and motion events for pointing devices are sent from
> > +  the device to the driver using the eventq.
> > +\item Status feedback such as keyboard LED updates are sent from the
> > +  driver to the device using the statusq.
> > +\item Both queues use the same virtio_input_event struct.
> > +  \field{type}, \field{code} and \field{value} are filled according to
> > +  the Linux input layer (evdev) interface, except that the fields are
> > +  in little endian byte order whereas the evdev ioctl interface uses
> > +  native endian-ness.
> > +\end{enumerate}
> > +
> > +\begin{lstlisting}
> > +struct virtio_input_event {
> > +	le16 type;
> > +	le16 code;
> > +	le32 value;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\subsubsection}{Device Operation}{Device Types / Input Device / Device Operation}
> > +
> > +A driver SHOULD keep the eventq populated with buffers. These buffers
> > +  MUST be device-writable and MUST be at least the size of
> > +  struct virtio_input_event.
> > +
> > +Buffers placed into the statusq by a driver MUST be at least the size
> > +  of struct virtio_input_event.
> > +
> > +A driver SHOULD ignore eventq input events it does not recognize. Note
> > +  that evdev devices generally maintain backward compatibility by sending
> > +  redundant events and relying on the consuming side using only the events
> > +  it understands and ignoring the rest.
> > +
> > +\devicenormative{\subsubsection}{Device Operation}{Device Types / Input Device / Device Operation}
> > +
> > +A device MAY drop input events if the eventq does not have enough
> > +  available buffers. It SHOULD NOT drop individual input events if
> > +  they are part of a sequence forming one input device update. For
> > +  example, a pointing device update typically consists of several
> > +  input events, one for each axis, and a terminating EV_SYN event.
> > +  A device SHOULD either buffer or drop the entire sequence.
> > +
> > -- 
> > 2.9.3
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

