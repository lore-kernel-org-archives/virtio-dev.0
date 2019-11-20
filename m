Return-Path: virtio-dev-return-6353-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55161985E71
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 12:13:35 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org> <72712fe048af1489368f7416faa92c45@hostfission.com>
In-Reply-To: <72712fe048af1489368f7416faa92c45@hostfission.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 21:13:18 +0900
Message-ID: <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Geoffrey McRae <geoff@hostfission.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Stevens <stevensd@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Geoffrey,

On Thu, Nov 7, 2019 at 7:28 AM Geoffrey McRae <geoff@hostfission.com> wrote=
:
>
>
>
> On 2019-11-06 23:41, Gerd Hoffmann wrote:
> > On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> >> > (1) The virtio device
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> > Has a single virtio queue, so the guest can send commands to registe=
r
> >> > and unregister buffers.  Buffers are allocated in guest ram.  Each b=
uffer
> >> > has a list of memory ranges for the data. Each buffer also has some
> >>
> >> Allocating from guest ram would work most of the time, but I think
> >> it's insufficient for many use cases. It doesn't really support things
> >> such as contiguous allocations, allocations from carveouts or <4GB,
> >> protected buffers, etc.
> >
> > If there are additional constrains (due to gpu hardware I guess)
> > I think it is better to leave the buffer allocation to virtio-gpu.
>
> The entire point of this for our purposes is due to the fact that we can
> not allocate the buffer, it's either provided by the GPU driver or
> DirectX. If virtio-gpu were to allocate the buffer we might as well
> forget
> all this and continue using the ivshmem device.

I don't understand why virtio-gpu couldn't allocate those buffers.
Allocation doesn't necessarily mean creating new memory. Since the
virtio-gpu device on the host talks to the GPU driver (or DirectX?),
why couldn't it return one of the buffers provided by those if
BIND_SCANOUT is requested?

>
> Our use case is niche, and the state of things may change if vendors
> like
> AMD follow through with their promises and give us SR-IOV on consumer
> GPUs, but even then we would still need their support to achieve the
> same
> results as the same issue would still be present.
>
> Also don't forget that QEMU already has a non virtio generic device
> (IVSHMEM). The only difference is, this device doesn't allow us to
> attain
> zero-copy transfers.
>
> Currently IVSHMEM is used by two projects that I am aware of, Looking
> Glass and SCREAM. While Looking Glass is solving a problem that is out
> of
> scope for QEMU, SCREAM is working around the audio problems in QEMU that
> have been present for years now.
>
> While I don't agree with SCREAM being used this way (we really need a
> virtio-sound device, and/or intel-hda needs to be fixed), it again is an
> example of working around bugs/faults/limitations in QEMU by those of us
> that are unable to fix them ourselves and seem to have low priority to
> the
> QEMU project.
>
> What we are trying to attain is freedom from dual boot Linux/Windows
> systems, not migrate-able enterprise VPS configurations. The Looking
> Glass project has brought attention to several other bugs/problems in
> QEMU, some of which were fixed as a direct result of this project (i8042
> race, AMD NPT).
>
> Unless there is another solution to getting the guest GPUs frame-buffer
> back to the host, a device like this will always be required. Since the
> landscape could change at any moment, this device should not be a LG
> specific device, but rather a generic device to allow for other
> workarounds like LG to be developed in the future should they be
> required.
>
> Is it optimal? no
> Is there a better solution? not that I am aware of
>
> >
> > virtio-gpu can't do that right now, but we have to improve virtio-gpu
> > memory management for vulkan support anyway.
> >
> >> > properties to carry metadata, some fixed (id, size, application), bu=
t
> >>
> >> What exactly do you mean by application?
> >
> > Basically some way to group buffers.  A wayland proxy for example would
> > add a "application=3Dwayland-proxy" tag to the buffers it creates in th=
e
> > guest, and the host side part of the proxy could ask qemu (or another
> > vmm) to notify about all buffers with that tag.  So in case multiple
> > applications are using the device in parallel they don't interfere with
> > each other.
> >
> >> > also allow free form (name =3D value, framebuffers would have
> >> > width/height/stride/format for example).
> >>
> >> Is this approach expected to handle allocating buffers with
> >> hardware-specific constraints such as stride/height alignment or
> >> tiling? Or would there need to be some alternative channel for
> >> determining those values and then calculating the appropriate buffer
> >> size?
> >
> > No parameter negotiation.
> >
> > cheers,
> >   Gerd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

