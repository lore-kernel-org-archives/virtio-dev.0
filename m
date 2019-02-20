Return-Path: virtio-dev-return-5475-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D5C4985D77
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 15:35:19 +0000 (UTC)
MIME-Version: 1.0
References: <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org> <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
 <20190220062539.toctrkhk67iyzwnk@sirius.home.kraxel.org> <CAEkmjvU5tc8tYpbynigVSGqTh5_SyhoMVEAu3Z1wo6vaGBBbVg@mail.gmail.com>
In-Reply-To: <CAEkmjvU5tc8tYpbynigVSGqTh5_SyhoMVEAu3Z1wo6vaGBBbVg@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Wed, 20 Feb 2019 07:35:04 -0800
Message-ID: <CAEkmjvUdL5_XtNL6+nUfXyS4CUapsA7k+gPtyo5ZmgAcbYM4hQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cd4a0e0582551af5"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000cd4a0e0582551af5
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 20, 2019 at 7:30 AM Frank Yang <lfy@google.com> wrote:

>
>
> On Tue, Feb 19, 2019 at 10:25 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>>   Hi,
>>
>> > > That might simlify pass-through of v4l2 host devices, but isn't
>> > > necessarily the best choice long-term.
>>
>> > Right, but if we're not emulating at the v4l2 api level, then it starts
>> > looking a lot
>> > like the proposed virtio-hostmem; there's a common pattern of
>> > direct access to host memory
>>
>> Typically camera hardware can DMA the image data to any place in memory,
>> including guest ram.  There is no need to expose host memory to the
>> guest for that.  The normal virtio workflow with guest-allocated buffers
>> will work just fine.
>>
>>
> True, thanks for pointing it out.
> Although, I'd still think it is still a bit nicer to do it via a host
> memory buffer,
> because it'd be outside of guest ram;
> we wouldn't have to interface as tightly with the kernel in terms of not
> interfering with
> other guest RAM usages,
> such as equivalents of dma_alloc_coherent with the limitation on CMA and
> all.
>
> > In addition, we'd like to do things in a way
>> > that allows virtual drivers/devices to be defined in a manner that
>> doesn't
>> > require the guest kernel to be updated.
>>
>> Hmm.  I'm wondering whenever you just need a different virtio transport.
>> Very simliar to virtio-pci, but instead of using all guest ram (modulo
>> iommu quirks) as address space use a pci memory bar as address space.
>> virtio rings would live there, all buffers would live there, addresses
>> passed around would be offsets into that pci bar.  Then your userspace
>> driver can just mmap() that pci bar and handle (almost?) everything on
>> its own.  Maybe a little stub driver in the kernel is needed for ring
>> notifications.
>>
>>
> Yeah, that's (almost?) exactly what we want to do / we're doing already
> pretty much
> with the memory sharing scheme we're using currently.
>
> Defining it as a transport would also require definition of another virtio
> device type
> that the userspace drivers talk to, right?
> As a transport/device pair, would it break down as, the transport ends up
> restricting what kinds of addresses can be referred to in the ring messages
> (in the pci memory bar),
> then the device provides the userspace drivers with
> implementation of mmap() + memory allocation/sharing ops and notification?
>
>
>> > For us, maintaining and upgrading guest kernels in response to tweaks to
>> > virtual devices
>> > is much more work than modifying a userspace shared library driver that
>> > communicates to some virtio driver.
>>
>> Well, one of the design goals of virtio is that such an upgrade is not
>> required.  Capabilities of device and driver are negotiated using
>> feature flags, which removes the need for lockstep updates of guest and
>> host.
>>
>>
> We also have a similar feature flag system,
> but yeah it would be great to use the capabilities/flags
> to their fullest extent here.
>
>
>> > Thus far, it's suggested that socket or
>> > network devices
>> > be used for this, because they are general guest/host communication,
>> > but they don't have the portability or performance characteristics we
>> want.
>>
>> For high-bandwidth fully agree.
>>
>> For low-bandwidth (like the sensors discussed elsewhere in the thread) I
>> think running some protocol (mqtt, something json-based, ...) over
>> virtio-serial or virtio-vsock isn't too bad.
>>
>> But creating virtio-sensors makes sense too.
>>
>>
> Yeah for performance considerations, sockets seem to be fine.
>
(for low bandwidth devices that is, just to be clear)

> It's just that I've also got concerns on how well sockets work on
> non-Linux.
>
> > > Alternatively emulate something existing, USB Video Class device for
>> > > example.
>> >
>> > Using usb or faking some other transport generally also involves being
>> > coupled to that set of kernel code in the guest, which introduces
>> > complexity and overhead.  Exposing RAM can be a more flexible
>> > abstraction.
>>
>> Well, you get guest drivers for free and all existing software will run
>> just fine out-of-the-box.
>>
>> Which is the reason why there is no virtio-usb for example.  xhci has a
>> hardware design which can be emulated without much overhead, so the
>> performance benefit of virtio-usb over xhci would be pretty close to
>> zero.
>>
>>
> That's pretty interesting; from a brief glance at xhci, it looks like what
> you're proposing
> is that since there usb passthrough already with xhci,
> and xhci has something that looks like a virtqueue,
> perhaps we can create our own USB driver on the host,
> then pass it through.
>
> It does make things more inconvenient for users though since they would
> have to install
> usb drivers out of nowhere. Wonder if a usb forwarder virtual device
> exists that can talk to some shared library on the host for the xhci queue,
> though that might be considered an unsafe plugin.
>
>
>> cheers,
>>   Gerd
>>
>>

--000000000000cd4a0e0582551af5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 20, 2019 at 7:30 AM Frank=
 Yang &lt;<a href=3D"mailto:lfy@google.com">lfy@google.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Feb 19, 2019 at 10:25 PM Gerd Hoffmann &lt;<a =
