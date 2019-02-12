Return-Path: virtio-dev-return-5393-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4749985CE7
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 08:28:08 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com> <20190211092943-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190211092943-mutt-send-email-mst@kernel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 12 Feb 2019 00:27:54 -0800
Message-ID: <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > Our long term goal is to have as few kernel drivers as possible and to move
> > "drivers" into userspace. If we go with the virtqueues, is there
> > general a purpose
> > device/driver to talk between our host and guest to support custom hardware
> > (with own blobs)?
>
> The challenge is to answer the following question:
> how to do this without losing the benefits of standartization?

We looked into UIO and it still requires some kernel driver to tell
where the device is, it also has limitations on sharing a device
between processes. The benefit of standardization could be in avoiding
everybody writing their own UIO drivers for virtual devices.

Our emulator uses a battery, sound, accelerometer and more. We need to
support all of this. I looked into the spec, "5 Device types", and
seems "battery" is not there. We can invent our own drivers but we see
having one flexible driver is a better idea.

Yes, I realize that a guest could think it is using the same device as
the host advertised (because strings matched) while it is not. We
control both the host and the guest and we can live with this.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

