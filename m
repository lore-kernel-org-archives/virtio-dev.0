Return-Path: virtio-dev-return-8173-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4787986038
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 May 2021 16:49:04 +0000 (UTC)
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com> <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <20210517123300.0ea826ef.cohuck@redhat.com> <CAPR809vrz4+WRxSJ=BtQGeKLgHCeMwgB8xq9E+Ei8kykKbPfbA@mail.gmail.com>
In-Reply-To: <CAPR809vrz4+WRxSJ=BtQGeKLgHCeMwgB8xq9E+Ei8kykKbPfbA@mail.gmail.com>
From: Enrico Granata <egranata@google.com>
Date: Mon, 24 May 2021 10:48:51 -0600
Message-ID: <CAPR809s7TXj5m2x8P_om2oX2szy3uNCF7RGHUXb5BcgecHZyNg@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: multipart/alternative; boundary="000000000000dac3be05c3162f87"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000dac3be05c3162f87
Content-Type: text/plain; charset="UTF-8"

Friendly ping here. Since no further feedback, would it make sense to set
up a vote on this proposal?

Thanks,
- Enrico


On Mon, May 17, 2021 at 9:55 AM Enrico Granata <egranata@google.com> wrote:

> I believe the proposal was Acked-By and didn't receive any strong pushback
>
> The only open point of discussion was whether to rename the feature
> flag to F_EMMC_LIFETIME in order to open the door for F_NVME_LIFETIME
> I think, but I didn't hear any comment on that
>
> Thanks,
> - Enrico
>
> On Mon, May 17, 2021 at 4:33 AM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Wed, 5 May 2021 13:37:26 -0600
> > Enrico Granata <egranata@google.com> wrote:
> >
> > > ---------- Forwarded message ---------
> > > From: Enrico Granata <egranata@google.com>
> > > Date: Wed, May 5, 2021 at 1:37 PM
> > > Subject: [PATCH v2] Provide detailed specification of virtio-blk
> > > lifetime metrics
> > > To: <virtio-dev@lists.oasis-open.org>
> > > Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> > > <linux-block@vger.kernel.org>,
> > > <virtualization@lists.linux-foundation.org>
> > >
> > >
> > > In the course of review, some concerns were surfaced about the
> > > original virtio-blk lifetime proposal, as it depends on the eMMC
> > > spec which is not open
> > >
> > > Add a more detailed description of the meaning of the fields
> > > added by that proposal to the virtio-blk specification, as to
> > > make it feasible to understand and implement the new lifetime
> > > metrics feature without needing to refer to JEDEC's specification
> > >
> > > This patch does not change the meaning of those fields nor add
> > > any new fields, but it is intended to provide an open and more
> > > clear description of the meaning associated with those fields.
> > >
> > > Signed-off-by: Enrico Granata <egranata@google.com>
> > > ---
> > > Changes in v2:
> > >   - clarified JEDEC references;
> > >   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> > >   - clarified reserved block references
> > >
> > >  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > Do we have a consent here? I see the mails are not showing up on all of
> > the lists, so I'm a bit confused regarding the state of this...
> >
>

--000000000000dac3be05c3162f87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Friendly ping here. Since no further feedback, would =
it make sense to set up a vote on this proposal?</div><br clear=3D"all"><di=
v><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure">Thanks,<br>- Enrico</div></div><br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 17, 2021 at 9:55 AM Enr=
ico Granata &lt;<a href=3D"mailto:egranata@google.com">egranata@google.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I=
 believe the proposal was Acked-By and didn&#39;t receive any strong pushba=
ck<br>
<br>
The only open point of discussion was whether to rename the feature<br>
flag to F_EMMC_LIFETIME in order to open the door for F_NVME_LIFETIME<br>
I think, but I didn&#39;t hear any comment on that<br>
<br>
Thanks,<br>
- Enrico<br>
<br>
On Mon, May 17, 2021 at 4:33 AM Cornelia Huck &lt;<a href=3D"mailto:cohuck@=
redhat.com" target=3D"_blank">cohuck@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, 5 May 2021 13:37:26 -0600<br>
&gt; Enrico Granata &lt;<a href=3D"mailto:egranata@google.com" target=3D"_b=
lank">egranata@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; ---------- Forwarded message ---------<br>
&gt; &gt; From: Enrico Granata &lt;<a href=3D"mailto:egranata@google.com" t=
arget=3D"_blank">egranata@google.com</a>&gt;<br>
&gt; &gt; Date: Wed, May 5, 2021 at 1:37 PM<br>
&gt; &gt; Subject: [PATCH v2] Provide detailed specification of virtio-blk<=
br>
&gt; &gt; lifetime metrics<br>
&gt; &gt; To: &lt;<a href=3D"mailto:virtio-dev@lists.oasis-open.org" target=
=3D"_blank">virtio-dev@lists.oasis-open.org</a>&gt;<br>
&gt; &gt; Cc: &lt;<a href=3D"mailto:egranata@google.com" target=3D"_blank">=
egranata@google.com</a>&gt;, &lt;<a href=3D"mailto:hch@infradead.org" targe=
t=3D"_blank">hch@infradead.org</a>&gt;, &lt;<a href=3D"mailto:mst@redhat.co=
m" target=3D"_blank">mst@redhat.com</a>&gt;,<br>
&gt; &gt; &lt;<a href=3D"mailto:linux-block@vger.kernel.org" target=3D"_bla=
nk">linux-block@vger.kernel.org</a>&gt;,<br>
&gt; &gt; &lt;<a href=3D"mailto:virtualization@lists.linux-foundation.org" =
target=3D"_blank">virtualization@lists.linux-foundation.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; In the course of review, some concerns were surfaced about the<br=
>
&gt; &gt; original virtio-blk lifetime proposal, as it depends on the eMMC<=
br>
&gt; &gt; spec which is not open<br>
&gt; &gt;<br>
&gt; &gt; Add a more detailed description of the meaning of the fields<br>
&gt; &gt; added by that proposal to the virtio-blk specification, as to<br>
&gt; &gt; make it feasible to understand and implement the new lifetime<br>
&gt; &gt; metrics feature without needing to refer to JEDEC&#39;s specifica=
tion<br>
&gt; &gt;<br>
&gt; &gt; This patch does not change the meaning of those fields nor add<br=
>
&gt; &gt; any new fields, but it is intended to provide an open and more<br=
>
&gt; &gt; clear description of the meaning associated with those fields.<br=
>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Enrico Granata &lt;<a href=3D"mailto:egranata@goog=
le.com" target=3D"_blank">egranata@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Changes in v2:<br>
&gt; &gt;=C2=A0 =C2=A0- clarified JEDEC references;<br>
&gt; &gt;=C2=A0 =C2=A0- added VIRTIO_BLK prefix and cleaned up comment synt=
ax;<br>
&gt; &gt;=C2=A0 =C2=A0- clarified reserved block references<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 content.tex | 40 ++++++++++++++++++++++++++++++++--------<b=
r>
&gt; &gt;=C2=A0 1 file changed, 32 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; Do we have a consent here? I see the mails are not showing up on all o=
f<br>
&gt; the lists, so I&#39;m a bit confused regarding the state of this...<br=
>
&gt;<br>
</blockquote></div>

--000000000000dac3be05c3162f87--

