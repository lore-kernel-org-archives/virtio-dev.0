Return-Path: <virtio-comment-return-4580-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 28 Feb 2023 02:47:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230228023225-mutt-send-email-mst@kernel.org>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548149DF3FCB29805E442F75DCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548149DF3FCB29805E442F75DCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v9] virtio-net: support the virtqueue coalescing
 moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 28, 2023 at 01:40:29AM +0000, Parav Pandit wrote:
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Sunday, February 26, 2023 4:37 AM
> 
> > +# Read/Write attributes for coalescing parameters \begin{itemize} \item
> Hash # above is not needed. Please remove.
> 
> > +For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},
> > \field{reserved}, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}
> > and \field{reserved} are write-only
> > +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only
> > for the driver.
> > +\end{itemize}
> Instead of describing each individual fields of the structure struct virtio_net_ctrl_coal coal as read-only or write-only, better to say the struct itself as read/write only.

I don't see how you can reasonably do this. Which fields are RO and
which WO depends on the command.

> This way when/if in the future, if struct virtio_net_ctrl_coal coal extends, no need to rewrite this section of the spec.

Exactly the reverse.
If you specify RO/WO for each field then you don't need to touch
existing description when adding fields.
If you write in one place that all of struct is RO, when you add
WO fields you need to change it.


> > +
> >  Coalescing parameters:
> >  \begin{itemize}
> > +\item \field{vqn}: The virtqueue number of an enabled transmit or receive
> > virtqueue.
> >  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a
> > RX notification.
> >  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a
> > TX notification.
> >  \item \field{max_packets} for RX: Maximum number of packets to receive
> > before a RX notification.
> >  \item \field{max_packets} for TX: Maximum number of packets to send before
> > a TX notification.
> >  \end{itemize}
> > 
> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +\field{reserved} is reserved and it is ignored by a device.
> > +
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues, and values of
> > +                                        coalescing parameters are recorded as TX global values
> > by a device.
> "recording TX global values" is not conveying anything more as "all transmit virtqueues" is already mentioned.
> The original text without "recorded as Tx global values" is just fine. Same for the RX below.

I agree.

> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues, and values of
> > +                                        coalescing parameters are recorded as RX global values
> > by a device.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for an enabled transmit/receive
> > +                                        virtqueue whose number is \field{vqn}, and do not
> > change the TX/RX global values.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
> > \field{max_usecs} and \field{max_packets} parameters for an enabled
> > +                                        transmit/receive virtqueue whose number is \field{vqn}.
> >  \end{enumerate}
> > 
> > +If coalescing parameters are being set, the device applies the last
> > +coalescing parameters received for a virtqueue, regardless of the command
> > used to set the parameters. For example with 2 pairs of virtqueues:
> > +# Command sequence
> > +Each of the following commands sets \field{max_usecs} and
> > \field{max_packets} parameters for virtqueues.
> > +\begin{itemize}
> > +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
> > parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3
> > retain their previous parameter values.
> > +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
> > 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the values
> > from command1.
> > +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
> > 0, the device responds with coalescing parameters of virtqueue0 set by
> > command2.
> > +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
> > 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its previous
> > values.
> > +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing
> > parameters for virtqueue1 and virtqueue3, and overrides the values set by
> > command4.
> > +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
> > 1, the device responds with coalescing parameters of virtqueue1 set by
> > command5.
> > +\end{itemize}
> > +
> >  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / Operation}
> > 
> >  The device sends a used buffer notification once the notification conditions are
> > met and if the notifications are not suppressed as explained in \ref{sec:Basic
> > Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> > @@ -1549,6 +1612,11 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the
> > notification conditions are met after every packet received/sent.
> > 
> > +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands, it saves the values of
> > +coalescing parameters as global values, and the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command does not change the global
> > values. If the device is reset, the global values will be set to 0.
> > +When a virtqueue is enabled after virtqueue reset, its coalescing parameters
> > are set to global values.
> > +
> >  \subparagraph{RX Example}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / RX Example}
> > 
> >  If, for example:
> > @@ -1585,15 +1653,26 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
> > MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +If neither the VIRTIO_NET_F_NOTF_COAL nor the
> > VIRTIO_NET_F_VQ_NOTF_COAL
> > +feature has been negotiated, the driver MUST NOT issue
> > VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +
> I agree to Alvaro's suggestion.
> If VIRTIO_NET_F_NOTF_COAL is not negotiated, the driver must not issue commands A and B.
> 
> If VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated, the driver must not issue commands C and D.


Yea. Though double negatives are annoying.  One way to avoid them is

	The driver MUST negotiate VIRTIO_NET_F_NOTF_COAL before issuing commands A and B.

or
	The driver is REQUIRED to negotiate VIRTIO_NET_F_NOTF_COAL before issuing commands A and B.




> > +A driver MUST ignore the values of coalescing parameters received from the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with
> > VIRTIO_NET_ERR.
> > 
> >  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> > -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
> > with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it
> > was not able to change the parameters.
> > +
> > +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > command with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +
> > +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if
> > the given virtqueue is disabled.
> > +
> > +A device MUST ignore \field{reserved}.
> > 
> >  A device SHOULD NOT send used buffer notifications to the driver if the
> > notifications are suppressed, even if the notification conditions are met.
> > 
> > -Upon reset, a device MUST initialize all coalescing parameters to 0.
> > +After disabling and re-enabling a virtqueue, the device MUST revert coalescing
> revert to
> > parameters of the virtqueue to the global values.
> > +
> Like others suggested, above can be reworded as,
> 
> After disabling and re-enabling a virtuqueue, the device MUST revert to coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL.

meaning RX/TX I guess. be explicit.

... or 0 if RX/TX was not set?


> > +Upon reset, a device MUST initialize all coalescing parameters to 0 and MUST
> > set the global values to 0.
> > 
> No need to mention global values here. "all coalescing parameters to 0" covers per vq and per group of tx and rx vqs.

Let's wait for new version of Alvaro's patch, rebase on top of that.


> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> > Types / Network Device / Legacy Interface: Framing Requirements}
> > --
> > 2.19.1.6.gb485710b


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

