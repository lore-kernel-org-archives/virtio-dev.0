Return-Path: <mst@redhat.com>
Date: Mon, 29 Aug 2022 14:28:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio] [PATCH RFC v7 6/8] ccw: disallow ADMIN_VQ
Message-ID: <20220829142401-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-7-mst@redhat.com>
 <20220816164811.16464110.pasic@linux.ibm.com>
 <20220816114216-mutt-send-email-mst@kernel.org>
 <20220818153958.7219f6b8.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220818153958.7219f6b8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 18, 2022 at 03:39:58PM +0200, Halil Pasic wrote:
> On Tue, 16 Aug 2022 11:48:43 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Aug 16, 2022 at 04:48:11PM +0200, Halil Pasic wrote:
> > > On Fri, 12 Aug 2022 13:19:20 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  content.tex | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index 76b5a28..53be680 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -2668,6 +2668,16 @@ \subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Vi
> > > >  uses the CCW_CMD_WRITE_FEAT command, denoting a \field{features}/\field{index}
> > > >  combination.
> > > >  
> > > > +\devicenormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
> > > > +
> > > > +Device MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > > > +DeviceFeatures.
> > > > +
> > > > +\drivernormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
> > > > +
> > > > +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > > > +DriverFeatures even if offered by the device.
> > > > +  
> > > 
> > > I'm not sure I understand the intention here. I believe what we try to
> > > accomplish here is the following. The Channel I/O transport *currently*
> > > does not support the VIRTIO_F_ADMIN_VQ feature. It is not like we want
> > > to state that the feature VIRTIO_F_ADMIN_VQ won't ever be supported by
> > > the Channel I/O transport. Or am I wrong?
> > >
> > > If my assumptions are right, then the old incarnation of the spec could
> > > contradict the new incarnation of the spec. Thus I would prefer something
> > > like.  
> > 
> > Relaxing requirenents is always okay.
> 
> Are you telling me, that for instance a driver author may not rely on
> even the MUST type device normative behavior stated by the spec, because
> future incarnations of the spec could relax the requirements towards this
> particular device, for example by removing that device normative
> statement?
> 
> I always imagined, if the spec says the device or the driver MUST
> "something", then I as the implementer of the other end (driver or
> device, can rely on that "something"). If this assumption is wrong then
> I'm have to re-examine my entire mental model of the spec.
> 
> > 
> > > 
> > > """
> > > Currently the following features are not supported by the Channel I/O
> > > transport:
> > > * VIRTIO_F_ADMIN_VQ
> > > """  
> > 
> > what I want to prevent is driver saying "oh device will not set ADMIN_VQ
> > so it's ok to acknowledge it if offered, it is never offered even
> > though it does not suport it".
> > because then it becomes impossible to know when actually a new driver
> > appears with actual support.
> 
> Fair point!
> 
> I would prefer a driver normative which goes like this:
> 
> """
> A driver SHOULD NOT accept features (i.e. have code that would do so if
> the feature is offered) if the feature is not supported by the driver
> (e.g. because unsupported by the transport), even if the specification
> implies that the device can not offer these features in the first place
> (e.g. because the feature is not yet supported by the transport.
> """

ok. why not MUST NOT?

> And a similar device normative as well, which just that it may not offer
> such features.
> 
> """
> Note: The rationale behind the [reference to the normative] is that
> while some features can not be implemented within the boundaries of the
> current virtio specification, future incarnations of the specificaton may
> make such implementations possible.  A most prominent example is optional
> features dependent on optional virtio facilities whose transport specific
> implementation is not yet specified for some transports. Should one end
> gain the ability to support these features, the old implementation which
> made the assumption that the other end will make sure these features are
> not negotiated would end up negotiating something it can't actually
> support.
> """
> 
> 
> 
> > 
> > So, Maybe just add text
> > 
> > Note: future versions of this specification will allow setting ADMIN_VQ
> > for driver and device. Device MUST NOT assume driver does not
> > acknowledge ADMIN_VQ if offered.
> 
> I would not lean out of the window and promise something with regards to
> future versions of this spec.

s/will/might/

> > 
> > And similarly for drivers:
> > 
> > Note: future versions of this specification will allow setting ADMIN_VQ
> > for driver and device. Drivers MUST NOT assume ADMIN_VQ if not offered.
> > 
> 
> I think we can then make a note which references the generic normative
> for each feature affected where it suits us.
> 
> > > 
> > > If we want, we can also state what needs to be done in general when
> > > features are unsupported by the transport. And yes, that normative
> > > material in my opinion.
> > > 
> > > Regards,
> > > Halil  
> > 
> > 
> > Are there other examples? I want to call out the list explicitly because
> > it is so easy to enable an extra feature by mistake.
> > 
> 
> I don't think CCW supports the shared memory yet... But I may be wrong.
> 
> > 
> > > >  \subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
> > > >  
> > > >  The device's configuration space is located in host memory.  
> > 

