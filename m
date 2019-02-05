Return-Path: virtio-dev-return-5372-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DA6A985BE9
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Feb 2019 15:21:50 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm> <CAEkmjvWdSyMyy0=2CEN7LtX7XpDYNpVXeZfQTV2mz5rXkWmWmQ@mail.gmail.com>
In-Reply-To: <CAEkmjvWdSyMyy0=2CEN7LtX7XpDYNpVXeZfQTV2mz5rXkWmWmQ@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Tue, 5 Feb 2019 07:21:39 -0800
Message-ID: <CAEkmjvVd9G1pPoEwTkNkUY8-9K3F8CUatC=uVS-ovKMgF-mCrg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f7222a0581272a22"
Subject: Re: [virtio-dev] Memory sharing device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000f7222a0581272a22
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 5, 2019 at 7:17 AM Frank Yang <lfy@google.com> wrote:

> Hi all,
>
> I'm Frank who's been using Roman's goldfish address space driver for
> Vulkan host visible memory for the emulator. Some more in-depth replies
> inline.
>
> On Tue, Feb 5, 2019 at 2:04 AM Dr. David Alan Gilbert <dgilbert@redhat.com>
> wrote:
>
>> * Roman Kiryanov (rkir@google.com) wrote:
>> > Hi Gerd,
>> >
>> > > virtio-gpu specifically needs that to support vulkan and opengl
>> > > extensions for coherent buffers, which must be allocated by the host
>> gpu
>> > > driver.  It's WIP still.
>> >
>>
>> Hi Roman,
>>
>> > the proposed spec says:
>> >
>> > +Shared memory regions MUST NOT be used to control the operation
>> > +of the device, nor to stream data; those should still be performed
>> > +using virtqueues.
>>
>> Yes, I put that in.
>>
>> > Is there a strong reason to prohibit using memory regions for control
>> purposes?
>> > Our long term goal is to have as few kernel drivers as possible and to
>> move
>> > "drivers" into userspace. If we go with the virtqueues, is there
>> > general a purpose
>> > device/driver to talk between our host and guest to support custom
>> hardware
>> > (with own blobs)? Could you please advise if we can use something else
>> to
>> > achieve this goal?
>>
>> My reason for that paragraph was to try and think about what should
>> still be in the virtqueues; after all a device that *just* shares a
>> block of memory and does everything in the block of memory itself isn't
>> really a virtio device - it's the standardised queue structure that
>> makes it a virtio device.
>> However, I'd be happy to accept the 'MUST NOT' might be a bit strong for
>> some cases where there's stuff that makes sense in the queues and
>> stuff that makes sense differently.
>>
>>
> Currently, how we drive the gl/vk host coherent memory is that a host
> memory sharing device and a meta pipe device are used in tandem. The pipe
> device, goldfish_pipe, is used to send control messages (but is also
> currently used to send the API call parameters themselves over, and to
> drive other devices like sensors and camera; it's a bit of a catch-all),
> while the host memory sharing device does the act of sharing memory from
> the host and telling the guest which physical addresses are to be sent with
> the glMapBufferRange/vkMapMemory calls over the pipe to the host.
>

On this note, it might also be beneficial to run host memory sharing
drivers where host memory backs the API call parameters as well. This way,
the guest has to do less work to notify the host of which API calls need to
run. In particular, the "scatterlist" to reconstruct such API calls will
always be length 1, as the memory is always physically contiguous.


>
> In the interest of having fewer custom kernel drivers for the emulator, we
> were thinking of two major approaches to upstreaming the control message /
> meta pipe part:
>
>    1. Come up with a new virtio driver that captures what goldfish_pipe
>    does; it would have a virtqueue and it would be something like a virtio
>    driver for drivers defined in userspace that interacts closely with a host
>    memory sharing driver (virtio-userspace?). It would be used with the host
>    memory sharing driver not just to share coherent mappings, but also to
>    deliver the API call parameters. It'd have a single ioctl that pushes a
>    message into the virtqueue that notifies the host a) what kind of userspace
>    driver it is and b) how much data to send/receive.
>       1. On the host side, we would make the resolution of what virtual
>       device code to run based on the control message decided by a plugin DLL to
>       qemu. So once we decide to add new functionality, we would at max need to
>       increment some version number that is sent in some initial control message,
>       or change some enumeration in a handshake at the beginning, so no changes
>       would have to be made to the guest kernel or QEMU itself.
>       2. This is useful for standardizing the Android Emulator drivers in
>       the short term, but in the long term, it could be useful for quickly
>       specifying new drivers/devices in situations where the developer has some
>       control over both the guest/host bits. We'd use this also for:
>          1. Media codecs: the guest is given a pointer to host codec
>          input/output buffers, downloads compressed data to the input buffer, and
>          ioctl ping's the host. Then the host asynchronously decodes and populates
>          the codec output buffer.
>          2. One-off extension functionalities for Vulkan, such as
>          VK_KHR_external_memory_fd/win32. Suppose we want to simulate an OPAQUE_FD
>          Vulkan external memory in the guest, but we are running on a win32 host
>          (this will be an important part of our use case). Define a new driver type
>          in userspace, say enum VulkanOpaqueFdWrapper = 55, then open
>          virtio-userspace and run ioctls to define that fd as that kind of driver.
>          On the host side, it would then associate the filp with a host-side win32
>          vulkan handle. This can be a modular way to handle further functionality in
>          Vulkan as it comes up without requiring kernel / QEMU changes.
>       2. Add a raw ioctl for the above control messages to the proposed
>    host memory sharing driver, and make those control messages part of the
>    host memory sharing driver's virtqueue.
>
> I heard somewhere that having this kind of thing might run up against
> virtio design philosophies of having fewer 'generic' pipes; however, it
> could be valuable to have a generic way of defining driver/device
> functionality that is configurable without needing to change guest kernels
> / qemu directly.
>
> > I saw there were registers added, could you please elaborate how new
>> address
>> > regions are added and associated with the host memory (and backwards)?
>>
>> In virtio-fs we have two separate stages:
>>   a) A shared arena is setup (and that's what the spec Stefan pointed to
>> is about) -
>>      it's statically allocated at device creation and corresponds to a
>> chunk
>>      of guest physical address space
>>
>> This is quite like what we're doing for goldfish address space and Vulkan
> host visible currently.
>
>
>    - Our address space device reserves a fixed region in guest physical
>    address space on device realization. 16 gb
>    -  At the level of Vulkan, on Vulkan device creation, we map a sizable
>    amount of host visible memory on the host, and then use the address space
>    device to expose it to the guest. It then occupies some offset into the
>    address space device's pci resource.
>    - At the level of the guest Vulkan user, we satisfy host visible
>    VkDeviceMemory allocations by faking them; creating guest-only handles and
>    suballocating into that initial host visible memory, and then editing
>    memory offset/size parameters to correspond to the actual memory before the
>    API calls get to the host driver.
>
>   b) During operation the guest kernel asks for files to be mapped into
>>      part of that arena dynamically, using commands sent over the queue
>>      - our queue carries FUSE commands, and we've added two new FUSE
>>      commands to perform the map/unmap.  They talk in terms of offsets
>>      within the shared arena, rather than GPAs.
>>
>
> Yes, we'll most likely be operating in a similar manner for OpenGL and
> VUlkan.
>
>>
>> So I'd tried to start by doing the spec for (a).
>>
>> > We allocate a region from the guest first and pass its offset to the
>> > host to plug
>> > real RAM into it and then we mmap this offset:
>> >
>> > https://photos.app.goo.gl/NJvPBvvFS3S3n9mn6
>>
>> How do you transmit the glMapBufferRange command from QEMU driver to
>> host?
>>
>> This is done through an ioctl in the address space driver together with
> meta pipe commands:
>
>    1. Using the address space driver, run an ioctl to "Allocate" a
>    region, which reserves some space. An offset into the region is returned.
>    2. Using the meta pipe drier, tell the host about the offset and the
>    API call parameters of glMapBufferRange. On the host, glMapBufferRange is
>    run for real, and the resulting host pointer is sent to
>    KVM_SET_USER_MEMORY_REGION + pci resource start + that offset.
>    3.  mmap the region with the supplied offset in the guest.
>
> Dave
>>
>> > Thank you.
>> >
>> > Regards,
>> > Roman.
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> >
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>

