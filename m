Return-Path: virtio-return-3297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 12 Mar 2019 12:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190312121018-mutt-send-email-mst@kernel.org>
References: <20190312160109.7077-1-mst@redhat.com>
 <20190312170631.3f1a5118.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312170631.3f1a5118.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH v2] conformance: clarify
 transitional/non-transitional
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 12, 2019 at 05:06:31PM +0100, Cornelia Huck wrote:
> On Tue, 12 Mar 2019 12:01:41 -0400
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
> Wouldn't that be v4?

Donnu :(

> I'm currently very confused by the avalanche of patches and which issues
> they fix...

It could be easiest to follow links under ballots.
Each ballot is linked to the patch.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

