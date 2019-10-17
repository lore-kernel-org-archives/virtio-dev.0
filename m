Return-Path: virtio-dev-return-6254-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E93C7986018
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 16:22:44 +0000 (UTC)
MIME-Version: 1.0
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <20190923085637.bsaevedklweijgya@sirius.home.kraxel.org> <CAAFQd5Ba-REZU9=rdm3J6NRqqeAUFdCV7SJ_WdO2BHyKNBN7TQ@mail.gmail.com>
 <20191014121914.lyptm3gdmekvcu6v@sirius.home.kraxel.org> <CAAFQd5CaxYoXQ6z4pmdTG3FDN8ccEk3sHMnSkoNwL2==hk6znQ@mail.gmail.com>
 <CAEkmjvWuVcbMWh2Nzhrcm6vyggRJDMBmejPnkNOoMeLNkE1dNA@mail.gmail.com>
In-Reply-To: <CAEkmjvWuVcbMWh2Nzhrcm6vyggRJDMBmejPnkNOoMeLNkE1dNA@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Thu, 17 Oct 2019 09:22:30 -0700
Message-ID: <CAEkmjvXHDcv5VEGZDZpoK4uFkqHAbuamXwV-4deNpK0e5yHx3w@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007ae96f05951da0b9"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000007ae96f05951da0b9
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 17, 2019 at 8:00 AM Frank Yang <lfy@google.com> wrote:

