Return-Path: virtio-dev-return-5515-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00D0E985A9A
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Feb 2019 21:19:26 +0000 (UTC)
MIME-Version: 1.0
References: <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org> <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
 <20190212221738-mutt-send-email-mst@kernel.org> <20190212231458-mutt-send-email-mst@kernel.org>
 <CAEkmjvVD7E_DcBkoucNSYs74T10K2qrJHAYbzCqUF=7C+B-4GQ@mail.gmail.com>
 <CAEkmjvVON9+h_S90LDmaobKq4CG=VZz2HarVcRFP04oFK=H2cw@mail.gmail.com>
 <CAEkmjvU8vAXcH4SmMsbD_suU82w6XzLXzDCJSDY-UT2Xq6+TAw@mail.gmail.com> <20190222163900-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190222163900-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Sun, 24 Feb 2019 13:19:13 -0800
Message-ID: <CAEkmjvWrVQ28iwfkhh4TQ5G_F7XLssgVmQfC0XxgGJ0U540ReA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cfeca10582aa6054"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000cfeca10582aa6054
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 22, 2019 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Feb 13, 2019 at 11:15:12PM -0800, Frank Yang wrote:
> > Revised the spec to clean up a straggling mention of callbacks, and
> added a
> > concrete example of how it would be used for a video codec.
> >
> > Inlined here:
>
> BTW I'd rather you started sending versioned RFC patches.
> This thread's too large already.
>
>
> Ok, I've started a new thread on virtio-comment that re-shuffles the
github links I've sent over so far, and responds to your latest questions.
Thanks Michael!


> > \subsection{Example Use Case}\label{sec:Device Types / Host Memory
> Device /
> > Example Use Case}
> >
> > Suppose the guest wants to decode a compressed video buffer.
> >
> > \begin{enumerate}
> >
> > \item Guest creates an instance for the codec vendor id / device id /
> revision.
>
> OK we'll need to see how do we come up with a way to avoid conflicts
> here, e.g. if multiple vendors will use this device.
>
> > \item Guest allocates into the PCI region via config virtqueue messages.
>
> OK so who allocates memory out of the PCI region?
> Is it the host or the guest?
> E.g. does guest say "I want X bytes" and host would respond
> "here they are, start at offset X"?
>
> > \item Guest sends a message over the ping virtqueue for the host to back
> that
> > memory.
>
> And all of these will need to be maintained on the host right?
> How many of these regions need to be supported?
>
> >
> > \item Host codec device implementation exposes codec library's buffer
> directly
> > to guest.
> >
> > \item Guest: now that the memory is host backed, the guest mmap()'s and
> >     downloads the compressed video stream directly to the host buffer.
> >
> > \item Guest: After a packet of compressed video stream is downloaded to
> the
> >     buffer, another message, like a doorbell, is sent on the ping
> virtqueue to
> >         consume existing compressed data. The ping message's offset
> field is
> >         set to the proper offset into the shared-mem object.
>
> BTW is this terminology e.g. "download", "ping message" standard somewhere?
>
> > \item Host: The ping message arrives on the host and the offset is
> resolved to
> >     a physical address and then, if possible, the physical address to a
> host
> >         pointer. Since the memory is now backed, the host pointer is also
> >         resolved.
> >
> > \item Host: Codec implementation decodes the video and puts the decoded
> frames
> >     to either a host-side display library (thus with no further guest
> >         communication necessary), or puts the raw decompressed frame to a
> >         further offset in the host buffer that the guest knows about.
> >
> > \item Guest: Continue downloading video streams and hitting the
> doorbell, or
> >     optionally, wait until the host is done first. If scheduling is not
> that
> >         big of an impact, this can be done without even any further VM
> exit, by
> >         the host writing to an agreed memory location when decoding is
> done,
> >         then the guest uses a polling sleep(N) where N is the correctly
> tuned
> >         timeout such that only a few poll spins are necessary.
> >
> >
> > \item Guest: Or, the host can send back on the event virtqueue
> \field{revents}
> >     and the guest can perform a blocking read() for it.
> >
> > \end{enumerate}
> >
> > The unique / interesting aspects of virtio-hostmem are demonstrated:
> >
> > \begin{enumerate}
> >
> > \item During instance creation the host was allowed to reject the
> request if
> >     the codec device did not exist on host.
> >
> > \item The host can expose a codec library buffer directly to the guest,
> > allowing the guest to write into it with zero copy and the host to
> decompress
> > again without copying.
> >
> > \item Large bidirectional transfers are possible with zero copy.
>
> However just to make sure, sending small amounts of data
> is slower since you get to do all the mmap dance.
>
>
> > \item Large bidirectional transfers are possible without scatterlists,
> because
> >     the memory is always physically contiguous.
>
> It might get fragmented though. I think it would be up to
> host to try and make sure it's not too fragmented, right?
>
>
> > \item It is not necessary to use socket datagrams or data streams to
> >     communicate the ping messages; they can be raw structs fresh off the
> >         virtqueue.
>
> OK and ping messages are all fixed size?
>
>
> > \item After decoding, the guest has the option but not the requirement
> to wait
> >     for the host round trip, allowing for async operation of the codec.
> >
> > \item The guest has the option but not the requirement to wait for the
> host
> >     round trip, allowing for async operation of the codec.
> >
> > \end{enumerate}
>
> OK I still owe you that write-up about vhost pci.  will try to complete
> that early next week. But generally if I got it right that the host
> allocates buffers then what you describe does seem to fit a bit better
> with the vhost pci host/guest interface idea.
>
> One question that was asked about vhost pci is whether it is in fact
> necessary to share a device between multiple applications.
> Or is it enough to just have one id per device?
>
> Thanks!
> --
> MST
>

