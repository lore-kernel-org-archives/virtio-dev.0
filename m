Return-Path: virtio-dev-return-7664-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF41798425C
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Aug 2020 05:15:52 +0000 (UTC)
Date: Mon, 17 Aug 2020 07:15:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200817051547.3cnv5jdrwcfr3xwe@sirius.home.kraxel.org>
References: <20200810164113.GH3052@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200810164113.GH3052@work-vm>
Subject: [virtio-dev] Re: virtio-input for copy/paste?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, berrange@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 10, 2020 at 05:41:13PM +0100, Dr. David Alan Gilbert wrote:
> Hi,
>   Is there anywhere that virtio has where host/guest copy/paste would
> fit?

Well, spice supports it, with spice client and spice guest agent talking
to each other using a virtio-serial channel (guest <-> spice-server) and
a spice protocol tunnel (spice-server <-> spice-client).

You'll need a guest agent anyway, to bridge between window system
(x11/wayland/...) and device, so running some protocol over a stream
doesn't look bad to me as design choice.  These days you might choose
vsock instead (depends on how you design the host side though).

You also need the agent as user interface, so the user can explicitly
enable clipboard access for the other side (you don't want do this
automatically for security reasons: the guest should not be able to
sniff the passwords which you cut+paste on the host from password
manager to browser).

> I don't think it's something we have defined at the moment
> and I was wondering if virtio-input would be the right place to add it.
> If the client driver supported the feature then the host would
> hand it to the client, if it didn't it could insert a string
> of key events.

The problem with such a fallback is keyboard maps.  virtio-input sends
scancodes not keysyms.  Even with us-ascii this is a problem (querty vs.
quertz), and it doesn't become easier with =E2=82=AC =C3=A6 =C3=A4 =C3=9F a=
nd emoji ...

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

