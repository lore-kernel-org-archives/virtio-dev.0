Return-Path: virtio-comment-return-688-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20190222115433.7160-1-dgilbert@redhat.com>
In-Reply-To: <20190222115433.7160-1-dgilbert@redhat.com>
From: Frank Yang <lfy@google.com>
Date: Tue, 5 Mar 2019 07:47:52 -0800
Message-ID: <CAEkmjvU5q46v0cvFx31jfjHZuih8hyxF=9f-h8BdALb4k+bzdg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006700e705835accc0"
Subject: Re: [virtio-comment] [PATCH v2 0/3] Large shared memory regions
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000006700e705835accc0
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 22, 2019 at 3:54 AM Dr. David Alan Gilbert (git) <
dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hi,
>   This series formalises the idea of shared memory regions I'd
> previously discussed and is intended for use with virtio-fs.
>
> I've split it into three parts:
>
>   a) A general definition of the idea
>
>   b) A definition on virtio-pci using the layout previously
> discussed; this still uses the list of capabilities.
>
>   c) A definition on virtio-mmio; this is untested
> however I thought best to include it since it shows that
> it isn't tied to PCI.
>
>
> This v2 addresses (hopefully all) comments from the initial posting,
> except for CCW and the GPU/dynamic usage currently being
> discussed by Frank.  Cornelia has a suggested approach for CCW
> that is being discussed, so it looks like we're getting there on
> that.  The GPU usage being discussed by Frank is diverging to a
> very different usage.
>
>
I've modified the virtio-hostmem stuff to not be dynamic (and posted it);
I think we can get that kind of usage using your current definitions.

Dave
>
> Dr. David Alan Gilbert (3):
>   shared memory: Define shared memory regions
>   shared memory: Define PCI capability
>   shared memory: Define mmio registers
>
>  content.tex    | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  shared-mem.tex | 33 +++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 shared-mem.tex
>
> --
> 2.20.1
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines:
> https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>
>

--0000000000006700e705835accc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 22, 2019 at 3:54 AM Dr. D=
avid Alan Gilbert (git) &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilbert=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: &quot;Dr. David Alan Gilbert&quot; &lt;<a href=3D"mailto:d=
gilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
<br>
Hi,<br>
=C2=A0 This series formalises the idea of shared memory regions I&#39;d<br>
previously discussed and is intended for use with virtio-fs.<br>
<br>
I&#39;ve split it into three parts:<br>
<br>
=C2=A0 a) A general definition of the idea<br>
<br>
=C2=A0 b) A definition on virtio-pci using the layout previously<br>
discussed; this still uses the list of capabilities.<br>
<br>
=C2=A0 c) A definition on virtio-mmio; this is untested<br>
however I thought best to include it since it shows that<br>
it isn&#39;t tied to PCI.<br>
<br>
<br>
This v2 addresses (hopefully all) comments from the initial posting,<br>
except for CCW and the GPU/dynamic usage currently being<br>
discussed by Frank.=C2=A0 Cornelia has a suggested approach for CCW<br>
that is being discussed, so it looks like we&#39;re getting there on<br>
that.=C2=A0 The GPU usage being discussed by Frank is diverging to a<br>
very different usage.<br>
<br></blockquote><div>=C2=A0</div><div>I&#39;ve modified the virtio-hostmem=
 stuff to not be dynamic (and posted it);</div><div>I think we can get that=
 kind of usage using your current definitions.</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
Dave<br>
<br>
Dr. David Alan Gilbert (3):<br>
=C2=A0 shared memory: Define shared memory regions<br>
=C2=A0 shared memory: Define PCI capability<br>
=C2=A0 shared memory: Define mmio registers<br>
<br>
=C2=A0content.tex=C2=A0 =C2=A0 | 71 +++++++++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0shared-mem.tex | 33 +++++++++++++++++++++++<br>
=C2=A02 files changed, 104 insertions(+)<br>
=C2=A0create mode 100644 shared-mem.tex<br>
<br>
-- <br>
2.20.1<br>
<br>
<br>
This publicly archived list offers a means to provide input to the<br>
OASIS Virtual I/O Device (VIRTIO) TC.<br>
<br>
In order to verify user consent to the Feedback License terms and<br>
to minimize spam in the list archive, subscription is required<br>
before posting.<br>
<br>
Subscribe: <a href=3D"mailto:virtio-comment-subscribe@lists.oasis-open.org"=
 target=3D"_blank">virtio-comment-subscribe@lists.oasis-open.org</a><br>
Unsubscribe: <a href=3D"mailto:virtio-comment-unsubscribe@lists.oasis-open.=
org" target=3D"_blank">virtio-comment-unsubscribe@lists.oasis-open.org</a><=
br>
List help: <a href=3D"mailto:virtio-comment-help@lists.oasis-open.org" targ=
et=3D"_blank">virtio-comment-help@lists.oasis-open.org</a><br>
List archive: <a href=3D"https://lists.oasis-open.org/archives/virtio-comme=
nt/" rel=3D"noreferrer" target=3D"_blank">https://lists.oasis-open.org/arch=
ives/virtio-comment/</a><br>
Feedback License: <a href=3D"https://www.oasis-open.org/who/ipr/feedback_li=
cense.pdf" rel=3D"noreferrer" target=3D"_blank">https://www.oasis-open.org/=
who/ipr/feedback_license.pdf</a><br>
List Guidelines: <a href=3D"https://www.oasis-open.org/policies-guidelines/=
mailing-lists" rel=3D"noreferrer" target=3D"_blank">https://www.oasis-open.=
org/policies-guidelines/mailing-lists</a><br>
Committee: <a href=3D"https://www.oasis-open.org/committees/virtio/" rel=3D=
"noreferrer" target=3D"_blank">https://www.oasis-open.org/committees/virtio=
/</a><br>
Join OASIS: <a href=3D"https://www.oasis-open.org/join/" rel=3D"noreferrer"=
 target=3D"_blank">https://www.oasis-open.org/join/</a><br>
<br>
</blockquote></div></div>

--0000000000006700e705835accc0--
