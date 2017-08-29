Return-Path: virtio-dev-return-2504-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B29A258190DA
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Aug 2017 14:13:53 -0700 (PDT)
Date: Wed, 30 Aug 2017 00:13:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170830000452-mutt-send-email-mst@kernel.org>
References: <20170829200759.13975-1-willemdebruijn.kernel@gmail.com>
 <20170829200759.13975-3-willemdebruijn.kernel@gmail.com>
 <20170829231606-mutt-send-email-mst@kernel.org>
 <CAF=yD-L95x1EPKFeiPiZ2hbTzwYmDaG9O54+0tUW_4opuRKDMw@mail.gmail.com>
 <20170829233525-mutt-send-email-mst@kernel.org>
 <CAF=yD-+gPOYSgq8ckJ4wt3TPQYEnnB36g=Q5G4=yfoesGc=4hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-+gPOYSgq8ckJ4wt3TPQYEnnB36g=Q5G4=yfoesGc=4hA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH RFC 2/2] virtio_net: enable probing for NEEDS_RESET
 support
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Willem de Bruijn <willemb@google.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 29, 2017 at 05:02:29PM -0400, Willem de Bruijn wrote:
> + virtio-dev
> 
> On Tue, Aug 29, 2017 at 4:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Aug 29, 2017 at 04:27:41PM -0400, Willem de Bruijn wrote:
> >> On Tue, Aug 29, 2017 at 4:16 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Tue, Aug 29, 2017 at 04:07:59PM -0400, Willem de Bruijn wrote:
> >> >> From: Willem de Bruijn <willemb@google.com>
> >> >>
> >> >> Implement a mechanism to signal that a virtio device implements the
> >> >> VIRTIO_CONFIG_S_NEEDS_RESET command.
> >> >>
> >> >> Testing for VIRTIO_CONFIG_S_NEEDS_RESET support by issuing the request
> >> >> and verifying the reset state would require an expensive state change.
> >> >>
> >> >> To avoid that, add a status bit to the feature register used during
> >> >> feature negotiation between host and guest.
> >> >>
> >> >> Set the bit for virtio-net, which supports the feature.
> >> >>
> >> >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >> >
> >> > All virtio 1 devices have the reset feature
> >>
> >> I don't quite follow. No device drivers implement this request currently?
> >
> > Depends. Spec 1.0 describes the bit and that driver can respond
> > by reseting the device. You seem to do something else
> > in this patchset, but as designed in 1.0 it does not seem to need
> > a feature bit.
> 
> I see. So support is designed to be best effort?
> 
> The feature bit is only needed if driver support is optional.
> 
> The ack response is necessary if the device acts differently
> depending on whether the reset happened. The device has
> to reset its local state, too, so I think that this is needed.

That reset should only happen when guest driver resets the device.
And spec already has a mechanism for that anyway.

> 
> >> > so maybe guest does
> >> > not need this flag. Does device need it? Does device really
> >> > care that guest can't recover?
> >>
> >> If all device drivers support it, then the flag is not needed.
> >>
> >> But as long as legacy device drivers can exist that do not support
> >> this feature, it has to have a way of differentiating between the two.
> >
> > Why? Device won't set this unless it's in a bad state. In that case,
> > setting the bit is harmless even if drivers ignore it.
> 
> The goal is for the device to be able to rely on the driver reset to get
> to a good state even if it gets it into a bad state.
> 
> That allows it to implement optimizations that could get it into that bad
> state.

I see. I don't think this is what the need reset was designed for.

We can extend it to cover this case but let's add a bit more
documentation then.

And in particular won't it be better if we could just reset one ring,
and not the whole device state? This might be nicer so flows on other
rings aren't disrupted.

> 
> In particular, in the edge case where the device performs backpressure,
> takes the descriptor out of the avail ring and does not immediately post
> it to the used ring.
> 
> A reset will make the guest free all delayed packets and treat any
> unsent and unacknowledged as network drops. This allows the
> device to indeed drop long delayed packets when they eventually
> surface (e.g., leave a qdisc queue).

In this particular case, won't it be easier for device to just
report all packets as used, without involving the guest?

> This is of course not safe with
> zerocopy packets.


I wonder if we can teach kernel to drop zero copy packets too.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