>
>
> On Wed, Oct 16, 2019 at 11:58 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
>> On Mon, Oct 14, 2019 at 9:19 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >
>> > > > Well.  I think before even discussing the protocol details we need a
>> > > > reasonable plan for buffer handling.  I think using virtio-gpu
>> buffers
>> > > > should be an optional optimization and not a requirement.  Also the
>> > > > motivation for that should be clear (Let the host decoder write
>> directly
>> > > > to virtio-gpu resources, to display video without copying around the
>> > > > decoded framebuffers from one device to another).
>> > >
>> > > Just to make sure we're on the same page, what would the buffers come
>> > > from if we don't use this optimization?
>> > >
>> > > I can imagine a setup like this;
>> > >  1) host device allocates host memory appropriate for usage with host
>> > > video decoder,
>> > >  2) guest driver allocates arbitrary guest pages for storage
>> > > accessible to the guest software,
>> > >  3) guest userspace writes input for the decoder to guest pages,
>> > >  4) guest driver passes the list of pages for the input and output
>> > > buffers to the host device
>> > >  5) host device copies data from input guest pages to host buffer
>> > >  6) host device runs the decoding
>> > >  7) host device copies decoded frame to output guest pages
>> > >  8) guest userspace can access decoded frame from those pages; back
>> to 3
>> > >
>> > > Is that something you have in mind?
>> >
>> > I don't have any specific workflow in mind.
>> >
>> > If you want display the decoded video frames you want use dma-bufs
>> shared
>> > by video decoder and gpu, right?  So the userspace application (video
>> > player probably) would create the buffers using one of the drivers,
>> > export them as dma-buf, then import them into the other driver.  Just
>> > like you would do on physical hardware.  So, when using virtio-gpu
>> > buffers:
>> >
>> >   (1) guest app creates buffers using virtio-gpu.
>> >   (2) guest app exports virtio-gpu buffers buffers as dma-buf.
>> >   (3) guest app imports the dma-bufs into virtio-vdec.
>> >   (4) guest app asks the virtio-vdec driver to write the decoded
>> >       frames into the dma-bufs.
>> >   (5) guest app asks the virtio-gpu driver to display the decoded
>> >       frame.
>> >
>> > The guest video decoder driver passes the dma-buf pages to the host, and
>> > it is the host driver's job to fill the buffer.  How this is done
>> > exactly might depend on hardware capabilities (whenever a host-allocated
>> > bounce buffer is needed or whenever the hardware can decode directly to
>> > the dma-buf passed by the guest driver) and is an implementation detail.
>> >
>> > Now, with cross-device sharing added the virtio-gpu would attach some
>> > kind of identifier to the dma-buf, virtio-vdec could fetch the
>> > identifier and pass it to the host too, and the host virtio-vdec device
>> > can use the identifier to get a host dma-buf handle for the (virtio-gpu)
>> > buffer.  Ask the host video decoder driver to import the host dma-buf.
>> > If it all worked fine it can ask the host hardware to decode directly to
>> > the host virtio-gpu resource.
>> >
>>
>> Agreed.
>>
>> > > > Referencing virtio-gpu buffers needs a better plan than just
>> re-using
>> > > > virtio-gpu resource handles.  The handles are device-specific.
>> What if
>> > > > there are multiple virtio-gpu devices present in the guest?
>> > > >
>> > > > I think we need a framework for cross-device buffer sharing.  One
>> > > > possible option would be to have some kind of buffer registry, where
>> > > > buffers can be registered for cross-device sharing and get a unique
>> > > > id (a uuid maybe?).  Drivers would typically register buffers on
>> > > > dma-buf export.
>> > >
>> > > This approach could possibly let us handle this transparently to
>> > > importers, which would work for guest kernel subsystems that rely on
>> > > the ability to handle buffers like native memory (e.g. having a
>> > > sgtable or DMA address) for them.
>> > >
>> > > How about allocating guest physical addresses for memory corresponding
>> > > to those buffers? On the virtio-gpu example, that could work like
>> > > this:
>> > >  - by default a virtio-gpu buffer has only a resource handle,
>> > >  - VIRTIO_GPU_RESOURCE_EXPORT command could be called to have the
>> > > virtio-gpu device export the buffer to a host framework (inside the
>> > > VMM) that would allocate guest page addresses for it, which the
>> > > command would return in a response to the guest,
>> >
>> > Hmm, the cross-device buffer sharing framework I have in mind would
>> > basically be a buffer registry.  virtio-gpu would create buffers as
>> > usual, create a identifier somehow (details to be hashed out), attach
>> > the identifier to the dma-buf so it can be used as outlined above.
>> >
>> > Also note that the guest manages the address space, so the host can't
>> > simply allocate guest page addresses.
>>
>> Is this really true? I'm not an expert in this area, but on a bare
>> metal system it's the hardware or firmware that sets up the various
>> physical address allocations on a hardware level and most of the time
>> most of the addresses are already pre-assigned in hardware (like the
>> DRAM base, various IOMEM spaces, etc.).
>>
>> I think that means that we could have a reserved region that could be
>> used by the host for dynamic memory hot-plug-like operation. The
>> reference to memory hot-plug here is fully intentional, we could even
>> use this feature of Linux to get struct pages for such memory if we
>> really wanted.
>>
>>
> Wouldn't normal hotplug result in Linux trying to claim what you just hot
> plugged?
>
>
>> > Mapping host virtio-gpu resources
>> > into guest address space is planned, it'll most likely use a pci memory
>> > bar to reserve some address space.  The host can map resources into that
>> > pci bar, on guest request.
>>
>> Sounds like a viable option too. Do you have a pointer to some
>> description on how this would work on both host and guest side?
>>
>>
> I've been following the conv. and I'd like to have a more in depth
> discussion sometime. On the Android Emulator, we've successfully been
> mapping host memory into the PCI bar for graphics applications where host
> visible/coherent memory is needed (Vulkan) or has benefits for
> performance/compatibility (gralloc with CPU usage, as a substitute for
> ashmem).
>
> We use the address space driver
> <https://android.googlesource.com/kernel/goldfish/+/refs/heads/android-goldfish-4.14-dev/drivers/misc/goldfish_address_space.c>
>  + device
> <https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address_space.c>,
> which through the PING ioctl allows notifications from guest to host and
> allows all the implementation to be in VMM or guest userspace. I had a
> previous spec
> <https://github.com/741g/virtio-spec/blob/master/virtio-hostmem.tex>(virtio-hostmem)
> on making a version of the addr. space device for virtio, but we got
> sidetracked in various ways. One technical point from there was deciding on
> whether the host needed to allocate everything up front. Wonder if now that
> it's acceptable to map host memory on guest request into that, we can
> revisit the virtio-hostmem idea.
>
>

In terms of video decode specifically, we're able to allocate host memory
for the video codec, then map it to the guest via the PCI bar, and then the
guest ends up using the decoded frame in graphics. But, once it does so,
and the guest wants to upload the deocded frame as a texture or something,
on the VMM side we'd already be aware of the physical address (host virtual
address) where the decoded frame lives, regardless of how many layers and
other abstractions the decoded frame travels through (assuming it doesn't
get copied, but if it does, then we properly emulate the fact).

The situation is probably a bit more complex for video decode that is done
on hardware without copying to cpu memory. We haven't really addressed that
yet. I imagine on the VMM side, video codec decodes in hardware to some
image or texture that is associated with a dmabuf, or a native_handle_t, or
an OpenGL texture. But then the guest userspace shouldn't really care that
they are related on the VMM side as long as the VMM has a consistent
interface with whatever shared image kernel abstr / library (layers above
virtio) the guest uses?

