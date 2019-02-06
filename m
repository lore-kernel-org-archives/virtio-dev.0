Return-Path: virtio-dev-return-5378-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 252C4985DAD
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Feb 2019 20:28:01 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm> <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
 <20190206201406.GG2670@work-vm>
In-Reply-To: <20190206201406.GG2670@work-vm>
From: Frank Yang <lfy@google.com>
Date: Wed, 6 Feb 2019 12:27:48 -0800
Message-ID: <CAEkmjvWA=kVjL-9BX=c+jBFmoUfJB7KjLgYNdKmG1dEC2wb2Qg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d3d98305813f8fa2"
Subject: Re: [virtio-dev] Memory sharing device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000d3d98305813f8fa2
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 6, 2019 at 12:14 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Roman Kiryanov (rkir@google.com) wrote:
> > Hi Dave,
> >
> > > In virtio-fs we have two separate stages:
> > >   a) A shared arena is setup (and that's what the spec Stefan pointed
> to is about) -
> > >      it's statically allocated at device creation and corresponds to a
> chunk
> > >      of guest physical address space
> >
> > We do exactly the same:
> >
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c#659
> >
> > >   b) During operation the guest kernel asks for files to be mapped into
> > >      part of that arena dynamically, using commands sent over the queue
> > >      - our queue carries FUSE commands, and we've added two new FUSE
> > >      commands to perform the map/unmap.  They talk in terms of offsets
> > >      within the shared arena, rather than GPAs.
> >
> > In our case we have no files to map, only pointers returned from
> > OpenGL or Vulkan.
> > Do you have the approach to share for this use case?
>
> I should say that the spec I'm talking aobut is my 1st virito spec
> change; so take my ideas with a large pinch of salt!
>
> > > How do you transmit the glMapBufferRange command from QEMU driver to
> > > host?
> >
> > In December we did this by passing these bits over our guest-host channel
> > (another driver, goldfish_pipe). Frank is currently working on moving
> > this into our memory
> > mapping device as "something changed in the memory you shared".
> >
> > Do you this it is possible to have virtio-pipe where we could send
> > arbitrary blobs between
> > guest and host? We want to move all our drivers into userspace so we
> > could share memory
> > using the device you are currently working on and this virtio-pipe to
> > pass MMIOs and IRQs
> > to control our devices to avoid dealing with kernel drivers at all.
>
> It sounds to me like you want something like a virtio-pipe, with
> a shared arena (like specified using the spec change I suggested)
> but with either a separate queue, or commands in the queue to do the
> mapping/unmapping of your GL pointers from your arena.
>

This sounds close to what we want, but the current suggestions to use
virtio-serial/virtio-vsock are difficult to deal with as they add on the
req of console forwarding/hard limits on the number of queues, or coupling
to unix sockets on the host.

What about this:

A new spec, called "virtio-pipe". It only sends control messages. It's
meant to work in tandem with the current virtio host memory proposal. It's
not specialized to anything; it doesn't use sockets on the host either,
instead, it uses dlopen/dlsym on the host to load a library implementing
the wanted userspace devices, together with a minimal ioctl in the guest to
capture everything:

There is one ioctl:

ioctl_ping:
u64 offset (to the virtio host memory object)
u64 size
u64 metadata (driver-dependent data)
u32 wait (whether the guest is waiting for the host to be done with
something)

These are sent over virtqueue.

On the host, these pings arrive and call some dlsym'ed functions:

u32 on_context_create - when guest userspace open()'s the virtio-pipe, this
returns a new id.
on_context_destroy(u32 id) - on last close of the pipe
on_ioctl_ping(u32 id, u64 physaddr, u64 size, u64 metadata, u32 wait) -
called when the guest ioctl ping's.

There would need to be some kind of IRQ-like mechanism (either done with
actual virtual irqs, or polling, or a mprotect/mwait-like mechanism) that
tells the guest the host is done with something.

This would be the absolute minimum and most general way to send anything
to/from the host with explicit control messages; any device can be defined
on top of this with no changes to virtio or qemu.


> Dave
>
> > Thank you.
> >
> > Regards,
> > Roman.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

