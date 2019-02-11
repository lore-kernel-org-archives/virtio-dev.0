Return-Path: virtio-dev-return-5388-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DEBE5985C57
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 15:15:10 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com> <20190211092943-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190211092943-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Mon, 11 Feb 2019 07:14:53 -0800
Message-ID: <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000003426205819fc6db"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000003426205819fc6db
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 11, 2019 at 6:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:
> > Hi Gerd,
> >
> > > virtio-gpu specifically needs that to support vulkan and opengl
> > > extensions for coherent buffers, which must be allocated by the host
> gpu
> > > driver.  It's WIP still.
> >
> > the proposed spec says:
> >
> > +Shared memory regions MUST NOT be used to control the operation
> > +of the device, nor to stream data; those should still be performed
> > +using virtqueues.
> >
> > Is there a strong reason to prohibit using memory regions for control
> purposes?
>
> That's in order to make virtio have portability implications, such that if
> people see a virtio device in lspci they know there's
> no lock-in, their guest can be moved between hypervisors
> and will still work.
>
> > Our long term goal is to have as few kernel drivers as possible and to
> move
> > "drivers" into userspace. If we go with the virtqueues, is there
> > general a purpose
> > device/driver to talk between our host and guest to support custom
> hardware
> > (with own blobs)?
>
> The challenge is to answer the following question:
> how to do this without losing the benefits of standartization?
>
> Draft spec is incoming, but the basic idea is to standardize how to
enumerate, discover, and operate (with high performance) such userspace
drivers/devices; the basic operations would be standardized, and userspace
drivers would be constructed out of the resulting primitives.

> Could you please advise if we can use something else to
> > achieve this goal?
>
> I am not sure what the goal is though. Blobs is a means I guess
> or it should be :) E.g. is it about being able to iterate quickly?
>
> Maybe you should look at vhost-user-gpu patches on qemu?
> Would this address your need?
> Acks for these patches would be a good thing.
>
>
Is this it:

https://patchwork.kernel.org/patch/10444089/ ?

I'll check it out and try to discuss. Is there a draft spec for it as well?


>
> --
> MST
>

--00000000000003426205819fc6db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 11, 2019=
 at 6:49 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:<br>
&gt; Hi Gerd,<br>
&gt; <br>
&gt; &gt; virtio-gpu specifically needs that to support vulkan and opengl<b=
r>
&gt; &gt; extensions for coherent buffers, which must be allocated by the h=
ost gpu<br>
&gt; &gt; driver.=C2=A0 It&#39;s WIP still.<br>
&gt; <br>
&gt; the proposed spec says:<br>
&gt; <br>
&gt; +Shared memory regions MUST NOT be used to control the operation<br>
&gt; +of the device, nor to stream data; those should still be performed<br=
>
&gt; +using virtqueues.<br>
&gt; <br>
&gt; Is there a strong reason to prohibit using memory regions for control =
purposes?<br>
<br>
That&#39;s in order to make virtio have portability implications, such that=
 if<br>
people see a virtio device in lspci they know there&#39;s<br>
no lock-in, their guest can be moved between hypervisors<br>
and will still work.<br>
<br>
&gt; Our long term goal is to have as few kernel drivers as possible and to=
 move<br>
&gt; &quot;drivers&quot; into userspace. If we go with the virtqueues, is t=
here<br>
&gt; general a purpose<br>
&gt; device/driver to talk between our host and guest to support custom har=
dware<br>
&gt; (with own blobs)?<br>
<br>
The challenge is to answer the following question:<br>
how to do this without losing the benefits of standartization?<br>
<br></blockquote><div>Draft spec is incoming, but the basic idea is to stan=
dardize how to enumerate, discover, and operate (with high performance) suc=
h userspace drivers/devices; the basic operations would be standardized, an=
d userspace drivers would be constructed out of the resulting primitives.</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Could you please advise if we can use something else to<br>
&gt; achieve this goal?<br>
<br>
I am not sure what the goal is though. Blobs is a means I guess<br>
or it should be :) E.g. is it about being able to iterate quickly?<br>
<br>
Maybe you should look at vhost-user-gpu patches on qemu?<br>
Would this address your need?<br>
Acks for these patches would be a good thing.<br>
<br></blockquote><div><br></div><div>Is this it:</div><div><br></div><div><=
a href=3D"https://patchwork.kernel.org/patch/10444089/">https://patchwork.k=
ernel.org/patch/10444089/</a> ?</div><div><br></div><div>I&#39;ll check it =
out and try to discuss. Is there a draft spec for it as well?<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
MST<br>
</blockquote></div></div></div>

--00000000000003426205819fc6db--
