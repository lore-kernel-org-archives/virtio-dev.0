Return-Path: <virtio-comment-return-4013-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 02:43:02 +0000
Message-ID: <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: RE: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .
  org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, February 7, 2023 9:25 PM
>=20
> On Wed, 8 Feb 2023 02:20:27 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Tuesday, February 7, 2023 8:46 PM
> > >
> > > On Tue, 7 Feb 2023 09:06:19 -0500, "Michael S. Tsirkin"
> > > <mst@redhat.com>
> > > wrote:
> > > > On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
> > > > > Currently, the coalescing profile is directly applied to all queu=
es.
> > > > > This patch supports configuring the parameters for a specified qu=
eue.
> > > > >
> > > > > When the traffic between queues is unbalanced, for example, one
> > > > > queue is busy and another queue is idle, then it will be very
> > > > > useful to control coalescing parameters at the queue granularity.
> > > >
> > > > ethtool does not support this though, does it? what's the plan?
> > >
> > >
> > > Although it can be done, I think it is difficult to let users use
> > > ethtool to modify the parameters of each queue.
> > >
> > > At present ethtool supports adaptive-rx/adaptive-tx. This is that
> > > the driver automatically adapted to the appropriate parameter.
> > > Generally, it is implemented using netdim in the driver. At this time=
, this
> interface is needed.
> > >
> > > >
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > > What I dislike about this interface is that if
> > > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then in the
> common
> > > case
> > > > of same parameters for all queues driver has to issue multiple
> > > > commands.
> > > > I can see either a special vq index (0xffff ?) or a special
> > > > command used to set it for all queues.
> > >
> > > Although the structure is very similar, in fact, adding a new
> > > command may be clearer.
> >
> > O(N) loop is not that bad when user want to issue change it per device,=
 as this
> is something done very often.
> > Once per VQ is supported, driver may just use the default net-dim to ha=
ve
> best out of box experience, whenever device supports it.
>=20
>=20
> So you mean, we only support the parameters based on Per-Queue. My
> original idea is to support two methods at the same time.

Yes, if we want to support both the modes, that better to have such command=
.
Because otherwise the device implementation is bit clumsy which needs to do=
 the guess work.
For example, driver has configured global params per device.
Now suddenly driver configured first queues parameter.
At this point device should run N-1 queues using global mode and 1 queue wi=
th per Q param.

Similar sequence also occurs when there is per q params configured and sudd=
enly driver configures global param.
Even in this case now device either must iterate internally and move per q =
to global values.

Better to avoid such complexity in device around implicit and confusing beh=
avior.

I see two options.
1. Just have per VQ params. Software has the full knowledge of in which it =
is operating, and state remains at software level.
This effectively achieves both the mode.

2. Have a mode cmd,=20
Mode =3D (a) per device or (b) per VQ (c) disable
After the mode is set, driver can set per device or per VQ.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

