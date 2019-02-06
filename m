Return-Path: virtio-dev-return-5376-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8541A985D76
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Feb 2019 15:11:56 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm> <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
 <20190206070350.vaonutyqljccuh5y@sirius.home.kraxel.org> <CAEkmjvUHzSx-Vr2O4MWDN4Cmqe-+dm9N6hbxg7gLu-SUUo6u6Q@mail.gmail.com>
In-Reply-To: <CAEkmjvUHzSx-Vr2O4MWDN4Cmqe-+dm9N6hbxg7gLu-SUUo6u6Q@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Wed, 6 Feb 2019 07:11:43 -0800
Message-ID: <CAEkmjvX76cAZUNn4+HoPaFYPdBC88V78xzGZR=1YTYeiSunTww@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000074381a05813b2543"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000074381a05813b2543
Content-Type: text/plain; charset="UTF-8"

(Virtio-serial also doesn't seem like a good option due to specialization
to console forwarding and having an encoded limit on the number of
connections)

On Wed, Feb 6, 2019 at 7:09 AM Frank Yang <lfy@google.com> wrote:

>
>
> On Tue, Feb 5, 2019 at 11:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> On Tue, Feb 05, 2019 at 01:06:42PM -0800, Roman Kiryanov wrote:
>> > Hi Dave,
>> >
>> > > In virtio-fs we have two separate stages:
>> > >   a) A shared arena is setup (and that's what the spec Stefan pointed
>> to is about) -
>> > >      it's statically allocated at device creation and corresponds to
>> a chunk
>> > >      of guest physical address space
>> >
>> > We do exactly the same:
>> >
>> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c#659
>> >
>> > >   b) During operation the guest kernel asks for files to be mapped
>> into
>> > >      part of that arena dynamically, using commands sent over the
>> queue
>> > >      - our queue carries FUSE commands, and we've added two new FUSE
>> > >      commands to perform the map/unmap.  They talk in terms of offsets
>> > >      within the shared arena, rather than GPAs.
>> >
>> > In our case we have no files to map, only pointers returned from
>> > OpenGL or Vulkan.
>> > Do you have the approach to share for this use case?
>>
>> Fundamentally the same:  The memory region (PCI bar in case of
>> virtio-pci) reserves address space.  The guest manages the address
>> space, it can ask the host to map host gpu resources there.
>>
>> Well, that is at least the plan.  Some incomplete WIP patches exist, I'm
>> still busy hammering virtio-gpu ttm code into shape so it can support
>> different kinds of gpu objects.
>>
>> > Do you this it is possible to have virtio-pipe where we could send
>> > arbitrary blobs between
>> > guest and host?
>>
>> Well, there are virtio-serial and virtio-vsock which both give you a
>> pipe between host and guest, simliar to a serial line / tcp socket.
>> Dunno how good they are at handling larger blobs though.
>>
>>
> I've looked at virtio-vsock and it seems general, but requires Unix
> sockets, which is not going to work for us on Windows and not going to work
> as expected on macOS (most likely). Is there anything that is similar to
> and as portable as goldfish pipe which is more like a raw virtqueue? This
> would then work on memory in the same process, with callbacks registered to
> trigger upon transmission.
>
> cheers,
>>   Gerd
>>
>>

--00000000000074381a05813b2543
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(Virtio-serial also doesn&#39;t seem like a good option du=
e to specialization to console forwarding and having an encoded limit on th=
e number of connections)</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 6, 2019 at 7:09 AM Frank Yang &lt;<a hr=
ef=3D"mailto:lfy@google.com">lfy@google.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr=
"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Feb 5, 2019 at 11:03 PM Gerd Hoffmann &lt;<a href=3D"mailto:k=
raxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Feb 05, 2019 a=
t 01:06:42PM -0800, Roman Kiryanov wrote:<br>
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
Fundamentally the same:=C2=A0 The memory region (PCI bar in case of<br>
virtio-pci) reserves address space.=C2=A0 The guest manages the address<br>
space, it can ask the host to map host gpu resources there.<br>
<br>
Well, that is at least the plan.=C2=A0 Some incomplete WIP patches exist, I=
&#39;m<br>
still busy hammering virtio-gpu ttm code into shape so it can support<br>
different kinds of gpu objects.<br>
<br>
&gt; Do you this it is possible to have virtio-pipe where we could send<br>
&gt; arbitrary blobs between<br>
&gt; guest and host?<br>
<br>
Well, there are virtio-serial and virtio-vsock which both give you a<br>
pipe between host and guest, simliar to a serial line / tcp socket.<br>
Dunno how good they are at handling larger blobs though.<br>
<br></blockquote><div><br></div><div>I&#39;ve looked at virtio-vsock and it=
 seems general, but requires Unix sockets, which is not going to work for u=
s on Windows and not going to work as expected on macOS (most likely). Is t=
here anything that is similar to and as portable as goldfish pipe which is =
more like a raw virtqueue? This would then work on memory in the same proce=
ss, with callbacks registered to trigger upon transmission.</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>
</blockquote></div>

--00000000000074381a05813b2543--