href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0=
 Hi,<br>
<br>
&gt; &gt; That might simlify pass-through of v4l2 host devices, but isn&#39=
;t<br>
&gt; &gt; necessarily the best choice long-term.<br>
<br>
&gt; Right, but if we&#39;re not emulating at the v4l2 api level, then it s=
tarts<br>
&gt; looking a lot<br>
&gt; like the proposed virtio-hostmem; there&#39;s a common pattern of<br>
&gt; direct access to host memory<br>
<br>
Typically camera hardware can DMA the image data to any place in memory,<br=
>
including guest ram.=C2=A0 There is no need to expose host memory to the<br=
>
guest for that.=C2=A0 The normal virtio workflow with guest-allocated buffe=
rs<br>
will work just fine.<br>
<br></blockquote><div>=C2=A0</div><div>True, thanks for pointing it out.</d=
iv><div>Although, I&#39;d still think it is still a bit nicer to do it via =
a host memory buffer,</div><div>because it&#39;d be outside of guest ram;</=
div><div>we wouldn&#39;t have to interface as tightly with the kernel in te=
rms of not interfering with</div><div>other guest RAM usages,</div><div>suc=
h as equivalents of dma_alloc_coherent with the limitation on CMA and all.<=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; In addition, we&#39;d like to do things in a way<br>
&gt; that allows virtual drivers/devices to be defined in a manner that doe=
sn&#39;t<br>
&gt; require the guest kernel to be updated.<br>
<br>
Hmm.=C2=A0 I&#39;m wondering whenever you just need a different virtio tran=
sport.<br>
Very simliar to virtio-pci, but instead of using all guest ram (modulo<br>
iommu quirks) as address space use a pci memory bar as address space.<br>
virtio rings would live there, all buffers would live there, addresses<br>
passed around would be offsets into that pci bar.=C2=A0 Then your userspace=
<br>
driver can just mmap() that pci bar and handle (almost?) everything on<br>
its own.=C2=A0 Maybe a little stub driver in the kernel is needed for ring<=
br>
notifications.<br>
<br></blockquote><div>=C2=A0</div><div>Yeah, that&#39;s (almost?) exactly w=
hat we want to do / we&#39;re doing already pretty much</div><div>with the =
memory sharing scheme we&#39;re using currently.</div><div><br></div><div>D=
efining it as a transport would also require definition of another virtio d=
evice type<br></div><div>that the userspace drivers talk to, right?</div><d=
iv>As a transport/device pair, would it break down as, the transport ends u=
p restricting what kinds of addresses can be referred to in the ring messag=
es (in the pci memory bar),</div><div>then the device provides the userspac=
e drivers with</div><div>implementation of mmap() + memory allocation/shari=
ng ops and notification?</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt; For us, maintaining and upgrading guest kernels in response to tweaks =
to<br>
&gt; virtual devices<br>
&gt; is much more work than modifying a userspace shared library driver tha=
t<br>
&gt; communicates to some virtio driver.<br>
<br>
Well, one of the design goals of virtio is that such an upgrade is not<br>
required.=C2=A0 Capabilities of device and driver are negotiated using<br>
feature flags, which removes the need for lockstep updates of guest and<br>
host.<br>
<br></blockquote><div><br></div><div>We also have a similar feature flag sy=
stem,</div><div>but yeah it would be great to use the capabilities/flags</d=
iv><div>to their fullest extent here.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; Thus far, it&#39;s suggested that socket or<br>
&gt; network devices<br>
&gt; be used for this, because they are general guest/host communication,<b=
r>
&gt; but they don&#39;t have the portability or performance characteristics=
 we want.<br>
<br>
For high-bandwidth fully agree.<br>
<br>
For low-bandwidth (like the sensors discussed elsewhere in the thread) I<br=
>
think running some protocol (mqtt, something json-based, ...) over<br>
virtio-serial or virtio-vsock isn&#39;t too bad.<br>
<br>
But creating virtio-sensors makes sense too.<br>
<br></blockquote><div>=C2=A0</div><div>Yeah for performance considerations,=
 sockets seem to be fine.</div></div></div></blockquote><div>(for low bandw=
idth devices that is, just to be clear)=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=
It&#39;s just that I&#39;ve also got concerns on how well sockets work on n=
on-Linux.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; &gt; Alternatively emulate something existing, USB Video Class device =
for<br>
&gt; &gt; example.<br>
&gt; <br>
&gt; Using usb or faking some other transport generally also involves being=
<br>
&gt; coupled to that set of kernel code in the guest, which introduces<br>
&gt; complexity and overhead.=C2=A0 Exposing RAM can be a more flexible<br>
&gt; abstraction.<br>
<br>
Well, you get guest drivers for free and all existing software will run<br>
just fine out-of-the-box.<br>
<br>
Which is the reason why there is no virtio-usb for example.=C2=A0 xhci has =
a<br>
hardware design which can be emulated without much overhead, so the<br>
performance benefit of virtio-usb over xhci would be pretty close to<br>
zero.<br>
<br></blockquote><div>=C2=A0</div><div>That&#39;s pretty interesting; from =
a brief glance at xhci, it looks like what you&#39;re proposing</div><div>i=
s that since there usb passthrough already with xhci,</div><div>and xhci ha=
s something that looks like a virtqueue,</div><div>perhaps we can create ou=
r own USB driver on the host,</div><div>then pass it through.</div><div><br=
></div><div>It does make things more inconvenient for users though since th=
ey would have to install</div><div>usb drivers out of nowhere. Wonder if a =
usb forwarder virtual device exists that can talk to some shared library on=
 the host for the xhci queue, though that might be considered an unsafe plu=
gin.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000cd4a0e0582551af5--
