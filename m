Return-Path: virtio-dev-return-6299-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBC5F985F02
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Nov 2019 15:10:24 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org> <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
In-Reply-To: <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Thu, 7 Nov 2019 07:10:15 -0800
Message-ID: <CAEkmjvU8or7YT7CCBe7aUx-XQ3yJpUrY4CfBOnqk7pUH9d9RGQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007eb04b0596c310f0"
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000007eb04b0596c310f0
Content-Type: text/plain; charset="UTF-8"

So I'm not really sure why people are having issues sharing buffers that
live on the GPU. Doesn't that show up as some integer ID on the host, and
some $GuestFramework (dmabuf, gralloc) ID on the guest, and it all works
out due to maintaining the correspondence in your particular stack of
virtual devices? For example, if you want to do video decode in hardware on
an Android guest, there should be a gralloc buffer whose handle contains
enough information to reconstruct the GPU buffer ID on the host, because
gralloc is how processes communicate gpu buffer ids to each other on
Android.

BTW, if we have a new device just for this, this should also be more
flexible than being udmabuf on the host. There are other OSes than Linux.
Keep in mind, also, that across different drivers even on Linux, e.g.,
NVIDIA proprietary, dmabuf might not always be available.

As for host CPU memory that is allocated in various ways, I think Android
Emulator has built a very flexible/general solution, esp if we need to
share a host CPU buffer allocated via something thats not completely under
our control, such as Vulkan. We reserve a PCI BAR for that and map memory
directly from the host Vk drier into there, via the address space device.
It's

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address_space.c

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulation/address_space_device.cpp#205


Number of copies is also completely under the user's control, unlike
ivshmem. It also is not tied to any particular device such as gpu or codec.
Since the memory is owned by the host and directly mapped to the guest PCI
without any abstraction, it's contiguous, it doesn't carve out guest RAM,
doesn't waste CMA, etc.

On Thu, Nov 7, 2019 at 4:13 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > In the graphics buffer sharing use case, how does the other side
> > > determine how to interpret this data?
> >
> > The idea is to have free form properties (name=value, with value being
> > a string) for that kind of metadata.
> >
> > > Shouldn't there be a VIRTIO
> > > device spec for the messaging so compatible implementations can be
> > > written by others?
> >
> > Adding a list of common properties to the spec certainly makes sense,
> > so everybody uses the same names.  Adding struct-ed properties for
> > common use cases might be useful too.
>
> Why not define VIRTIO devices for wayland and friends?
>
> This new device exposes buffer sharing plus properties - effectively a
> new device model nested inside VIRTIO.  The VIRTIO device model has
> the necessary primitives to solve the buffer sharing problem so I'm
> struggling to see the purpose of this new device.
>
> Custom/niche applications that do not wish to standardize their device
> type can maintain out-of-tree VIRTIO devices.  Both kernel and
> userspace drivers can be written for the device and there is already
> VIRTIO driver code that can be reused.  They have access to the full
> VIRTIO device model, including feature negotiation and configuration
> space.
>
> Stefan
>
>

--0000000000007eb04b0596c310f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So I&#39;m not really sure why people are having issues sh=
aring buffers that live on the GPU. Doesn&#39;t that show up as some intege=
r ID on the host, and some $GuestFramework (dmabuf, gralloc) ID on the gues=
t, and it all works out due to maintaining the correspondence in your parti=
cular stack of virtual devices? For example, if you want to do video decode=
 in hardware on an Android guest, there should be a gralloc buffer whose ha=
ndle contains enough information to reconstruct the GPU buffer ID on the ho=
st, because gralloc is how processes communicate gpu buffer ids to each oth=
er on Android.<div><br></div><div>BTW, if we have a new device just for thi=
s, this should also be more flexible than being udmabuf on the host. There =
are other OSes than Linux. Keep in mind, also, that across different driver=
s even on Linux, e.g., NVIDIA proprietary, dmabuf might not always be avail=
able.<div><br><div>As for host CPU memory that is allocated in various ways=
, I think Android Emulator has built a very flexible/general solution, esp =
if we need to share a host CPU buffer allocated via something thats not com=
pletely under our control, such as Vulkan. We reserve a PCI BAR for that an=
d map memory directly from the host Vk drier into there, via the address sp=
ace device. It&#39;s=C2=A0</div><div><br></div><div><a href=3D"https://andr=
oid.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/=
pci/goldfish_address_space.c">https://android.googlesource.com/platform/ext=
ernal/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address_space.c</a>=
=C2=A0</div><div><a href=3D"https://android.googlesource.com/platform/exter=
nal/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulation/=
address_space_device.cpp#205">https://android.googlesource.com/platform/ext=
ernal/qemu/+/refs/heads/emu-master-dev/android/android-emu/android/emulatio=
n/address_space_device.cpp#205</a>=C2=A0<br></div><div><br></div><div><div>=
Number of copies is also completely under the user&#39;s control, unlike iv=
shmem. It also is not tied to any particular device such as gpu or codec. S=
ince the memory is owned by the host and directly mapped to the guest PCI w=
ithout any abstraction, it&#39;s contiguous, it doesn&#39;t carve out guest=
 RAM, doesn&#39;t waste CMA, etc.</div></div></div></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 7, 201=
9 at 4:13 AM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stef=
anha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, Nov 6, 2019 at 1:50 PM Gerd Hoffmann &lt;<a href=3D"m=
ailto:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:=
<br>
&gt; &gt; In the graphics buffer sharing use case, how does the other side<=
br>
&gt; &gt; determine how to interpret this data?<br>
&gt;<br>
&gt; The idea is to have free form properties (name=3Dvalue, with value bei=
ng<br>
&gt; a string) for that kind of metadata.<br>
&gt;<br>
&gt; &gt; Shouldn&#39;t there be a VIRTIO<br>
&gt; &gt; device spec for the messaging so compatible implementations can b=
e<br>
&gt; &gt; written by others?<br>
&gt;<br>
&gt; Adding a list of common properties to the spec certainly makes sense,<=
br>
&gt; so everybody uses the same names.=C2=A0 Adding struct-ed properties fo=
r<br>
&gt; common use cases might be useful too.<br>
<br>
Why not define VIRTIO devices for wayland and friends?<br>
<br>
This new device exposes buffer sharing plus properties - effectively a<br>
new device model nested inside VIRTIO.=C2=A0 The VIRTIO device model has<br=
>
the necessary primitives to solve the buffer sharing problem so I&#39;m<br>
struggling to see the purpose of this new device.<br>
<br>
Custom/niche applications that do not wish to standardize their device<br>
type can maintain out-of-tree VIRTIO devices.=C2=A0 Both kernel and<br>
userspace drivers can be written for the device and there is already<br>
VIRTIO driver code that can be reused.=C2=A0 They have access to the full<b=
r>
VIRTIO device model, including feature negotiation and configuration<br>
space.<br>
<br>
Stefan<br>
<br>
</blockquote></div>

--0000000000007eb04b0596c310f0--
