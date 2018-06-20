Return-Path: virtio-dev-return-4446-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id ED3835819139
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 20:13:48 -0700 (PDT)
Date: Wed, 20 Jun 2018 06:13:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620061219-mutt-send-email-mst@kernel.org>
References: <1490350679-19068-1-git-send-email-lprosek@redhat.com>
 <20170324234220-mutt-send-email-mst@kernel.org>
 <CABdb736T+YRoAdze-LYYqy+gZ495CnRXvi7cqS3gffhL9OoCYw@mail.gmail.com>
 <20170406011025-mutt-send-email-mst@kernel.org>
 <CABdb734uWaa8CUZ-WbHJ-70MONB+WUDfPHbmGYEXXa3AjPZotg@mail.gmail.com>
 <1491484886.12607.57.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491484886.12607.57.camel@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] Update virtio input device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 06, 2017 at 03:21:26PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > The downside is that this is hard to specify formally, the same way we
> > do other devices. Say we do that and point to a fixed version of the
> > relevant Linux headers and the headers evolve and add or change
> > something. Then we would either go change the spec to be in sync with
> > the headers or build a compatibility layer in the implementation.
> 
> Highly unlikely that the structs and ioctls in linux header change.
> It's userspace <=> kernel abi.  And even if they change some days it
> would have to happen in a backward compatible way.  So I think
> documenting the ioctl structs we have today is reasonable.  If new
> ioctls for new device types show up we probably need a virtio feature
> flag anyway to properly support them.
> 
> Events (new key codes for example) are added now and then.  So for them
> we might continue referencing the include file with the codes instead of
> copying them into the spec.
> 
> > because evdev
> > needs to maintain some reasonable backwards compatibility by itself so
> > it's very unlikely that things would break.
> 
> Yep.  Unknown events can simply be ignored.  And you can query the
> device to figure which events (aka keys / axis / ...) are supported
> (ioctl in evdev, config space in virtio).  So that level of
> compatibility is already taken care of, in both evdev and virtio.
> 
> > > Let's assume linux gains ability to generate new events on top of old
> > > ones.
> > > Do you want to send both in all cases?
> > > If you only send multitouch how do you handle old guests?
> > > If you send both how does new guest know it should
> > > ignore old  events?
> > 
> > I think that these are valid concerns but they need to be addressed at
> > the evdev layer, not in virtio.
> 
> Indeed.  And I think multitouch is addressed by simply sending both.
> Apps without multitouch support simply ignore the multitouch events.
> Apps with multitouch support can figure this is a multitouch-capable
> device and ignore the old events on those.
> 
> cheers,
>   Gerd


Gerd is there a chance you could try and address whatever
you think needs to be addressed and repost?

Would be nice to have this in 1.1 and I think it's better
to have an incomplete description than none.


> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

