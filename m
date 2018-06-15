Return-Path: virtio-dev-return-4400-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EE6F21CB807D
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jun 2018 06:39:09 -0700 (PDT)
Date: Fri, 15 Jun 2018 21:39:11 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180615133911.GA30056@debian>
References: <20180611075640.19751-1-tiwei.bie@intel.com>
 <2eb17c91-9158-c14f-e582-223dd6e5c6d2@linux.ibm.com>
 <20180615151329-mutt-send-email-mst@kernel.org>
 <545e8649-8029-d135-e927-3ad11f4eb29d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545e8649-8029-d135-e927-3ad11f4eb29d@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3] content: enhance device requirements for
 feature bits
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 15, 2018 at 02:42:58PM +0200, Halil Pasic wrote:
> On 06/15/2018 02:19 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 15, 2018 at 02:10:11PM +0200, Halil Pasic wrote:
> > > 
> > > 
> > > On 06/11/2018 09:56 AM, Tiwei Bie wrote:
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/14
> > > > ---
> > > > v2:
> > > > - Refine the wording (Cornelia);
> > > > 
> > > > v3:
> > > > - Refine the wording (MST);
> > > > 
> > > >    content.tex | 7 +++++++
> > > >    1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index f996fad..3c7d67d 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -125,6 +125,13 @@ which was not offered.  The device SHOULD accept any valid subset
> > > >    of features the driver accepts, otherwise it MUST fail to set the
> > > >    FEATURES_OK \field{device status} bit when the driver writes it.
> > > > +If a device has successfully negotiated a set of features
> > > > +at least once (by accepting the FEATURES_OK \field{device
> > > > +status} bit during device initialization), then it SHOULD
> > > > +NOT fail re-negotiation of the same set of features after
> > > > +a device or system reset.  Failure to do so would interfere
> > > > +with resuming from suspend and error recovery.
> > > > +
> > > 
> > > 
> > > Sorry people but I don't get it. I mean it is kind of reasonable
> > > to assume that with a given device and a given driver (given, i.e.
> > > nothing changes) the two will always negotiate the same features
> > > (including the extremal case where the negotiation fails).
> > > 
> > > Either the device or a driver rolling a dice to make feature negotiation
> > > more fun seems quite unreasonable. So I assume this is not what we are
> > > bothering to soft prohibit here.
> > > 
> > > So the interesting scenario seems to be when stuff changes. When
> > > migrating the implementation of the device could change. Or something
> > > changes regarding the resources used to provide the virtual device.
> > > 
> > > But then, if the device really can not support the set of features
> > > it used to be able, I guess the SHOULD does not take effect (I guess
> > > that is the difference compared to MUST).
> > > 
> > > Bottom line is: I tried to figure out what is this about, but I failed.
> > > I've read https://github.com/oasis-tcs/virtio-spec/issues/14 too but
> > > it did not click. I would appreciate some assistance.
> > 
> > It's exactly what it says. Let's say you negotiated a feature and then
> > device sets NEED_RESET.  Driver must now reset the device and put it
> > back in the same state it had before the reset, then resubmit
> > requests that were available but never used.
> > 
> > What if any of the features changed? Device suddenly
> > needs to check for requests which do not match the
> > features.
> > 
> > Suspend is similar: guests tend to assume hardware
> > does not change across suspend/resume, any changes
> > tend to make resume fail.
> > 
> 
> Thank you very much! But it still does not answer why would a device
> want to do that (fail to negotiate a feature that it was able
> to negotiate before). So I'm still in the dark about what are we
> trading for what.

Hi Halil,

Just like what you said, normally there is no reason
for a device to fail to negotiate a feature that it
was able to negotiate before. But the spec doesn't
forbid devices to do this , i.e. the spec allows a
device to fail to negotiate a feature that it was
able to negotiate before, which could cause problems
in some cases. Although everything works fine in
reality because there is no device would really do
this, it would be better to make spec to explicitly
forbid devices to do this in the necessary cases.

Best regards,
Tiwei Bie

> 
> Is there somewhere a patch that fixes such a bug? Maybe that would
> help me understand what can be done at the device to avoid the
> problem.
> 
> Regards,
> Halil
> 
> 
> > > 
> > > >    \subsection{Legacy Interface: A Note on Feature
> > > >    Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
> > > >    Bits / Legacy Interface: A Note on Feature Bits}
> > > > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