--000000000000cfeca10582aa6054
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 22, 2019 at 2:05 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, F=
eb 13, 2019 at 11:15:12PM -0800, Frank Yang wrote:<br>
&gt; Revised the spec to clean up a straggling mention of callbacks, and ad=
ded a<br>
&gt; concrete example of how it would be used for a video codec.<br>
&gt; <br>
&gt; Inlined here:<br>
<br>
BTW I&#39;d rather you started sending versioned RFC patches.<br>
This thread&#39;s too large already.<br>
<br>
<br></blockquote><div>Ok, I&#39;ve started a new thread on virtio-comment t=
hat re-shuffles the github links I&#39;ve sent over so far, and responds to=
 your latest questions. Thanks Michael!</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
&gt; \subsection{Example Use Case}\label{sec:Device Types / Host Memory Dev=
ice /<br>
&gt; Example Use Case}<br>
&gt; <br>
&gt; Suppose the guest wants to decode a compressed video buffer.<br>
&gt; <br>
&gt; \begin{enumerate}<br>
&gt; <br>
&gt; \item Guest creates an instance for the codec vendor id / device id / =
revision.<br>
<br>
OK we&#39;ll need to see how do we come up with a way to avoid conflicts<br=
>
here, e.g. if multiple vendors will use this device.<br>
<br>
&gt; \item Guest allocates into the PCI region via config virtqueue message=
s.<br>
<br>
OK so who allocates memory out of the PCI region?<br>
Is it the host or the guest?<br>
E.g. does guest say &quot;I want X bytes&quot; and host would respond<br>
&quot;here they are, start at offset X&quot;?<br>
<br>
&gt; \item Guest sends a message over the ping virtqueue for the host to ba=
ck that<br>
&gt; memory.<br>
<br>
And all of these will need to be maintained on the host right?<br>
How many of these regions need to be supported?<br>
<br>
&gt; <br>
&gt; \item Host codec device implementation exposes codec library&#39;s buf=
fer directly<br>
&gt; to guest.<br>
&gt; <br>
&gt; \item Guest: now that the memory is host backed, the guest mmap()&#39;=
s and<br>
&gt; =C2=A0 =C2=A0 downloads the compressed video stream directly to the ho=
st buffer.<br>
&gt; <br>
&gt; \item Guest: After a packet of compressed video stream is downloaded t=
o the<br>
&gt; =C2=A0 =C2=A0 buffer, another message, like a doorbell, is sent on the=
 ping virtqueue to<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 consume existing compressed data. The ping=
 message&#39;s offset field is<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 set to the proper offset into the shared-m=
