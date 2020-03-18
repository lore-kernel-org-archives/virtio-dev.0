Return-Path: virtio-dev-return-6961-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40732985DA2
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Mar 2020 15:13:43 +0000 (UTC)
MIME-Version: 1.0
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org> <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
In-Reply-To: <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Wed, 18 Mar 2020 11:13:15 -0400
Message-ID: <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: multipart/alternative; boundary="0000000000005e26b005a1227fcf"
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000005e26b005a1227fcf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In trying to more fully understand DPT, I ran across an article regarding
how Physical RAM works within QEMU and noticed the statement below. My
current understanding, based upon the statement, is that DPT is automatic
inside QEMU. I can understand that this scheme is not employed in all
hypervisors, but i'm wondering if others, b/c of VM migration, do have a
similar scheme.


Dirty memory tracking

When the guest CPU or device DMA stores to guest RAM this needs to be
noticed by several users:


   1. The live migration feature relies on tracking dirty memory pages so
   they can be resent if they change during live migration.
   2. TCG relies on tracking self-modifying code so it can recompile
   changed instructions.
   3. Graphics card emulation relies on tracking dirty video memory to
   redraw only scanlines that have changed.

There are dirty memory bitmaps for each of these users in ram_list because
dirty memory tracking can be enabled or disabled independently for each of
these users.

http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-ram.html

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Tue, Mar 10, 2020 at 2:39 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/3/10 =E4=B8=8B=E5=8D=882:24, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 11:22:00AM +0800, Jason Wang wrote:
> >> On 2020/3/9 =E4=B8=8B=E5=8D=886:13, Michael S. Tsirkin wrote:
> >>> On Mon, Mar 09, 2020 at 04:50:43PM +0800, Jason Wang wrote:
> >>>> On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wrote:
> >>>>> On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
> >>>>>> I understand that DPT isn't really on the forefront of the vDPA
> framework, but
> >>>>>> wanted to understand if there any initial thoughts on how this
> would work...
> >>>>> And judging by the next few chapters, you are actually
> >>>>> talking about vhost pci, right?
> >>>>>
> >>>>>> In the migration framework, in its simplest form, (I gather) its
> QEMU via KVM
> >>>>>> that is reading the dirty page table, converting bits to page
> numbers, then
> >>>>>> flushing remote VM/copying local page(s)->remote VM, ect.
> >>>>>>
> >>>>>> While this is fine for a VM (say VM1) dirtying its own memory and
> the accesses
> >>>>>> are trapped in the kernel as well as the log is being updated, I'm
> not sure
> >>>>>> what happens in the situation of vhost, where a remote VM (say VM2=
)
> is dirtying
> >>>>>> up VM1's memory since it can directly access it, during packet
> reception for
> >>>>>> example.
> >>>>>> Whatever technique is employed to catch this, how would this diffe=
r
> from a HW
> >>>>>> based Virtio device doing DMA directly into a VM's DDR, wrt to DPT=
?
> Is QEMU
> >>>>>> going to have a 2nd place to query the dirty logs - ie: the vDPA
> layer?
> >>>>> I don't think anyone has a good handle at the vhost pci migration
> yet.
> >>>>> But I think a reasonable way to handle that would be to
> >>>>> activate dirty tracking in VM2's QEMU.
> >>>>>
> >>>>> And then VM2's QEMU would periodically copy the bits to the log -
> does
> >>>>> this sound right?
> >>>>>
> >>>>>> Further I heard about a SW based DPT within the vDPA framework for
> those
> >>>>>> devices that do not (yet) support DPT inherently in HW. How is thi=
s
> envisioned
> >>>>>> to work?
> >>>>> What I am aware of is simply switching to a software virtio
> >>>>> for the duration of migration. The software can be pretty simple
> >>>>> since the formats match: just copy available entries to device ring=
,
> >>>>> and for used entries, see a used ring entry, mark page
> >>>>> dirty and then copy used entry to guest ring.
> >>>> That looks more heavyweight than e.g just relay used ring (as what
> dpdk did)
> >>>> I believe?
> >>> That works for used but not for the packed ring.
> >> For packed ring, we can relay the descriptor ring?
> > Yes, and thus one must relay both available and used descriptors.
> >
>
> Yes.
>
>
> > It's an interesting tradeoff. Packed ring at least was not designed
> > with multiple actors in mind.
>
>
> Yes.
>
>
> > If this becomes a thing (and that's a big if) it might make sense to
> > support temporarily reporting used entries in a separate buffer, while
> > migration is in progress.  Also if doing this, it looks like we can the=
n
> > support used ring resize too, and thus it might also make sense to use
> > this to support sharing a used ring between multiple available rings -
> > this way a single CPU can handle multiple used rings efficiently.
>
>
> Right, that's something similar to the two ring model I proposed in the
> past.
>
> Thanks
>
>

--0000000000005e26b005a1227fcf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In trying to more fully understand DPT, I ran across an ar=
ticle regarding how Physical RAM works within QEMU and noticed the statemen=
t below. My current understanding, based upon the statement, is that DPT is=
 automatic inside QEMU. I can understand that this scheme=C2=A0is not emplo=
yed=C2=A0in all hypervisors, but i&#39;m wondering if others, b/c of VM mig=
ration, do have a similar=C2=A0scheme.<div><br></div><div><div><br></div><d=
iv><h2 style=3D"margin:0px;font-size:22px;font-family:Arial,Tahoma,Helvetic=
a,FreeSans,sans-serif"><span style=3D"background-color:rgb(238,238,238)"><f=
ont color=3D"#000000">Dirty memory tracking</font></span></h2><p style=3D"f=
ont-family:Arial,Tahoma,Helvetica,FreeSans,sans-serif;font-size:13.2px"><fo=
nt color=3D"#000000" style=3D""><span style=3D"background-color:rgb(238,238=
,238)">When the guest CPU </span><span style=3D"background-color:rgb(255,25=
5,0)">or device DMA stores to guest RAM </span><span style=3D"background-co=
lor:rgb(238,238,238)">this needs to be noticed by several users:</span></fo=
nt></p><p style=3D"font-family:Arial,Tahoma,Helvetica,FreeSans,sans-serif;f=
ont-size:13.2px"></p><ol style=3D"font-family:Arial,Tahoma,Helvetica,FreeSa=
ns,sans-serif;font-size:13.2px"><li style=3D"padding:0px;margin:0px 0px 0.2=
5em"><span style=3D"background-color:rgb(238,238,238)"><font color=3D"#0000=
00">The live migration feature relies on tracking dirty memory pages so the=
y can be resent if they change during live migration.</font></span></li><li=
 style=3D"padding:0px;margin:0px 0px 0.25em"><span style=3D"background-colo=
