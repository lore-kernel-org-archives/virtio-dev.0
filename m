Return-Path: <virtio-dev-return-9293-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B563F9863E0
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Feb 2022 05:41:47 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
 <YfuwGoRY6LkEOTCp@stefanha-x1.localdomain> <CAAQ-SiNEk3OzBK6DGtufWKS+wqysZeN2Ntp3tHa_3N=dbFCrSg@mail.gmail.com>
In-Reply-To: <CAAQ-SiNEk3OzBK6DGtufWKS+wqysZeN2Ntp3tHa_3N=dbFCrSg@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 10 Feb 2022 21:41:34 -0800
Message-ID: <CAOGAQerL47Ve3qx0PVX+w9QhFr0uyVLC5S=7vX8ZRm2KwthVWQ@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Type: multipart/alternative; boundary="000000000000b6be5a05d7b785e1"
To: Shreyansh Chouhan <chouhan.shreyansh2702@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Anton Yakovlev <anton.yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000b6be5a05d7b785e1
Content-Type: text/plain; charset="UTF-8"

On Sun, Feb 6, 2022 at 9:41 PM Shreyansh Chouhan <
chouhan.shreyansh2702@gmail.com> wrote:

> Hi,
>
> On Thu, 3 Feb 2022 at 16:06, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:
> > > Hello,
> > >
> > > I work in Android Studio Emulator and I am currently implementing a
> > > virtio-snd device. We found a spec draft here:
> > >
> > >
> https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5
> > >
> > > It mentions four virtqueues: ctl, event, rx and tx. It is not very
> clear
> > > where a virtio-snd device should put responses to the ctl requests
> from the
> > > linux kernel driver. There is a kernel driver implementation and we
> have a
> > > virtio-snd device implemented in another emulator, it uses the same
> > > virtqueue (ctl) to put ctl responses and the current kernel driver
> seems
> > > happy with this.
> > >
> > > Do you know if this is expected behavior? I am far from an expert
> here, but
> > > I believe the device and the kernel will race here by reading from the
> same
> > > virtqueue: the device could read VirtQueueElement produced by itself
> before
> > > the kernel if the kernel is not fast enough.
>
> I think that is the intended behavior. Each virtqueue is supposed to have
> device and driver writable areas. (Separate used ring and avail ring
> in case of split
> virtqueues, and in case of packed virtqueues we have something similar
> but within a single circular buffer.)
>
> I don't think there will be any races. In case of split virtqueues we
> have separate
> avail and used rings and device and the driver look for buffers to consume
> from
> these different rings. In case of packed virtqueues we have flags and
> a wrap counting
> bit and we use these to make sure we don't read anything not intended for
> us.
>
> You can check these explanations out for more details, these are what I
> used
> when I started the sound card implementation.
>
> Split Virtqueue:
> https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travels
> Packed Virtqueue:
> https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-virtio


Hi,
thank you all for looking into this. This helped me to make some progress.
My device is able to play audio, sometimes clean and sometimes I see the
guest issues a lot of PCM_PREPARE/PCM_START/PCM_STOP/PCM_RELEASE requests
for no reason. Maybe it is not happy with my replies in the tx virtqueue.

Do you happen to have a more recent patch to the spec for virtio-snd? The
patch (
https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3
) says "The driver MUST NOT place device-writable buffers into the tx
queue" while it seems expect for the device to write status messages there.
Also, it is never mentioned which status messages to write into the tx
virtqueue (I guess it is virtio_snd_pcm_status) and
the virtio_snd_pcm_status::latency_bytes explanation is not very elaborate.
I believe it is the amount of bytes buffered in the device waiting to go
to AUD_write.

Could you please clarify? Thank you.

Regards,
Roman.

--000000000000b6be5a05d7b785e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sun, Feb 6, 2022 at 9:41 PM Shreyansh Chouhan &lt;<a href=3D"mail=
to:chouhan.shreyansh2702@gmail.com">chouhan.shreyansh2702@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Thu, 3 Feb 2022 at 16:06, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; I work in Android Studio Emulator and I am currently implementing=
 a<br>
