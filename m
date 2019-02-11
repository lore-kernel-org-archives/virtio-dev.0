Return-Path: virtio-dev-return-5389-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66535985C62
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 15:25:31 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
In-Reply-To: <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
From: Frank Yang <lfy@google.com>
Date: Mon, 11 Feb 2019 07:25:18 -0800
Message-ID: <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003c25cd05819feb31"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000003c25cd05819feb31
Content-Type: text/plain; charset="UTF-8"

BTW, I have a few concerns about the upcoming shared-mem virtio type. This
is mostly directed at David and kraxel.

We've found that for many applications, simply telling the guest to create
a new host pointer of Vulkan or OpenGL has quite some overhead in just
telling the hypervisor to map it, and in fact, it's easy to run out of KVM
slots by doing so. So for Vulkan, we rely on having one large host visible
region on the host that is a single region of host shared memory. That, is
then sub-allocated for the guest. So there is no Vulkan host pointer that
is being shared to the guest 1:1; we suballocate, then generate the right
'underlying' Vulkan device memory offset and size parameters for the host.

In general though, this means that the ideal usage of host pointers would
be to set a few regions up front for certain purposes, then share that out
amongst other device contexts. This also facilitates sharing the memory
between guest processes, which is useful for implementing things like
compositors. This also features heavily for our "virtio userspace" thing.
Since this is a common pattern, should this sharing concept be standardized
somehow? I.e., should there be a standard way to send Shmid/offset/size to
other devices, or have that be a standard struct in the hypervisor?

On Mon, Feb 11, 2019 at 7:14 AM Frank Yang <lfy@google.com> wrote:

>
>
> On Mon, Feb 11, 2019 at 6:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>> On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:
>> > Hi Gerd,
>> >
>> > > virtio-gpu specifically needs that to support vulkan and opengl
>> > > extensions for coherent buffers, which must be allocated by the host
>> gpu
>> > > driver.  It's WIP still.
>> >
>> > the proposed spec says:
>> >
>> > +Shared memory regions MUST NOT be used to control the operation
>> > +of the device, nor to stream data; those should still be performed
>> > +using virtqueues.
>> >
>> > Is there a strong reason to prohibit using memory regions for control
>> purposes?
>>
>> That's in order to make virtio have portability implications, such that if
>> people see a virtio device in lspci they know there's
>> no lock-in, their guest can be moved between hypervisors
>> and will still work.
>>
>> > Our long term goal is to have as few kernel drivers as possible and to
>> move
>> > "drivers" into userspace. If we go with the virtqueues, is there
>> > general a purpose
>> > device/driver to talk between our host and guest to support custom
>> hardware
>> > (with own blobs)?
>>
>> The challenge is to answer the following question:
>> how to do this without losing the benefits of standartization?
>>
>> Draft spec is incoming, but the basic idea is to standardize how to
> enumerate, discover, and operate (with high performance) such userspace
> drivers/devices; the basic operations would be standardized, and userspace
> drivers would be constructed out of the resulting primitives.
>
> > Could you please advise if we can use something else to
>> > achieve this goal?
>>
>> I am not sure what the goal is though. Blobs is a means I guess
>> or it should be :) E.g. is it about being able to iterate quickly?
>>
>> Maybe you should look at vhost-user-gpu patches on qemu?
>> Would this address your need?
>> Acks for these patches would be a good thing.
>>
>>
> Is this it:
>
> https://patchwork.kernel.org/patch/10444089/ ?
>
> I'll check it out and try to discuss. Is there a draft spec for it as well?
>
>
>>
>> --
>> MST
>>
>

--0000000000003c25cd05819feb31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">BTW, I have a few concerns about the upcoming shared-mem v=
irtio type. This is mostly directed at David and kraxel.<div><br></div><div=
>We&#39;ve found that for many applications, simply telling the guest to cr=
eate a new host pointer of Vulkan or OpenGL has quite some overhead in just=
 telling the hypervisor to map it, and in fact, it&#39;s easy to run out of=
 KVM slots by doing so. So for Vulkan, we rely on having one large host vis=
ible region on the host that is a single region of host shared memory. That=
, is then sub-allocated for the guest. So there is no Vulkan host pointer t=
hat is being shared to the guest 1:1; we suballocate, then generate the rig=
ht &#39;underlying&#39; Vulkan device memory offset and size parameters for=
 the host.</div><div><br></div><div>In general though, this means that the =
ideal usage of host pointers would be to set a few regions up front for cer=
tain purposes, then share that out amongst other device contexts. This also=
 facilitates sharing the memory between guest processes, which is useful fo=
r implementing things like compositors. This also features heavily for our =
&quot;virtio userspace&quot; thing. Since this is a common pattern, should =
this sharing concept be standardized somehow? I.e., should there be a stand=
ard way to send Shmid/offset/size to other devices, or have that be a stand=
ard struct in the hypervisor?</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 11, 2019 at 7:14 AM Frank Ya=
ng &lt;<a href=3D"mailto:lfy@google.com">lfy@google.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 11, 2019 at 6:49 AM Michael =
S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:<br>
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
a href=3D"https://patchwork.kernel.org/patch/10444089/" target=3D"_blank">h=
ttps://patchwork.kernel.org/patch/10444089/</a> ?</div><div><br></div><div>=
I&#39;ll check it out and try to discuss. Is there a draft spec for it as w=
ell?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
-- <br>
MST<br>
</blockquote></div></div></div>
</blockquote></div>

--0000000000003c25cd05819feb31--