r:rgb(238,238,238)"><font color=3D"#000000">TCG relies on tracking self-mod=
ifying code so it can recompile changed instructions.</font></span></li><li=
 style=3D"padding:0px;margin:0px 0px 0.25em"><span style=3D"background-colo=
r:rgb(238,238,238)"><font color=3D"#000000">Graphics card emulation relies =
on tracking dirty video memory to redraw only scanlines that have changed.<=
/font></span></li></ol><p style=3D"font-family:Arial,Tahoma,Helvetica,FreeS=
ans,sans-serif;font-size:13.2px"><span style=3D"background-color:rgb(238,23=
8,238)"><font color=3D"#000000">There are dirty memory bitmaps for each of =
these users in ram_list because dirty memory tracking can be enabled or dis=
abled independently for each of these users.</font></span></p><p style=3D"f=
ont-family:Arial,Tahoma,Helvetica,FreeSans,sans-serif;font-size:13.2px"><a =
href=3D"http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-=
ram.html">http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physica=
l-ram.html</a>=C2=A0=C2=A0<span style=3D"background-color:rgb(238,238,238)"=
><font color=3D"#000000"><br></font></span></p><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Ro=
b Miller<div><a href=3D"mailto:rob.miller@broadcom.com" target=3D"_blank">r=
ob.miller@broadcom.com</a></div><div>(919)721-3339</div></div></div></div><=
br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Mar 10, 2020 at 2:39 AM Jason Wang &lt;<a href=3D"m=
ailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/10 =E4=B8=8B=E5=8D=882:24, Michael S. Tsirkin wrote:<br>
&gt; On Tue, Mar 10, 2020 at 11:22:00AM +0800, Jason Wang wrote:<br>
&gt;&gt; On 2020/3/9 =E4=B8=8B=E5=8D=886:13, Michael S. Tsirkin wrote:<br>
&gt;&gt;&gt; On Mon, Mar 09, 2020 at 04:50:43PM +0800, Jason Wang wrote:<br=
>
&gt;&gt;&gt;&gt; On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wro=
te:<br>
&gt;&gt;&gt;&gt;&gt; On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller w=
rote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; I understand that DPT isn&#39;t really on the fore=
front of the vDPA framework, but<br>
&gt;&gt;&gt;&gt;&gt;&gt; wanted to understand if there any initial thoughts=
 on how this would work...<br>