>
>> > >  - virtio-gpu driver could then create a regular DMA-buf object for
>> > > such memory, because it's just backed by pages (even though they may
>> > > not be accessible to the guest; just like in the case of TrustZone
>> > > memory protection on bare metal systems),
>> >
>> > Hmm, well, pci memory bars are *not* backed by pages.  Maybe we can use
>> > Documentation/driver-api/pci/p2pdma.rst though.  With that we might be
>> > able to lookup buffers using device and dma address, without explicitly
>> > creating some identifier.  Not investigated yet in detail.
>>
>> Not backed by pages as in "struct page", but those are still regular
>> pages of the physical address space. That said, currently the sg_table
>> interface is only able to describe physical memory using struct page
>> pointers. It's been a long standing limitation affecting even bare
>> metal systems, so perhaps it's just the right time to make them
>> possible to use some other identifiers, like PFNs? There is at least
>> one more free bit in the page_link field, which could mean that the
>> field contains a PFN instead of a struct page pointer.
>>
>> Best regards,
>> Tomasz
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>>

--0000000000007ae96f05951da0b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 2019 at 8:00 AM Frank=
 Yang &lt;<a href=3D"mailto:lfy@google.com">lfy@google.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 16, 2019 at 11:58 PM Tomasz Figa &lt;<a hr=
ef=3D"mailto:tfiga@chromium.org" target=3D"_blank">tfiga@chromium.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon=
, Oct 14, 2019 at 9:19 PM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat=
.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; &gt; Well.=C2=A0 I think before even discussing the protocol deta=
ils we need a<br>
&gt; &gt; &gt; reasonable plan for buffer handling.=C2=A0 I think using vir=
tio-gpu buffers<br>
&gt; &gt; &gt; should be an optional optimization and not a requirement.=C2=
=A0 Also the<br>
&gt; &gt; &gt; motivation for that should be clear (Let the host decoder wr=
ite directly<br>
&gt; &gt; &gt; to virtio-gpu resources, to display video without copying ar=
ound the<br>
&gt; &gt; &gt; decoded framebuffers from one device to another).<br>
&gt; &gt;<br>
&gt; &gt; Just to make sure we&#39;re on the same page, what would the buff=
ers come<br>
&gt; &gt; from if we don&#39;t use this optimization?<br>
&gt; &gt;<br>
&gt; &gt; I can imagine a setup like this;<br>
&gt; &gt;=C2=A0 1) host device allocates host memory appropriate for usage =
with host<br>
&gt; &gt; video decoder,<br>
&gt; &gt;=C2=A0 2) guest driver allocates arbitrary guest pages for storage=
<br>
&gt; &gt; accessible to the guest software,<br>
&gt; &gt;=C2=A0 3) guest userspace writes input for the decoder to guest pa=
ges,<br>
&gt; &gt;=C2=A0 4) guest driver passes the list of pages for the input and =
output<br>
&gt; &gt; buffers to the host device<br>
&gt; &gt;=C2=A0 5) host device copies data from input guest pages to host b=
uffer<br>
&gt; &gt;=C2=A0 6) host device runs the decoding<br>
&gt; &gt;=C2=A0 7) host device copies decoded frame to output guest pages<b=
r>
&gt; &gt;=C2=A0 8) guest userspace can access decoded frame from those page=
s; back to 3<br>
&gt; &gt;<br>
&gt; &gt; Is that something you have in mind?<br>
&gt;<br>
&gt; I don&#39;t have any specific workflow in mind.<br>
&gt;<br>
&gt; If you want display the decoded video frames you want use dma-bufs sha=
red<br>
&gt; by video decoder and gpu, right?=C2=A0 So the userspace application (v=
ideo<br>
&gt; player probably) would create the buffers using one of the drivers,<br=
>
&gt; export them as dma-buf, then import them into the other driver.=C2=A0 =
Just<br>
&gt; like you would do on physical hardware.=C2=A0 So, when using virtio-gp=
u<br>
&gt; buffers:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0(1) guest app creates buffers using virtio-gpu.<br>
&gt;=C2=A0 =C2=A0(2) guest app exports virtio-gpu buffers buffers as dma-bu=
f.<br>
&gt;=C2=A0 =C2=A0(3) guest app imports the dma-bufs into virtio-vdec.<br>
&gt;=C2=A0 =C2=A0(4) guest app asks the virtio-vdec driver to write the dec=
oded<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0frames into the dma-bufs.<br>
&gt;=C2=A0 =C2=A0(5) guest app asks the virtio-gpu driver to display the de=
coded<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0frame.<br>
&gt;<br>
&gt; The guest video decoder driver passes the dma-buf pages to the host, a=
nd<br>
&gt; it is the host driver&#39;s job to fill the buffer.=C2=A0 How this is =
done<br>
&gt; exactly might depend on hardware capabilities (whenever a host-allocat=
ed<br>
&gt; bounce buffer is needed or whenever the hardware can decode directly t=
o<br>
&gt; the dma-buf passed by the guest driver) and is an implementation detai=
l.<br>
&gt;<br>
&gt; Now, with cross-device sharing added the virtio-gpu would attach some<=
br>
&gt; kind of identifier to the dma-buf, virtio-vdec could fetch the<br>
&gt; identifier and pass it to the host too, and the host virtio-vdec devic=
e<br>
&gt; can use the identifier to get a host dma-buf handle for the (virtio-gp=
u)<br>
&gt; buffer.=C2=A0 Ask the host video decoder driver to import the host dma=
-buf.<br>
&gt; If it all worked fine it can ask the host hardware to decode directly =
to<br>
&gt; the host virtio-gpu resource.<br>
&gt;<br>
<br>
Agreed.<br>
<br>
&gt; &gt; &gt; Referencing virtio-gpu buffers needs a better plan than just=
 re-using<br>
