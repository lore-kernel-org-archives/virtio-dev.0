Return-Path: virtio-dev-return-7050-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 713129842BE
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Apr 2020 13:31:05 +0000 (UTC)
MIME-Version: 1.0
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org> <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
 <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com> <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
 <20200409170152-mutt-send-email-mst@kernel.org> <cf4a59a4-ee86-1d9e-147e-e30e586e2320@redhat.com>
 <CAJaqyWc3-swETnT-h43XcRD0N4CSvd7FM1tZKokHnEOBB0RNqw@mail.gmail.com>
In-Reply-To: <CAJaqyWc3-swETnT-h43XcRD0N4CSvd7FM1tZKokHnEOBB0RNqw@mail.gmail.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Mon, 13 Apr 2020 09:30:38 -0400
Message-ID: <CAJPjb1LU9Mo6uiRTQ7yFM97VDT58fXNa-SrrJhr0-axY4u6Gmw@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: multipart/alternative; boundary="00000000000033121405a32c1846"
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000033121405a32c1846
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2020 at 8:16 AM Eugenio Perez Martin <eperezma@redhat.com>
wrote:

> On Fri, Apr 10, 2020 at 4:40 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2020/4/10 =E4=B8=8A=E5=8D=885:06, Michael S. Tsirkin wrote:
> > > On Tue, Apr 07, 2020 at 11:52:46AM +0200, Eugenio Perez Martin wrote:
> > >> Hi!
> > >>
> > >> So, from the previous mails, it seems that monitoring the used ring
> > >> (and the packed descriptors) is a good first step in that direction,
> > >> as DPDK did. This way, the device does not need to worry about the
> > >> dirty page tracking using a bitmap and the PCI writes limitation, an=
d
> > >> we can evaluate later the proposed alternatives:
> > >> * Alternate used descriptors in packed.
> > >> * vDPA interface for vDPA devices in a convenient format.
> > >>
> > >> Any thoughts? Do you think that we should start with another way?
> > >>
> > >> Thanks!
> > > I am concerned that with software in data path, we'll hit RX queue
> > > underruns, won't we?
> >
> >
> > Do you mean it will lose some performance? If yes, I think so.
> >
> >
> > > Two ways to avoid underruns:
> > > - dirty page tracking
> > > - page faults
> >
> >
> > It looks to me this will lead even worse performance than software path=
?
> > There will be lots of page faults during RX.
> >
> > Another direction is to track dirty pages via IOMMU. E.g recent Intel
> > IOMMU has EA and D bit which could be used for tracking pages wrote by
> > devices but not CPU.
> >
>
> So this could be added on top of the dirty tracking mechanism, isn't?
> or would it be easier to start another-way around, and to start using
> modern IOMMU and then extend to old generic code?
>
> >
> > >
> > > I'm working on a proposal for page faults now.
> >
> >
> > I guess it's better to have a transport independent method.
> >
> >
> > > If someone wants
> > > to work on dirty tracking in addition, that's also an option.
> >
> >
> > I remember Rob mention some challenges of implementing dirty bitmap, I
> > wonder something like queue based interface would be better (similar to
> > Peter did for KVM)?
> >
>
> I think that the main challenge was to write bits instead of writes
> using PCI bus.
>
> From a conversation with Juan, another solution could be to do a byte
> map DPT, where a byte represents a page, not a bit. While I find this
> solution simpler, I'm not sure about the performance implications of
> track this way (memory/TLB pressure, etc). Rob and Juan, please
> correct me if I'm wrong or missed something.
>
RJM>] You captured it correctly. We (Broadcom) discussed the idea of
using a byte (being 0xFF) which effectively indicate that 64KB were dirty,
this would cause potentially refreshing pages to the remote that weren't
needed to be refreshed, slowing down the migration. I like the idea of
mapping
a byte to a page, and teach QEMU (or vDPA, or ...) how to interpret.

>
> Compared to the used ring interposition, much more logic needs to be
> in the device driver for both alternatives (byte mapping and queue),
> isn't it?
>
RJM> Yes, but this would (should) lead to best performance.