--000000000000f7222a0581272a22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 5, 2019 at 7:17 AM Frank =
Yang &lt;<a href=3D"mailto:lfy@google.com">lfy@google.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div>Hi all,</div><div><br></div><div>I&#39;m Frank who&#39;s been using Rom=
an&#39;s goldfish address space driver for Vulkan host visible memory for t=
he emulator. Some more in-depth replies inline.</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 5, 2019 at 2:04 =
AM Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com" target=
=3D"_blank">dgilbert@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">* Roman Kiryanov (<a href=3D"mailto:rkir@g=
oogle.com" target=3D"_blank">rkir@google.com</a>) wrote:<br>
&gt; Hi Gerd,<br>
&gt; <br>
&gt; &gt; virtio-gpu specifically needs that to support vulkan and opengl<b=
r>
&gt; &gt; extensions for coherent buffers, which must be allocated by the h=
ost gpu<br>
&gt; &gt; driver.=C2=A0 It&#39;s WIP still.<br>
&gt; <br>
<br>
Hi Roman,<br>
<br>
&gt; the proposed spec says:<br>
&gt; <br>
&gt; +Shared memory regions MUST NOT be used to control the operation<br>
&gt; +of the device, nor to stream data; those should still be performed<br=
>
&gt; +using virtqueues.<br>
<br>
Yes, I put that in.<br>
<br>
&gt; Is there a strong reason to prohibit using memory regions for control =
purposes?<br>
&gt; Our long term goal is to have as few kernel drivers as possible and to=
 move<br>
