Return-Path: virtio-comment-return-748-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20190222115433.7160-1-dgilbert@redhat.com> <CAEkmjvU5q46v0cvFx31jfjHZuih8hyxF=9f-h8BdALb4k+bzdg@mail.gmail.com>
 <20190617143845-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190617143845-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Mon, 17 Jun 2019 11:59:28 -0700
Message-ID: <CAEkmjvXzgcUgDBS5RhC0wpWkBNGCHYF8CumaKpBBV56xF9xhiw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000238147058b8999a9"
Subject: Re: [virtio-comment] [PATCH v2 0/3] Large shared memory regions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000238147058b8999a9
Content-Type: text/plain; charset="UTF-8"

Yup

On Mon, Jun 17, 2019 at 11:38 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Mar 05, 2019 at 07:47:52AM -0800, Frank Yang wrote:
> >
> >
> > On Fri, Feb 22, 2019 at 3:54 AM Dr. David Alan Gilbert (git) <
> > dgilbert@redhat.com> wrote:
> >
> >     From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> >     Hi,
> >       This series formalises the idea of shared memory regions I'd
> >     previously discussed and is intended for use with virtio-fs.
> >
> >     I've split it into three parts:
> >
> >       a) A general definition of the idea
> >
> >       b) A definition on virtio-pci using the layout previously
> >     discussed; this still uses the list of capabilities.
> >
> >       c) A definition on virtio-mmio; this is untested
> >     however I thought best to include it since it shows that
> >     it isn't tied to PCI.
> >
> >
> >     This v2 addresses (hopefully all) comments from the initial posting,
> >     except for CCW and the GPU/dynamic usage currently being
> >     discussed by Frank.  Cornelia has a suggested approach for CCW
> >     that is being discussed, so it looks like we're getting there on
> >     that.  The GPU usage being discussed by Frank is diverging to a
> >     very different usage.
> >
> >
> >
> > I've modified the virtio-hostmem stuff to not be dynamic (and posted it);
> > I think we can get that kind of usage using your current definitions.
>
> OK that's an ack then?
>
> >
> >     Dave
> >
> >     Dr. David Alan Gilbert (3):
> >       shared memory: Define shared memory regions
> >       shared memory: Define PCI capability
> >       shared memory: Define mmio registers
> >
> >      content.tex    | 71
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >      shared-mem.tex | 33 +++++++++++++++++++++++
> >      2 files changed, 104 insertions(+)
> >      create mode 100644 shared-mem.tex
> >
> >     --
> >     2.20.1
> >
> >
> >     This publicly archived list offers a means to provide input to the
> >     OASIS Virtual I/O Device (VIRTIO) TC.
> >
> >     In order to verify user consent to the Feedback License terms and
> >     to minimize spam in the list archive, subscription is required
> >     before posting.
> >
> >     Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >     Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >     List help: virtio-comment-help@lists.oasis-open.org
> >     List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >     Feedback License:
> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >     List Guidelines: https://www.oasis-open.org/policies-guidelines/
> >     mailing-lists
> >     Committee: https://www.oasis-open.org/committees/virtio/
> >     Join OASIS: https://www.oasis-open.org/join/
> >
> >
>

--000000000000238147058b8999a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yup</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Jun 17, 2019 at 11:38 AM Michael S. Tsirkin &lt=
;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Mar 05, 2019 at 07=
:47:52AM -0800, Frank Yang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Feb 22, 2019 at 3:54 AM Dr. David Alan Gilbert (git) &lt;<br>
&gt; <a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redh=
at.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: &quot;Dr. David Alan Gilbert&quot; &lt;<a hre=
f=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&=
gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 This series formalises the idea of shared me=
mory regions I&#39;d<br>
&gt;=C2=A0 =C2=A0 =C2=A0previously discussed and is intended for use with v=
irtio-fs.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ve split it into three parts:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 a) A general definition of the idea<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 b) A definition on virtio-pci using the layo=
ut previously<br>
&gt;=C2=A0 =C2=A0 =C2=A0discussed; this still uses the list of capabilities=
.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 c) A definition on virtio-mmio; this is unte=
sted<br>
&gt;=C2=A0 =C2=A0 =C2=A0however I thought best to include it since it shows=
 that<br>
