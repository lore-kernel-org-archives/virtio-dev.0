Return-Path: virtio-dev-return-5425-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7EF1985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 04:59:24 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org> <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
 <20190212221738-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212221738-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 20:59:10 -0800
Message-ID: <CAEkmjvU2_so0u1xKEQgxBXHLuocGB3ODQYdqiaMGD+QqSGBn6w@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bc30390581bf67aa"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000bc30390581bf67aa
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 8:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:
> >
> >
> > On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yang wrote:
> >     > BTW, the other unique aspect is that the ping messages allow a
> _host_
> >     pointer
> >     > to serve as the lump of shared memory;
> >     > then there is no need to track buffers in the guest kernel and the
> device
> >     > implementation can perform specialize buffer space management.
> >     > Because it is also host pointer shared memory, it is also
> physically
> >     contiguous
> >     > and there is no scatterlist needed to process the traffic.
> >
> >     Yes at the moment virtio descriptors all pass addresses guest to
> host.
> >
> >     Ability to reverse that was part of the vhost-pci proposal a while
> ago.
> >     BTW that also at least originally had ability to tunnel
> >     multiple devices over a single connection.
> >
> >
> >
> > Can there be a similar proposal for virtio-pci without vhsot?
> >
> >     There was nothing wrong with the proposals I think, they
> >     just had to be polished a bit before making it into the spec.
> >     And that runneling was dropped but I think it can be brought back
> >     if desired, we just didn't see a use for it.
> >
> >
> > Thinking about it more, I think vhost-pci might be too much for us due
> to the
> > vhost requirement (sockets and IPC while we desire a highly process local
> > solution)
>
> I agree because the patches try to document a bunch of stuff.
> But I really just mean taking the host/guest interface
> part from there.
>
> So, are you referring to the new ideas that vhost-pci introduces minus
socket IPC/inter-VM communication, and the vhost server being in the same
process as qemu?
That sounds like we could build something for qemu (Stefan?) that talks to
a virtio-pci-user (?) backend with a similar set of command line arguments.

>
> > But there's nothing preventing us from having the same reversals for
> virtio-pci
> > devices without vhost, right?
>
> Right. I think that if you build something such that vhost pci
> can be an instance of it on top, then it would have
> a lot of value.
>
> I'd be very eager to chase this down. The more interop with existing
virtual PCI concepts the better.

>
> > That's kind of what's being proposed with the shared memory stuff at the
> > moment, though it is not a device type by itself yet (Arguably, it
> should be).
> >
> >
> >     How about that? That sounds close to what you were looking for,
> >     does it not? That would be something to look into -
> >     if your ideas can be used to implement a virtio device
> >     backend by code running within a VM, that would be very interesting.
> >
> >
> > What about a device type, say, virtio-metapci,
>
> I have to say I really dislike that name. It's basically just saying I'm
> not telling you what it is.  Let's try to figure it out.  Looks like
> although it's not a vsock device it's also trying to support creating
> channels with support for passing two types of messages (data and
> control) as well as some shared memory access.  And it also has
> enumeration so opened channels can be tied to what? strings?  PCI Device
> IDs?
>
> I think we can build this relying on PCI device ids, assuming there are
still device IDs readily available.

Then the vsock device was designed for this problem space.  It might not
> be a good fit for you e.g. because of some vsock baggage it has. But one
> of the complex issues it does address is controlling host resource usage
> so guest socket can't DOS host or starve other sockets by throwing data
> at host. Things might slow down but progress will be made. If you are
> building a generic kind of message exchange you could do worse than copy
> that protocol part.
>
> That's a good point and I should make sure we've captured that.

> I don't think the question of why not vsock generally was addressed all
> that well. There's discussion of sockets and poll, but that has nothing
> to do with virtio which is a host/guest interface. If you are basically
> happy with the host/guest interface but want to bind a different driver
> to it, with some minor tweaks, we could create a virtio-wsock which is
> just like virtio-vsock but has a different id, and use that as a
> starting point.  Go wild build a different driver for it.
>
> The virtio-wsock notion also sounds good, though (also from Stefan's
comments) I'd want to clarify
how we would define such a device type
that is both pure in terms of host/guest interface (i.e., not assuming
sockets either in the guest or host),
but doesn't also, at the implementation level, imply that the existing
implementation of v(w)sock
change to accomodate non-socket-based guest/host interfaces.

