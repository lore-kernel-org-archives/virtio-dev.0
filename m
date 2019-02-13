Return-Path: virtio-dev-return-5422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A858985E0D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 02:50:42 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com> <20190212135924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212135924-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 18:50:29 -0800
Message-ID: <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000769b420581bd9b4e"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000769b420581bd9b4e
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:
> > BTW, the other unique aspect is that the ping messages allow a _host_
> pointer
> > to serve as the lump of shared memory;
> > then there is no need to track buffers in the guest kernel and the device
> > implementation can perform specialize buffer space management.
> > Because it is also host pointer shared memory, it is also physically
> contiguous
> > and there is no scatterlist needed to process the traffic.
>
> Yes at the moment virtio descriptors all pass addresses guest to host.
>
> Ability to reverse that was part of the vhost-pci proposal a while ago.
> BTW that also at least originally had ability to tunnel
> multiple devices over a single connection.
>
>
Can there be a similar proposal for virtio-pci without vhsot?


> There was nothing wrong with the proposals I think, they
> just had to be polished a bit before making it into the spec.
> And that runneling was dropped but I think it can be brought back
> if desired, we just didn't see a use for it.
>
> Thinking about it more, I think vhost-pci might be too much for us due to
the vhost requirement (sockets and IPC while we desire a highly process
local solution)

But there's nothing preventing us from having the same reversals for
virtio-pci devices without vhost, right?
That's kind of what's being proposed with the shared memory stuff at the
moment, though it is not a device type by itself yet (Arguably, it should
be).

How about that? That sounds close to what you were looking for,
> does it not? That would be something to look into -
> if your ideas can be used to implement a virtio device
> backend by code running within a VM, that would be very interesting.
>

What about a device type, say, virtio-metapci, that relies on virtio-pci
for device enumeration and shared memory handling
(assuming it's going to be compatible with the host pointer shared memory
implementation),
so there's no duplication of the concept of device enumeration nor shared
memory operations.
But, it works in terms of the ping / event virtqueues, and relies on the
host hypervisor to dispatch to device implementation callbacks.
A potential issue is that such metapci device share the same device id
namespace as other virtio-pci devices...but maybe that's OK?
If this can build on virtio-pci, I might be able to come up with a spec
that assumes virtio-pci as the transport,
and assumes (via the WIP host memory sharing work) that host memory can be
used as buffer storage.
The difference is that it will not contain most of the config virtqueue
stuff (except maybe for create/destroy instance),
and it should also work with the existing ecosystem around virtio-pci.


>
> --
> MST
>

--000000000000769b420581bd9b4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 11:06 AM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, =
Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:<br>
&gt; BTW, the other unique aspect is that the ping messages allow a _host_ =
pointer<br>
&gt; to serve as the lump of shared memory;<br>
&gt; then there is no need to track buffers in the guest kernel and the dev=
ice<br>
&gt; implementation can perform specialize buffer space management.<br>
&gt; Because it is also host pointer shared memory, it is also physically c=
ontiguous<br>
&gt; and there is no scatterlist needed to process the traffic.<br>
<br>
Yes at the moment virtio descriptors all pass addresses guest to host.<br>
<br>
Ability to reverse that was part of the vhost-pci proposal a while ago.<br>
BTW that also at least originally had ability to tunnel<br>
multiple devices over a single connection.<br>
<br></blockquote><div><br></div><div>Can there be a similar proposal for vi=
rtio-pci without vhsot?</div><div>=C2=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
There was nothing wrong with the proposals I think, they<br>
just had to be polished a bit before making it into the spec.<br>
And that runneling was dropped but I think it can be brought back<br>
if desired, we just didn&#39;t see a use for it.<br>
<br></blockquote><div>Thinking about it more, I think vhost-pci might be to=
o much for us due to the vhost requirement (sockets and IPC while we desire=
 a highly process local solution)</div><div><br></div><div>But there&#39;s =
nothing preventing us from having the same reversals for virtio-pci devices=
 without vhost, right?</div><div>That&#39;s kind of what&#39;s being propos=
ed with the shared memory stuff at the moment, though it is not a device ty=
pe by itself yet (Arguably, it should be).</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
How about that? That sounds close to what you were looking for,<br>
does it not? That would be something to look into -<br>
if your ideas can be used to implement a virtio device<br>
backend by code running within a VM, that would be very interesting.<br></b=
lockquote><div><br></div><div>What about a device type, say, virtio-metapci=
, that relies on virtio-pci for device enumeration and shared memory handli=
ng</div><div>(assuming it&#39;s going to be compatible with the host pointe=
r shared memory implementation),</div><div>so there&#39;s no duplication of=
 the concept of device enumeration nor shared memory operations.</div><div>=
But, it works in terms of the ping / event virtqueues, and relies on the ho=
st hypervisor to dispatch to device implementation callbacks.</div><div>A p=
otential issue is that such metapci device share the same device id namespa=
ce as other virtio-pci devices...but maybe that&#39;s OK?</div><div>If this=
 can build on virtio-pci, I might be able to come up with a spec that assum=
es virtio-pci as the transport,</div><div>and assumes (via the WIP host mem=
ory sharing work) that host memory can be used as buffer storage.</div><div=
>The difference is that it will not contain most of the config virtqueue st=
uff (except maybe for create/destroy instance),</div><div>and it should als=
o work with the existing ecosystem around virtio-pci.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
MST<br>
</blockquote></div></div>

--000000000000769b420581bd9b4e--