&gt; &gt; &gt; virtio-gpu resource handles.=C2=A0 The handles are device-sp=
ecific.=C2=A0 What if<br>
&gt; &gt; &gt; there are multiple virtio-gpu devices present in the guest?<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I think we need a framework for cross-device buffer sharing.=
=C2=A0 One<br>
&gt; &gt; &gt; possible option would be to have some kind of buffer registr=
y, where<br>
&gt; &gt; &gt; buffers can be registered for cross-device sharing and get a=
 unique<br>
&gt; &gt; &gt; id (a uuid maybe?).=C2=A0 Drivers would typically register b=
uffers on<br>
&gt; &gt; &gt; dma-buf export.<br>
&gt; &gt;<br>
&gt; &gt; This approach could possibly let us handle this transparently to<=
br>
&gt; &gt; importers, which would work for guest kernel subsystems that rely=
 on<br>
&gt; &gt; the ability to handle buffers like native memory (e.g. having a<b=
r>
&gt; &gt; sgtable or DMA address) for them.<br>
&gt; &gt;<br>
&gt; &gt; How about allocating guest physical addresses for memory correspo=
nding<br>
&gt; &gt; to those buffers? On the virtio-gpu example, that could work like=
<br>
&gt; &gt; this:<br>
&gt; &gt;=C2=A0 - by default a virtio-gpu buffer has only a resource handle=
,<br>
&gt; &gt;=C2=A0 - VIRTIO_GPU_RESOURCE_EXPORT command could be called to hav=
e the<br>
&gt; &gt; virtio-gpu device export the buffer to a host framework (inside t=
he<br>
&gt; &gt; VMM) that would allocate guest page addresses for it, which the<b=
r>
&gt; &gt; command would return in a response to the guest,<br>
&gt;<br>
&gt; Hmm, the cross-device buffer sharing framework I have in mind would<br=
>
&gt; basically be a buffer registry.=C2=A0 virtio-gpu would create buffers =
as<br>
&gt; usual, create a identifier somehow (details to be hashed out), attach<=
br>
&gt; the identifier to the dma-buf so it can be used as outlined above.<br>
&gt;<br>
&gt; Also note that the guest manages the address space, so the host can&#3=
9;t<br>
&gt; simply allocate guest page addresses.<br>
<br>
Is this really true? I&#39;m not an expert in this area, but on a bare<br>
metal system it&#39;s the hardware or firmware that sets up the various<br>
physical address allocations on a hardware level and most of the time<br>
most of the addresses are already pre-assigned in hardware (like the<br>
DRAM base, various IOMEM spaces, etc.).<br>
<br>
I think that means that we could have a reserved region that could be<br>
used by the host for dynamic memory hot-plug-like operation. The<br>
reference to memory hot-plug here is fully intentional, we could even<br>
use this feature of Linux to get struct pages for such memory if we<br>
really wanted.<br>
<br></blockquote><div><br></div><div>Wouldn&#39;t normal hotplug result in =
Linux trying to claim what you just hot plugged?</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Mapping host virtio-gpu resources<br>
&gt; into guest address space is planned, it&#39;ll most likely use a pci m=
emory<br>
&gt; bar to reserve some address space.=C2=A0 The host can map resources in=
to that<br>
&gt; pci bar, on guest request.<br>
<br>
Sounds like a viable option too. Do you have a pointer to some<br>
description on how this would work on both host and guest side?<br>
<br></blockquote><div><br></div><div>I&#39;ve been following the conv. and =
I&#39;d like to have a more in depth discussion sometime. On the Android Em=
ulator, we&#39;ve successfully been mapping host memory into the PCI bar fo=
r graphics applications where host visible/coherent memory is needed (Vulka=
n) or has benefits for performance/compatibility (gralloc with CPU usage, a=
s a substitute for ashmem).</div><div><br></div><div>We use the address spa=
ce <a href=3D"https://android.googlesource.com/kernel/goldfish/+/refs/heads=
/android-goldfish-4.14-dev/drivers/misc/goldfish_address_space.c" target=3D=
"_blank">driver</a>=C2=A0+=C2=A0<a href=3D"https://android.googlesource.com=
/platform/external/qemu/+/refs/heads/emu-master-dev/hw/pci/goldfish_address=
_space.c" target=3D"_blank">device</a>, which through the PING ioctl allows=
 notifications from guest to host and allows all the implementation to be i=
