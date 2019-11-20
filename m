Return-Path: virtio-dev-return-6351-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49DD9985E6F
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 11:58:29 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org> <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
In-Reply-To: <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 20:58:11 +0900
Message-ID: <CAAFQd5ASJ0yEXY-V0j+c8nBQ1Q=k9SUU48AZ_8haLezUb_yN-A@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Frank Yang <lfy@google.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Frank,

On Fri, Nov 8, 2019 at 12:10 AM Frank Yang <lfy@google.com> wrote:
>
> So I'm not really sure why people are having issues sharing buffers that =
live on the GPU. Doesn't that show up as some integer ID on the host, and s=
ome $GuestFramework (dmabuf, gralloc) ID on the guest, and it all works out=
 due to maintaining the correspondence in your particular stack of virtual =
devices? For example, if you want to do video decode in hardware on an Andr=
oid guest, there should be a gralloc buffer whose handle contains enough in=
formation to reconstruct the GPU buffer ID on the host, because gralloc is =
how processes communicate gpu buffer ids to each other on Android.

I don't think we really have any issues with that. :)

We just need a standard for:
a) assignment of buffer IDs that the guest can refer to,
b) making all virtual devices understand the IDs from a) when such are
passed to them by the guest.

>
> BTW, if we have a new device just for this, this should also be more flex=
ible than being udmabuf on the host. There are other OSes than Linux. Keep =
in mind, also, that across different drivers even on Linux, e.g., NVIDIA pr=
oprietary, dmabuf might not always be available.
>
> As for host CPU memory that is allocated in various ways, I think Android=
 Emulator has built a very flexible/general solution, esp if we need to sha=
re a host CPU buffer allocated via something thats not completely under our=
 control, such as Vulkan. We reserve a PCI BAR for that and map memory dire=
ctly from the host Vk drier into there, via the address space device. It's
>
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
master-dev/hw/pci/goldfish_address_space.c
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
master-dev/android/android-emu/android/emulation/address_space_device.cpp#2=
05

I recall that we already agreed on exposing host memory to the guests
using PCI BARs. There should be work-in-progress patches for
virtio-gpu to use that instead of shadow buffers and transfers.

>
> Number of copies is also completely under the user's control, unlike ivsh=
mem. It also is not tied to any particular device such as gpu or codec. Sin=
ce the memory is owned by the host and directly mapped to the guest PCI wit=
hout any abstraction, it's contiguous, it doesn't carve out guest RAM, does=
n't waste CMA, etc.

That's one of the reasons we use host-based allocations in VMs running
on Chrome OS. That said, I think everyone here agrees that it's a good
optimization that should be specified and implemented.

P.S. The common mailing list netiquette recommends bottom posting and
plain text emails.

Best regards,
Tomasz

>
> On Thu, Nov 7, 2019 at 4:13 AM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
>>
>> On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > > In the graphics buffer sharing use case, how does the other side
>> > > determine how to interpret this data?
>> >
>> > The idea is to have free form properties (name=3Dvalue, with value bei=
ng
>> > a string) for that kind of metadata.
>> >
>> > > Shouldn't there be a VIRTIO
>> > > device spec for the messaging so compatible implementations can be
>> > > written by others?
>> >
>> > Adding a list of common properties to the spec certainly makes sense,
>> > so everybody uses the same names.  Adding struct-ed properties for
>> > common use cases might be useful too.
>>
>> Why not define VIRTIO devices for wayland and friends?
>>
>> This new device exposes buffer sharing plus properties - effectively a
>> new device model nested inside VIRTIO.  The VIRTIO device model has
>> the necessary primitives to solve the buffer sharing problem so I'm
>> struggling to see the purpose of this new device.
>>
>> Custom/niche applications that do not wish to standardize their device
>> type can maintain out-of-tree VIRTIO devices.  Both kernel and
>> userspace drivers can be written for the device and there is already
>> VIRTIO driver code that can be reused.  They have access to the full
>> VIRTIO device model, including feature negotiation and configuration
>> space.
>>
>> Stefan
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

