Return-Path: virtio-return-3308-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 14 Mar 2019 07:06:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190314065825-mutt-send-email-mst@kernel.org>
References: <20190313014750.3438-1-mst@redhat.com>
 <20190313130836.3b5294c4@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313130836.3b5294c4@oc2783563651>
Subject: Re: [virtio] [PATCH v4] conformance: clarify
 transitional/non-transitional
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 13, 2019 at 01:08:36PM +0100, Halil Pasic wrote:
> On Tue, 12 Mar 2019 21:48:13 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > We already have a specification for conformance targets for
> > non-transitional devices.
> > Just add another clause that transitional devices satisfy.
> > 
> > VIRTIO-167
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Same patch was previouly sent as v2.
> > 
> >  conformance.tex | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/conformance.tex b/conformance.tex
> > index 6df113b..8b69e39 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -341,13 +341,9 @@ A conformant implementation MUST be either transitional or
> >  non-transitional, see \ref{intro:Legacy
> >  Interface: Terminology}.
> >  
> > -A non-transitional implementation conforms to this specification
> > -if it satisfies all of the MUST or REQUIRED level requirements
> > -defined above.
> > -
> > -An implementation MAY choose to implement OPTIONAL support for the
> > +A transitional implementation MUST implement support for the
> >  legacy interface, including support for legacy drivers
> > -or devices, by additionally conforming to all of the MUST or
> > +or devices, by conforming to all of the MUST or
> >  REQUIRED level requirements for the legacy interface
> >  for the transitional devices and drivers.
> >  
> 
> Hm, I actually liked that v3 spelled out, that legacy is not
> standardized (no normative exists).

Right but then I started worrying that
- this was not actually what the defect report said.
  it was basically just complaining that this chapter was not
  linked into any conformance targets.
  so it's an unrelated concern - why not defer it to 1.2?
- can one argue that this is a material change?
  we don't want to come up with these at this stage
- we actually specified quite a lot about legacy interfaces.
  so since we did the work already, why through it away?

> v4 makes things look like
> 'transitional' is a separate conformance profile, and that the
> description of  the legacy interface is normative.


I think it kind of is, isn't it?

> I took the liberty and tweaked your v3. As stated before, I don't think
> transitional vs non-transitional is a big issue. I'm basically fine with
> anything.
> 
> Regards,
> Halil

Yea me too. For reasons above I prefer the more limited change in v4.
But if you prefer pls post your version separately as a patch and we
can have the TC choose by a ballot.


> --------------------------------8<--------------------------------------
> diff --git a/conformance.tex b/conformance.tex
> index ad7e82e..53be96e 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -338,22 +338,18 @@ A socket device MUST conform to the following normative statements:
>  Transitional Driver Conformance}\label{sec:Conformance / Legacy
>  Interface: Transitional Device and 
>  Transitional Driver Conformance}
> -A conformant implementation MUST be either transitional or
> -non-transitional, see \ref{intro:Legacy
> -Interface: Terminology}.
> -
> -A non-transitional implementation conforms to this specification
> -if it satisfies all of the MUST or REQUIRED level requirements
> -defined above.
> -
> -An implementation MAY choose to implement OPTIONAL support for the
> -legacy interface, including support for legacy drivers
> -or devices, by additionally conforming to all of the MUST or
> -REQUIRED level requirements for the legacy interface
> -for the transitional devices and drivers.
> -
> -The requirements for the legacy interface for transitional implementations
> -are located in sections named ``Legacy Interface'' listed below:
> +
> +A transitional driver or device is a conforming driver or device (as
> +defined by section \ref{sec:Conformance / Conformance Targets}) that aims
> +for interoperability with the existing body of legacy devices or drivers
> +(see \ref{intro:Legacy Interface: Terminology}).
> +
> +No normative specification for the legacy interface exists, but to
> +facilitate inter-operability with non-conforming legacy implementations,
> +known differences between the legacy interface and the standard interface
> +are documented in non-normative sections named ``Legacy Interface''
> +listed below:
>  \begin{itemize}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device /
>  Feature Bits / Legacy Interface: A Note on Feature Bits}

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

