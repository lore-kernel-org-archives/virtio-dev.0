Return-Path: <pasic@linux.ibm.com>
Date: Wed, 31 Aug 2022 16:33:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH RFC v7 6/8] ccw:
 disallow ADMIN_VQ
Message-ID: <20220831163349.545f726d.pasic@linux.ibm.com>
In-Reply-To: <20220828052839-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-7-mst@redhat.com>
 <20220816164811.16464110.pasic@linux.ibm.com>
 <20220816114216-mutt-send-email-mst@kernel.org>
 <20220818153958.7219f6b8.pasic@linux.ibm.com>
 <20220818235403-mutt-send-email-mst@kernel.org>
 <20220824014519.028ee16d.pasic@linux.ibm.com>
 <20220828052839-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, 28 Aug 2022 05:35:53 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > Like here:
> > > 	 +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > > 	 +DriverFeatures even if offered by the device.
> > > 
> > > This makes sure that drivers do not make an assumption that
> > > devices do not set the bit. But yes, maybe spell it out:
> > > 
> > > 	 +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > > 	 +DriverFeatures even if offered by the device.
> > > 	 +Driver MUST NOT assume that device does not offer VIRTIO_F_ADMIN_VQ.
> > > 	 +In particular driver MUST NOT fail feature negotiation if
> > > 	 +device offers VIRTIO_F_ADMIN_VQ.
> > > 
> > > ok now?  
> > 
> > Sorry, it still does not work for me. But I may be wrong. My problem
> > is that what we mean is the following:
> > 
> > If the driver (where driver includes both the transport part and the
> > transport agnostic part) does not support VIRTIO_F_ADMIN_VQ then it must
> > not set VIRTIO_F_ADMIN_VQ. And any reasoning along the lines "hey the
> > device was not supposed to offer that bit in the first place" is
> > misguided.  
> 
> Yes, this is exactly what I'm trying to prevent here.
> 
> > The crucial part here is that the MUST NOT accept VIRTIO_F_ADMIN_VQ
> > partee is only applicable if the driver does not support
> > VIRTIO_F_ADMIN_VQ. That is, if we happen to extend the Channel I/O transport, and we
> > decide to implement VIRTIO_F_ADMIN_VQ for the over Channel I/O devices,
> > that MUST NOT accept does not get in the way.  
> 
> Then we'll describe how it works in the spec and then drop this.
> 
> > My problem with your proposal is, that the MUST NOT is not guarded by a
> > proper precondition (it is a prohibition that does not allow for any
> > exceptions).
> > 
> > I would very much like Conny to chime in on this.
> > 
> > Regards,
> > Halil  
> 
> But we do this all the time. We disallow some behaviour then
> following spec versions start allowing it.
> 
> Basically removing a requirement is ok as long as the other side
> does not rely on it.
> 

Sorry I don't want to delay this any further. It is unlikely to
do any harm so I'm fine with moving forward with this.

TLDR: I agree: it would be safe to remove both of the statements
you introduce with this patch once the transport gains support
for the feature.

But I would still prefer being generic about the problem and maintaining
a list of not (yet) supported features rather than adding and removing
normative statement pairs. Just like we do for features, and also in your
cfg_type example.

The rest are my thoughts on the implications. 

You seem to say that all the normative statements may be classified
into two categories:
C1) the other side does not rely on this requirement
C2) the other side does rely on this requirement

The requirements form C1 can be removed form future versions of the
spec, and devices may start not honoring these without breaking
compatibility because the other side did not rely on these being held
up in the first place.

The requirements from C2 can not be removed from future versions of the
spec, because a device compliant to the previous version of the spec
that relies on this requirement being fulfilled would break. And
interchangeability is about compatibility and interoperability -- so
that is no good.

I understand that reasoning. But what I don't understand is the
following: how is the reader of the specification supposed to decide
if a certain requirement is a C1 requirement or a C2 requirement.
Misclassifying a requirement could obviously pose a problem.

Some examples where it may not be entirely obvious if it is C1 or C2:

2.1.2:
The device MUST NOT consume buffers or send any used buffer
notifications to the driver before DRIVER_OK. 

2.2.1
The driver MUST NOT accept a feature which the device did not offer, and
MUST NOT accept a feature which requires another feature which was not
accepted.

2.4.1
Drivers MUST NOT limit structure size and device configuration space
size.

After some more thinking... Regarding whether the other side (B) is
allowed to rely on a certain normative requirement or not really boils
down to the question is there a normative statement that explicitly prohibits
the other side (B) to rely on the property of the other side (A) that is
implied by the first normative statement. I think feature bits are a
good example.

I think, it would conceptually simplify things a lot if the avoided
normative statements that we hope to drop in the future. 

This is a rather academic discussion and probably not a worthwhile one.



> For example, we had this for a while:
> 
> 
> 	The driver MUST ignore any vendor-specific capability structure which has
> 	a reserved \field{cfg_type} value.
> 
> 
> but the meaning of a "reserved cfg_type" changed over time, allowing
> driver to access new cfg_type values.

Right! I completely agree, our goal is that version N and version N+M
should be interoperable.  And that does not mean that every
device/driver that is compliant to version N+M must also be compliant
to the version N of the spec. I agree that having when adding new
stuff the entity implementing the new stuff must be non-compliant
to the statements of the previous specification that say the unknown
stuff must be fenced.

Yet I prefer phrasings like this one where the phrasing of statement is
still valid for all future versions of the spec (just the parameters
change: in this case what is reserved and what is not).

Regards,
Halil