&gt;&gt;&gt;&gt;&gt; And judging by the next few chapters, you are actually=
<br>
&gt;&gt;&gt;&gt;&gt; talking about vhost pci, right?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; In the migration framework, in its simplest form, =
(I gather) its QEMU via KVM<br>
&gt;&gt;&gt;&gt;&gt;&gt; that is reading the dirty page table, converting b=
its to page numbers, then<br>
&gt;&gt;&gt;&gt;&gt;&gt; flushing remote VM/copying local page(s)-&gt;remot=
e VM, ect.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; While this is fine for a VM (say VM1) dirtying its=
 own memory and the accesses<br>
&gt;&gt;&gt;&gt;&gt;&gt; are trapped in the kernel as well as the log is be=
ing updated, I&#39;m not sure<br>
&gt;&gt;&gt;&gt;&gt;&gt; what happens in the situation=C2=A0of vhost, where=
 a remote VM (say VM2) is dirtying<br>
&gt;&gt;&gt;&gt;&gt;&gt; up VM1&#39;s memory since it can directly access i=
t, during packet reception for<br>
&gt;&gt;&gt;&gt;&gt;&gt; example.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Whatever technique is employed=C2=A0to catch this,=
 how would this differ from a HW<br>
&gt;&gt;&gt;&gt;&gt;&gt; based Virtio device doing DMA directly into a VM&#=
39;s DDR, wrt to DPT? Is QEMU<br>
&gt;&gt;&gt;&gt;&gt;&gt; going to have a 2nd place to query the dirty logs =
- ie: the vDPA layer?<br>
&gt;&gt;&gt;&gt;&gt; I don&#39;t think anyone has a good handle at the vhos=
t pci migration yet.<br>
&gt;&gt;&gt;&gt;&gt; But I think a reasonable way to handle that would be t=
o<br>
&gt;&gt;&gt;&gt;&gt; activate dirty tracking in VM2&#39;s QEMU.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; And then VM2&#39;s QEMU would periodically copy the bi=
ts to the log - does<br>
&gt;&gt;&gt;&gt;&gt; this sound right?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Further I heard about a SW based DPT within the vD=
PA framework for those<br>
&gt;&gt;&gt;&gt;&gt;&gt; devices that do not (yet) support DPT inherently i=
n HW. How is this envisioned<br>
&gt;&gt;&gt;&gt;&gt;&gt; to work?<br>
&gt;&gt;&gt;&gt;&gt; What I am aware of is simply switching to a software v=
irtio<br>
&gt;&gt;&gt;&gt;&gt; for the duration of migration. The software can be pre=
tty simple<br>
&gt;&gt;&gt;&gt;&gt; since the formats match: just copy available entries t=
o device ring,<br>
&gt;&gt;&gt;&gt;&gt; and for used entries, see a used ring entry, mark page=
<br>
&gt;&gt;&gt;&gt;&gt; dirty and then copy used entry to guest ring.<br>
&gt;&gt;&gt;&gt; That looks more heavyweight than e.g just relay used ring =
(as what dpdk did)<br>
&gt;&gt;&gt;&gt; I believe?<br>
&gt;&gt;&gt; That works for used but not for the packed ring.<br>
&gt;&gt; For packed ring, we can relay the descriptor ring?<br>
&gt; Yes, and thus one must relay both available and used descriptors.<br>
&gt;<br>
<br>
Yes.<br>
<br>
<br>
&gt; It&#39;s an interesting tradeoff. Packed ring at least was not designe=
d<br>
&gt; with multiple actors in mind.<br>
<br>
<br>
Yes.<br>
<br>
<br>
&gt; If this becomes a thing (and that&#39;s a big if) it might make sense =
to<br>
&gt; support temporarily reporting used entries in a separate buffer, while=
<br>
&gt; migration is in progress.=C2=A0 Also if doing this, it looks like we c=
an then<br>
&gt; support used ring resize too, and thus it might also make sense to use=
<br>
&gt; this to support sharing a used ring between multiple available rings -=
<br>
&gt; this way a single CPU can handle multiple used rings efficiently.<br>
<br>
<br>
Right, that&#39;s something similar to the two ring model I proposed in the=
 <br>
past.<br>
<br>
Thanks<br>
<br>
</blockquote></div>

--0000000000005e26b005a1227fcf--