>
> > that relies on virtio-pci for
> > device enumeration and shared memory handling
> > (assuming it's going to be compatible with the host pointer shared memory
> > implementation),
> > so there's no duplication of the concept of device enumeration nor shared
> > memory operations.
> > But, it works in terms of the ping / event virtqueues, and relies on the
> host
> > hypervisor to dispatch to device implementation callbacks.
>
> All the talk about dispatch and device implementation is just adding to
> confusion.  This isn't something that belongs in virtio spec anyway, and
> e.g. qemu is unlikely to add an in-process plugin support just for this.
>
> A plugin system of some type is what we think is quite valuable,
for decoupling device functionality from QEMU.
Keeping the same process is also attractive because of the lack of need of
IPC.
If there's a lightweight, cross platform way to do IPC via function pointer
mechanisms,
perhaps by dlsym or LoadLibrary on another process,
that could work too, though yes, it would need to be integrated to qemu.

>
> > A potential issue is that such metapci device share the same device id
> > namespace as other virtio-pci devices...but maybe that's OK?
>
> That's a vague question.
> Same device and vendor id needs to imply same driver works.
> I think you use the terminology that doesn't match virtio.
> words device and driver have a specific meaning and that
> doesnt include things like implementation callbacks.
>
>
> > If this can build on virtio-pci, I might be able to come up with a spec
> that
> > assumes virtio-pci as the transport,
> > and assumes (via the WIP host memory sharing work) that host memory can
> be used
> > as buffer storage.
> > The difference is that it will not contain most of the config virtqueue
> stuff
> > (except maybe for create/destroy instance),
> > and it should also work with the existing ecosystem around virtio-pci.
> >
>
> I still can't say from above whether it's in scope for virtio or not.
> All the talk about blobs and controlling both host and guest sounds
> out of scope. But it could be that there are pieces that are
> inscope, and you would use them for whatever vendor specific
> thing you need.
>
> And I spent a lot of time on this by now.
>
> So could you maybe try to extract specifically the host/guest interface
> things that you miss? I got the part where you want to take a buffer
> within BAR and pass it to guest.  But beyond that I didn't get a lot. E.g.
> who is sending most data? host? guest? both? There are control messages
> are these coming from guest?  Do you want to know when guest is done
> with the buffer host allocated? Can you take a buffer away from guest?
>
> Thanks for taking the time to evaluate; we very much appreciate it
and want to resolve the issues you're having!

To answer the other questions:
- We expect most data to be sent by the guest, except in the cases of image
readback,
where the host will write a lot of data.
- The control messages (ping) are driven by the guest only; at most, the
guest can async wait on a long host operation that was triggered by the
guest.
Hence, the events argument in the spec being guest driver, and revents
being populated by the host.
- It is out of scope to know when the guest is done with the host buffer.
- Buffers will be owned by the host, and the guest will not own any buffers
under the current scheme.
This is because it is up to the host-side implementation to decide how to
back new memory allocations from the guest.


> OTOH all the callback discussion is really irrelevant for the virtio tc.
> If things can't be described without this they are out of scope
> for virtio.
>
>  We can describe the current proposal for virtio without explicitly naming
callbacks
on the host, but it would push that kind of implementation burden to the
host qemu,
so I thought it would be a good idea to lay things out end to end
in a way that would be concretely implementable.

> >
> >     --
> >     MST
> >
>

--000000000000bc30390581bf67aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 8:02 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, F=
eb 12, 2019 at 06:50:29PM -0800, Frank Yang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Feb 12, 2019 at 11:06 AM Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Feb 12, 2019 at 09:26:10AM -0800, Frank Yan=
g wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; BTW, the other unique aspect is that the ping =
messages allow a _host_<br>
&gt;=C2=A0 =C2=A0 =C2=A0pointer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to serve as the lump of shared memory;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; then there is no need to track buffers in the =
guest kernel and the device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; implementation can perform specialize buffer s=
pace management.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Because it is also host pointer shared memory,=
 it is also physically<br>
&gt;=C2=A0 =C2=A0 =C2=A0contiguous<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and there is no scatterlist needed to process =
the traffic.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes at the moment virtio descriptors all pass addre=
sses guest to host.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Ability to reverse that was part of the vhost-pci p=
roposal a while ago.<br>
&gt;=C2=A0 =C2=A0 =C2=A0BTW that also at least originally had ability to tu=
nnel<br>
&gt;=C2=A0 =C2=A0 =C2=A0multiple devices over a single connection.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Can there be a similar proposal for virtio-pci without vhsot?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There was nothing wrong with the proposals I think,=
 they<br>
