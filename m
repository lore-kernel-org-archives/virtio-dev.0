Return-Path: virtio-dev-return-6702-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1DEE98610C
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Feb 2020 17:28:47 +0000 (UTC)
Date: Fri, 7 Feb 2020 18:28:42 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200207182842.770bfb27@collabora.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello everyone,

I recently took over Tomeu's task of upstreaming virtio-wayland. After
spending quite a bit of time collecting information from his different
attempts [1][2] I wanted to sync with all the people that were involved
in the previous discussions (if I missed some of them, feel free to add
them back).

The goal here is to get a rough idea of the general direction this
should take so I can start implementing a PoC and see if it fits
everyone's needs.

virtio-wayland [3] started as a solution to pass wayland messages
between host and guests so the guest can execute wayland apps whose
surface buffers are passed to the wayland compositor running on the
host. While this was its primary use case, I've heard it's been used to
transport other protocols. And that's not surprising, when looking at
the code I noticed it was providing a protocol-agnostic message passing
interface between host and guests, similar to what VSOCK provides but
with FD passing as an extra feature.

Based on all previous discussions, I could identify 3 different
approaches:

    1/ Use VSOCK and extend it to support passing (some) FDs
    2/ Use a user space VSOCK-based proxy that's in charge of
       a/ passing regular messages
       b/ passing specific handles to describe objects shared
          between host and guest (most focus has been on dmabufs as
          this is what we really care about for the gfx use case,
          but other kind of FDs can be emulated through a
          VSOCK <-> UNIX_SOCK bridging)
    3/ Have a dedicated kernel space solution that provides features
       exposed by #1 but through a virtio device interface (basically
       what virtio-wayland does today)

Each of them has its pros and cons, which I'll try to sum-up (please
correct me if I'm wrong, and add new things if you think they are
missing).

#1 might require extra care if we want to make it safe, as pointed
out by Stefan here [4] (but I wonder if the problem is not the same
for a virtio-wayland based solution). Of course you also need a bit of
infrastructure to register FD <-> VFD mappings (VFD being a virtual
file descriptor that's only used as unique IDs identifying the resource
backed by the local FD). FD <-> VFD mappings would have to be created
by the subsystem in charge of the object backing the FD (virtio-gpu for
exported GEM buffers, virtio-vdec for video buffers, vsock for unix
sockets if we decide to bridge unix and vsock sockets to make it
transparent, ...). The FD <-> VFD mapping would also have to be created
on the host side, probably by the virtio device implementation
(virglrenderer for GEM bufs for instance), which means host and guest
need a way to inform the other end that a new FD <-> VFD mapping has
been created so the other end can create a similar mapping (I guess this
requires extra device-specific commands to work). Note that this
solution doesn't look so different from the virtio-dmabuf [5] approach
proposed by Gerd a few months back, it's just extended to be a global
VFD <-> FD registry instead of a dmabuf <-> unique-handle one. One
great thing about this approach is that we can re-use it for any kind
of FD sharing, not just dmabufs.

#2 is a bit challenging, since it requires the proxy to know about all
possible kind of FDs and do a FD <-> unique handle conversion with some
help from the subsystem backing the FD. For dmabufs, that means we
need to know who created the dmabuf, or assume that only one device is
used for all allocations (virtio-gpu?). AFAIU, there's also a security
issue as one could pass random (but potentially valid) handles to the
host proxy (pointed out by Tomasz [6]).

#3 is pretty similar to #1 in its design except that, instead of using
the VSOCK infrastructure it's using a new type of virtio device. I
guess it has the same pros and cons #1 has, and the name should probably
be changed to reflect the fact that it can transmit any kind of data not
just wayland.

This is just a high level view of the problem and the solutions proposed
by various people over the years. I'm sure I'm missing tons of details
and don't realize yet all the complexity behind solution #1, but looking
at this summary, I wonder if I should investigate this solution in
priority. An alternative could be to rebrand virtio-wayland, but as I
said, it's close enough to VSOCK to try to merge the missing features
in VSOCK instead. This being said, I'm not yet set on any of those
solutions, and the point of this email is to see with all of you which
option I should investigate first.

Note that option #3 is already implemented (would have to be polished
for upstream), IIRC option #2 has been partially implemented by Tomeu
but I'm not sure it was finished, and option #1 has just been discussed
so far [2].

Any feedback/comment is welcome.

Thanks,

Boris

[1]https://lore.kernel.org/patchwork/patch/878268/
[2]https://www.spinics.net/lists/kvm/msg159206.html
[3]https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrome=
os-4.19/drivers/virtio/virtio_wl.c
[4]https://www.spinics.net/lists/kvm/msg159206.html
[5]https://markmail.org/message/jeh5xjjxvylyrbur
[6]https://www.spinics.net/lists/kvm/msg185688.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

