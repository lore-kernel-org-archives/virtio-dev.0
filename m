Return-Path: virtio-dev-return-5471-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BB56985D75
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 15:24:34 +0000 (UTC)
MIME-Version: 1.0
References: <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org> <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
 <20190219223936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190219223936-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Wed, 20 Feb 2019 07:24:20 -0800
Message-ID: <CAEkmjvVV0xeVaygfYJpFkhrKtSLL9demMOC_=ubVcgO=yjJF9w@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000062b911058254f4eb"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000062b911058254f4eb
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 19, 2019 at 7:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 19, 2019 at 07:54:04AM -0800, Frank Yang wrote:
> > To update driver/device functionality, ideally we want to ship two small
> shared
> > libraries,
> > one to guest userspace and one to plug in to the host VMM.
>
> I don't think we want to support that last in QEMU.  Generally you want
> process isolation, not shared library plugins - definitely not host
> side - VMM is just to sensitive to allow random plugins -
> and maybe not guest side either.
>
>
Yeah that's a good point.

I haven't really thought too much into it since I've been
planning around, for upstreaming purposes,
if not a shared library plugin, then non-shared code living in the VMM,
though that does make things more complex for us since we also don't want
to further
customize QEMU if possible.

IPC though, seems like it would add quite some overhead,
unless there's some generally accepted portable way to run via shared memory
that doesn't also involve busy waiting in a way that burns up the CPU?

Then we could maybe define a new transport that works through that, or
something.

Well, regardless of IPC mechanism, we would also need to solve a
compatibility issue:
on most host OSes, we can't just take any host pointer and map it into
another process (then the hypervisor mapping that pointer to the guest);
the Vulkan use case for example, ironically, seems to only work well after
remapping through a hypervisor;
IPC cannot be done with them unless the driver happens to support
that flavor of external memory (cross process shareable + host visible).


> I'm at a conference tomorrow but I hope to complete review
> of the proposal and respond by end of week.
>
> Thanks!
>
> Thanks very much Michael for taking the the time to review it.

> --
> MST
>

--00000000000062b911058254f4eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 19, 2019 at 7:46 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, F=
eb 19, 2019 at 07:54:04AM -0800, Frank Yang wrote:<br>
&gt; To update driver/device functionality, ideally we want to ship two sma=
ll shared<br>
&gt; libraries,<br>
&gt; one to guest userspace and one to plug in to the host VMM.<br>
<br>
I don&#39;t think we want to support that last in QEMU.=C2=A0 Generally you=
 want<br>
process isolation, not shared library plugins - definitely not host<br>
side - VMM is just to sensitive to allow random plugins -<br>
and maybe not guest side either.<br>
<br></blockquote><div>=C2=A0</div><div>Yeah that&#39;s a good point.</div><=
div><br></div><div>I haven&#39;t really thought too much into it since I&#3=
9;ve been</div><div>planning around, for upstreaming purposes,</div><div>if=
 not a shared library plugin, then non-shared code living in the VMM,</div>=
<div>though that does make things more complex for us since we also don&#39=
;t want to further</div><div>customize QEMU if possible.</div><div><br></di=
v><div>IPC though, seems like it would add quite some overhead,</div><div>u=
nless there&#39;s some generally accepted portable way to run via shared me=
mory</div><div>that doesn&#39;t also involve busy waiting in a way that bur=
ns up the CPU?</div><div><br></div><div>Then we could maybe define a new tr=
ansport that works through that, or something.</div><div><br></div><div>Wel=
l, regardless of IPC mechanism, we would also need to solve a compatibility=
 issue:</div><div>on most host OSes, we can&#39;t just take any host pointe=
r and map it into another process (then the hypervisor mapping that pointer=
 to the guest);</div><div>the Vulkan use case for example, ironically, seem=
s to only work well after remapping through a hypervisor;</div><div>IPC can=
not be done with them unless the driver happens to support</div><div>that f=
lavor of external memory (cross process shareable=C2=A0+ host visible).</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m at a conference tomorrow but I hope to complete review<br>
of the proposal and respond by end of week.<br>
<br>
Thanks!<br>
<br></blockquote><div>Thanks very much Michael for taking the the time to r=
eview it.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
MST<br>
</blockquote></div></div>

--00000000000062b911058254f4eb--