--000000000000d3d98305813f8fa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 6, 2019 at 12:14 PM Dr. D=
avid Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilbert@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">* Roman Kiryanov (<a href=3D"mailto:rkir@google.com" target=3D"_blank"=
>rkir@google.com</a>) wrote:<br>
&gt; Hi Dave,<br>
&gt; <br>
&gt; &gt; In virtio-fs we have two separate stages:<br>
&gt; &gt;=C2=A0 =C2=A0a) A shared arena is setup (and that&#39;s what the s=
pec Stefan pointed to is about) -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 it&#39;s statically allocated at device creat=
ion and corresponds to a chunk<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 of guest physical address space<br>
&gt; <br>
&gt; We do exactly the same:<br>
&gt; <a href=3D"https://android.googlesource.com/platform/external/qemu/+/e=
mu-master-dev/hw/pci/goldfish_address_space.c#659" rel=3D"noreferrer" targe=
t=3D"_blank">https://android.googlesource.com/platform/external/qemu/+/emu-=
master-dev/hw/pci/goldfish_address_space.c#659</a><br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0b) During operation the guest kernel asks for files t=
o be mapped into<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 part of that arena dynamically, using command=
s sent over the queue<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 - our queue carries FUSE commands, and we&#39=
;ve added two new FUSE<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 commands to perform the map/unmap.=C2=A0 They=
 talk in terms of offsets<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 within the shared arena, rather than GPAs.<br=
>
&gt; <br>
&gt; In our case we have no files to map, only pointers returned from<br>
&gt; OpenGL or Vulkan.<br>
&gt; Do you have the approach to share for this use case?<br>
<br>
I should say that the spec I&#39;m talking aobut is my 1st virito spec<br>
change; so take my ideas with a large pinch of salt!<br>
<br>
&gt; &gt; How do you transmit the glMapBufferRange command from QEMU driver=
 to<br>
&gt; &gt; host?<br>
&gt; <br>
&gt; In December we did this by passing these bits over our guest-host chan=
nel<br>
&gt; (another driver, goldfish_pipe). Frank is currently working on moving<=
br>
&gt; this into our memory<br>
&gt; mapping device as &quot;something changed in the memory you shared&quo=
t;.<br>
&gt; <br>
&gt; Do you this it is possible to have virtio-pipe where we could send<br>
&gt; arbitrary blobs between<br>
&gt; guest and host? We want to move all our drivers into userspace so we<b=
r>
&gt; could share memory<br>
&gt; using the device you are currently working on and this virtio-pipe to<=
br>
&gt; pass MMIOs and IRQs<br>
&gt; to control our devices to avoid dealing with kernel drivers at all.<br=
>
<br>
It sounds to me like you want something like a virtio-pipe, with<br>
a shared arena (like specified using the spec change I suggested)<br>
but with either a separate queue, or commands in the queue to do the<br>
mapping/unmapping of your GL pointers from your arena.<br></blockquote><div=
><br></div><div>This sounds close to what we want, but the current suggesti=
ons to use virtio-serial/virtio-vsock are difficult to deal with as they ad=
d on the req of console forwarding/hard limits on the number of queues, or =
coupling to unix sockets on the host.</div><div><br></div><div>What about t=
his:</div><div><br></div><div>A new spec, called &quot;virtio-pipe&quot;. I=
t only sends control messages. It&#39;s meant to work in tandem with the cu=
rrent virtio host memory proposal. It&#39;s not specialized to anything; it=
 doesn&#39;t use sockets on the host either, instead, it uses dlopen/dlsym =
on the host to load a library implementing the wanted userspace devices, to=
gether with a minimal ioctl in the guest to capture everything:</div><div><=
br></div><div>There is one ioctl:</div><div><br></div><div>ioctl_ping:</div=
><div>u64 offset (to the virtio host memory object)</div><div>u64 size</div=
><div>u64 metadata (driver-dependent data)</div><div>u32 wait (whether the =
guest is waiting for the host to be done with something)</div><div><br></di=
v><div>These are sent over virtqueue.</div><div><br></div><div>On the host,=
 these pings arrive and call some dlsym&#39;ed functions:</div><div><br></d=
iv><div>u32 on_context_create - when guest userspace open()&#39;s the virti=
o-pipe, this returns a new id.</div><div>on_context_destroy(u32 id) - on la=
st close of the pipe</div><div>on_ioctl_ping(u32 id, u64 physaddr, u64 size=
, u64 metadata, u32 wait) - called when the guest ioctl ping&#39;s.=C2=A0</=
div><div><br></div><div>There would need to be some kind of IRQ-like mechan=
ism (either done with actual virtual irqs, or polling, or a mprotect/mwait-=
like mechanism) that tells the guest the host is done with something.</div>=
<div><br></div><div>This would be the absolute minimum and most general way=
 to send anything to/from the host with explicit control messages; any devi=
ce can be defined on top of this with no changes to virtio or qemu.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Dave<br>
<br>
&gt; Thank you.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Roman.<br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
</blockquote></div></div>

--000000000000d3d98305813f8fa2--