&gt;=C2=A0 =C2=A0 =C2=A0it isn&#39;t tied to PCI.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This v2 addresses (hopefully all) comments from the=
 initial posting,<br>
&gt;=C2=A0 =C2=A0 =C2=A0except for CCW and the GPU/dynamic usage currently =
being<br>
&gt;=C2=A0 =C2=A0 =C2=A0discussed by Frank.=C2=A0 Cornelia has a suggested =
approach for CCW<br>
&gt;=C2=A0 =C2=A0 =C2=A0that is being discussed, so it looks like we&#39;re=
 getting there on<br>
&gt;=C2=A0 =C2=A0 =C2=A0that.=C2=A0 The GPU usage being discussed by Frank =
is diverging to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0very different usage.<br>
&gt; <br>
&gt; <br>
&gt; =C2=A0<br>
&gt; I&#39;ve modified the virtio-hostmem stuff to not be dynamic (and post=
ed it);<br>
&gt; I think we can get that kind of usage using your current definitions.<=
br>
<br>
OK that&#39;s an ack then?<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Dave<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Dr. David Alan Gilbert (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 shared memory: Define shared memory regions<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 shared memory: Define PCI capability<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 shared memory: Define mmio registers<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0content.tex=C2=A0 =C2=A0 | 71 +++++++++++++++=
+++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0shared-mem.tex | 33 +++++++++++++++++++++++<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A02 files changed, 104 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0create mode 100644 shared-mem.tex<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A02.20.1<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This publicly archived list offers a means to provi=
de input to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0OASIS Virtual I/O Device (VIRTIO) TC.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In order to verify user consent to the Feedback Lic=
ense terms and<br>
&gt;=C2=A0 =C2=A0 =C2=A0to minimize spam in the list archive, subscription =
is required<br>
&gt;=C2=A0 =C2=A0 =C2=A0before posting.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Subscribe: <a href=3D"mailto:virtio-comment-subscri=
be@lists.oasis-open.org" target=3D"_blank">virtio-comment-subscribe@lists.o=
asis-open.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Unsubscribe: <a href=3D"mailto:virtio-comment-unsub=
scribe@lists.oasis-open.org" target=3D"_blank">virtio-comment-unsubscribe@l=
ists.oasis-open.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0List help: <a href=3D"mailto:virtio-comment-help@li=
sts.oasis-open.org" target=3D"_blank">virtio-comment-help@lists.oasis-open.=
org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0List archive: <a href=3D"https://lists.oasis-open.o=
rg/archives/virtio-comment/" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.oasis-open.org/archives/virtio-comment/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Feedback License: <a href=3D"https://www.oasis-open=
.org/who/ipr/feedback_license.pdf" rel=3D"noreferrer" target=3D"_blank">htt=
ps://www.oasis-open.org/who/ipr/feedback_license.pdf</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0List Guidelines: <a href=3D"https://www.oasis-open.=
org/policies-guidelines/" rel=3D"noreferrer" target=3D"_blank">https://www.=
oasis-open.org/policies-guidelines/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0mailing-lists<br>
&gt;=C2=A0 =C2=A0 =C2=A0Committee: <a href=3D"https://www.oasis-open.org/co=
mmittees/virtio/" rel=3D"noreferrer" target=3D"_blank">https://www.oasis-op=
en.org/committees/virtio/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Join OASIS: <a href=3D"https://www.oasis-open.org/j=
oin/" rel=3D"noreferrer" target=3D"_blank">https://www.oasis-open.org/join/=
</a><br>
&gt; <br>
&gt; <br>
</blockquote></div>

--000000000000238147058b8999a9--
