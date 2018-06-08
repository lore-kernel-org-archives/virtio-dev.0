Return-Path: virtio-dev-return-4327-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 502B35818F80
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 09:05:45 -0700 (PDT)
Date: Fri, 8 Jun 2018 19:05:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608190440-mutt-send-email-mst@kernel.org>
References: <20180608065928.2456-1-tiwei.bie@intel.com>
 <20180608093617.3fc9b951.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608093617.3fc9b951.cohuck@redhat.com>
Subject: [virtio-dev] Re: [PATCH] content: enhance device requirements for feature bits
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 08, 2018 at 09:36:17AM +0200, Cornelia Huck wrote:
> On Fri,  8 Jun 2018 14:59:28 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/14
> > ---
> >  content.tex | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index f996fad..8374d3f 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -125,6 +125,13 @@ which was not offered.  The device SHOULD accept any valid subset
> >  of features the driver accepts, otherwise it MUST fail to set the
> >  FEATURES_OK \field{device status} bit when the driver writes it.
> >  
> > +If a device has successfully negotiated a set of features
> > +at least once (by setting the FEATURES_OK \field{device
> > +status} bit when the driver writes it), then it SHOULD NOT
> 
> Hm, it's the driver that sets FEATURES_OK, not the device. What about
> "by succeeding to set"?

I think the best terminology we have is
"accept the FEATURES_OK status bit during device initialization"
that's from the mmio chapter.

> > +fail re-negotiation of the same set of features after a
> > +device or system reset.  Failure to do so would interfere
> > +with the resuming from suspend and error recovery.
> 
> s/the resuming/resuming/
> 
> > +
> >  \subsection{Legacy Interface: A Note on Feature
> >  Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
> >  Bits / Legacy Interface: A Note on Feature Bits}

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

