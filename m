Return-Path: <mst@redhat.com>
Date: Wed, 22 Feb 2023 01:29:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6] virtio-net: support the virtqueue coalescing
 moderation
Message-ID: <20230222012200-mutt-send-email-mst@kernel.org>
References: <20230222032148.106406-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481457D8EE37A39198592C1DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481457D8EE37A39198592C1DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 22, 2023 at 04:13:06AM +0000, Parav Pandit wrote:
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Tuesday, February 21, 2023 10:22 PM
> 
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue
> > notification coalescing.
> > +
> s/notification/notifications 
> should be plural as multiple notifications are coalesced like the below description of VIRTIO_NET_F_NOTF_COAL.

Hmm nope - this is the "reduced relative" construct. It's always in a singular
form. The full form would be "coalescing of notifications of virtqueues"
and that indeed would use a plural form. But technical writing is
usually using the reduced relative form.

> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications
> > coalescing.
> > 
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -139,6 +141,7 @@ \subsubsection{Feature bit
> > requirements}\label{sec:Device Types / Network Device
> > \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> > VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> > 
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /
> > Network Device / Feature bits / Legacy Interface: Feature bits} @@ -1508,6
> > +1511,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types /
> > Network Device / Devi  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated,
> > the driver can  send control commands for dynamically changing the coalescing
> > parameters.
> > 
> > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> > +\begin{itemize}
> > +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
> > to set coalescing parameters of a given
> > +      enabled transmit/receive virtqueue.
> > +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command
> > to a device, and the device responds with
> > +      coalescing parameters of a given enabled transmit/receive virtqueue.
> > +\end{itemize}
> > +
> >  \begin{note}
> >  The behavior of the device in response to these commands is best-effort:
> >  the device may generate notifications more or less frequently than specified.
> > @@ -1519,25 +1530,76 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> >      le32 max_usecs;
> >  };
> > 
> > +struct virtio_net_ctrl_coal_vq {
> > +    le16 vqn;
> > +    le16 reserved;
> > +    struct virtio_net_ctrl_coal coal;
> > +};
> > +
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> > + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> >  \end{lstlisting}
> > 
> > +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands use the
> > virtio_net_ctrl_coal
> > +structure to set \field{max_usecs} and \field{max_packets} for all
> > transmit/receive virtqueues.
> > +
> > +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the
> > +virtio_net_ctrl_coal_vq structure to set \field{max_usecs} and
> > \field{max_packets} for the supplied virtqueue number \field{vqn}.
> > +
> > +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of
> > +\field{max_usecs} and \field{max_packets} of the specified virtqueue
> > +from the device by setting \field{vqn} in the virtio_net_ctrl_coal_vq structure.
> > +
> 
> > +# Read/Write attributes for coalescing parameters \begin{itemize} \item
> > +For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},
> 
> Virtio spec is using vq number and vq index terminology interchangeably.
> For example, a new patch about admin vq, uses aq_start_index.
> 
> MMIO device has vq_index register too.
> I am inclined to vq_index given current state of spec

[mst@tuck virtio]$ git grep vq_index|wc -l
0

> and new additions by Michael.

admin vq? Good point, I will change that to vqn too.

> Michael,
> Can you please suggest vqn or vq_index to use?

[mst@tuck virtio]$ git grep vqn|wc -l
5

I'd say vqn has precedent.


> > \field{reserved}, \field{max_usecs}
> > +      and \field{max_packets} are write-only for a driver.
> > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}
> > and \field{reserved} are write-only
> 
> 
> > +      for a driver, and, \field{max_usecs} and \field{max_packets} are read-only
> > for a driver.
> Remove this trailing "for a driver", it is a duplicate.

Nope it's required, without it, it's unclear which side is doing reading
and which writing. Unfortunate that it's a bit verbose but we don't have
better terms in the spec right now.

> > +\end{itemize}
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
> > +\field{vqn} points to an enabled transmit/receive virtqueue, and its value
> > satisfies $ 0 \leq vqn < max_virtqueue_pairs \ast 2 $.
> > +
> This calculation description is not needed here. It is covered somewhere else.


I agree.

> > +\field{reserved} is reserved and it is ignored by a device.
> > +
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all transmit virtqueues.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for all receive virtqueues.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and
> > \field{max_packets} parameters for an enabled transmit/receive
> > +                                        virtqueue whose number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
> > \field{max_usecs} and \field{max_packets} parameters for an enabled
> > +                                        transmit/receive virtqueue whose number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect as the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
> > virtqueue of transmitq1\ldots transmitqN.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect as the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
> > virtqueue of receiveq1\ldots receiveqN.
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
> > @@ -1549,6 +1611,16 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > 
> >  When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the
> > notification conditions are met after every packet received/sent.
> > 
> > +When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL
> > class
> > +to set a coalescing parameter, it may set the parameter to a value close to a
> > power of 2. For example:
> > +If the device receives \field{max_usecs} = 7 from the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, it may set
> > \field{max_usecs} = 8 for a given enabled virtqueue.
> > +
> > +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands, it saves the values of
> > +coalescing parameters as global values, and the
> > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command does not change the global
> > values. If the device is reset, the global values will be set to 0.
> > +
> > +When a virtqueue is reset, its coalescing parameters are set to the global
> > values.
> > +
> A VQ reset operation disables (or destroys) the VQ in the device.
> Hence, a vq under reset doesn't have any valid parameters.
> Therefore, above wording should be,
> 
> When a virtqueue is enabled after it is reset, its coalescing parameters are set to global values as configured by VIRTIO_NET_CTRL_NOTF_COAL_TX_SET or VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.

Right though this repeats "it" twice. At which point the second it
becomes slightly confusing. Not too bad but ""enabled after virtqueue
reset" would address this.


> >  \subparagraph{RX Example}\label{sec:Device Types / Network Device / Device
> > Operation / Control Virtqueue / Notifications Coalescing / RX Example}
> > 
> >  If, for example:
> > @@ -1585,11 +1657,29 @@ \subsubsection{Control
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
> > +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands set coalescing parameters
> > for all transmit/receive virtqueues respectively and values of coalescing
> > parameters are recorded as global values by a device.
> > +The device MUST set the global values of coalescing parameters to 0 after
> > being reset.
> > +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing
> > parameters for a given enabled virtqueue without changing the global values.
> > +
> > +After disabling and re-enabling a virtqueue, the device MUST revert coalescing
> > parameters of the virtqueue to the global values.
> > +
> > +A device MAY set the coalescing parameter to a value close to a power of 2
> > value.
> > +
> > +A device MUST ignore \field{reserved}.
> > 
> >  A device SHOULD NOT send used buffer notifications to the driver if the
> > notifications are suppressed, even if the notification conditions are met.
> > 
> > --
> > 2.19.1.6.gb485710b

