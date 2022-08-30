Return-Path: <pasic@linux.ibm.com>
Date: Tue, 30 Aug 2022 14:48:54 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio] [PATCH RFC v7 6/8] ccw: disallow ADMIN_VQ
Message-ID: <20220830144854.7853a573.pasic@linux.ibm.com>
In-Reply-To: <20220829142401-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
	<20220812171841.12183-7-mst@redhat.com>
	<20220816164811.16464110.pasic@linux.ibm.com>
	<20220816114216-mutt-send-email-mst@kernel.org>
	<20220818153958.7219f6b8.pasic@linux.ibm.com>
	<20220829142401-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 29 Aug 2022 14:28:05 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Aug 18, 2022 at 03:39:58PM +0200, Halil Pasic wrote:
[..]
> > Fair point!
> > 
> > I would prefer a driver normative which goes like this:
> > 
> > """
> > A driver SHOULD NOT accept features (i.e. have code that would do so if
> > the feature is offered) if the feature is not supported by the driver
> > (e.g. because unsupported by the transport), even if the specification
> > implies that the device can not offer these features in the first place
> > (e.g. because the feature is not yet supported by the transport.
> > """  
> 
> ok. why not MUST NOT?

I'm fine with MUST NOT. Since this is a general statement (i.e. not
scoped to ADMIN_VQ) I felt like SHOULD NOT is a bit safer because
provided somebody is doing this wrong for some feature already, it
wouldn't render that implementation outright non-compliant. But I
believe this is just a theoretical possibility. I'm fine with MUST NOT.

> 
> > And a similar device normative as well, which just that it may not offer
> > such features.
> > 
> > """
> > Note: The rationale behind the [reference to the normative] is that
> > while some features can not be implemented within the boundaries of the
> > current virtio specification, future incarnations of the specificaton may
> > make such implementations possible.  A most prominent example is optional
> > features dependent on optional virtio facilities whose transport specific
> > implementation is not yet specified for some transports. Should one end
> > gain the ability to support these features, the old implementation which
> > made the assumption that the other end will make sure these features are
> > not negotiated would end up negotiating something it can't actually
> > support.
> > """
> > 
> > 
> >   
> > > 
> > > So, Maybe just add text
> > > 
> > > Note: future versions of this specification will allow setting ADMIN_VQ
> > > for driver and device. Device MUST NOT assume driver does not
> > > acknowledge ADMIN_VQ if offered.  
> > 
> > I would not lean out of the window and promise something with regards to
> > future versions of this spec.  
> 
> s/will/might/

With this change it works like a charm!

> 
> > > 
> > > And similarly for drivers:
> > > 
> > > Note: future versions of this specification will allow setting ADMIN_VQ
> > > for driver and device. Drivers MUST NOT assume ADMIN_VQ if not offered.
> > >   
> > 
> > I think we can then make a note which references the generic normative
> > for each feature affected where it suits us.
> >   
> > > > 
> > > > If we want, we can also state what needs to be done in general when
> > > > features are unsupported by the transport. And yes, that normative
> > > > material in my opinion.
> > > > 
> > > > Regards,
> > > > Halil    
> > > 
> > > 
> > > Are there other examples? I want to call out the list explicitly because
> > > it is so easy to enable an extra feature by mistake.
> > >   
> > 
> > I don't think CCW supports the shared memory yet... But I may be wrong.
> >   
> > >   
> > > > >  \subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
> > > > >  
> > > > >  The device's configuration space is located in host memory.    
> > >   
> 

