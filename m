Return-Path: <mst@redhat.com>
Date: Thu, 24 Nov 2022 03:15:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 01/10] virtio: document forward compatibility
 guarantees
Message-ID: <20221124031018-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-2-mst@redhat.com>
 <CACGkMEtk6YLic7zjDj-yd36piLSjx5h18eXYs4rKD=uKdqprzw@mail.gmail.com>
 <20221124015254-mutt-send-email-mst@kernel.org>
 <CACGkMEuxYxXU+bYGh79=-KzRRKA-hTvEkTbxej7c=8dB_Q_jZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuxYxXU+bYGh79=-KzRRKA-hTvEkTbxej7c=8dB_Q_jZA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 03:34:19PM +0800, Jason Wang wrote:
> On Thu, Nov 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 24, 2022 at 12:33:52PM +0800, Jason Wang wrote:
> > > On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > Feature negotiation forms the basis of forward compatibility
> > > > guarantees of virtio but has never been properly documented.
> > > > Do it now.
> > > >
> > > > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > >
> > > > diff --git a/content.tex b/content.tex
> > > > index 3051399..e3203be 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> > > >  In particular, new fields in the device configuration space are
> > > >  indicated by offering a new feature bit.
> > > >
> > > > +To keep te feature negotiation mechanism extensible, it is important
> > > > +that devices \em{do not} offer any feature bits that they would not be
> > > > +able to handle if the driver accepted them (even though drivers are not
> > > > +supposed to accept them in the first place even if offered, according to
> > > > +this version of the specification.)
> > >
> > > It looks to me if we want to clarify like this, feature negotiation is
> > > not sufficient. Do we need to do something similar in other basic
> > > facilities? Generally, we probably need to do this for facilities that
> > > are similar to features (status, virtqueue size and others).
> >
> > I'm not sure about "not sufficient". It's sufficient as long
> > as you just want to extend features. What triggered this
> > work is adding a transport specific feature.
> 
> E.g:
> 
> For status: Devices do not offer any status bit it would not be able to handle.
> For virtqueue size:  Devices do not offer virtqueue size it would not
> be able to handle.
> 
> ?

Jason I think what you miss here is this part:

"even though drivers are not
supposed to accept them in the first place even if offered, according to
this version of the specification"

does not apply to status and virtqueue size.


Let me clarify what all this means.
It seems safe for a device to offer a reserved feature bit
since drivers are not supposed to accept it.
This text says device must not rely on this.

How would this apply to status or vq size? I don't see.










> >
> >
> > > > Likewise, it is important that
> > > > +drivers \em{do not} accept feature bits they do not know how to handle
> > > > +(even though devices are not supposed to offer them in the first place,
> > > > +according to this version of the specification.) The preferred way for
> > > > +handling reserved and unexpected features is that the driver ignores
> > > > +them.
> > >
> > > I'm not sure this is the best way or whether we've defined the
> > > "unexpected features" before. It might be better to say that to accept
> > > the features that the driver understands.
> >
> > So specifically, if feature is documented as pci only and then
> > down the road we enable it for ccw. Does driver "understand" it? Or not?
> > It is clearly unexpected.
> > I am not too worried about using terms we didn't define this is not
> > part of a conformance statement.
> > And people seem to get the meaning ;)
> 
> Ok.
> 
> Thanks