&gt; &quot;drivers&quot; into userspace. If we go with the virtqueues, is t=
here<br>
&gt; general a purpose<br>
&gt; device/driver to talk between our host and guest to support custom har=
dware<br>
&gt; (with own blobs)? Could you please advise if we can use something else=
 to<br>
&gt; achieve this goal?<br>
<br>
My reason for that paragraph was to try and think about what should<br>
still be in the virtqueues; after all a device that *just* shares a<br>
block of memory and does everything in the block of memory itself isn&#39;t=
<br>
really a virtio device - it&#39;s the standardised queue structure that<br>
makes it a virtio device.<br>
However, I&#39;d be happy to accept the &#39;MUST NOT&#39; might be a bit s=
trong for<br>
some cases where there&#39;s stuff that makes sense in the queues and<br>
stuff that makes sense differently.<br>
<br></blockquote><div><br></div><div>Currently, how we drive the gl/vk host=
 coherent memory is that a host memory sharing device and a meta pipe devic=
e are used in tandem. The pipe device, goldfish_pipe, is used to send contr=
ol messages (but is also currently used to send the API call parameters the=
mselves over, and to drive other devices like sensors and camera; it&#39;s =
a bit of a catch-all), while the host memory sharing device does the act of=
 sharing memory from the host and telling the guest which physical addresse=
s are to be sent with the glMapBufferRange/vkMapMemory calls over the pipe =
to the host.</div></div></div></blockquote><div><br></div><div>On this note=
, it might also be beneficial to run host memory sharing drivers where host=
 memory backs the API call parameters as well. This way, the guest has to d=
o less work to notify the host of which API calls need to run. In particula=
r, the &quot;scatterlist&quot; to reconstruct such API calls will always be=
 length 1, as the memory is always physically contiguous.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_quote"><div><br></div><div>In the interest of having fewer=
 custom kernel drivers for the emulator, we were thinking of two major appr=
oaches to upstreaming the control message / meta pipe part:</div><div><ol><=
li>Come up with a new virtio driver that captures what goldfish_pipe does; =
it would have a virtqueue and it would be something like a virtio driver fo=
r drivers defined in userspace that interacts closely with a host memory sh=
aring driver (virtio-userspace?). It would be used with the host memory sha=
ring driver not just to share coherent mappings, but also to deliver the AP=
I call parameters. It&#39;d have a single ioctl that pushes a message into =
the virtqueue that notifies the host a) what kind of userspace driver it is=
 and b) how much data to send/receive.</li><ol><li>On the host side, we wou=
ld make the resolution of what virtual device code to run based on the cont=
rol message decided by a plugin DLL to qemu. So once we decide to add new f=
unctionality, we would at max need to increment some version number that is=
 sent in some initial control message, or change some enumeration in a hand=
shake at the beginning, so no changes would have to be made to the guest ke=
rnel or QEMU itself.</li><li>This is useful for standardizing the Android E=
mulator drivers in the short term, but in the long term, it could be useful=
 for quickly specifying new drivers/devices in situations where the develop=
er has some control over both the guest/host bits. We&#39;d use this also f=
or:</li><ol><li>Media codecs: the guest is given a pointer to host codec in=
put/output buffers, downloads compressed data to the input buffer, and ioct=
l ping&#39;s the host. Then the host asynchronously decodes and populates t=
he codec output buffer.</li><li>One-off extension functionalities for Vulka=
n, such as VK_KHR_external_memory_fd/win32. Suppose we want to simulate an =
OPAQUE_FD Vulkan external memory in the guest, but we are running on a win3=
2 host (this will be an important part of our use case). Define a new drive=
r type in userspace, say enum VulkanOpaqueFdWrapper =3D 55, then open virti=
o-userspace and run ioctls to define that fd as that kind of driver. On the=
 host side, it would then associate the filp with a host-side win32 vulkan =
