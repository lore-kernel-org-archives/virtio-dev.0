Return-Path: virtio-dev-return-7688-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A414985DD1
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Aug 2020 05:32:56 +0000 (UTC)
Date: Thu, 20 Aug 2020 07:32:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200820053250.jy3fwuhy5josnfog@sirius.home.kraxel.org>
References: <20200810164113.GH3052@work-vm>
 <20200817051547.3cnv5jdrwcfr3xwe@sirius.home.kraxel.org>
 <20200819153528.GA2980@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200819153528.GA2980@work-vm>
Subject: Re: [virtio-dev] Re: virtio-input for copy/paste?
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, berrange@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> Right; what I was interested in was whether there would be a way to
> plumb copy/paste through for a VNC or local Gtk display; the guest view
> should be independent of the transport protocol.

Well.  Full-blown cut+paste is quite complex.  spice goes all-in and
supports cut+paste everything both ways.  The minimal thing would be
host -> guest support for "text/plain; charset=utf-8".  Quick google
search suggests the vnc protocol supports just that.

So, what exactly we are talking about?

> Perhaps that way is just to standardise on the virtio-serial channel
> that spice already uses and provide that for other transports;
> but if not then it feels like there should be some standard.

Not that easy I think, the channel is not used exclusively for
cut+paste but also some other, spice-specific stuff.

We could try integrate this into qemu guest agent.

Or use something completely separate.  qemu guest agent works at system
level whereas cut+paste would work on user session level.  spice solves
this by having both system and user daemon, where the user daemon talks
to the system daemon.  With a separate channel you wouldn't need the
system daemon as middle man though.

> > You also need the agent as user interface, so the user can explicitly
> > enable clipboard access for the other side (you don't want do this
> > automatically for security reasons: the guest should not be able to
> > sniff the passwords which you cut+paste on the host from password
> > manager to browser).
> 
> That should be on the host side-UI shouldn't it?

Guest UI too (you can make the same argument the other way around) if we
want support guest->host cut+paste.

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

