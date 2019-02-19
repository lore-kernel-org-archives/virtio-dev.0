Return-Path: virtio-dev-return-5457-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CBD4985B8C
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 07:54:27 +0000 (UTC)
Date: Tue, 19 Feb 2019 08:54:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> As another example, consider camera / video playback. I've heard that the
> way to approach this
> is to build v4l2 and build a virtio-v4l2 layer underneath.

That would be one option, yes.  virtio-v4l2 is a pretty bad name though,
I'd name it virtio-camera or virtio-media (if you want both capture and
playback) and you don't have to mimic the v4l2 api at virtio level.
That might simlify pass-through of v4l2 host devices, but isn't
necessarily the best choice long-term.

Alternatively emulate something existing, USB Video Class device for
example.

> However, this would mean either assuming v4l2 on host which is not
> portable to non-Linux, or requiring additional translation layers
> between v4l2 in the guest and $library on the host.

Well, sure, you need to wire up the host side somehow anyway.  Emulate
something virtual, feed the guest camera with image data from the host
camera, ...

> With the proposed spec, a more general 'codec' device can be
> implemented, tested on actual programs on multiple guests/hosts
> easily, and then, if it makes sense, "promoted" to a new
> "virtio-codec" device type.

I fail to see how a more general device avoids host-specific code (to
talk to the host camera, for example).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