&gt;=C2=A0 =C2=A0 =C2=A0just had to be polished a bit before making it into=
 the spec.<br>
&gt;=C2=A0 =C2=A0 =C2=A0And that runneling was dropped but I think it can b=
e brought back<br>
&gt;=C2=A0 =C2=A0 =C2=A0if desired, we just didn&#39;t see a use for it.<br=
>
&gt; <br>
&gt; <br>
&gt; Thinking about it more, I think vhost-pci might be too much for us due=
 to the<br>
&gt; vhost requirement (sockets and IPC while we desire a highly process lo=
cal<br>
&gt; solution)<br>
<br>
I agree because the patches try to document a bunch of stuff.<br>
But I really just mean taking the host/guest interface<br>
part from there.<br>
<br></blockquote><div>So, are you referring to the new ideas that vhost-pci=
 introduces minus socket IPC/inter-VM communication, and the vhost server b=
eing in the same process as qemu?</div><div>That sounds like we could build=
 something for qemu (Stefan?) that talks to a virtio-pci-user (?) backend w=
ith a similar set of command line arguments.</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; But there&#39;s nothing preventing us from having the same reversals f=
or virtio-pci<br>
&gt; devices without vhost, right?<br>
<br>
Right. I think that if you build something such that vhost pci<br>
can be an instance of it on top, then it would have<br>
a lot of value.<br>
<br></blockquote><div>I&#39;d be very eager to chase this down. The more in=
terop with existing virtual PCI concepts the better.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; That&#39;s kind of what&#39;s being proposed with the shared memory st=
uff at the<br>
&gt; moment, though it is not a device type by itself yet (Arguably, it sho=
uld be).<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0How about that? That sounds close to what you were =
looking for,<br>
&gt;=C2=A0 =C2=A0 =C2=A0does it not? That would be something to look into -=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0if your ideas can be used to implement a virtio dev=
ice<br>
&gt;=C2=A0 =C2=A0 =C2=A0backend by code running within a VM, that would be =
very interesting.<br>
&gt; <br>
&gt; <br>
&gt; What about a device type, say, virtio-metapci,<br>
<br>
I have to say I really dislike that name. It&#39;s basically just saying I&=
#39;m<br>
not telling you what it is.=C2=A0 Let&#39;s try to figure it out.=C2=A0 Loo=
ks like<br>
although it&#39;s not a vsock device it&#39;s also trying to support creati=
ng<br>
channels with support for passing two types of messages (data and<br>
control) as well as some shared memory access.=C2=A0 And it also has<br>
enumeration so opened channels can be tied to what? strings?=C2=A0 PCI Devi=
ce<br>
IDs?<br>
<br></blockquote><div>I think we can build this relying on PCI device ids, =
assuming there are still device IDs readily available.</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Then the vsock device was designed for this problem space.=C2=A0 It might n=
ot<br>
be a good fit for you e.g. because of some vsock baggage it has. But one<br=
>
of the complex issues it does address is controlling host resource usage<br=
>
so guest socket can&#39;t DOS host or starve other sockets by throwing data=
<br>
at host. Things might slow down but progress will be made. If you are<br>
building a generic kind of message exchange you could do worse than copy<br=
>
that protocol part.<br>
<br></blockquote><div>That&#39;s a good point and I should make sure we&#39=
;ve captured that.</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I don&#39;t think the question of why not vsock generally was addressed all=
<br>
that well. There&#39;s discussion of sockets and poll, but that has nothing=
<br>
to do with virtio which is a host/guest interface. If you are basically<br>
happy with the host/guest interface but want to bind a different driver<br>
to it, with some minor tweaks, we could create a virtio-wsock which is<br>
just like virtio-vsock but has a different id, and use that as a<br>
starting point.=C2=A0 Go wild build a different driver for it.<br>
<br></blockquote><div>The virtio-wsock notion also sounds good, though (als=
o from Stefan&#39;s comments) I&#39;d want to clarify</div><div>how we woul=
d define such a device type</div><div>that is both pure in terms of host/gu=
est interface (i.e., not assuming sockets either in the guest or host),</di=
v><div>but doesn&#39;t also, at the implementation level, imply that the ex=
isting implementation of v(w)sock</div><div>change to accomodate non-socket=
-based guest/host interfaces.</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; that relies on virtio-pci for<br>
&gt; device enumeration and shared memory handling<br>
&gt; (assuming it&#39;s going to be compatible with the host pointer shared=
 memory<br>
&gt; implementation),<br>
&gt; so there&#39;s no duplication of the concept of device enumeration nor=
 shared<br>
&gt; memory operations.<br>
&gt; But, it works in terms of the ping / event virtqueues, and relies on t=
he host<br>
&gt; hypervisor to dispatch to device implementation callbacks.<br>
<br>
All the talk about dispatch and device implementation is just adding to<br>
confusion.=C2=A0 This isn&#39;t something that belongs in virtio spec anywa=
y, and<br>
e.g. qemu is unlikely to add an in-process plugin support just for this.<br=
>
<br></blockquote><div>A plugin system of some type is what we think is quit=
e valuable,</div><div>for decoupling device functionality from QEMU.</div><=
div>Keeping the same process is also attractive because of the lack of need=
 of IPC.</div><div>If there&#39;s a lightweight, cross platform way to do I=
PC via function pointer mechanisms,</div><div>perhaps by dlsym or LoadLibra=
ry on another process,</div><div>that could work too, though yes, it would =
need to be integrated to qemu.</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; A potential issue is that such metapci device share the same device id=
<br>
&gt; namespace as other virtio-pci devices...but maybe that&#39;s OK?<br>
<br>
That&#39;s a vague question.<br>
Same device and vendor id needs to imply same driver works.<br>
I think you use the terminology that doesn&#39;t match virtio.<br>
words device and driver have a specific meaning and that<br>
doesnt include things like implementation callbacks.<br>
<br>
<br>
&gt; If this can build on virtio-pci, I might be able to come up with a spe=
c that<br>
&gt; assumes virtio-pci as the transport,<br>
&gt; and assumes (via the WIP host memory sharing work) that host memory ca=
n be used<br>
&gt; as buffer storage.<br>
&gt; The difference is that it will not contain most of the config virtqueu=
e stuff<br>
&gt; (except maybe for create/destroy instance),<br>
&gt; and it should also work with the existing ecosystem around virtio-pci.=
<br>
&gt; =C2=A0<br>
<br>
I still can&#39;t say from above whether it&#39;s in scope for virtio or no=
t.<br>
All the talk about blobs and controlling both host and guest sounds<br>
out of scope. But it could be that there are pieces that are<br>
inscope, and you would use them for whatever vendor specific<br>
thing you need.<br>
<br>
And I spent a lot of time on this by now.<br>
<br>
So could you maybe try to extract specifically the host/guest interface<br>
things that you miss? I got the part where you want to take a buffer<br>
within BAR and pass it to guest.=C2=A0 But beyond that I didn&#39;t get a l=
ot. E.g.<br>
who is sending most data? host? guest? both? There are control messages<br>
are these coming from guest?=C2=A0 Do you want to know when guest is done<b=
r>
with the buffer host allocated? Can you take a buffer away from guest?<br>
<br></blockquote><div>Thanks for taking the time to evaluate; we very much =
appreciate it</div><div>and want to resolve the issues you&#39;re having!</=
div><div><br></div><div>To answer the other questions:</div><div>- We expec=
t most data to be sent by the guest, except in the cases of image readback,=
</div><div>where the host will write a lot of data.</div><div>- The control=
 messages (ping) are driven by the guest only; at most, the guest can async=
 wait on a long host operation that was triggered by the guest.</div><div>H=
ence, the events argument in the spec being guest driver, and revents being=
 populated by the host.</div><div>- It is out of scope to know when the gue=
st is done with the host buffer.</div><div>- Buffers will be owned by the h=
ost, and the guest will not own any buffers under the current scheme.</div>=
<div>This is because it is up to the host-side implementation to decide how=
 to back new memory allocations from the guest.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
OTOH all the callback discussion is really irrelevant for the virtio tc.<br=
>
If things can&#39;t be described without this they are out of scope<br>
for virtio.<br>
<br></blockquote><div>=C2=A0We can describe the current proposal for virtio=
 without explicitly naming callbacks</div><div>on the host, but it would pu=
sh that kind of implementation burden to the host qemu,</div><div>so I thou=
ght it would be a good idea to lay things out end to end</div><div>in a way=
 that would be concretely implementable.</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0MST<br>
&gt; <br>
</blockquote></div></div>

--000000000000bc30390581bf67aa--
