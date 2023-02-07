Return-Path: <virtio-comment-return-3983-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 7 Feb 2023 12:51:26 +0000
Message-ID: <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] Re: [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .
 org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, February 7, 2023 6:50 AM
>=20
> On Tue, 7 Feb 2023 13:25:13 +0200, Alvaro Karsz <alvaro.karsz@solid-run.c=
om>
> wrote:
> > Hi Heng,
> >
> > > Currently, the coalescing profile is directly applied to all queues.
> > > This patch supports configuring the parameters for a specified queue.
> > >
> > > When the traffic between queues is unbalanced, for example, one
> > > queue is busy and another queue is idle, then it will be very useful
> > > to control coalescing parameters at the queue granularity.
> > >
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 42 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/content.tex b/content.tex index e863709..049c0e4 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device
> > > Types / Network Device / Feature bits
> \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > >      channel.
> > >
> > > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-
> queue
> > > +       notifications coalescing.
> > > +
> >
> > Since this feature allows us to change the coalescing parameters for
> > all the queues when rx/tx_qid =3D 0xFFFF, and since version 1.3 wasn't
> > released yet, maybe the "per-vq" functionality can be added to
> > VIRTIO_NET_F_NOTF_COAL instead of adding a new feature?
>=20
>=20
> According to my understanding, all the features of voting are formal. It =
can be
> used by the manufacturer.
>=20
> Of course, as far as I know, no manufacturer has used this feature for th=
e time
> being. But I think we should add a new feature.
>=20
> Or other people have other ideas.

I believe we should treat it as fix and avoid a new feature bit as spec is =
not released, and it is very recent change.

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

