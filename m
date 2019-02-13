Return-Path: virtio-dev-return-5426-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 690BA985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 04:59:40 +0000 (UTC)
MIME-Version: 1.0
References: <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org> <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
 <20190212221738-mutt-send-email-mst@kernel.org> <20190212231458-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212231458-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 20:59:27 -0800
Message-ID: <CAEkmjvVD7E_DcBkoucNSYs74T10K2qrJHAYbzCqUF=7C+B-4GQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b9aa050581bf68e2"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000b9aa050581bf68e2
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 8:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 11:02:19PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:
> > >
> > >
> > > On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >
> > >     On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:
> > >     > BTW, the other unique aspect is that the ping messages allow a
> _host_
> > >     pointer
> > >     > to serve as the lump of shared memory;
> > >     > then there is no need to track buffers in the guest kernel and
> the device
> > >     > implementation can perform specialize buffer space management.
> > >     > Because it is also host pointer shared memory, it is also
> physically
> > >     contiguous
> > >     > and there is no scatterlist needed to process the traffic.
> > >
> > >     Yes at the moment virtio descriptors all pass addresses guest to
> host.
> > >
> > >     Ability to reverse that was part of the vhost-pci proposal a while
> ago.
> > >     BTW that also at least originally had ability to tunnel
> > >     multiple devices over a single connection.
> > >
> > >
> > >
> > > Can there be a similar proposal for virtio-pci without vhsot?
> > >
> > >     There was nothing wrong with the proposals I think, they
> > >     just had to be polished a bit before making it into the spec.
> > >     And that runneling was dropped but I think it can be brought back
> > >     if desired, we just didn't see a use for it.
> > >
> > >
> > > Thinking about it more, I think vhost-pci might be too much for us due
> to the
> > > vhost requirement (sockets and IPC while we desire a highly process
> local
> > > solution)
> >
> > I agree because the patches try to document a bunch of stuff.
> > But I really just mean taking the host/guest interface
> > part from there.
>
> Tomorrow I'll try to write up a little bit more about the vhost pci
> ideas.  The patches on list go deep into envisioned implementation
> detail within qemu instead of the actual host/guest interface.
> You should then be able to figure out they are relevant for you.
>
> Ok, looking forward! It does seems like a lot of what you are pointing
out, and in the vhost pci, what is specified is not strictly dependent on
the qemu implementation. Hopefully we can make the minimal set of changes
to support our constraints.


> --
> MST
>

--000000000000b9aa050581bf68e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 8:19 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, F=
eb 12, 2019 at 11:02:19PM -0500, Michael S. Tsirkin wrote:<br>
&gt; On Tue, Feb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On Tue, Feb 12, 2019 at 09:26:10AM -0800, Fran=
k Yang wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; BTW, the other unique aspect is that the =
ping messages allow a _host_<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0pointer<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; to serve as the lump of shared memory;<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; then there is no need to track buffers in=
 the guest kernel and the device<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; implementation can perform specialize buf=
fer space management.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Because it is also host pointer shared me=
mory, it is also physically<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0contiguous<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; and there is no scatterlist needed to pro=
cess the traffic.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Yes at the moment virtio descriptors all pass =
addresses guest to host.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Ability to reverse that was part of the vhost-=
pci proposal a while ago.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BTW that also at least originally had ability =
to tunnel<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0multiple devices over a single connection.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Can there be a similar proposal for virtio-pci without vhsot?<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0There was nothing wrong with the proposals I t=
hink, they<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0just had to be polished a bit before making it=
 into the spec.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0And that runneling was dropped but I think it =
can be brought back<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if desired, we just didn&#39;t see a use for i=
t.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Thinking about it more, I think vhost-pci might be too much for u=
s due to the<br>
&gt; &gt; vhost requirement (sockets and IPC while we desire a highly proce=
ss local<br>
&gt; &gt; solution)<br>
&gt; <br>
&gt; I agree because the patches try to document a bunch of stuff.<br>
&gt; But I really just mean taking the host/guest interface<br>
&gt; part from there.<br>
<br>
Tomorrow I&#39;ll try to write up a little bit more about the vhost pci<br>
ideas.=C2=A0 The patches on list go deep into envisioned implementation<br>
detail within qemu instead of the actual host/guest interface.<br>
You should then be able to figure out they are relevant for you.<br>
<br></blockquote><div>Ok, looking forward! It does seems like a lot of what=
 you are pointing out, and in the vhost pci, what is specified is not stric=
tly dependent on the qemu implementation. Hopefully we can make the minimal=
 set of changes to support our constraints.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
-- <br>
MST<br>
</blockquote></div></div>

--000000000000b9aa050581bf68e2--
