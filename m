Return-Path: <pasic@linux.ibm.com>
Date: Fri, 2 Sep 2022 01:33:47 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH RFC v7 6/8] ccw:
 disallow ADMIN_VQ
Message-ID: <20220902013347.2cc8b344.pasic@linux.ibm.com>
In-Reply-To: <20220831104233-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
	<20220812171841.12183-7-mst@redhat.com>
	<20220816164811.16464110.pasic@linux.ibm.com>
	<20220816114216-mutt-send-email-mst@kernel.org>
	<20220818153958.7219f6b8.pasic@linux.ibm.com>
	<20220818235403-mutt-send-email-mst@kernel.org>
	<20220824014519.028ee16d.pasic@linux.ibm.com>
	<20220828052839-mutt-send-email-mst@kernel.org>
	<20220831163349.545f726d.pasic@linux.ibm.com>
	<20220831104233-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 31 Aug 2022 10:50:21 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > You seem to say that all the normative statements may be classified
> > into two categories:
> > C1) the other side does not rely on this requirement
> > C2) the other side does rely on this requirement
> > 
> > The requirements form C1 can be removed form future versions of the
> > spec, and devices may start not honoring these without breaking
> > compatibility because the other side did not rely on these being held
> > up in the first place.
> > 
> > The requirements from C2 can not be removed from future versions of the
> > spec, because a device compliant to the previous version of the spec
> > that relies on this requirement being fulfilled would break. And
> > interchangeability is about compatibility and interoperability -- so
> > that is no good.
> > 
> > I understand that reasoning. But what I don't understand is the
> > following: how is the reader of the specification supposed to decide
> > if a certain requirement is a C1 requirement or a C2 requirement.
> > Misclassifying a requirement could obviously pose a problem.  
> 
> The reader is supposed to satisfy all requirements.

I fullheartheadly agree with that. Ideally just both sides (the
device and the driver) satisfying all the normative requirements would
guarantee a favorable outcome for the end user: interoperability and at
least basic functionality.

I'm not sure we are there yet with virtio. 

> Whether it is ok to rely on requirements is a problem that
> unfortunately we don't always clarify.

I believe, we want the people to rely on the spec. AFAIU the
normative statements are the parts of the spec that are the
deserve the most to be relied upon.

[..]


> > 
> > I think, it would conceptually simplify things a lot if the avoided
> > normative statements that we hope to drop in the future. 
> > 
> > This is a rather academic discussion and probably not a worthwhile one.  
> 
> I absolutely understand where you are coming from... I'm fine just using
> SHOULD NOT here for now.

If we stick with the statement pair like proposed in this patch, in my
opinion only MUST NOT works. Let me cite those:
"""
+\devicenormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
+
+Device MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DeviceFeatures.
+
+\drivernormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
+
+Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DriverFeatures even if offered by the device.
"""

By the way I just noticed that in the second normative above the heading
says "Device Features" while the normative itself makes a statement about
"DriverFeatures".

IMHO we can remove both together, because any implementation that could
be adversely affected by the removal of both is non-conforming because
it violates one of these MUST NOT statements.

Also for the approach:  generic statement about handling feature
negotiations for features are non-viable in certain constellations (e.g.
some transport or the platform, or whatever lacks support or renders the
feature impossible to implement) + a list of features not supported by
certain transport, I came to prefer MUST NOT.

> Do you feel that's the way to go or have you changed your mind?
> Couldn't figure it out.
> 

I believe we are fine either way, but generic statement + list of cases
where this is known to apply is nicer to work with and evolve.
 
> 
> But generally, I feel C1 is the default unless there is text that
> explicitly says C2.
> 

Here we disagree. I believe most of our normative statements are such
that the can be relied upon by everyone including the other side.

[..]
> > Yet I prefer phrasings like this one where the phrasing of statement is
> > still valid for all future versions of the spec (just the parameters
> > change: in this case what is reserved and what is not).
> > 
> > Regards,
> > Halil  
> 
> 
> I guess it's a matter of taste.
> What worries me is that it's so easy to miss these implications.

I agree, it is a matter of taste. I believe what we code-wise want
is a transport specific mask both on the end of the device and on the
end of the driver which ensures that bits that corresponding features can
not be supported by entity that is doing its part of the negotiation are
not set. I believe having a list of such features in the specification
for each transport at an easy to locate place i s easier to map to code
than a bunch of normative statement pairs. And also manipulating this
list (adding to it, or removing form it) looks more straightforward to
me.

But I'm fine with either solution.

Regards,
Halil

