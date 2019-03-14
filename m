Return-Path: virtio-return-3310-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 14 Mar 2019 19:06:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190314065825-mutt-send-email-mst@kernel.org>
References: <20190313014750.3438-1-mst@redhat.com>
	<20190313130836.3b5294c4@oc2783563651>
	<20190314065825-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190314190617.6c02225b@oc2783563651>
Subject: Re: [virtio] [PATCH v4] conformance: clarify
 transitional/non-transitional
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 14 Mar 2019 07:06:07 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 13, 2019 at 01:08:36PM +0100, Halil Pasic wrote:
> > On Tue, 12 Mar 2019 21:48:13 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > We already have a specification for conformance targets for
> > > non-transitional devices.
> > > Just add another clause that transitional devices satisfy.
> > > 
> > > VIRTIO-167
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
[..]
> > 
> > Hm, I actually liked that v3 spelled out, that legacy is not
> > standardized (no normative exists).
> 
> Right but then I started worrying that
> - this was not actually what the defect report said.
>   it was basically just complaining that this chapter was not
>   linked into any conformance targets.

I think whether legacy is a normative or a non-normative part of the
virtio spec is what we need to decide on in the first place.

If it is normative it needs to get linked to some conformance targets.
If it isn't normative, it should not be a part of the conformance
chapter.

I think the latter is closer to how we as a community see this, but I'm
not sure.

In any case if we decide legacy is normative then we need to change "7.1
Conformance Targets" or change the conformance statements.

Let me explain. Currently we have the conformance targets "driver"
and "device". We would need to change this to something like
"non-transitional driver", "transitional driver", "non-transitional
device" and "non-transitional device" if we decide to change the targets,
or declare that there is a variable e.g. called 'transitional' which may
take the values 'transitional' and 'non-transitional'. But then we would
need to convert the 'Legacy Interface' sections to 'if transitional
has the value transitional' parts of the respective normative statements.

In any case making legacy interface a normative part of the spec requires
IMHO more work than this patch does.


>   so it's an unrelated concern - why not defer it to 1.2?

I'm all for deferring VIRTIO-167.

> - can one argue that this is a material change?
>   we don't want to come up with these at this stage

I would argue that making legacy interface a normative part of the spec
is a material change.

> - we actually specified quite a lot about legacy interfaces.
>   so since we did the work already, why through it away?
> 

IMHO we should not throw it away. But we should make the form suit the
intention. The intention of the conformance targets of virtio
specification is a standard that guarantees conforming
implementations are interoperable.

The intention behind the description of the legacy interface is not to
standardize it, but to help people cope with the virtio stuff that
emerged before virtio 1.0.

> > v4 makes things look like
> > 'transitional' is a separate conformance profile, and that the
> > description of  the legacy interface is normative.
> 
> 
> I think it kind of is, isn't it?
> 

The blurb of your v3 states the opposite:
"""
... legacy device descriptions are non-normative.
  In fact virtio 0.9 is non-normative as a whole
  and always was by design: it was early days and
  spec evolved to document bugs in implementations.
"""

And I believe this is the truth. We certainly can make legacy interface
normative, but then we need to take care of the formal requirements.

I see no benefit in making the legacy interface normative, because
AFAIU we don't expect legacy implementations to get fixed if they don't
conform to what is written in 'Legacy Interface'. AFAIU this is about
helping people to deal with legacy, but not about claims that something
is compliant to the legacy profile.


> > I took the liberty and tweaked your v3. As stated before, I don't think
> > transitional vs non-transitional is a big issue. I'm basically fine with
> > anything.
> > 
> > Regards,
> > Halil
> 
> Yea me too. For reasons above I prefer the more limited change in v4.
> But if you prefer pls post your version separately as a patch and we
> can have the TC choose by a ballot.
> 

I've just sent out a modified version of it. It ain't perfect. As said
before my preferred course of action would be:
* defer resolving VIRTIO-167
* figure out how do we want to resolve VIRTIO-167 by figuring out do we
want to have a normative description of the legacy interface or not
* figure out how to change the spec accordingly (remove legacy form
  conformance; or add a variable or add more conformance targets that
  cover legacy)

Cheers,
Halil

[..]


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

