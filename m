Return-Path: <virtio-comment-return-4185-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 13 Feb 2023 11:21:41 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20230213032141.GD2751@h68b04307.sqa.eu95>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212154046-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230212154046-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the
 virtqueue coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 12, 2023 at 03:43:45PM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 10, 2023 at 07:36:03PM +0000, Parav Pandit wrote:
> > 
> > 
> > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > Sent: Friday, February 10, 2023 2:02 AM
> > > 
> > > Currently, the coalescing profile is directly applied to all queues.
> > 
> > Say it,
> > Currently coalescing parameters are grouped for all transmit and receive virtqueues.
> > 
> > > This patch supports setting or getting the parameters for a specified queue, and
> > > a typical application of this function is NetDIM.
> > Many of us know the net dim.
> > But if you prefer to mention it here, better to have the link for it.
> > 
> > Please add pointer to it.
> > [1] https://docs.kernel.org/networking/net_dim.html
> > 
> > > 
> > > When the traffic between queues is unbalanced, for example, one queue is
> > > busy and another queue is idle, then it will be very useful to control coalescing
> > > parameters at the queue granularity.
> > > 
> > > 
> > > +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver can
> > > +send control commands to set or get the coalescing parameters of a
> > Control command singular?
> 
> why? driver can send any number of commands e.g. to different vqs.

I think Parav pointed out a syntax error on my part.

a singular command --> a specified virtqueue.

Thanks.

> 
> > > +specified virtqueue (excluding the control virtqueue).
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_net_ctrl_coal_vq {
> > > +    le32 max_packets;
> > > +    le32 usecs;
> > > +    le16 vqn;
> > > +};
> > > +
> > Change that Michael suggest restructuring and under same class looks good to me.
> > 
> > > +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
> > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0  #define
> > > +VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1 \end{lstlisting}
> > > +
> > > +Virtqueue coalescing parameters:
> > > +\begin{itemize}
> > > +\item \field{max_packets}: The maximum number of packets sent/received by
> > > the
> > > +    specified virtqueue before a TX/RX notification.
> > > +\item \field{usecs}: The maximum number of TX/RX usecs that the specified
> > > +    virtqueue delays a TX/RX notification.
> > > +\item \field{vqn}: The virtqueue number of the specified virtqueue.
> > > +\end{itemize}
> > > +
> > The virtqueue number of the enabled transmit or receive virtuqueue.
> > This will simplify below description.
> > 
> > > +The range of \filed{vqn} is between 0 and 0xFFFF inclusive, $ \lfloor
> > > +vqn / 2 \rfloor $ is the index of the corresponding receiveq, and
> > > +$\lfloor (vqn / 2) + 1 \rfloor $ is the corresponding tranmitq.
> > > +
> > 
> > Please add short description something like,
> > 
> > When the driver prefers to use per virtqueue notifications coalescing, and if queue group (transmit or receive) level notification coalescing is enabled, driver SHOULD first disable device level notification coalescing.
> > Or it should be,
> > 
> > Virtqueue level notifications coalescing, and device level notifications can be enabled together.
> > When both of them are enabled, per virtqueue notifications coalescing take priority over queue group level.
> 
> Note that neither of these reflects what I proposed.
> I proposed explaining that VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET have the same effect as
> repeatedly calling VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET for all TX/RX vqs.
> 
> > With rests of the comments from Michael and Alvaro in progress, looks good.
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

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