n VMM or guest userspace. I had a previous <a href=3D"https://github.com/74=
1g/virtio-spec/blob/master/virtio-hostmem.tex" target=3D"_blank">spec </a>(=
virtio-hostmem) on making a version of the addr. space device for virtio, b=
ut we got sidetracked in various ways. One technical point from there was d=
eciding on whether the host needed to allocate everything up front. Wonder =
if now that it&#39;s acceptable to map host memory on guest request into th=
at, we can revisit the virtio-hostmem idea.</div><div>=C2=A0</div></div></d=
iv></blockquote><div><br></div><div>In terms of video decode specifically, =
we&#39;re able to allocate host memory for the video codec, then map it to =
the guest via the PCI bar, and then the guest ends up using the decoded fra=
me in graphics. But, once it does so, and the guest wants to upload the deo=
cded=C2=A0frame as a texture or something, on the VMM side we&#39;d already=
 be aware of the physical address (host virtual address) where the decoded =
frame lives, regardless of how many layers and other abstractions the decod=
ed frame travels through (assuming it doesn&#39;t get copied, but if it doe=
s, then we properly emulate the fact).</div><div><br></div><div>The situati=
on is probably a bit more complex for video decode that is done on hardware=
 without copying to cpu memory. We haven&#39;t really addressed that yet. I=
 imagine on the VMM side, video codec decodes in hardware to some image or =
texture that is associated with a dmabuf, or a native_handle_t, or an OpenG=
L texture. But then the guest userspace shouldn&#39;t really care that they=
 are related on the VMM side as long as the VMM has a consistent interface =
with whatever shared image kernel abstr / library (layers above virtio) the=
 guest uses?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
&gt;<br>
&gt; &gt;=C2=A0 - virtio-gpu driver could then create a regular DMA-buf obj=
ect for<br>
&gt; &gt; such memory, because it&#39;s just backed by pages (even though t=
hey may<br>
&gt; &gt; not be accessible to the guest; just like in the case of TrustZon=
e<br>
&gt; &gt; memory protection on bare metal systems),<br>
&gt;<br>
&gt; Hmm, well, pci memory bars are *not* backed by pages.=C2=A0 Maybe we c=
an use<br>
&gt; Documentation/driver-api/pci/p2pdma.rst though.=C2=A0 With that we mig=
ht be<br>
&gt; able to lookup buffers using device and dma address, without explicitl=
y<br>
&gt; creating some identifier.=C2=A0 Not investigated yet in detail.<br>
<br>
Not backed by pages as in &quot;struct page&quot;, but those are still regu=
lar<br>
pages of the physical address space. That said, currently the sg_table<br>
interface is only able to describe physical memory using struct page<br>
pointers. It&#39;s been a long standing limitation affecting even bare<br>
metal systems, so perhaps it&#39;s just the right time to make them<br>
possible to use some other identifiers, like PFNs? There is at least<br>
one more free bit in the page_link field, which could mean that the<br>
field contains a PFN instead of a struct page pointer.<br>
<br>
Best regards,<br>
Tomasz<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000007ae96f05951da0b9--