em object.<br>
<br>
BTW is this terminology e.g. &quot;download&quot;, &quot;ping message&quot;=
 standard somewhere?<br>
<br>
&gt; \item Host: The ping message arrives on the host and the offset is res=
olved to<br>
&gt; =C2=A0 =C2=A0 a physical address and then, if possible, the physical a=
ddress to a host<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 pointer. Since the memory is now backed, t=
he host pointer is also<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 resolved.<br>
&gt; <br>
&gt; \item Host: Codec implementation decodes the video and puts the decode=
d frames<br>
&gt; =C2=A0 =C2=A0 to either a host-side display library (thus with no furt=
her guest<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 communication necessary), or puts the raw =
decompressed frame to a<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 further offset in the host buffer that the=
 guest knows about.<br>
&gt; <br>
&gt; \item Guest: Continue downloading video streams and hitting the doorbe=
ll, or<br>
&gt; =C2=A0 =C2=A0 optionally, wait until the host is done first. If schedu=
ling is not that<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 big of an impact, this can be done without=
 even any further VM exit, by<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 the host writing to an agreed memory locat=
ion when decoding is done,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 then the guest uses a polling sleep(N) whe=
re N is the correctly tuned<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout such that only a few poll spins ar=
e necessary.<br>
&gt;<br>
&gt;<br>
&gt; \item Guest: Or, the host can send back on the event virtqueue \field{=
revents}<br>
&gt; =C2=A0 =C2=A0 and the guest can perform a blocking read() for it.<br>
&gt; <br>
&gt; \end{enumerate}<br>
&gt; <br>
&gt; The unique / interesting aspects of virtio-hostmem are demonstrated:<b=
r>
&gt; <br>
&gt; \begin{enumerate}<br>
&gt; <br>
&gt; \item During instance creation the host was allowed to reject the requ=
est if<br>
&gt; =C2=A0 =C2=A0 the codec device did not exist on host.<br>
&gt; <br>
&gt; \item The host can expose a codec library buffer directly to the guest=
,<br>
&gt; allowing the guest to write into it with zero copy and the host to dec=
ompress<br>
&gt; again without copying.<br>
&gt; <br>
&gt; \item Large bidirectional transfers are possible with zero copy.<br>
<br>
However just to make sure, sending small amounts of data<br>
is slower since you get to do all the mmap dance.<br>
<br>
<br>
&gt; \item Large bidirectional transfers are possible without scatterlists,=
 because<br>
&gt; =C2=A0 =C2=A0 the memory is always physically contiguous.<br>
<br>
It might get fragmented though. I think it would be up to<br>
host to try and make sure it&#39;s not too fragmented, right?<br>
<br>
<br>
&gt; \item It is not necessary to use socket datagrams or data streams to<b=
r>
&gt; =C2=A0 =C2=A0 communicate the ping messages; they can be raw structs f=
resh off the<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtqueue.<br>
<br>
OK and ping messages are all fixed size?<br>
<br>
<br>
&gt; \item After decoding, the guest has the option but not the requirement=
 to wait<br>
&gt; =C2=A0 =C2=A0 for the host round trip, allowing for async operation of=
 the codec.<br>
&gt; <br>
&gt; \item The guest has the option but not the requirement to wait for the=
 host<br>
&gt; =C2=A0 =C2=A0 round trip, allowing for async operation of the codec.<b=
r>
&gt; <br>
&gt; \end{enumerate}<br>
<br>
OK I still owe you that write-up about vhost pci.=C2=A0 will try to complet=
e<br>
that early next week. But generally if I got it right that the host<br>
allocates buffers then what you describe does seem to fit a bit better<br>
with the vhost pci host/guest interface idea.<br>
<br>
One question that was asked about vhost pci is whether it is in fact<br>
necessary to share a device between multiple applications.<br>
Or is it enough to just have one id per device?<br>
<br>
Thanks!<br>
-- <br>
MST<br>
</blockquote></div></div>

--000000000000cfeca10582aa6054--
