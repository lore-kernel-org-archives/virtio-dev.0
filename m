Return-Path: <virtio-comment-return-4010-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1675823233.0015643-3-xuanzhuo@linux.alibaba.com>
Date: Wed, 8 Feb 2023 10:27:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .  org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 8 Feb 2023 02:20:27 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, February 7, 2023 8:46 PM
> >
> > On Tue, 7 Feb 2023 09:06:19 -0500, "Michael S. Tsirkin" <mst@redhat.com>
> > wrote:
> > > On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
> > > > Currently, the coalescing profile is directly applied to all queues.
> > > > This patch supports configuring the parameters for a specified queue.
> > > >
> > > > When the traffic between queues is unbalanced, for example, one
> > > > queue is busy and another queue is idle, then it will be very useful
> > > > to control coalescing parameters at the queue granularity.
> > >
> > > ethtool does not support this though, does it? what's the plan?
> >
> >
> > Although it can be done, I think it is difficult to let users use ethtool to modify
> > the parameters of each queue.
> >
> > At present ethtool supports adaptive-rx/adaptive-tx. This is that the driver
> > automatically adapted to the appropriate parameter. Generally, it is
> > implemented using netdim in the driver. At this time, this interface is needed.
> >
> > >
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > What I dislike about this interface is that if
> > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then in the common
> > case
> > > of same parameters for all queues driver has to issue multiple
> > > commands.
> > > I can see either a special vq index (0xffff ?) or a special command
> > > used to set it for all queues.
> >
> > Although the structure is very similar, in fact, adding a new command may be
> > clearer.
>
> O(N) loop is not that bad when user want to issue change it per device, as this is something done very often.

Considering the software device, I think that sending too many commands in a row
may not be particularly friendly. I still want to retain global config.


> Once per VQ is supported, driver may just use the default net-dim to have best out of box experience, whenever device supports it.

I agree.

Thanks.

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

