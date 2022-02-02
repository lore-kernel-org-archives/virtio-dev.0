Return-Path: <virtio-dev-return-9247-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9CA398660F
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Feb 2022 18:43:50 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
 <20220202024251-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220202024251-mutt-send-email-mst@kernel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 2 Feb 2022 10:43:38 -0800
Message-ID: <CAOGAQer+uO55se7N9ndr4psGqyqaGB4pnzgysusSc_WR1zA6sg@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Type: multipart/alternative; boundary="000000000000fe42a205d70d65c9"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000fe42a205d70d65c9
Content-Type: text/plain; charset="UTF-8"

Sure. This is how I expect the device side ctl listening loop should look
like:

while (...) {
    request = virtqueue_pop(ctl_vq, ...);  //1
        response = virtqueue_pop(ctl_vq, ...);  //2
        virtqueue_push(ctl_vq, response, response_size):  //3
    virtqueue_push(ctl_vq, request, 0):  //4
}

My understanding is that line 1 could read output from line 3 if the kernel
is not fast enough fetching the response.

On Tue, Feb 1, 2022 at 11:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:
> > Hello,
> >
> > I work in Android Studio Emulator and I am currently implementing a
> virtio-snd
> > device. We found a spec draft here:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/
> > e73c8cdf3e822fd83c26c6de964a947670f93cc3#
> > diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5
> >
> > It mentions four virtqueues: ctl, event, rx and tx. It is not very clear
> where
> > a virtio-snd device should put responses to the ctl requests from the
> linux
> > kernel driver. There is a kernel driver implementation and we have a
> > virtio-snd device implemented in another emulator, it uses the same
> virtqueue
> > (ctl) to put ctl responses and the current kernel driver seems happy
> with this.
> >
> > Do you know if this is expected behavior? I am far from an expert here,
> but I
> > believe the device and the kernel will race here by reading from the same
> > virtqueue: the device could read VirtQueueElement produced by itself
> before the
> > kernel if the kernel is not fast enough.
> >
> > Thank you.
> >
> > Regards,
> > Roman.
>
> Could you explain a bit more? which function in the kernel driver are
> you referring to?
>
>
>

--000000000000fe42a205d70d65c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sure. This is how I expect the device side ctl listen=
ing loop should look like:</div><div><br></div>while (...) {<br>=C2=A0 =C2=
=A0 request =3D virtqueue_pop(ctl_vq, ...); =C2=A0//1<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 response =3D virtqueue_pop(ctl_vq, ...);=C2=A0 //2<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 virtqueue_push(ctl_vq, response, response_size):=C2=A0 //=
3<br>=C2=A0 =C2=A0 virtqueue_push(ctl_vq, request, 0):=C2=A0 //4<br>}<br><d=
iv><br></div><div>My understanding is that line 1 could read output from li=
ne 3 if the kernel is not fast=C2=A0enough fetching the response.</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Feb 1, 2022 at 11:44 PM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@re=
dhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kir=
yanov wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I work in Android Studio Emulator and I am currently implementing a vi=
rtio-snd<br>
&gt; device. We found a spec draft here:<br>
&gt; <br>
&gt; <a href=3D"https://github.com/oasis-tcs/virtio-spec/commit/" rel=3D"no=
referrer" target=3D"_blank">https://github.com/oasis-tcs/virtio-spec/commit=
/</a><br>
&gt; e73c8cdf3e822fd83c26c6de964a947670f93cc3#<br>
&gt; diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5<=
br>
&gt; <br>
&gt; It mentions four virtqueues: ctl, event, rx and tx. It is not very cle=
ar where<br>
&gt; a virtio-snd device should put responses to the ctl requests from the =
linux<br>
&gt; kernel driver. There is a kernel driver implementation and we have a<b=
r>
&gt; virtio-snd=C2=A0device implemented in another emulator, it uses the sa=
me virtqueue<br>
&gt; (ctl) to put ctl responses and the current kernel driver seems happy w=
ith this.<br>
&gt; <br>
&gt; Do you know if this is expected behavior? I am far from an expert here=
, but I<br>
&gt; believe the device and the kernel will race here by reading from the s=
ame<br>
&gt; virtqueue: the device could read VirtQueueElement produced by itself b=
efore the<br>
&gt; kernel if the kernel is not fast enough.<br>
&gt; <br>
&gt; Thank you.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Roman.<br>
<br>
Could you explain a bit more? which function in the kernel driver are<br>
you referring to?<br>
<br>
<br>
</blockquote></div>

--000000000000fe42a205d70d65c9--