handle. This can be a modular way to handle further functionality in Vulkan=
 as it comes up without requiring kernel / QEMU changes.</li></ol></ol><li>=
Add a raw ioctl for the above control messages to the proposed host memory =
sharing driver, and make those control messages part of the host memory sha=
ring driver&#39;s virtqueue.</li></ol></div><div>I heard somewhere that hav=
ing this kind of thing might run up against virtio design philosophies of h=
aving fewer &#39;generic&#39; pipes; however, it could be valuable to have =
a generic way of defining driver/device functionality that is configurable =
without needing to change guest kernels / qemu directly.</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I saw there were registers added, could you please elaborate how new a=
ddress<br>
&gt; regions are added and associated with the host memory (and backwards)?=
<br>
<br>
In virtio-fs we have two separate stages:<br>
=C2=A0 a) A shared arena is setup (and that&#39;s what the spec Stefan poin=
ted to is about) -<br>
=C2=A0 =C2=A0 =C2=A0it&#39;s statically allocated at device creation and co=
rresponds to a chunk<br>
=C2=A0 =C2=A0 =C2=A0of guest physical address space<br>
<br></blockquote><div>This is quite like what we&#39;re doing for goldfish =
address space and Vulkan host visible currently.</div><div><br></div><div><=
ul><li>Our address space device reserves a fixed region in guest physical a=
ddress space on device realization. 16 gb</li><li>=C2=A0At the level of Vul=
kan, on Vulkan device creation, we map a sizable amount of host visible mem=
ory on the host, and then use the address space device to expose it to the =
guest. It then occupies some offset into the address space device&#39;s pci=
 resource.<br></li><li>At the level of the guest Vulkan user, we satisfy ho=
st visible VkDeviceMemory allocations by faking them; creating guest-only h=
andles and suballocating into that initial host visible memory, and then ed=
iting memory offset/size parameters to correspond to the actual memory befo=
re the API calls get to the host driver.</li></ul></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 b) During operation the guest kernel asks for files to be mapped int=
o<br>
=C2=A0 =C2=A0 =C2=A0part of that arena dynamically, using commands sent ove=
r the queue<br>
=C2=A0 =C2=A0 =C2=A0- our queue carries FUSE commands, and we&#39;ve added =
two new FUSE<br>
=C2=A0 =C2=A0 =C2=A0commands to perform the map/unmap.=C2=A0 They talk in t=
erms of offsets<br>
=C2=A0 =C2=A0 =C2=A0within the shared arena, rather than GPAs.<br></blockqu=
ote><div><br></div><div>Yes, we&#39;ll most likely be operating in a simila=
r manner for OpenGL and VUlkan.=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
So I&#39;d tried to start by doing the spec for (a).<br>
<br>
&gt; We allocate a region from the guest first and pass its offset to the<b=
r>
&gt; host to plug<br>
&gt; real RAM into it and then we mmap this offset:<br>
&gt; <br>
&gt; <a href=3D"https://photos.app.goo.gl/NJvPBvvFS3S3n9mn6" rel=3D"norefer=
rer" target=3D"_blank">https://photos.app.goo.gl/NJvPBvvFS3S3n9mn6</a><br>
<br>
How do you transmit the glMapBufferRange command from QEMU driver to<br>
host?<br>
<br></blockquote><div>This is done through an ioctl in the address space dr=
iver together with meta pipe commands:</div><div><ol><li>Using the address =
space driver, run an ioctl to &quot;Allocate&quot; a region, which reserves=
 some space. An offset into the region is returned.</li><li>Using the meta =
pipe drier, tell the host about the offset and the API call parameters of g=
lMapBufferRange. On the host, glMapBufferRange is run for real, and the res=
ulting host pointer is sent to KVM_SET_USER_MEMORY_REGION=C2=A0+ pci resour=
ce start=C2=A0+ that offset.</li><li>=C2=A0mmap the region with the supplie=
d offset in the guest.<br></li></ol></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Dave<br>
<br>
&gt; Thank you.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Roman.<br>
&gt; <br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.=
org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</=
a><br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000f7222a0581272a22--