>
> > Thanks
> >
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--00000000000033121405a32c1846
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 13, 2020 at 8:16 AM Eugen=
io Perez Martin &lt;<a href=3D"mailto:eperezma@redhat.com">eperezma@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Fri, Apr 10, 2020 at 4:40 AM Jason Wang &lt;<a href=3D"mailto:jasowan=
g@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 2020/4/10 =E4=B8=8A=E5=8D=885:06, Michael S. Tsirkin wrote:<br>
&gt; &gt; On Tue, Apr 07, 2020 at 11:52:46AM +0200, Eugenio Perez Martin wr=
ote:<br>
&gt; &gt;&gt; Hi!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; So, from the previous mails, it seems that monitoring the use=
d ring<br>
&gt; &gt;&gt; (and the packed descriptors) is a good first step in that dir=
ection,<br>
&gt; &gt;&gt; as DPDK did. This way, the device does not need to worry abou=
t the<br>
&gt; &gt;&gt; dirty page tracking using a bitmap and the PCI writes limitat=
ion, and<br>
&gt; &gt;&gt; we can evaluate later the proposed alternatives:<br>
&gt; &gt;&gt; * Alternate used descriptors in packed.<br>
&gt; &gt;&gt; * vDPA interface for vDPA devices in a convenient format.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Any thoughts? Do you think that we should start with another =
way?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks!<br>
&gt; &gt; I am concerned that with software in data path, we&#39;ll hit RX =
queue<br>
&gt; &gt; underruns, won&#39;t we?<br>
&gt;<br>
&gt;<br>
&gt; Do you mean it will lose some performance? If yes, I think so.<br>
&gt;<br>
&gt;<br>
&gt; &gt; Two ways to avoid underruns:<br>
&gt; &gt; - dirty page tracking<br>
&gt; &gt; - page faults<br>
&gt;<br>
&gt;<br>
&gt; It looks to me this will lead even worse performance than software pat=
h?<br>
&gt; There will be lots of page faults during RX.<br>
&gt;<br>
&gt; Another direction is to track dirty pages via IOMMU. E.g recent Intel<=
br>
&gt; IOMMU has EA and D bit which could be used for tracking pages wrote by=
<br>
&gt; devices but not CPU.<br>
&gt;<br>
<br>
So this could be added on top of the dirty tracking mechanism, isn&#39;t?<b=
r>
or would it be easier to start another-way around, and to start using<br>
modern IOMMU and then extend to old generic code?<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m working on a proposal for page faults now.<br>
&gt;<br>
&gt;<br>
&gt; I guess it&#39;s better to have a transport independent method.<br>
&gt;<br>
&gt;<br>
&gt; &gt; If someone wants<br>
&gt; &gt; to work on dirty tracking in addition, that&#39;s also an option.=
<br>
&gt;<br>
&gt;<br>
&gt; I remember Rob mention some challenges of implementing dirty bitmap, I=
<br>
&gt; wonder something like queue based interface would be better (similar t=
o<br>
&gt; Peter did for KVM)?<br>
&gt;<br>
<br>
I think that the main challenge was to write bits instead of writes<br>
using PCI bus.<br>
<br>
From a conversation with Juan, another solution could be to do a byte<br>
map DPT, where a byte represents a page, not a bit. While I find this<br>
solution simpler, I&#39;m not sure about the performance implications of<br=
>
track this way (memory/TLB pressure, etc). Rob and Juan, please<br>
correct me if I&#39;m wrong or missed something.<br></blockquote><div>RJM&g=
t;] You captured it correctly. We (Broadcom) discussed the idea of</div><di=
v>using a byte (being 0xFF) which effectively indicate that 64KB were dirty=
,</div><div>this would cause potentially refreshing pages to the remote tha=
t weren&#39;t</div><div>needed to be refreshed, slowing down the migration.=
 I like the idea of mapping</div><div>a byte to a page, and teach QEMU (or =
vDPA, or ...) how to interpret.</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
Compared to the used ring interposition, much more logic needs to be<br>
in the device driver for both alternatives (byte mapping and queue),<br>
isn&#39;t it?<br></blockquote><div>RJM&gt; Yes, but this would (should) lea=
d to best performance.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; Thanks<br>
&gt;<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div></div>

--00000000000033121405a32c1846--