&gt; &gt; virtio-snd device. We found a spec draft here:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/oasis-tcs/virtio-spec/commit/e73c8c=
df3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d32=
0c82a9d29b4027721f5f5f3918dc5" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670=
f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc=
5</a><br>
&gt; &gt;<br>
&gt; &gt; It mentions four virtqueues: ctl, event, rx and tx. It is not ver=
y clear<br>
&gt; &gt; where a virtio-snd device should put responses to the ctl request=
s from the<br>
&gt; &gt; linux kernel driver. There is a kernel driver implementation and =
we have a<br>
&gt; &gt; virtio-snd device implemented in another emulator, it uses the sa=
me<br>
&gt; &gt; virtqueue (ctl) to put ctl responses and the current kernel drive=
r seems<br>
&gt; &gt; happy with this.<br>
&gt; &gt;<br>
&gt; &gt; Do you know if this is expected behavior? I am far from an expert=
 here, but<br>
&gt; &gt; I believe the device and the kernel will race here by reading fro=
m the same<br>
&gt; &gt; virtqueue: the device could read VirtQueueElement produced by its=
elf before<br>
&gt; &gt; the kernel if the kernel is not fast enough.<br>
<br>
I think that is the intended behavior. Each virtqueue is supposed to have<b=
r>
device and driver writable areas. (Separate used ring and avail ring<br>
in case of split<br>
virtqueues, and in case of packed virtqueues we have something similar<br>
but within a single circular buffer.)<br>
<br>
I don&#39;t think there will be any races. In case of split virtqueues we<b=
r>
have separate<br>
avail and used rings and device and the driver look for buffers to consume =
from<br>
these different rings. In case of packed virtqueues we have flags and<br>
a wrap counting<br>
bit and we use these to make sure we don&#39;t read anything not intended f=
or us.<br>
<br>
You can check these explanations out for more details, these are what I use=
d<br>
when I started the sound card implementation.<br>
<br>
Split Virtqueue:<br>
<a href=3D"https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-da=
ta-travels" rel=3D"noreferrer" target=3D"_blank">https://www.redhat.com/en/=
blog/virtqueues-and-virtio-ring-how-data-travels</a><br>
Packed Virtqueue:<br>
<a href=3D"https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overh=
ead-virtio" rel=3D"noreferrer" target=3D"_blank">https://www.redhat.com/en/=
blog/packed-virtqueue-how-reduce-overhead-virtio</a></blockquote><div><br><=
/div>Hi,<br>thank you all for looking into this. This helped me to make som=
e progress. My device is able to play audio, sometimes clean and sometimes =
I see the guest issues a lot of=C2=A0PCM_PREPARE/PCM_START/PCM_STOP/PCM_REL=
EASE requests for no reason. Maybe it is not happy with my replies in the t=
x virtqueue.</div><div class=3D"gmail_quote"><br><div>Do you happen to have=
 a more recent patch to the spec for virtio-snd? The patch ( <a href=3D"htt=
ps://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a94=
7670f93cc3">https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd=
83c26c6de964a947670f93cc3</a> ) says &quot;The driver MUST NOT place device=
-writable buffers into the tx queue&quot; while it seems expect for the dev=
ice to write status messages there. Also, it is never mentioned which statu=
s messages to write into the tx virtqueue (I guess it is virtio_snd_pcm_sta=
tus) and the=C2=A0virtio_snd_pcm_status::latency_bytes explanation is not v=
ery elaborate. I believe it is the amount of bytes buffered in the device w=
aiting to go to=C2=A0AUD_write.</div><div><br></div><div>Could you please c=
larify? Thank you.</div><div><br></div><div>Regards,</div><div>Roman.</div>=
</div></div>

--000000000000b6be5a05d7b785e1--

